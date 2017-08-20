var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var sqlite3 = require('sqlite3');
var expressValidator = require('express-validator');
var app = express();
var db = new sqlite3.Database('sistema_pedido.db');

//View Engine
app.set('view engine','ejs');
app.set('views', path.join(__dirname, 'public/views'));

//Static Directory
app.use(express.static(__dirname));

//Listener
app.listen(process.env.PORT || 3000, function(){
    console.log('Server started on Port 3000');
});


//Body Parser Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));

app.use(function(req, res, next){
  res.locals.errors=null;
  next();
});


//Validator Middleware
app.use(expressValidator({
  errorFormatter: function(param, msg, value) {
      var namespace = param.split('.')
      , root    = namespace.shift()
      , formParam = root;

    while(namespace.length) {
      formParam += '[' + namespace.shift() + ']';
    }
    return {
      param : formParam,
      msg   : msg,
      value : value
    };
  }
}));

//Routes
app.get('/', function(request, response){
  response.render('index');
});

app.get('/articulos', function(request, response) {
    db.all("SELECT * FROM tbl_articulo", function(err, rows) {
      console.log("GET request for articulos");
      response.render('articulos', {
        title: 'Articulos',
        rows: rows
        });
    });
});

app.get('/articulos/crearArticulo', function(request, response) {
  response.render('crearArticulo');
});

app.post('/articulos/crearArticulo', function(request, response){
  db.run('INSERT INTO tbl_articulo(descripcion, precio) VALUES (?,?)',
  [request.body.descripcion, request.body.precio]);
  response.redirect('/articulos');
});

app.get('/articulos/:referencia', function(request, response) {
  db.all("SELECT * FROM tbl_articulo WHERE referencia=?", [request.params.referencia],
    function(err, rows) {
      console.log("GET request for articulos with referencia: " + request.params.referencia);
      response.render('editarArticulo', {
        title: 'Articulos',
        rows: rows
      });
  });
});

app.post('/articulo/editar/:referencia', function(request, response) {
  request.checkBody('descripcion', 'La descripcion es requerida.').notEmpty();
  request.checkBody('precio', 'El precio es requerido.').notEmpty();

  request.getValidationResult().then(function(result) {
    if (result.array() != '') {
      db.all("SELECT * FROM tbl_articulo WHERE referencia=?", [request.params.referencia], function(err, rows) {
        response.render('editarArticulo', {
          title: 'Articulos',
          rows: rows,
          errors: result.array()
        });
      });
      return;
      return;
    } else {
        db.run("UPDATE tbl_articulo SET descripcion=?, precio=? WHERE referencia=?",
        [request.body.descripcion, request.body.precio, request.params.referencia]);
        response.redirect('/articulos');
    }
  });
});

app.delete('/articulo/borrar/:referencia', function(request, response){
  console.log('DELETE request para articulo: '+ request.params.referencia);
  db.run("DELETE FROM tbl_articulo WHERE referencia=?", [request.params.referencia]);
  response.redirect('/articulos');
});

app.get('/empresa', function(request, response) {
  response.render('empresa');
});

app.get('/empleados', function(request, response) {
  response.render('empleados');
});

app.get('/usuarios', function(request, response) {
  response.render('usuarios');
});

app.get('/historial', function(request, response) {
  response.render('historial');
});

app.get('/clientes', function(request, response) {
  response.render('clientes');
});

app.get('/pedidos', function(request, response) {
  response.render('pedido');
});

