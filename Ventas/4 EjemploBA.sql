SELECT 
	SUM(Ventas) AS VENTAS
FROM prolav_dmart_venta.HVENTA AS HV;

SELECT 
	DP.Cat_prod,
	SUM(Ventas) AS TOTAL_VENTAS
FROM prolav_dmart_venta.HVENTA AS HV
INNER JOIN DPRODUCTO AS DP ON HV.DProducto_id = DP.DProducto_id
GROUP BY DP.Cat_prod;

SELECT
	DP.Nom_prod,
    SUM(Ventas) AS Ventas
FROM prolav_dmart_venta.HVENTA AS HV
INNER JOIN DPRODUCTO AS DP ON HV.DProducto_id = DP.DProducto_id
GROUP BY DP.Nom_prod;

SELECT 
	DT.Mes_des,
    SUM(Ventas) AS Ventas
FROM prolav_dmart_venta.HVENTA AS HV
INNER JOIN DTIEMPO AS DT ON HV.DTiempo_id = DT.DTiempo_id
GROUP BY DT.Mes_des;

SELECT 
	DT.Mes_des,
    SUM(Vent_Cant_Prod) AS Cant_producto
FROM prolav_dmart_venta.HVENTA AS HV
INNER JOIN DTIEMPO AS DT ON HV.DTiempo_id = DT.DTiempo_id
GROUP BY DT.Mes_des;