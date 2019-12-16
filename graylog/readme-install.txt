### Pull below 3 images from Docker HUB:
$ docker pull mongo:3
$ docker pull elasticsearch:6.8.0 
$ docker pull graylog/graylog:3.0

# Install & Run Graylog with in 2 Minute.
-------------RUN 3 Containers ----------- 
$ docker run --name mongo -d mongo:3 
$ docker run --name elasticsearch -e "http.host=0.0.0.0" -e "xpack.security.enabled=false" -d elasticsearch 
$ docker run --link mongo --link elasticsearch -p 9000:9000 -p 12201:12201 -p 514:514 -e GRAYLOG_WEB_ENDPOINT_URI="http://graylog-container-ip:9000/api" -d graylog/graylog:3.0

------ OPEN GRAYLOG ------- 
http://graylog-container-ip:9000
