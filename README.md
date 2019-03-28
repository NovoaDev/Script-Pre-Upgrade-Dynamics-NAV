# Script Pre-upgrade Dynamics NAV

Mini script Pre-upgrade.

•	Verifica existencia y elimina estructura de carpetas pre upgrade.

•	Crea estructura de carpetas para upgrade.

•	Mueve archivos .txt a las carpetas necesarias.

•	Hace split de los archivos .txt principales.

•	Hace merge de código de cada uno de los .txt generados. 

•	Hace join de los .txt de resultados. 

•	Arroja un único .txt para ser importado desde Dynamics NAV. 

***********************************************************************************

USO:

•	Se puede indicar la ruta principal modificando la variable "Base" por defecto es "C:\Test".

•	Se ejecuta el Script.

•	El creara estructura de carpetas para upgrade.

•	Se tiene que generar .txt desde Dynamics NAV.

	M.txt - txt de los objetos de la base de datos Modificada. 

	O.txt - txt de los objetos de la base de datos Original limpia sin ninguna modificación, de la misma versión y mismo CU de la base modificada.

	T.txt - txt de los objetos de la base de datos Destino.

•	Se copia .txt generados a la carpeta TEMP.

•	Se importa resultado.txt a la base de datos destino.

***********************************************************************************



