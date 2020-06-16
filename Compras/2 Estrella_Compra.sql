CREATE TABLE `dproducto` (
  `id_dproducto` int(11) NOT NULL,
  `cod_prod` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom_prod` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cat_prod` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preCom_prod` decimal(11,0) DEFAULT NULL,
  `prevent_prod` decimal(11,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dproveedor` (
  `id_dproveedor` int(11) NOT NULL,
  `nom_prov` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipDoc_prov` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir_prov` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tel_prov` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ema_prov` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `dtiempo` (
  `id_dtiempo` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `dia_sem` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mes_cod` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mes_des` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trim_cod` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trim_des` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anio` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `hcompra` (
  `ID_DPRODUCTO` int(11) NOT NULL,
  `ID_DTIEMPO` int(11) NOT NULL,
  `ID_DPROVEEDOR` int(11) NOT NULL,
  `compras` decimal(9,2) NOT NULL,
  `com_cant_prod` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `dproducto`
  ADD PRIMARY KEY (`id_dproducto`);

ALTER TABLE `dproveedor`
  ADD PRIMARY KEY (`id_dproveedor`);

ALTER TABLE `dtiempo`
  ADD PRIMARY KEY (`id_dtiempo`);


ALTER TABLE `hcompra`
  ADD PRIMARY KEY (`ID_DPRODUCTO`,`ID_DTIEMPO`,`ID_DPROVEEDOR`),
  ADD KEY `ID_DTIEMPO` (`ID_DTIEMPO`,`ID_DPROVEEDOR`),
  ADD KEY `ID_DPROVEEDOR` (`ID_DPROVEEDOR`);


ALTER TABLE `dproducto`
  MODIFY `id_dproducto` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `dproveedor`
  MODIFY `id_dproveedor` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `dtiempo`
  MODIFY `id_dtiempo` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `hcompra`
  ADD CONSTRAINT `hcompra_ibfk_1` FOREIGN KEY (`ID_DPROVEEDOR`) REFERENCES `dproveedor` (`id_dproveedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hcompra_ibfk_2` FOREIGN KEY (`ID_DPRODUCTO`) REFERENCES `dproducto` (`id_dproducto`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hcompra_ibfk_3` FOREIGN KEY (`ID_DTIEMPO`) REFERENCES `dtiempo` (`id_dtiempo`) ON UPDATE CASCADE;
COMMIT;

