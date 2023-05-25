""" Shell Script que analiza y cuenta el número de ficheros de un directorio dado, además tendrá que cumplir una serie de requisitos:

1. Recibirá como parámetro el directorio a analizar.
2. Únicamente tendrá un parámetro, en caso contrario deberá mostrar “Número de argumentos incorrecto” y deberá finalizar la ejecución.
3. Si el parámetro suministrado no es un directorio, deberá informar con el siguiente mensaje “<parámetro> no es un directorio” y deberá finalizar la ejecución.
4. El script mostrará el contenido del directorio actual y además el contenido de sus subdirectorios, contando el número de ficheros de cada tipo (fichero normal, directorio, enlace simbólico, tipo de dispositivo… y mostrar por la salida estándar el total de cada tipo, junto con su porcentaje """

#!/bin/bash

numArg=$#
buscarFicherosTotales(){
	echo -n $(find "$1" | wc -l) ##busca y cuenta todos los ficheros del
				      #directorio actual
	echo " Archivos encontrados:"
}
buscarFicherosNormales(){
	echo -n $(find $1 -type f | wc -l) ##busca en el directorio pasado, 
					    #los ficheros normales y los cuenta
	echo " ficheros normales"
}
buscarDirectorios(){
	echo -n $(find $1 -type d | wc -l)
	echo " directorios"
}
buscarDispositivosDeBloque(){
	echo -n $(find $1 -type b | wc -l)
	echo " dispositivos de bloque"
}
buscarDispositivosDecaracteres(){
	echo -n $(find $1 -type c | wc -l)
	echo " dispositivos de caracteres"
}
buscarPipes(){
	echo -n $(find $1 -type p | wc -l)
	echo " pipes"
}
buscarEnlacesSimbolicos(){
	echo -n $(find $1 -type l | wc -l)
	echo " enlaces simbolicos"
}
buscarSockets(){
	echo -n $(find $1 -type s | wc -l)
	echo " sockets"
}

if [[ $numArg != 1 ]]; then  ##comprobamos que le pasamos solo un parametro
	echo "Numero de parametros incorrecto"
else
	if [[ -d $1"/"$file ]];then  ##comprobamos que lo que le pasamos 
					#es un directorio
	
	echo "Analisis de $1 "
	
		buscarFicherosTotales $1
		buscarFicherosNormales $1
		buscarDirectorios $1 
		buscarDispositivosDeBloque $1
		buscarDispositivosDecaracteres $1
		buscarPipes $1
		buscarEnlacesSimbolicos $1
		buscarSockets $1
	
	else
		echo "$1 no es un directorio"
	exit 1
	fi
fi
