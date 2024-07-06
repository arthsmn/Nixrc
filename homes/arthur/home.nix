{config, ...}: let
  homedir = config.home.homeDirectory;
in {
  imports = [./default.nix];

  home = {
    username = "arthur";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${homedir}";
    documents = "${homedir}/Documentos";
    music = "${homedir}/Mídia/Músicas";
    pictures = "${homedir}/Mídia/Imagens";
    publicShare = "${homedir}/Documentos/Público";
    templates = "${homedir}/Documentos/Modelos";
    videos = "${homedir}/Mídia/Vídeos";
  };
}
