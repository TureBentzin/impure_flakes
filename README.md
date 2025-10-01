# Impure Demo
This repo provides an example on how to use impure derivations to use environment variables on build time.

## How to use?

To run / build / check the provided package, you will need to pass `--impure` to your nix command.

**These will fail:**
```
  nix build github:TureBentzin/impure_flakes
```

```
  nix check github:TureBentzin/impure_flakes
```

etc...

**Instead you need to do this:**

1. export the TARGET variable

```
  export TARGET=World
```


2. run the nix command using `--impure`

```
  nix build --impure github:TureBentzin/impure_flakes
``` 
