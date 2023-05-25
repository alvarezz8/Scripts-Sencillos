""" 
el script deberá buscar todos los nombres de fichero ubicados en directorio1 y directorio2, exceptuando los nombres de los directorios, y a continuación mostrar las diferencias, o sea aquellos ficheros que aparecen en uno de los directorios, pero no en el otro, indicando para cada uno de ellos en que directorio se encuentran

Por otra parte, será necesario introducir una serie de parámetros: directorio1 y directorio2, siendo los directorios donde realizaremos la comparación, y como podemos observar en la sintaxis directorio2 es opcional, esto quiere decir que si el usuario no lo especifica el script comparará directorio1 con el directorio actual.
"""

#!/bin/bash

#Función que se ejecuta si el primer argumento es -r. 

funcionr()
{
	#Se coloca en el directorio pasado por teclado y hace un bucle dentro de el 
	#revisando todos los archivos. Con el comando grep excluimos los directorios.
	cd $2
	for file1 in $(ls -p | grep -v /);
	do	
		#Pedimos encontrar un archivo con el mismo nombre, si lo encuentra entonces muestra el
		#texto
		test $(find $3 -name "$file1") && echo "El archivo $file1 está en ambos ficheros"
		
	done

}
#Esta funcion se ejecuta si el primer parametro no es -r
funcion()
{
	#hace lo mismo que en funcion r pero esta vez si no lo encuentra muestra el texto
	cd $1
	for file1 in $(ls -p | grep -v /);
	do	
	
		test $(find $2 -name "$file1") || echo "El archivo $file1 está sólo en $1"
		
	done
	
	#hace lo mismo que en funcion r pero ahora en el otro directorio pasado por parámetro
	cd $2
	for file2 in $(ls -p | grep -v /);
	do
	
		test $(find $1 -name "$file2") || echo "El archivo $file2 está sólo en $2"
	
	done
}

if [ $1 = -r ]; then
	funcionr $@
else
	funcion $@
fi
