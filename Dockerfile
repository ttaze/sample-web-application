FROM tomcat 
WORKDIR webapps 
COPY target/WebApp.war .

ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
