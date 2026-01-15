with (import <nixpkgs> {});

mkShell {
    buildInputs = [
        gh
        python311
        python311Packages.build
        python311Packages.setuptools
    ];
}