{pkgs, ...}: let
  writeFootINI = attr: pkgs.writeTextFile {
    name = "foot-config";
    text = (pkgs.lib.generators.toINIWithGlobalSection {listsAsDuplicateKeys = true;} attr);
  };
  in {
  #   wrappers.foot = {
  #     basePackage = pkgs.foot;
  #     flags = [
	# "-c"
	# (writeFootINI {
	#   globalSection = {
	#     font = "Iosevka Comfy:size=13";
	#     pad = "5x5 center";
	#     resize-by-cells = false;
	#     include = "${pkgs.foot.themes}/share/foot/themes/modus-vivendi";
	#   };
	#   sections = {
	#     csd.preferred = "none";
	#   };
	# })
  #     ];
  #   };
  }
