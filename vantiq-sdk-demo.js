var express = require('express');
var app = express();
var fs = require("fs");

app.get('/randomNumber', function (req, res) {
    var data = getRandomInt(0, 1000);
    console.log( data.toString() );
    res.end( data.toString() );
})

/**
 * Returns a random integer between min (inclusive) and max (inclusive)
 * Using Math.round() will give you a non-uniform distribution!
 */
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}


var server = app.listen(8080, function () {

    var host = server.address().address
    var port = server.address().port

    console.log("Example app listening at http://%s:%s", host, port)

})
