// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports
export as namespace Elm


export interface App {
  ports: {
    signup: {
      subscribe(callback: (data: { email: string; phone: string; password: string }) => void): void
    }
    signupSuccess: {
      send(data: { username: string }): void
    }
    confirmSignup: {
      subscribe(callback: (data: { code: string; username: string }) => void): void
    }
    signupConfirmationSuccess: {
      send(data: { username: string }): void
    }
    errors: {
      send(data: string): void
    }
  }
}
    

export namespace Main {
  export function fullscreen(): App
  export function embed(node: HTMLElement | null): App
}