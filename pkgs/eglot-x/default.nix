{
  trivialBuild,
  fetchFromGitHub,
  eglot,
  project,
  xref,
}:
trivialBuild rec {
  pname = "eglot-x";
  version = "unstable-07-06-2024";
  src = fetchFromGitHub {
    owner = "nemethf";
    repo = "eglot-x";
    rev = "ada0c9f32deac90038661f461966aae51707abff";
    hash = "sha256-qZrJkGUBnSvH6w2MuIdYg/2Vb7eowAU0CqTw2LleDhM=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    eglot
    project
    xref
  ];
  buildInputs = propagatedUserEnvPkgs;
}
