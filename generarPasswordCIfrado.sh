"""
Realizar un Shell Script que nos genere contraseñas cifradas de 10 caracteres aleatorios, siendo dichos caracteres los que a continuación se describen dentro de un vector:
 VECTOR="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

Posteriormente realizar la compresión de un fichero de texto:
casa bbb zzzzz ff -> casa 3b 5z 2f
Y a continuación realizar un cifrado simple de cada uno de los caracteres:
Carácter cifrado = (Código ASCII(carácter) + número constante) Módulo 256

"""


#Para la correcta funcion de este script debe ser ejecutado con bash

VECTOR="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcefghijklmnopqrstuvwxyz"

#Obtener un valor random del array

contador=1
cadena=""
nConstante=`echo $(($RANDOM))`

funcion(){

	while [ $contador -ne 11 ]; do
	
		#Asignoa random un numero aleatorio entre 0 y 63 que son el numero de carácteres que tengo 
		#en el vector. Al salir 0 el programa da error por tanto le sumo 1.
		
		random=`echo $(($RANDOM%63))`
		test $random -eq 0 && let random=$random+1  
		caracter=$(echo "$VECTOR" | cut -c "$random")
		
		#Con el siguiente comando pasamos el carácter a código ascii. El comando tr lo uso para que
		#no haya errores con el espaciado del echo
		
		ascii=$(echo -n "$caracter" | od -An -t uC | tr -d '[[:space:]]')
		
		#Con el comando let podemos hacer operaciones aritméticas pero hay que ejecutar con .bash
		#cifrado es el resto de la suma de las dos variables divida para 256
		
		let cifrado=($ascii+$nConstante)%256
		
		let contador=$contador+1
		
		#Voy almacenando en cadena los caráceres cifrados
		cadena="$cadena$cifrado"
		
	done

	echo "$cadena"

}

funcion
