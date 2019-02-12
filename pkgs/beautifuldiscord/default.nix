{ stdenv, python37Packages, fetchFromGitHub, fetchpatch }:

python37Packages.buildPythonApplication rec {
  pname = "beautifuldiscord";
  version = "20180901";

  src = fetchFromGitHub {
    owner = "leovoel";
    repo = pname;
    rev = "ed5b942567b0fd0b770cb0b4d65547e91f7a4f74";
    sha256 = "1w5fmvk5lac5j63f8cmzp65w61cbrv9ny0nlaxgx0gvvh1j299md";
  };

  patches = [(fetchpatch {
    # https://github.com/leovoel/BeautifulDiscord/pull/65
    url = "https://patch-diff.githubusercontent.com/raw/leovoel/BeautifulDiscord/pull/65.diff";
    sha256 = "0ky703pwvyy94zkkvgb2abk0rp7aznncj8kv8xap8g112ab98zh1";
  })];

  doCheck = false;

  propagatedBuildInputs = with python37Packages; [ psutil ];

  meta = with stdenv.lib; {
    description = "Simple Python script that adds CSS hot-reload to Discord";
    homepage = https://github.com/leovoel/BeautifulDiscord;
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
