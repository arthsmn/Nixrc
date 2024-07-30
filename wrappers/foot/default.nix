{pkgs, ...}: {
  wrappers.foot = {
    basePackage = pkgs.foot;
    flags = [
      "-c"
      (pkgs.generators.toINIWithGlobalSection {listsAsDuplicateKeys = true;} {
	globalSection = {
	  font = "Iosevka Comfy:size=12";
	  pad = "5x5 center";
	  resize-by-cells = false;
	};
	csd.preferred = "none";
      })
    ];
  };
}
