{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.colorscheme.nord;
  hexColor = types.str // {
    check = (x: hasPrefix "#" x && builtins.stringLength x == 7);
    description = "hexadecimal color";
  };
  mkHexColorOption = name: default:
    mkOption {
      type = hexColor;
      default = default;
      description = name;
    };
in {
  ## POLAR NIGHT
  # The origin color or the Polar Night palette.
  nord0  = mkHexColorOption "nord0"  "#2E3440";

  # A brighter shade color based on nord0.
  nord1  = mkHexColorOption "nord1"  "#3B4252";

  # An even more brighter shade color of nord0.
  nord2  = mkHexColorOption "nord2"  "#434C5E";

  # The brightest shade color based on nord0.
  nord3  = mkHexColorOption "nord3"  "#4C566A";

  ## SNOW STORM
  # The origin color or the Snow Storm palette.
  nord4  = mkHexColorOption "nord4"  "#D8DEE9";

  # A brighter shade color of nord4.
  nord5  = mkHexColorOption "nord5"  "#E5E9F0";

  # The brightest shade color based on nord4.
  nord6  = mkHexColorOption "nord6"  "#ECEFF4";

  ## FROST
  # A calm and highly contrasted color reminiscent of frozen polar water.
  nord7  = mkHexColorOption "nord7"  "#8FBCBB";

  # The bright and shiny primary accent color reminiscent of pure and clear ice.
  nord8  = mkHexColorOption "nord8"  "#88C0D0";

  # A more darkened and less saturated color reminiscent of arctic waters.
  nord9  = mkHexColorOption "nord9"  "#81A1C1";

  # A dark and intensive color reminiscent of the deep arctic ocean.
  nord10 = mkHexColorOption "nord10" "#5E81AC";

  ## AURORA
  # RED
  nord11 = mkHexColorOption "nord11" "#BF616A";

  # ORANGE
  nord12 = mkHexColorOption "nord12" "#D08770";

  # YELLOW
  nord13 = mkHexColorOption "nord13" "#EBCB8B";

  # GREEN
  nord14 = mkHexColorOption "nord14" "#A3BE8C";

  # PURPLE
  nord15 = mkHexColorOption "nord15" "#B48EAD";
}
