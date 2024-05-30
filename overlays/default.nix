{inputs, ...}: {
  additions = final: _: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # example = prev.example.overrideAttrs ({});
  };
}
