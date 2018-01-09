interface Config {
  userPoolWebClientId: string;
  userPoolId: string;
  identityPoolId: string;
  userPoolArn: string;
  region: string;
}

const config: Config = {
  userPoolWebClientId: "64f9qi5ennb1q6u41jbkgrpmmh",
  userPoolId: "us-east-1_BQEMZzYAT",
  identityPoolId: "us-east-1:d254b154-0431-4ad0-8b13-9486b726e5c8",
  userPoolArn:
    "arn:aws:cognito-idp:us-east-1:065895952035:userpool/us-east-1_BQEMZzYAT",
  region: "us-east-1"
};

export let {
  userPoolWebClientId,
  userPoolId,
  identityPoolId,
  userPoolArn,
  region
} = config;
