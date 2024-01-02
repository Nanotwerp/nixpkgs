{ lib
, stdenv
, fetchzip
, makeWrapper
, jre
, python3
, unzip
,
}:
stdenv.mkDerivation rec {
  pname = "nzbhydra2";
  version = "5.3.5";

  src = fetchzip {
    url = "https://github.com/theotherp/${pname}/releases/download/v${version}/${pname}-${version}-amd64-linux.zip";
    hash = "sha512-l4k4vqCFMdImluu4mslGnz/WuYA/0Wy+3UKfHSHEqznrfEpN+7NHNhQSVGjf09311Rm4fkVuTeWmGEuRyHwS3w==";
    stripRoot = false;
  };

  nativeBuildInputs = [ jre makeWrapper unzip ];

  installPhase = ''
    runHook preInstall

    install -d -m 755 "$out/lib/${pname}"
    cp -dpr --no-preserve=ownership "readme.md" "$out/lib/nzbhydra2"
    install -D -m 755 "nzbhydra2wrapperPy3.py" "$out/lib/nzbhydra2/nzbhydra2wrapperPy3.py"

    makeWrapper ${python3}/bin/python $out/bin/nzbhydra2 \
      --add-flags "$out/lib/nzbhydra2/nzbhydra2wrapperPy3.py" \
      --prefix PATH ":" ${jre}/bin

    runHook postInstall
  '';

  meta = with lib; {
    description = "Usenet meta search";
    homepage = "https://github.com/theotherp/nzbhydra2";
    license = licenses.asl20;
    maintainers = with maintainers; [ jamiemagee ];
    platforms = with platforms; linux;
    mainProgram = "nzbhydra2";
  };
}
