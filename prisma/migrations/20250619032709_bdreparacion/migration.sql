-- CreateTable
CREATE TABLE "Empresas" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "nit" TEXT NOT NULL,
    "responsable" TEXT,
    "cedula" TEXT,
    "email" TEXT,
    "logo" TEXT,
    "eslogan" TEXT,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Empresas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ordenes" (
    "id" SERIAL NOT NULL,
    "danoequipo" TEXT NOT NULL,
    "estadoequipo" TEXT NOT NULL,
    "enciende" BOOLEAN NOT NULL DEFAULT true,
    "simcard" BOOLEAN NOT NULL DEFAULT false,
    "memoria" BOOLEAN NOT NULL DEFAULT false,
    "observaciones" TEXT NOT NULL DEFAULT '',
    "valor" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "descuento" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "abono" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fechaentrega" TIMESTAMP(3),
    "estadoorden" TEXT NOT NULL DEFAULT 'Pendiente',
    "userId" INTEGER NOT NULL,
    "modeloequipo" TEXT NOT NULL,
    "nombreequipo" TEXT NOT NULL,
    "idcliente" INTEGER NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "saldo" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ordenes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clientes" (
    "idpersona" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "telefono" TEXT,
    "email" TEXT,
    "direccion" TEXT,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "clientes_pkey" PRIMARY KEY ("idpersona")
);

-- CreateTable
CREATE TABLE "ordenrespuesta" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT NOT NULL DEFAULT '',
    "cantidad" INTEGER NOT NULL DEFAULT 1,
    "costo" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "valor" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "userId" INTEGER NOT NULL,
    "idorden" INTEGER NOT NULL,
    "valorTotal" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ordenrespuesta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pagos" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "valor" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "observaciones" TEXT NOT NULL DEFAULT '',
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "idorden" INTEGER NOT NULL,
    "idcaja" INTEGER NOT NULL,

    CONSTRAINT "pagos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "caja" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "prefijo" TEXT NOT NULL,
    "consecutivo" INTEGER NOT NULL DEFAULT 1,
    "estado" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "caja_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mensajes" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tipo" TEXT NOT NULL,
    "procesado" BOOLEAN NOT NULL DEFAULT false,
    "fechaenvio" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "idusuario" INTEGER NOT NULL,
    "idcliente" INTEGER NOT NULL,
    "idorden" INTEGER,
    "mensaje" TEXT NOT NULL,

    CONSTRAINT "mensajes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Empresas_nombre_key" ON "Empresas"("nombre");

-- AddForeignKey
ALTER TABLE "ordenes" ADD CONSTRAINT "ordenes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ordenes" ADD CONSTRAINT "ordenes_idcliente_fkey" FOREIGN KEY ("idcliente") REFERENCES "clientes"("idpersona") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ordenrespuesta" ADD CONSTRAINT "ordenrespuesta_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ordenrespuesta" ADD CONSTRAINT "ordenrespuesta_idorden_fkey" FOREIGN KEY ("idorden") REFERENCES "ordenes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_idorden_fkey" FOREIGN KEY ("idorden") REFERENCES "ordenes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagos" ADD CONSTRAINT "pagos_idcaja_fkey" FOREIGN KEY ("idcaja") REFERENCES "caja"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensajes" ADD CONSTRAINT "mensajes_idusuario_fkey" FOREIGN KEY ("idusuario") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensajes" ADD CONSTRAINT "mensajes_idcliente_fkey" FOREIGN KEY ("idcliente") REFERENCES "clientes"("idpersona") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensajes" ADD CONSTRAINT "mensajes_idorden_fkey" FOREIGN KEY ("idorden") REFERENCES "ordenes"("id") ON DELETE SET NULL ON UPDATE CASCADE;
