var util = require('util'),
    exec = require('child_process').exec,
    http = require('http'),
    querystring = require('querystring');

http.createServer(function (request, response) {

    if(request.method === 'POST') {
    var requestBody = '';

    request.on('data', function(chunk) {
            requestBody += chunk.toString();
    });

    request.on('end', function() {
        var posted = querystring.parse(requestBody);
        response.writeHead(200, {'Content-Type': 'text/html'});
        console.log(util.inspect(posted));

        // cmcc edit <service> pass <pass>
        exec('cmcc edit ' + posted.service + ' pass ' + posted.pass);

        // cmcc connect <service>
        exec('cmcc connect ' + posted.service,
            function (error, stdout, stderr) {
                if (stdout === '') response.write('<h1>Connected</h1>');
                else response.write('<h1>Connection Failed</h1>');
            }
            response.end();
        });
   
    });

    } else { 

    response.writeHead(200, {'Content-Type': 'text/html'});

    response.write('<html><body><h1>WiFi Setting</h1>\n');
    response.write('<form method="post" action="." enctype="application/x-www-form-urlencoded">\n');
    response.write('<select name="service" size="5" style="width: 300px;">\n');

    exec('cmcc scan',
      function (error, stdout, stderr) {
	    var list = stdout.split('\n');

	    for (var i = 0; i < list.length; i++) {
            var ap = list[i].match(/. (.+) \{ (wifi_.*) \}/);
            if (ap !== null) {
                response.write('<option value="' + ap[2] + '">');
                // FIXME: add background image to <option> tag 
                (! ap[2].match(/_none$/)) ? response.write('!') : response.write('　'); 
                response.write(ap[1] + '</option>\n');
            }
	    }

        response.write('</select><br><label>Password : </label><input type="password" name="pass"><input type="submit" value="Connect">');
        response.end('</form></body></html>');
    });
    
    }


}).listen(80);
