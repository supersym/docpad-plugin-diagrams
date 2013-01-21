var theJobType = 'FOO';
var exec = require('child_process').exec;
var child = exec('Test.exe ' + theJobType, function( error, stdout, stderr)
   {
       if ( error != null ) {
            console.log(stderr);
            // error handling & exit
       }

       // normal

});
