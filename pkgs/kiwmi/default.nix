{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "kiwmi";
  version = "20180131.0";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "buffet";
    repo = pname;
    rev = "f3557edd4828d7b97ec4d06d88294b88ca843243";
    sha256 = "0daj1pnjq9djfxbgdp11gpbbn7vlsw53m199dsanff1vqwmhrhic";
    fetchSubmodules = true;
  };

  cargoSha256 = "0smqncdf01a462scmxq0n0wr2bxfkjbyn5jv9bwzzhw5q5i040l1";
}
