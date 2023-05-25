"""
Shell Script que genere cuentas de usuario.
	Funcionamiento: ./genera_usuario login nombre_real grupo
	
	• Login: el login del usuario a crear.
	• Nombre_real: datos del usuario (nombre y apellidos).
	• Grupo: únicamente podrá ser: contabilidad, finanzas, estadística.

Requisitos:
	• El número de parámetros tiene que ser tres, en caso contrario tendrá que mostrar “Número de parámetros incorrecto” y deberá finalizar la ejecución.
	• El primer parámetro deberá tener entre 3 y 8 caracteres, estando todos ellos en minúsculas, en caso contrario deberá mostrar “Login incorrecto: el login “login” deberá tener entre 3 y 8 caracteres” o bien “Login incorrecto: el login “login” deberá estar en minúsculas” y deberá finalizar la ejecución.
	• Si el segundo parámetro contiene el carácter “:” deberá mostrar “el nombre real no puede contener el carácter :” y deberá finalizar la ejecución.
	• Si el tercer parámetro no es ni contabilidad, ni finanzas, ni estadística, entonces	 deberá mostrar “grupo incorrecto: el grupo tiene que ser contabilidad, finanzas, estadística” y deberá finalizar la ejecución.
	• Si el grupo seleccionado no se ha creado todavía, crear el primer GID que esté libre en el sistema [100 – 999], y si no existe ninguno libre, entonces deberá mostrar “No hay GID’s libres” y deberá finalizar la ejecución.
	• El directorio de inicio del usuario estará en /HOME y deberá llamarse igual que el login del usuario, si a la hora de crearse se produce un error, entonces deberá mostar por consola el error pertinente.
	• El usuario usará /bin/bash como shell de inicio.
	• El script preguntará al usuario la contraseña asociada, para ello usará la orden passwd. En el caso de que el usuario se equivoque al insertar la contraseña tres veces consecutivas, entonces el script deberá bloquear la cuenta de usuario.
	• Los ficheros de personalización se tomarán de /etc/skel
"""

#!/bin/bash

numArg=$#

comprobarPrimerParametro() {
	if ! ([ ${#1} -ge 3 ] && [ ${#1} -le 8 ]); then  ##comprobamos que el primer argumento tenga entre 3 y 8 caracteres
		echo "Login incorrecto: el login “login” deberá tener entre 3 y 8 caracteres"
		exit 1
	fi
}

comprobarSegundoParametro(){
	if [ $(echo "$2" | grep '.*:.*') ]; then ##comprobamos que el segundo argumento no tiene el caracter ":"
		echo "el nombre real no puede contener el carácter :"
		exit 2
	fi
}
comprobarTercerParametro(){
	if ! ([ $3 = "finanzas" ] || [ $3 = "contabilidad" ] || [ $3 = "estadistica" ]); then ##comprobamos el tercer parametro, si no es ninguno de los indicados, finaliza el programa
		echo "grupo incorrecto: el grupo tiene que ser contabilidad, finanzas, estadística"
		exit 3
	fi
}

crearUsuario(){
	sudo useradd -m "$1" -c "$2" -s /bin/bash -g "$3" ##creamos el usuario, con la opcion -m le estamos diciendo que estara en el directorio /home, -c es para datos del usuario. -s para asignarle /bin/bash como shell. Y -g para asignarle el grupo 
}

crearGrupo(){
	sudo groupadd -K GID_MIN=100 -K GID_MAX=999 "$3" ##si no existe, creamos el grupo indicado y le asociamos un GID del 100 al 999, se le asigna el primero que este libre
}

crearContrasenya(){
	echo "¿Que contraseña quieres?"
	sudo passwd "$1"
}
if [ $numArg -eq 3 ]; then  ##comprobamos que le pasamos 3 parametros

	comprobarPrimerParametro $@
	comprobarSegundoParametro $@
	comprobarTercerParametro $@
	
	if  [  $(getent group "$3") ]; then  ##comprobamos si existe el grupo que hemos indicado
		crearUsuario $@
		
	else
		crearGrupo $@
		crearUsuario $@ 
	fi	
	
	crearContrasenya $@
	
else

	echo "Número de parámetros incorrecto"
exit 1
fi
