const camposPorModelo = {
  user: [ 'username', 'email','nombre', 'apellidos', 'estado' ],
  producto: ['id', 'nombre', 'precio'],
  // etc...
};

function campoEsValido(campo, modelo) {
    console.log('campo :>> ', campo);
  return camposPorModelo[modelo]?.includes(campo);
}


module.exports = {
  campoEsValido, 
  }