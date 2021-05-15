{ ps-pkgs, ... }:
  with ps-pkgs;
  { dependencies = [ functions prelude ]; }
