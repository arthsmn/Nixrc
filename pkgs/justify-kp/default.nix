{
  trivialBuild,
  fetchFromGitHub,
  dash-functional,
  s,
}:
trivialBuild rec {
  pname = "justify-kp";
  version = "unstable-17-03-2023";
  src = fetchFromGitHub {
    owner = "Fuco1";
    repo = "justify-kp";
    rev = "33a186e297c0359547820088669486afd7b5fddb";
    hash = "sha256-4zT6cED3wQkLCXhi1mZd+LREISS6XFtktNN1CkItZ5I=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    dash-functional
    s
  ];
  buildInputs = propagatedUserEnvPkgs;
}
