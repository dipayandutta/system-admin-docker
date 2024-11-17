var http = require('http');
var dateTime = require('./dateTime.js');

http.createServer(function(req,res){
    res.writeHead(200,{'Content-Type':'text/html'});
    res.write("Current Date and Time is "+dateTime.myDateTime());
    res.end();
}).listen(8080);