{lib, ...}: {
  listToAttrs = lib.genAttrs;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.attrsets) mapAttrs';
  inherit (lib.attrsets) mergeAttrsList;
  inherit (lib.attrsets) foldlAttrs;
}
