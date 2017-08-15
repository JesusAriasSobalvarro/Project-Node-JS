function borrarUsuario(referencia) {
  var url = '/articulo/borrar/' + referencia;
  $.ajax({
    type: 'DELETE',
    url: url
  }).done(function(response) {})
  window.location.reload();
}
