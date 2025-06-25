//modelo del servidor

const expres = require("express");

const cors = require("cors");

const fileUpload = require('express-fileupload');
const prisma = require("../database/config"); // Importa la instancia de Prisma

class Server {
  //constructor
  constructor() {
    this.app = expres();
    this.port = 8080;

    //paths de rutas
    this.paths = {
      usuarios: "/api/users",
      login: "/api/login",
      productos: "/api/productos",
      imagenes: "/api/subirImagen",
      relproductos: "/api/crearProducto",
    };

    this.middleware();
    //rutas de la aplicacion
     this.routes();
    this.conectarDD();
  }

  //para que escuche
  listen() {
    this.app.listen(process.env.port, () => {
      console.log(`Backend corriendo en http://localhost:${process.env.port}`);
    });
  }

  async conectarDD() {
      try {
    // simple query de prueba
    await prisma.$queryRaw`SELECT 1`;
    console.log('✅ Conexión a la base de datos exitosa');
  } catch (error) {
    console.error('❌ Error al conectar a la base de datos:', error);
 
  }
  }
  //middlewares de mi app
  middleware() {
    // uso de cors
    this.app.use(cors());
    //lectura y pareson de json
    this.app.use(expres.json());
    //acepta archiva desde peticiones rest es una configuracion
    this.app.use(
      fileUpload({
        useTempFiles: true,
        tempFileDir: "/tmp/",
        createParentPath: true, //mucho cuidado que esto crea carpeta donde sea
      })
    );
  }

  //importar Rutas
   routes() {
     this.app.use(this.paths.usuarios, require("../routes/users"));
     this.app.use(this.paths.login, require("../routes/auth"));
  //   this.app.use(this.paths.productos, require("../routes/productos"));
  //   this.app.use(this.paths.imagenes, require("../routes/cargaArchivos"));
  //   this.app.use(this.paths.relproductos , require('../routes/relproductos'))
   }
}
//exportar
module.exports = Server;
