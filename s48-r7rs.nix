{
  stdenv,
  fetchgit,
  autoconf,
  automake,
  libtool,
  scheme48,
  ...
}: stdenv.mkDerivation {
  pname = "s48-r7rs";
  version = "1.9.2";
  src = fetchgit {
    url = "https://codeberg.org/prescheme/s48-r7rs.git";
    rev = "8aa179a2cf5dce967555212122fc524d01089194";
    sha256 = "0dzvw1ycimgh9lha5fgfdwb8l8v94587qsfyx5qb0gb32pn4iqir";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    scheme48
  ];

  CFLAGS="-Wno-implicit-int -std=gnu89";

  preConfigure = "./bootstrap";
}
