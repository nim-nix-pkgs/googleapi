{
  description = ''Google API for nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-googleapi-master.flake = false;
  inputs.src-googleapi-master.owner = "treeform";
  inputs.src-googleapi-master.ref   = "refs/heads/master";
  inputs.src-googleapi-master.repo  = "googleapi";
  inputs.src-googleapi-master.type  = "github";
  
  inputs."jwt".dir   = "nimpkgs/j/jwt";
  inputs."jwt".owner = "riinr";
  inputs."jwt".ref   = "flake-pinning";
  inputs."jwt".repo  = "flake-nimble";
  inputs."jwt".type  = "github";
  inputs."jwt".inputs.nixpkgs.follows = "nixpkgs";
  inputs."jwt".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-googleapi-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-googleapi-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}