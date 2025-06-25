
//helper encargado de la generacion del JWT para autenticar el usuario
const jwt  =  require('jsonwebtoken')
const prisma = require('../database/config')

const generarJWT = (username = '') => {

    const payload = {username}
    return new Promise((resolve, reject) => {
        jwt.sign(payload , process.env.SECRETORPRIVATEKEY , {
            expiresIn: '1h'
        }, (err, token) => {
            if(err){
                console.log(err);
                reject('No Se Pudo Crear Ek JWT');
            }else{
                resolve( token)
            }
        })
    })
}

//comprurvo el token
const comprobarJWT = async( ) => {

    try {
        
        if(  token.length < 10 ) {
            return null;
        }

      

        const { username } = jwt.verify( token, process.env.SECRETORPRIVATEKEY );
        const usuario = await prisma.usuario.findUnique({
            where: {
                username: username
            }
        });

        if ( usuario ) {
            if ( usuario.estado ) {
                return usuario;
            } else {
                return null;
            }
        } else {
            return null;
        }

    } catch (error) {
        return null;
    }

    
}
module.exports = {
    generarJWT,
    comprobarJWT
}