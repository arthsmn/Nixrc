{inputs, ...}: {
  # additions = final: _: import ./pkgs final.pkgs;
  additions = final: _: import ./pkgs { pkgs = final; };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs ({});
  };
}
