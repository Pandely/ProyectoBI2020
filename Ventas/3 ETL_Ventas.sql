use prolav_dmart_venta;
-- DPRODUCTO----------->
INSERT INTO DPRODUCTO ( -- L = CARGA----------->
	Cod_prod,
    Nom_prod,
    Cat_prod,
    PreCom_prod,
    PreVent_prod
)
SELECT -- E = EXTRACCIÓN
	   -- T = TRANSFORMACIÓN
	p.codigo as Cod_Producto,
    p.nombre as Nom_Producto,
	c.nombre as Nom_Categoria,
    dc.precio as Prec_Compra,
	p.precio_venta as Prec_Venta
FROM proyectolaravel.productos as p
	INNER JOIN proyectolaravel.detalle_compras as dc on p.idproducto = dc.idproducto
    INNER JOIN proyectolaravel.categorias as c on p.idcategoria = c.idcategoria
;
-- DTIEMPO----------->
INSERT INTO DTIEMPO(
	Fecha,
    Dia_sem,
    Mes_cod,
    Mes_des,
    Trim_cod,
    Trim_des,
    Anio
)
SELECT 
	DATE_FORMAT(v.fecha_venta, '%Y-%m-%d') as Fecha,
	DAYNAME(v.fecha_venta) as Dia_Semana,
	MONTH(v.fecha_venta) as Cod_Mes,
	MONTHNAME(v.fecha_venta) as Des_Mes,
	QUARTER(v.fecha_venta) as Cod_Trimestre,
	CONCAT('Trimestre', QUARTER(v.fecha_venta)) as Des_Trimestre,
	YEAR(v.fecha_venta) as Cod_Año
FROM proyectolaravel.ventas as v;
-- DVENDEDOR----------->	
INSERT INTO DVENDEDOR(
	Nom_ven,
    TipDoc_ven,
    NumDoc_ven,
    Dir_ven,
    Tel_ven,
    Ema_ven
)
SELECT 
    vd.nombre as Nom_Vendedor,
    vd.tipo_documento as Tipo_Documento,
    vd.num_documento as Num_Documento,
    vd.direccion as Dirección,
    vd.telefono as Teléfono,
    vd.email as Email
FROM proyectolaravel.users as vd;
-- DCLIENTE----------->	
INSERT INTO DCLIENTE(
	Nom_cli,
    TipDoc_cli,
    NumDoc_cli,
    Dir_cli,
    Tel_cli,
    Ema_cli
)
SELECT
	cl.nombre as Nom_Cliente,
    cl.tipo_documento as Tipo_Documento,
    cl.num_documento as Num_Documento,
    cl.direccion as Dirección,
    cl.telefono as Teléfono,
    cl.email as Email
FROM proyectolaravel.clientes as cl;
-- HVENTA----------->	
INSERT INTO HVENTA (
	DProducto_id,
    DTiempo_id,
    DVendedor_id,
    DCliente_id,
    Ventas,
    Vent_Cant_Prod,
    Vent_Costo,
    Descuento
)
SELECT
	DP.DProducto_id, 
    DT.DTiempo_id,
    DV.DVendedor_id,
    DC.DCliente_id, 
    SUM(G.Ventas) as VENTAS, 
    SUM(G.Vent_Cant_Prod) as CANT_UNID,
    SUM(G.Vent_Costo) as COSTO, 
    SUM(G.Descuento) as DESCTOS
FROM (
	SELECT
		DATE_FORMAT(ve.fecha_venta, '%Y-%m-%d') AS Fecha,
        p.codigo as Cod_prod,
		p.nombre as Nom_Producto,
		c.nombre as Cat_Producto,
		dv.cantidad as Vent_Cant_Prod,
        dc.precio as Prec_Compra,
        dv.cantidad * dc.precio as Vent_Costo,
        dv.cantidad * (dv.precio - dv.descuento) as Ventas,
        dv.cantidad * (dv.descuento) as Descuento,
        cli.nombre as Nom_cli,
        v.nombre as Nom_ven
	FROM proyectolaravel.ventas as ve
		INNER JOIN proyectolaravel.detalle_ventas as dv on ve.idventa = dv.idventa
        INNER JOIN proyectolaravel.productos as p on dv.idproducto = p.idproducto
        INNER JOIN proyectolaravel.categorias as c on p.idcategoria = c.idcategoria
        INNER JOIN proyectolaravel.detalle_compras as dc on p.idproducto = dc.idproducto
        INNER JOIN proyectolaravel.clientes as cli on ve.idcliente = cli.idcliente
        INNER JOIN proyectolaravel.users as v on ve.idusuario = v.idusuario
) as G
INNER JOIN DPRODUCTO as DP on G.Cod_prod = DP.Cod_prod
INNER JOIN DTIEMPO as DT on G.Fecha = DT.Fecha
INNER JOIN DCLIENTE as DC on G.Nom_cli = DC.Nom_cli
INNER JOIN DVENDEDOR as DV on G.Nom_ven = DV.Nom_ven
GROUP BY DProducto_id, DTiempo_id, DCliente_id, DVendedor_id;