#PRUEBAS routing para conectar cliente1 y cliente2 mediante routing por el routerC

Cliente1:
ip route add 10.0.2.0/24 via 10.0.1.2
Cliente2:
ip route add 10.0.1.0/24 via 10.0.2.2

#mirar rutas de default