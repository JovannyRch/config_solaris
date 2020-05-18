#!/bin/bash
#Autor: Jovanny Ramirez Chimal


dns () {
	while :
	do
		clear 
		echo "___________________________________________________________"
		echo "                  Configuracion del DNS"
		echo "___________________________________________________________"
		echo "1.- Configurar dominio	"
		echo "2.- Agregar dominio"
		read -n1 -p "Elija una opcion" opc
		case $opc in 
			1)
				read -p "Ingrese el dominio" dominio
				
				;;
			3) break
				;;
		esac
	done
}

dhpc () {
	while :
	do
		clear
		echo "____________________________________________________________"
		echo "			Configuracion del DCHP			  "
		echo "___________________________________________________________ "
		echo "1.- Mostrar direcciones IP"
		echo "2.- Mostrar Adaptadores de red"
		echo "3.- Crear direccion IP estatica"
		echo "4.- Crear direccion via DHCP"
		echo "5.- Asignar todas los adaptadores por DHCP"
		echo "6.- Bajar adaptador de red"
		echo "7.- Eliminar direccion ipv4"
		echo "8.- Bajar todas los adaptadores de Red"
		echo "9.- Salir"
		read -n1 -p "Elija opcion" opc
		case $opc in 
			1) 
				ipadm show-addr
				;;
			2)	
				dladm show-phys
				;;
			3)	
				dladm show-phys | grep v4
				read -p "Ingrese adaptador de red" adaptador
				read -p "Ingrese direccion IPV4" ip
				ipadm create-ip -T static -a local=$ip $adaptador/v4
				echo "La direccion asignada es"
				ipadm show-addr | grep $adaptador/v4
				;;
			4)
				dladm show-phys | grep v4
				read -p "Ingrese adaptador" adaptador
				ipadm create-ip -T dhcp $adaptador/v4
				echo "La direccion asignada es"
				ipadm show-addr | grep $adaptador/v4
				;;
			9) 
				break
				;;
		esac
		echo -e "/n"
		read -p "Presione una tecla para continuar" mm

	done
}

while :
do
	clear
	echo "						$(date)"
	echo "==========================================================="
	echo "                       MENU PRINCIPAL                      "
	echo "==========================================================="
	echo -e "/n"
	echo "1.- DNS"
	echo "2.- DHCP"
	echo "3.- SMF"
	echo "4.- ZONAS"
	echo "5.- AI"
	echo "6.- Oracle Database"
	echo "7.- Servidor Web"
	echo "8.- Servidor de Aplicaciones"
	echo "9.- Salir"
	read -n1 -p "Elija una opcion:" opcion	
	case $opcion in
		1)
			dns
			;;
	
		2)
			dns
			;;
		3)
			dns
			;;
		4)
			dns
			;;
		5)
			dns
			;;
		6)
			dns
			;;
		7)
			dns
			;;
		8)
			dns
			;;
		9)
			exit 0
			;;
	esac
done


