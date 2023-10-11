#Dockerfile
This image is based on the fluentd official image. It is installed the elasticsearch plugin, but it's likely to be useless.
##Entrypoint for fluentd
The entrypoint script is copied which means it is integrated in the fluentd image. To change them, the image needs to be changed as well. 
Finally it's made executable thanks to chmod.

###Entrypoints script
* Fluentd is start by using the configuration file present in the shared volume (refere to docker-compose.yml file or readme) and executed in background.
* Finally the sleep command is called.

##Additional notes
Differently from the other images used fluentd doesn't allow the bash shell but the sh.

#Conf
In the conf directory is present the fluent.conf file, which is used to start fluentd.
Still have to use it at the best.
#Output
Is where the output.log is. It's produced by fluentd as described in the fluent.conf
#Shared-volume
Is the shared volume as described in the docker-compose file. It contains the frr folder with the logs produced by frr (that are also sources in the fluent.conf)