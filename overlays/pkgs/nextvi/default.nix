{
  lib,
  clangStdenv,
  fetchFromGitHub,
  libllvm,
}:
clangStdenv.mkDerivation {
  pname = "nextvi";
  version = "unstable-2024-03-18";

  src = fetchFromGitHub {
    owner = "kyx0r";
    repo = "nextvi";
    rev = "24c8fcccacdab2cbe329b451fe8aa5cf28be0c4e";
    hash = "sha256-tA7Gkz1dqvOBnc7MEon04bt+dKZSgoSzTtx/6svr2G8=";
  };

  buildInputs = [libllvm];

  buildPhase = ''
    runHook preBuild

    ./build.sh pgobuild
    PREFIX=$out ./build.sh install

    runHook postBuild
  '';

  meta = with lib; {
    description = "Next version of neatvi (a small vi/ex editor) for editing bidirectional UTF-8 text";
    homepage = "https://github.com/kyx0r/nextvi";
    license = licenses.isc;
    mainProgram = "nextvi";
    platforms = platforms.all;
  };
}
