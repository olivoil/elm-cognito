// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports
export as namespace Elm


export interface App {
  ports: {
    signup: {
      subscribe(callback: (data: { email: string; password: string }) => void): void
    }
    errors: {
      send(data: string): void
    }
    signupSuccess: {
      send(data: { username: string }): void
    }
  }
}
    

export namespace Main {
  export function fullscreen(): App
  export function embed(node: HTMLElement | null): App
}