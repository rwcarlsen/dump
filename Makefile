

SOURCEPATH=src
LOCALLIBS=lib/PureMVC_Java_MultiCore-1.0.8.jar:lib/commons-logging.jar:lib/log4j-1.2.16.jar:lib/mysql-connector-java-5.1.18-bin.jar:lib/sqlite-jdbc-3.7.2.jar
JAVAFX=/opt/java/jre/lib/jfxrt.jar:/opt/java/lib/ant-javafx.jar

CLASSPATH=$(LOCALLIBS):$(JAVAFX):$(SOURCEPATH)

JR=java
JC=javac
FLAGS=-classpath "$(CLASSPATH)"

cyclist:

	$(JC) $(FLAGS) $(SOURCEPATH)/cyclist/*.java

run:

	cd src
	$(JR) $(FLAGS) cyclist/Cyclist

