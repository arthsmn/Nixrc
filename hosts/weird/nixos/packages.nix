{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brave
    libreoffice-qt
    kcalc
  ];
}
