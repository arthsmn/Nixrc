
{ stdenvNoCC
, fetchFromGitHub
}: stdenvNoCC.mkDerivation {
  pname = "material-black-colors-theme";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "rtlewis1";
    repo = "GTK";
    rev = "6d6c480a392ba666d2f5d3da4f8bf76c23f9f70b";
    hash = "sha256-8AiMTAsmBdQJD9C4d/Y3eO+S7Fqz4rzYPLvxtCznYtE=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cp -r $src/Material-Black-* $out/share/themes
    runHook postInstall
  '';

  dontFixup = true;
}
