#!/bin/bash
#Autor: Jovanny Ramirez Chimal


showNICS() {
	dladm show_phys
	read -p "Choose a Network Adapter: " nat
	echo $nat
}

# Funcion que configura un tarjeta de red
# Params: $1 es el nombre del adaptador 
configDHCP () {
	nat = $1
	output = "$(ipadm create-ip $nat)"
	ipadm create-addr -T dhcp $nat/v4
	ipadm show-addr | grep $nat/v4
}

configIPV6 () {
	nat $1
	ouput = "$(ipadm crate-ip $nat)"
	ipadm create-addr -T addrconf $nat/v6
	ipadm show-addr | grep $nat/v6
}

network () {
	while :
	do
		clear 
		echo "___________________________________________________________"
		echo "			Networking config			 "	
		echo "___________________________________________________________"
		echo " 1.- Show Network's Adapters"
		echo " 2.- Show Network's Addresses"
		echo " 3.- Create a static IP"
		echo " 4.- Create an IP using DHCP with IPv4"
		echo " 5.- Config all NICs by DHCP with IPv4"
		echo " 6.- Create an IP using DHCP with IPv6"
		echo " 7.- Config all NICs by DHCP with IPv6"
		echo " 8.- Delete a IP address"
		echo " 9.- Exit"
		read -n1 -p "Type a number: " opc
		clear
		case $opc in
			1)
				dladm show-phys
				;;
			2) 	
				ipadm show-addr
				;;
			3) 	
				echo "		Create a static IP"
				nat = "$(showNICS)"
				read -p "Enter the IP (IPv4) address: " ip
				output = "$(ipadm create-ip $nat)"
				ipadm create-addr -T static -a local=$ip $nat/v4
				ipadm show-addr | grep $nat/v4
				;;
			4) 	
				echo "		Create an IP address by DHCP with IPv4"
				nat = "$(showNICS)"
				configDHCP $nat
				;;		
			5)	
				echo " 		Configuring all NICs by DHCP with IPv4"
				configDHCP nat0
				configDHCP nat1
				configDHCP nat2
				configDHCP nat3
				;;
			6) 
				echo "		Craete an IP address by DHCP with IPv6"
				nat = "$(showNICS)"
				configIPV6 $nat
				;;

			7) 
				echo "		Configuring all NICs by DHCP with IPv6"
				configIPV6 nat0
				configIPV6 nat1
				configIPV6 nat2
				configIPV6 nat3
				;;
			8) 
				echo " 		Delete a IP address"
				ipadm show-addr
				read -p "Type the Address Objetc" addr
				ipadm delete-addr $addr
				ipadm show-addr
				;;
			9) 
				break
				;;
		esac

		read -n1 -p "Press any key to continue..." a
	done

}


dns () {
	while :
	do
		clear 
		echo "___________________________________________________________"
		echo "                 DNS Config "
		echo "___________________________________________________________"
		echo "1.- Add domain	"
		echo "2.- Add"
		read -n1 -p "Type a number: " opc
		case $opc in 
			1)
				read -p "Ingrese el dominio" dominio
				
				;;
			3) break
				;;
		esac
	done
}

chooseService () {
	echo "1.- IPv4"
	echo "2.- IPv6"
	read -p "Type an option" opc
	echo "opc"
}

dhpc () {
	while :
	do
		clear
		echo "____________________________________________________________"
		echo "			 DCHP Config			  "
		echo "___________________________________________________________ "
		echo "1.- Show state servers DHCP"
		echo "2.- Set disable service DHCP"
		echo "3.- Set enable service DHCP"
		echo "4.- Config dhcpd4.conf file "
		read -p "Type a number" opc
		
		case $opc in 
			1) 	svcs | grep dhcp
				;;
			2) 	ipv = "$(chooseService)"
				if ["$ipv" == "1"]; then 
					svcadm enable /network/dhcp/server:ipv4
				else 
					svcadm enable /network/dhcp/server:ipv6
				fi
				;;
			3) 	ipv = "$(chooseService)"
				if ["$ipv" == "1"]; then 
					svcadm disable /network/dhcp/server:ipv4
				else 
					svcadm disable /network/dhcp/server:ipv6
				fi
				;;
			4)
				echo "		Config dhcpd4.conf file"
				read -p "Enter the subnet: " subnet
				read -p "Enter the netmask: " netmask
				read -p "Enter the interface: " interface
				read -p "Enter the min range value: " r1
				read -p "Enter the max range value: " r2
				read -p "Enter the address routers: " router
				read -p "Enter the broadcast address: " broadcast
				file = "/etc/inet/dhcpd4.conf"
				touch $file
				echo "subnet $subnet netmask $netmask {" > $file
				echo "		interface $interface; " >> $file
				echo "		range $r1 $r2; " >> $file
				echo "		option routers $router; " >> $file
				echo "		option broadcast-address $broadcast" >> $file
				echo "}" >> $file

				echo "All changes saved..."
				;;
		esac

		echo -e "/n"
		read -p "Type a key to continue" key

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


