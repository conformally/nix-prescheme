{
  lib,
  stdenv,
  fetchgit,
  callPackage,
  autoconf,
  automake,
  libtool,
  texinfo,
  gcc,
  ...
}: let
  scheme48-r7rs = callPackage ./s48-r7rs.nix {};
in stdenv.mkDerivation {
  pname = "prescheme";
  version = "0.1";
  src = fetchgit {
    url = "https://codeberg.org/prescheme/prescheme.git";
    rev = "697e056778e1e544b50ea9186237ac7a18fa806d";
    sha256 = "1j14hjq9sfgbwf64cf005al0dkhjxn28s0w77pi6mbz7gg1yv2vb";
  };

  nativeBuildInputs = [
    autoconf
    automake
    libtool
    texinfo
  ];
  buildInputs = [ scheme48-r7rs ];

  preConfigure = "./bootstrap";

  installPhase = ''
    TMPDIR=$(mktemp -d) make install
    runHook postInstall
  '';

  postInstall = ''
    substitute ${./preschemec} $out/bin/preschemec \
        --subst-var out \
        --subst-var-by cc "${gcc}/bin/gcc"

    chmod +x $out/bin/preschemec
  '';

  meta = {
    homepage = "https://prescheme.org";
    description = "A statically typed dialect of the Scheme programming language";
    license = lib.licenses.bsd3;
  };
}
