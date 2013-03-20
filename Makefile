

SOURCEPATH=src
LOCALLIBS=lib/PureMVC_Java_MultiCore-1.0.8.jar;lib/commons-logging.jar;lib/log4j-1.2.16.jar;lib/mysql-connector-java-5.1.18-bin.jar;lib/sqlite-jdbc-3.7.2.jar;/opt/java/jre/lib/jfxrt.jar
CLASSPATH=$(LOCALLIBS);$(SOURCEPATH)

COMPILER=javafxpackager

FLAGS= -makeall -cp "$(CLASSPATH)" -srcdir=$(SOURCEPATH) -source 7

cyclist:

	$(COMPILER) $(FLAGS) -srcfiles $(SOURCEPATH)/cyclist/*.java
