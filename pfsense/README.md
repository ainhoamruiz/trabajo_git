#SEGURIDAD DE LA RED - PFSENSE#

#Direcciones de red
-MAIN: 192.168.100.0/24
-INTERNAL: 10.10.10.0/24

#Gateways
-MAIN: 192.168.100.1
-INTERNAL: 10.10.10.1

#Funciones
-Firewall
-Enrutado
-NAT
-Politicas de seguridad

#Acceso a la web
Desde tbworkers crear un canal de acceso al navegador en el 8081: ssh -L 8081:10.10.10.1:80 <usuario>@172.20.48.163
Acceder a la web para visualizar todas las reglas de firewall (credenciales por defecto user: admin / pass: pfsense): http://localhost:8081/

#Pruebas de conectividad
-Ping para la conexion desde una main a internal -> funciona
-Ping para la conexion desde una main a internet -> funciona
-Ping para la conexion desde una internal a main -> funciona
-Ping para la conexion desde una internal a internet -> no funcion
-Curl a la WAN (o crear puente para acceder desde el navegador) para el acceso de internet a balanceador -> funciona
-Acceso de internet a una vm distinta al balanceador -> no funciona
