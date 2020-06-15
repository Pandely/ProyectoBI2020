use prolav_dmart_venta;

CREATE TABLE IF NOT EXISTS DPRODUCTO (
	DProducto_id		INT				AUTO_INCREMENT,
    Cod_prod			VARCHAR(100)	NULL,
    Nom_prod			VARCHAR(100)	NULL,
    Cat_prod			VARCHAR(100)	NULL,
    PreCom_prod			DECIMAL(9,2)	NULL,
    PreVent_prod		DECIMAL(9,2)	NOT NULL,
    PRIMARY KEY (DProducto_id)
);

CREATE TABLE IF NOT EXISTS DTIEMPO (
	DTiempo_id			INT				AUTO_INCREMENT,
    Fecha				DATE			NULL,	
    Dia_sem				VARCHAR(12)		NULL,
    Mes_cod				VARCHAR(2)		NULL,
    Mes_des				VARCHAR(12)		NULL,
    Trim_cod			VARCHAR(1)		NULL,
    Trim_des			VARCHAR(20)		NULL,
    Anio				VARCHAR(4)		NULL,
    PRIMARY KEY (DTIempo_id)
);

CREATE TABLE IF NOT EXISTS DVENDEDOR (
	DVendedor_id		INT 			AUTO_INCREMENT,
    Nom_ven				VARCHAR(100)	NOT NULL,
    TipDoc_ven			VARCHAR(100)	NOT NULL,
    NumDoc_ven			VARCHAR(20)		NOT NULL,
    Dir_ven				VARCHAR(100)	NULL,
    Tel_ven				VARCHAR(20)		NOT NULL,
    Ema_ven				VARCHAR(100)	NULL,
    PRIMARY KEY (DVendedor_id)
);

CREATE TABLE IF NOT EXISTS DCLIENTE (
	DCliente_id			INT 			AUTO_INCREMENT,
    Nom_cli				VARCHAR(100)	NULL,
    TipDoc_cli			VARCHAR(100)	NOT NULL,
    NumDoc_cli			VARCHAR(20)		NOT NULL,
    Dir_cli				VARCHAR(100)	NULL,
    Tel_cli				VARCHAR(20)		NULL,
    Ema_cli				VARCHAR(100)	NULL,
    PRIMARY KEY (DCliente_id)
);

CREATE TABLE IF NOT EXISTS HVENTA (
	DProducto_id		INT				NOT NULL,
    DTiempo_id			INT				NOT NULL,
    DVendedor_id		INT 			NOT NULL,
    DCliente_id			INT 			NOT NULL,
    Ventas				DECIMAL(9,2) 	NULL,
    Vent_Cant_Prod		VARCHAR(100)	NULL,
    Vent_Costo			DECIMAL(9,2)	NULL,
    Descuento			DECIMAL(9,2)	NULL,
    
    FOREIGN KEY (DProducto_id) REFERENCES DPRODUCTO (DProducto_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (DTiempo_id) REFERENCES DTIEMPO (DTiempo_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (DVendedor_id) REFERENCES DVENDEDOR (DVendedor_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (DCliente_id) REFERENCES DCLIENTE (DCliente_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (DProducto_id, DTiempo_id, DVendedor_id, DCliente_id)
);

