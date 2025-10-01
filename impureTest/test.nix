{ impureTest, lib,  runCommand }:

runCommand "tes"
{
  inherit impureTest;
} '' 
  (
    set -x
    [[ "Hello world!" == "$(${lib.getExe impureTest})" ]]
  )
  touch $out
''
