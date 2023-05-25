"""
El correo de los usuarios se guarda en el directorio /var/mail, en archivos con el nombre de login de cada usuario. Script que monitoree estos archivos, realizando lo siguiente:

	a) si el usuario fue borrado, pero quedó su archivo de correo, listar estos usuarios.
	b) si el operador invocó el programa sin parámetro finalizará.
	c) si el operador dio un parámetro no numérico, avisa el error y termina.
	d) si el operador da como parámetro un número, listar los usuarios que hace más de este número de días que no lee su correo, es decir, que el archivo con su nombre en /var/mail no ha sido accedido
"""


#!/bin/bash

comprobacion()
{

	#Compara el numero de parametros introducidos y si es igual a 0 entonces sale del script
	test $# -eq 0  && exit 

	#Le paso el primer parametro y verifico si es un número con una expresión regular
	if ! [ $(echo "$1" | grep '^[0-9]') ]; then
		echo "el parámetro introducido no es un número"
		exit
	
	else 
		#Con este comando me busca y lista los archivos que han sido accedidos hace mas de 30 dias

		find /var/mail -atime $1
	fi

}

borrados()
{

	dirMail=/var/mail
	cd $dirMail
	#hago un bucle y con cada nombre de archivo dentro del mail y lo comparo con los usuarios de 
	#passwd, si no encuentra un nombre identico entonces crea o escribe al final del fichero 
	#listaBorrados.txt

	for file in $(ls)
	do
		test $(cat /etc/passwd | cut -d":" -f1 | grep $file) || echo "$file" >> listaBorrados.txt  
	done

}

comprobacion $@
borrados $@
