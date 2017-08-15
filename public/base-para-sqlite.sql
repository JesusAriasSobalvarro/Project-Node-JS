-- Creator:       MySQL Workbench 6.3.9/ExportSQLite Plugin 0.1.0
-- Author:        oswal
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2017-08-08 13:38
-- Created:       2017-07-10 22:06
PRAGMA foreign_keys = OFF;

-- Schema: sistema_pedido
ATTACH "sistema_pedido.db" AS "sistema_pedido";
BEGIN;
CREATE TABLE "sistema_pedido"."tbl_persona"(
  "identidad" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "nombre" VARCHAR(45),
  "apellido" VARCHAR(45),
  "telefono" INTEGER,
  "correo" VARCHAR(45)
);
CREATE TABLE "sistema_pedido"."tbl_estado"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "descripcion" VARCHAR(45)
);
CREATE TABLE "sistema_pedido"."tbl_empresa"(
  "rtn" INTEGER PRIMARY KEY NOT NULL,
  "nombre_empresa" VARCHAR(45),
  "nombre_corto" VARCHAR(45),
  "pais" VARCHAR(45),
  "provincia" VARCHAR(45),
  "ciudad" VARCHAR(45),
  "telefono" VARCHAR(45),
  "fax" VARCHAR(45),
  "web" VARCHAR(45)
);
CREATE TABLE "sistema_pedido"."tbl_articulo"(
  "referencia" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "descripcion" VARCHAR(45),
  "precio" VARCHAR(45)
);
CREATE TABLE "sistema_pedido"."tbl_cliente"(
  "rtn" INTEGER NOT NULL,
  "direccion" VARCHAR(45),
  "tbl_persona_identidad" INTEGER NOT NULL,
  PRIMARY KEY("rtn","tbl_persona_identidad"),
  CONSTRAINT "fk_tbl_cliente_tbl_persona1"
    FOREIGN KEY("tbl_persona_identidad")
    REFERENCES "tbl_persona"("identidad")
);
CREATE INDEX "sistema_pedido"."tbl_cliente.fk_tbl_cliente_tbl_persona1_idx" ON "tbl_cliente" ("tbl_persona_identidad");
CREATE TABLE "sistema_pedido"."tbl_empleado"(
  "rtn" INTEGER NOT NULL,
  "tbl_persona_identidad" INTEGER NOT NULL,
  "cargo_asignado" VARCHAR(45),
  "fecha_contratacion" VARCHAR(45),
  PRIMARY KEY("rtn","tbl_persona_identidad"),
  CONSTRAINT "fk_tbl_empleado_tbl_persona"
    FOREIGN KEY("tbl_persona_identidad")
    REFERENCES "tbl_persona"("identidad")
);
CREATE INDEX "sistema_pedido"."tbl_empleado.fk_tbl_empleado_tbl_persona_idx" ON "tbl_empleado" ("tbl_persona_identidad");
CREATE TABLE "sistema_pedido"."tbl_usuario"(
  "id" INTEGER NOT NULL,
  "nombre_usuario" VARCHAR(45),
  "contrasenia_usuario" VARCHAR(45),
  "tbl_empleado_rtn" INTEGER NOT NULL,
  PRIMARY KEY("id","tbl_empleado_rtn"),
  CONSTRAINT "fk_tbl_usuario_tbl_empleado1"
    FOREIGN KEY("tbl_empleado_rtn")
    REFERENCES "tbl_empleado"("rtn")
);
CREATE INDEX "sistema_pedido"."tbl_usuario.fk_tbl_usuario_tbl_empleado1_idx" ON "tbl_usuario" ("tbl_empleado_rtn");
CREATE TABLE "sistema_pedido"."tbl_historial"(
  "id" INTEGER NOT NULL,
  "tipo_accion" VARCHAR(45),
  "detalle_accion" VARCHAR(45),
  "tbl_usuario_id" INTEGER NOT NULL,
  "ip" VARCHAR(45),
  "fecha_accion" DATETIME,
  PRIMARY KEY("id","tbl_usuario_id"),
  CONSTRAINT "fk_tbl_historial_tbl_usuario1"
    FOREIGN KEY("tbl_usuario_id")
    REFERENCES "tbl_usuario"("id")
);
CREATE INDEX "sistema_pedido"."tbl_historial.fk_tbl_historial_tbl_usuario1_idx" ON "tbl_historial" ("tbl_usuario_id");
CREATE TABLE "sistema_pedido"."tbl_pedido"(
  "id" INTEGER NOT NULL,
  "fecha_entrega" DATE,
  "fecha_solicitud" DATE,
  "descripcion" VARCHAR(45),
  "total_pedido" VARCHAR(45),
  "tbl_cliente_rtn" INTEGER NOT NULL,
  "tbl_usuario_id" INTEGER NOT NULL,
  "tbl_estado_pedido_id" INTEGER NOT NULL,
  PRIMARY KEY("id","tbl_cliente_rtn","tbl_usuario_id","tbl_estado_pedido_id"),
  CONSTRAINT "fk_tbl_pedido_tbl_cliente1"
    FOREIGN KEY("tbl_cliente_rtn")
    REFERENCES "tbl_cliente"("rtn"),
  CONSTRAINT "fk_tbl_pedido_tbl_usuario1"
    FOREIGN KEY("tbl_usuario_id")
    REFERENCES "tbl_usuario"("id"),
  CONSTRAINT "fk_tbl_pedido_tbl_estado_pedido1"
    FOREIGN KEY("tbl_estado_pedido_id")
    REFERENCES "tbl_estado"("id")
);
CREATE INDEX "sistema_pedido"."tbl_pedido.fk_tbl_pedido_tbl_cliente1_idx" ON "tbl_pedido" ("tbl_cliente_rtn");
CREATE INDEX "sistema_pedido"."tbl_pedido.fk_tbl_pedido_tbl_usuario1_idx" ON "tbl_pedido" ("tbl_usuario_id");
CREATE INDEX "sistema_pedido"."tbl_pedido.fk_tbl_pedido_tbl_estado_pedido1_idx" ON "tbl_pedido" ("tbl_estado_pedido_id");
CREATE TABLE "sistema_pedido"."tbl_pedido_has_tbl_articulo"(
  "tbl_pedido_id" INTEGER NOT NULL,
  "tbl_articulo_referencia" INTEGER NOT NULL,
  "tbl_estado_pedido_id" INTEGER NOT NULL,
  PRIMARY KEY("tbl_pedido_id","tbl_articulo_referencia","tbl_estado_pedido_id"),
  CONSTRAINT "fk_tbl_pedido_has_tbl_articulo_tbl_pedido1"
    FOREIGN KEY("tbl_pedido_id")
    REFERENCES "tbl_pedido"("id"),
  CONSTRAINT "fk_tbl_pedido_has_tbl_articulo_tbl_articulo1"
    FOREIGN KEY("tbl_articulo_referencia")
    REFERENCES "tbl_articulo"("referencia"),
  CONSTRAINT "fk_tbl_pedido_has_tbl_articulo_tbl_estado_pedido1"
    FOREIGN KEY("tbl_estado_pedido_id")
    REFERENCES "tbl_estado"("id")
);
CREATE INDEX "sistema_pedido"."tbl_pedido_has_tbl_articulo.fk_tbl_pedido_has_tbl_articulo_tbl_articulo1_idx" ON "tbl_pedido_has_tbl_articulo" ("tbl_articulo_referencia");
CREATE INDEX "sistema_pedido"."tbl_pedido_has_tbl_articulo.fk_tbl_pedido_has_tbl_articulo_tbl_pedido1_idx" ON "tbl_pedido_has_tbl_articulo" ("tbl_pedido_id");
CREATE INDEX "sistema_pedido"."tbl_pedido_has_tbl_articulo.fk_tbl_pedido_has_tbl_articulo_tbl_estado_pedido1_idx" ON "tbl_pedido_has_tbl_articulo" ("tbl_estado_pedido_id");
COMMIT;
