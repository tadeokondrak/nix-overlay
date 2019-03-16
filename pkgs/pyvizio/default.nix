{ stdenv, python37Packages, fetchFromGitHub}:

python37Packages.buildPythonApplication rec {
  pname = "pyvizio";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "vkorn";
    repo = pname;
    rev = "e69ffc1962454c869f5f408ab9a244390f544701";
    sha256 = "1cd4f491d7sws3pq6s1h4ckvahzlg0ggfllrg9jbszp47h9pvbba";
  };

  doCheck = false;

  propagatedBuildInputs = with python37Packages; [click requests jsonpickle xmltodict];
}
