{ pkgs }:

let
  imgLink = "https://i.pinimg.com/originals/57/4c/67/574c67c1d8816141746e845f06ecc04d.jpg";
  
  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-I/Iu2KpxZO25tMHtpMMhfHsFCge45MkpYJOLVEqWSNs=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
