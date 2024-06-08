{
  trivialBuild,
  fetchFromGitHub,
  eglot,
  seq,
  jsonrpc,
}:
trivialBuild rec {
  pname = "eglot-booster";
  version = "unstable-11-04-2024";
  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "eglot-booster";
    rev = "e19dd7ea81bada84c66e8bdd121408d9c0761fe6";
    hash = "sha256-vF34ZoUUj8RENyH9OeKGSPk34G6KXZhEZozQKEcRNhs=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    eglot
    seq
    jsonrpc
  ];
  buildInputs = propagatedUserEnvPkgs;
}
