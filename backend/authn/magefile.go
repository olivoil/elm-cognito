// +build mage

package main

import (
	"bytes"
	"fmt"
	"os"
	"regexp"

	"github.com/magefile/mage/sh"
	"github.com/segmentio/go-prompt"
)

// variables
var (
	template = "./cloudformation/cognito.json"
	app = "elmcognito"
	stack = "authn"
	env = "dev"
	profile = fmt.Sprintf("%s-%s", app, env)
	noChanges = regexp.MustCompile(`didn\'t contain changes`)
	awsChangesetCmd = regexp.MustCompile(`\-\-change\-set\-name\s(arn\:.*)`)
)

func init() {
	if eTemplate := os.Getenv("TEMPLATE"); eTemplate != "" {
		template = eTemplate
	}
	if eApp := os.Getenv("APP"); eApp != "" {
		app = eApp
	}
	if eStack := os.Getenv("STACK"); eStack != "" {
		stack = eStack
	}
	if eEnv := os.Getenv("ENV"); eEnv != "" {
		stack = eEnv
	}

	profile = fmt.Sprintf("%s-%s", app, env)
	if eProfile := os.Getenv("PROFILE"); eProfile != "" {
		profile = eProfile
	}
}

// plan stack update
func plan() (changeset string, err error) {
	var buf bytes.Buffer

	_, err = sh.Exec(
		nil,
		&buf,
		&buf,
		"aws",
		"cloudformation",
		"deploy",
		"--no-execute-changeset",
		"--template", template,
		"--stack-name", fmt.Sprintf("%s-%s-%s", app, stack, env),
		"--parameter-overrides", fmt.Sprintf("App=%s", app), fmt.Sprintf("Stack=%s", stack), fmt.Sprintf("Env=%s", env),
		"--capabilities", "CAPABILITY_IAM",
		"--profile", profile,
	)
	if err != nil {
		out := buf.String()

		if noChanges.MatchString(out) {
			fmt.Println("no changes")
			return "", nil
		}

		fmt.Println(out)
		return "", err
	}

	// find changeset name
	m := awsChangesetCmd.FindStringSubmatch(buf.String())
	if m == nil || len(m) < 2 {
		return "", nil
	}

	changeset = m[1]

	if changeset != "" {
		changes, err := sh.Output(`aws`, `cloudformation`, `describe-change-set`, `--change-set-name`, changeset, `--profile`, profile)
		if err != nil {
			return changeset, err
		}

		fmt.Println(changes)
	}

	return changeset, nil
}

// apply stack update
func apply(changeset string) error {
	out, err := sh.Output(`aws`, `cloudformation`, `execute-change-set`, `--change-set-name`, changeset, `--profile`, profile)
	if err != nil {
		return err
	}
	fmt.Println(out)
	return nil
}

// plan and apply changes to infra and functions
func Deploy() error {
	// plan
	changeset, err := plan()
	if err != nil {
		return err
	}
	if changeset == "" {
		return nil
	}

	// ask if user wants to execute
	if ok := prompt.Confirm("apply this change? (y/n)"); !ok {
		return nil
	}

	// execute
	if err := apply(changeset); err != nil {
		return err
	}

	return nil
}

// TODO
// validate stack
func Validate() error {
	// @aws cloudformation validate-template \
	// 	--template-body file://${PWD}/cloudformation/cognito.json \
	// 	--profile ${APP}-${ENV} 
	return nil
}

// TODO
// export stack outputs to frontend config
func Export() error {
	out, err := sh.Output(`make`, `export`)
	fmt.Println(out)
	return err
}