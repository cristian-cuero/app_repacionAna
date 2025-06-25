const { response, request } = require("express");
const bcryptjs = require("bcryptjs");
const prisma = require("../database/config");
const { campoEsValido } = require("../helpers/camposModelos");

//se busca todos los usuarios
const usariosGet = async (req = request, res = response) => {
  const users = await prisma.user.findMany();
  const usuarios = users.map(({ password, ...resto }) => resto);
  res.json({
    usuarios,
  });
};

// //buscar un usario por algun parametro

const buscarUsuario = async (req = request, res = response) => {
  const { parametro, busca } = req.params;

  try {
    const isparametro = campoEsValido(parametro, "user");
    console.log(isparametro);
    if (!isparametro) {
      return res.status(500).json({
        errors: [
          {
            msg: "No Se Encontro El Parametro",
          },
        ],
      });
    }
    let user = await prisma.user.findMany({
      where: {
        [parametro]: {
          contains: busca,
          mode: "insensitive", // para que no distinga entre mayusculas y minusculas
        },
      },
    });

    if (!user) {
      user = {};
    }
    res.json({
      user,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      errors: [
        {
          msg: "Error Interno Del Servidor",
        },
      ],
    });
  }
  // los corchetes es para tarerlo de manera dinamica el where
};

//creamos un usario
const crearUsuario = async (req = request, res = response) => {
  const { username, password, nombre, apellido, correo } = req.body;
    //encriptar contraseña
try {
  const user = await prisma.user.create({
    data: {
      username,
      password: bcryptjs.hashSync(password, 10), //encriptamos la contraseña
      nombre,
      apellido,
      email: correo,
    },
  });
    // 
    // Excluir el campo de contraseña antes de enviar la respuesta
    const { password: _, ...resto } = user; // usamos el guion bajo para no usar la variable password
    res.json({
        user: resto, // devolvemos el usuario sin la contraseña
  });
  } catch (error) {
    console.log('error :>> ', error);
      res.status(400).json({error})
  }
  //user.set('password', )

};

// //editar usuario
// const editarUser = async (req = request , res = response) =>{
//   const {ID} = req.params;
//   const {  username,correo, ...resto} = req.body;
//   let user = await User.findByPk(ID);
//   if(!user){
//     return res.status(400).json({
//       msg: "El usuario No Existe"
//     })
//   }
//   try {
//     user =  await user.update({...resto} ,
//       {where : {idu : ID}})
//   } catch (error) {
//       console.log(error)
//   }
//   res.json(
//     {...resto}
//   )
// }

module.exports = {
  usariosGet,
  buscarUsuario,
  crearUsuario

};
