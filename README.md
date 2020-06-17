# ProyectoBI2020
Sistema de Información para el área de Ventas y Compras de la empresa SAVILPA

===CONSIDERACIONES Y RECOMENDACIONES===
1. Al crear el schema para el DATAMART:
   - Asigne en Character set: "utf8mb4".
   - Así mismo en collation: "utfmb4_unicode_ci".
2. Para que los SCRIPTS del ETL_Ventas funcionen con normalidad renombra los ID de las tablas del Schema "proyectolaravel" o si desea, adapte el SCRIPT.
   - Ejemplo:
      ALTER TABLE "proyectolaravel.productos" CHANGE id idproducto INT AUTO_INCREMENT;
