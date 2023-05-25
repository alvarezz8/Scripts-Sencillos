"""
Script que nos permite generar ficheros tar, inicialmente el script nos mostrará un menú con las siguientes opciones:
	a. Generacion fichero tar
 	b. Extracción fichero tar
	c. Visualización de la información del fichero tar
	d. Listado de todos los archivos incluidos en el fichero tar
"""

#!/bin/bash

#Muestra un menú con las opciones a elegir

echo "a. Generacion fichero tar"
echo "b. Extraccion fichero tar"
echo "c. Visualización de la información del fichero tar"
echo "d. Listado de todos los archivos incluidos en el fichero tar"

read opcion

#Generador de ficheros.tar. En este condicional verifico que se ha pasado una "a" por teclado y si 
#lo es pido que me indique el nombre del fichero que quiere comprimir. Con el comando tar
#comprimo el archivo indicado con el nombre del mismo archivo pero .tar 

generartar()
{

	if [ $opcion = "a" ]; then
		echo "Para generar el fichero indique el archivo que quiere comprimir: "
		read directorio
		tar -cf $directorio.tar $directorio
		echo "Se ha generado el archivo tar con el nombre: $directorio.tar"
	fi

}

#Extrae el fichero .tar. Verifico que se haya introducido una "b", si es asi, entonces le pido al
#usuario el nombre del archivo .tar que quiere descomprimir y el directorio en el que quiere
#extraerlo.

extraertar()
{

	if [ $opcion = "b" ]; then
		echo "Indique el archivo .tar que desea descomprimir"
		read archivotar
		echo "Indique el directorio donde quiere extraer el archivo"
		read directorio
		tar -xf $archivotar -C $directorio
		echo "Archivo extraído"
	fi
	
}


#Pido el nombre del fichero por teclado y ofrezco un listado del fichero .tar con el comando
#tar -tvf [archivo.tar]

verInformacion()
{

	if [ $opcion = "c" ]; then
		echo "Indique el archivo .tar que desee ver la información"
		read archivotar
		ls -l $archivotar
	fi
	
}

#Pido el nombre del fichero por teclado y ofrezco un listado del fichero .tar con el comando
#tar -tvf [archivo.tar]

verContenido()
{
	
	if [ $opcion = "d" ]; then
		echo "Indique el archivo .tar que desee visualizar"
		read archivotar
		tar -tvf $archivotar
	fi

}



#Si escribimos cualquier otra cosa entonces informa del error

error()
{

	if [ opcion =~ '[abcd]' ]; then
		echo "ERROR: Elija entre las opciones con a, b, c o d"
	fi

}

generartar
extraertar
verInformacion
verContenido
