#!/usr/bin/coffee

{exec,child} = require 'child_process'
child = exec('/usr/bin/java -jar ../lib/jre/BrkParse17.jar -gr ../lib/jre/BrkParseEN.gr', (error, stdout, stderr) ->
  console.log 'stdout: ' + stdout
  console.log 'stderr: ' + stderr
  if error isnt null then console.log 'exec error: ' + error
)




