use prolav_dmart_compra;
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
	p.precio_venta as Prec_compra
FROM proyectolaravel.productos as p
	INNER JOIN proyectolaravel.detalle_compras as dc on p.id = dc.id
    INNER JOIN proyectolaravel.categorias as c on p.id = c.id
;
-- DPROVEEDOR----------->
INSERT INTO DPROVEEDOR(
	
	nom_prov,
	tipDoc_prov,
	dir_prov,
	tel_prov,
	ema_prov
   
)
SELECT 
    vd.nombre as Nom_Nombre,
    vd.tipo_documento as Tipo_Documento,
    vd.direccion as Dirección,
    vd.telefono as Teléfono,
    vd.email as Email
FROM proyectolaravel.proveedores as vd;
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
	DATE_FORMAT(v.fecha_compra, '%Y-%m-%d') as Fecha,
	DAYNAME(v.fecha_compra) as Dia_Semana,
	MONTH(v.fecha_compra) as Cod_Mes,
	MONTHNAME(v.fecha_compra) as Des_Mes,
	QUARTER(v.fecha_compra) as Cod_Trimestre,
	CONCAT('Trimestre', QUARTER(v.fecha_compra)) as Des_Trimestre,
	YEAR(v.fecha_compra) as Cod_Año
FROM proyectolaravel.compras as v;

insert into HCOMPRA (
	ID_DPRODUCTO,
    ID_DTIEMPO,
    ID_DPROVEEDOR,
    compras,
    com_cant_prod
)
SELECT 
DP.id_dproducto,
DT.id_dtiempo,
DPRO.id_dproveedor,
sum(G.Compras) as compras,
sum(G.Cantidad) as CANT_UNID
FROM (
	SELECT  
		DATE_FORMAT(co.fecha_compra, '%Y-%m-%d') AS fecha,
        p.cod_prod
		 ,p.nom_prod
		 ,c.cat_prod
        ,com.cantidad
		,com.cantidad*com.preCom_prod as compras
		,pro.nom_prov

	FROM proyectolaravel.compras as co
		INNER JOIN proyectolaravel.detalle_compras as com on co.idcompra= com.idcompra
        INNER JOIN proyectolaravel.productos as p on com.idproducto= p.idproducto
        INNER JOIN proyectolaravel.categorias as c on p.idcategoria= c.idcategoria
        INNER JOIN proyectolaravel.proveedores as pro on co.idproveedor= pro.idproveedor
	)  AS G
    
	INNER JOIN dproducto as DP on G.cod_prod = DP.cod_prod
	INNER JOIN dproveedor as DPRO on G.nom_prov = DPRO.nom_prov
    INNER JOIN dtiempo as DT on G.fecha = DT.fecha
	GROUP BY DP.id_dproducto, DT.id_dtiempo, DPRO.id_dproveedor
;





