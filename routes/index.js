var express = require('express');
var router = express.Router();

//Routes
app.get('/', function(request, response){
  response.render('index');
});

module.exports = router;
