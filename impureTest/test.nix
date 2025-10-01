{ impureTest, lib,  runCommand }:

runCommand "tes"
{
  inherit impureTest;
} '' 
  (
    set -x
    [[ "Hello ${impureTest.target}" == "$(${lib.getExe impureTest})" ]]
  )
  touch $out
''
