{pkgs, ...}: {
  wrappers.bottom = {
    basePackage = pkgs.bottom;
    flags = [
      "--basic"
      "--mem_as_value"
      "--disable_advanced_kill"
    ];
  };
}
