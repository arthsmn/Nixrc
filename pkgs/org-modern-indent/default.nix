{
  trivialBuild,
  fetchFromGitHub,
  org,
  compat,
}:
trivialBuild rec {
  pname = "org-modern-indent";
  version = "unstable-03-20-2024";
  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "org-modern-indent";
    rev = "f2b859bc53107b2a1027b76dbf4aaebf14c03433";
    hash = "sha256-vtbaa3MURnAI1ypLueuSfgAno0l51y3Owb7g+jkK6JU=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    org
    compat
  ];
  buildInputs = propagatedUserEnvPkgs;
}
