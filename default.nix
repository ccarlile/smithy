{ lib, stdenv, fetchzip, jdk, bash }:

stdenv.mkDerivation rec {
  pname = "smithy-cli";
  version = "1.49.0";

  src = fetchzip {
    url = "https://github.com/smithy-lang/smithy/releases/download/${version}/smithy-cli-linux-x86_64.zip";
    hash = "sha256-XES+rpdzwI3B84mfA2I9avbJmx12FzJlMHhYRn8BKco=";
  };

  nativeBuildInputs = [ jdk bash ];

  installPhase = ''
    mkdir -p $out/bin $out/lib $out/conf

    cp -r $src/lib $out
    cp -r $src/conf $out

    cp $src/bin/smithy $out/bin/smithy
    sed -i 's|^JAVA_HOME.*|JAVA_HOME=${jdk}|' $out/bin/smithy
    chmod +x $out/bin/smithy
  '';

  meta = {
    description = "Smithy CLI tool for the Smithy language";
    homepage = "https://github.com/smithy-lang/smithy";
    license = lib.licenses.mit; # Assuming MIT, adjust if necessary
    maintainers = with lib.maintainers; [ ccarlile ]; # Replace with your Nixpkgs maintainer username
  };
}
