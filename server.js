var express = require('express');

var app = express();

var port = process.env.PORT || 3000;

['i18n', 'domReady', 'text', 'requirejs', 'reqwirejs'].forEach(function(dep) {
    app.use('/' + dep, express.static(dep));
});

app.listen(port, console.log.bind(console, "Running http:// on " + port));
