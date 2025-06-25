///archivo que contiene la instancia del sequelize para poder ser reutilizado por los demas
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

module.exports = prisma;