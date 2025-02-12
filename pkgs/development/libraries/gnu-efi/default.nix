{ lib, stdenv, buildPackages, fetchurl, pciutils
, gitUpdater }:

stdenv.mkDerivation rec {
  pname = "gnu-efi";
  version = "3.0.17";

  src = fetchurl {
    url = "mirror://sourceforge/gnu-efi/${pname}-${version}.tar.bz2";
    sha256 = "sha256-eAfpAzSTQ6ehQuu5NHA6KHIjXolojPWGwDKwoQh7yvQ=";
  };

  buildInputs = [ pciutils ];

  hardeningDisable = [ "stackprotector" ];

  makeFlags = [
    "PREFIX=\${out}"
    "HOSTCC=${buildPackages.stdenv.cc.targetPrefix}cc"
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
  ];

  passthru.updateScript = gitUpdater {
    # No nicer place to find latest release.
    url = "https://git.code.sf.net/p/gnu-efi/code";
  };

  meta = with lib; {
    description = "GNU EFI development toolchain";
    homepage = "https://sourceforge.net/projects/gnu-efi/";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
