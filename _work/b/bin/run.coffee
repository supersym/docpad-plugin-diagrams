theJobType = "../lib/jre/BrkParse17.jar -gr ../lib/jre/BrkParseEN.gr"
exec = require("child_process").exec
child = exec("/usr/bin/java -jar " + theJobType, (error, stdout, stderr) ->
  console.log stderr  if error?
)

# error handling & exit

# normal
