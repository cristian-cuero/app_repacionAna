const {request , response} = require('express');
const bcryptjs = require('bcryptjs');
const { generarJWT } = require('../helpers/generarWTK');
const prisma = require('../database/config');

//logueo de la aplicacion
const auth = async (req = request , res = response) => {
    const {username , password } = req.body;
 
    try {
        const user = await prisma.user.findUnique({
            where: {
                username: username
            }
        });
        if(!user){
            return res.status(400).json({
                msg: "Usuario O Contraseña Invalida"
            })
        }
        //valido la contraseña
        const validarContraseña = bcryptjs.compareSync(password , user.password)
        if(!validarContraseña){
            return res.status(400).json({
                msg: "Usuario O Contraseña Invalida"
            })
        }
        //valido que el usuario este activo
        if(!user.estado){
            return res.status(400).json({
                msg:"El usuario Esta Inactivo"
            })
        }
        //gebera el JWT
        const token = await generarJWT(user.username)
        return res.json({
            user,
            token
        })
    } catch (error) {

        console.log(error)
    }
    

}

module.exports = {
    auth
}