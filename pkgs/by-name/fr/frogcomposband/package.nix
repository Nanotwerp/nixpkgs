{ lib
, stdenv
, fetchFromGitHub
, clangStdenv
, autoreconfHook
, ncurses5
, enableSdl2 ? false
, SDL2
, SDL2_image
, SDL2_sound
, SDL2_mixer
, SDL2_ttf
}:

clangStdenv.mkDerivation rec {
  pname = "frogcomposband";
  version = "7.1";

  src = fetchFromGitHub {
    owner = "sulkasormi";
    repo = "frogcomposband";
    rev = "3d28f6b1d28a0246a1c4923414455eb669ea34b8";
    sha256 = "sha256-PwUmksRtAN9cSrOpw+7I9V/Xqo6bQ5Iok9olLCugaS8=";
  };


  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ ncurses5 ]
    ++ lib.optionals enableSdl2 [
    SDL2
    SDL2_image
    SDL2_sound
    SDL2_mixer
    SDL2_ttf
  ];

  env.NIX_CFLAGS_COMPILE = "-Wno-error=format-security";

  enableParallelBuilding = true;

  autoreconfPhase = "sh autogen.sh";

  configureFlags = lib.optional enableSdl2 "--enable-sdl2";

  installFlags = [ "bindir=$(out)/bin" ];

  meta = with lib; {
    homepage = "https://github.com/sulkasormi/frogcomposband";
    description = "A variant of PosChengband and Composband with more stuff, more humor and fewer bugs ";
    maintainers = [ maintainers.nanotwerp ];
    license = licenses.gpl2;
  };
}
