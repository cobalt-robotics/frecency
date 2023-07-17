with (import <nixpkgs> {});

mkShell {
    buildInputs = [
        python311
        python311Packages.build
    ];
}