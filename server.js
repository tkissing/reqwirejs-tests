var express = require('express');

var app = express();

var port = process.env.PORT || 3000;

['i18n', 'domReady', 'text', 'requirejs'].forEach(function(dep) {
    app.use('/' + dep, express.static(dep));
});

app.use('/', express.static('reqwirejs'));

app.listen(port, console.log.bind(console, "Running http:// on " + port));
