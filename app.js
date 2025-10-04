require('dotenv').config();
pool = require('./database/config')
const Server = require("./model/server");


const server = new Server()

 
console.log('Iniciando :>> ');


server.listen()