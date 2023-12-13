# TFG - Recolección y Detección de Anomalias en la Red


## Control de versiones:


##### 13/12/2023:

- NAT realizado en los routers para que los clientes puedan salir por internet ->  /router/entrypoints/
- hping3 instalado en los clientes para realizar SYN Flood a otros hosts de la red y comprobar que datos se recogen.
- Probando con el siguiente comando para determinar los parametros a recoger:
tshark -i any -f "tcp[tcpflags] & (tcp-syn) != 0 and (tcp[tcpflags] & (tcp-ack) = 0)" -T fields -e frame.time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -e tcp.flags.syn -e tcp.flags.ack -e tcp.flags.res -E header=y -E separator=, -E quote=d -E occurrence=f >> /shared-volume/pruebaD.csv
- eBPF/BCC descartado por el momento debido a la dependencia del kernel.


##### 7/12/2023:
#
Recogida de los logs de cada Router a nivel de red:
- tshark (wireshark en linea de comandos) instalado en la imagen de los 4 routers
- Se recoge  TODO el tráfico de cada router y se aloja la salida en /shared-volume/tshark con el nombre del fichero hostnameDelRouter+Log.txt. El comando que se ejecuta en cada entrypoint es el siguiente: (se puede acotar el tráfico)
```sh
tshark -i any > /shared-volume/"$(hostname)"Log.txt &
```
- Una vez identificada la salida de los 4 routers se unifica /teacher-fluentd/output gracias a la configuración realizada en fluentd. Se nombra como "fecha  nombredelrouter {mensaje}"

Ejemplo:   ping del alumno1(10.0.1.3) al profesor(10.200.0.3):
Esta información es la que vería cada router (A, B y C) que se unifica todo ello en el output the fluentd. (Router D no porque no pasa el tráfico por ese router.)

teacher-fluentd/output/output.log.YYYYMMDD

###### 2023-12-07T15:33:40+00:00	routerAlogs	{"message":" 1903 495.681282000     10.0.1.3 → 10.200.0.3   ICMP 100 Echo (ping) request  id=0x0024, seq=277/5377, ttl=61"} 
###### 2023-12-07T15:33:40+00:00	routerAlogs	{"message":" 1904 495.681300300   10.200.0.3 → 10.0.1.3     ICMP 100 Echo (ping) reply    id=0x0024, seq=277/5377, ttl=64 (request in 1903)"}
###### 2023-12-07T15:31:22+00:00	routerBlogs	{"message":" 1296 354.000500500     10.0.1.3 → 10.200.0.3   ICMP 100 Echo (ping) request  id=0x0024, seq=139/35584, ttl=62"}
###### 2023-12-07T15:31:22+00:00	routerBlogs	{"message":" 1297 354.000535900   10.200.0.3 → 10.0.1.3     ICMP 100 Echo (ping) reply    id=0x0024, seq=139/35584, ttl=63 (request in 1296)"}
###### 2023-12-07T15:31:25+00:00	routerClogs	{"message":"  976 361.760303300     10.0.1.3 → 10.200.0.3   ICMP 100 Echo (ping) request  id=0x0024, seq=147/37632, ttl=63"}
###### 2023-12-07T15:31:25+00:00	routerClogs	{"message":"  977 361.760351100   10.200.0.3 → 10.0.1.3     ICMP 100 Echo (ping) reply    id=0x0024, seq=147/37632, ttl=62 (request in 976)"}


#
##### 13/10/2023: 

Configuradas las rutas dinamicas gracias a OSPF en todos los routers y configuradas las rutas estaticas del gateway de cada host para la conectividad entre hosts, profesor y router.
