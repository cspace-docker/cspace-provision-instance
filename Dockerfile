FROM rem/cspace-version
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

#
# Setup CollectionSpace instance-specific database properties
#
ENV DB_CSADMIN_PASSWORD csadmin
ENV DB_CSPACE_PASSWORD cspace
ENV DB_NUXEO_PASSWORD nuxeo
ENV DB_READER_PASSWORD reader

#
# Perform a full source code build and deployment. NOTE: We must build the Application layer first since it creates the configuation tool
# need to create the Service layer's configuration artifacts -i.e, things like the Nuxeo plugins and service bindings.
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/application && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && mvn clean install -DskipTests
RUN cd $USER_HOME/$CSPACE_USERNAME/src/ui && mvn clean install -DskipTests

#
# Deploy configuration artifacts, create and initialize the databases, and populate with AuthN/AuthZ tables
#
RUN cd $USER_HOME/$CSPACE_USERNAME/src/services && ant undeploy deploy create_db import

#
# Finally export port 8180 to our host
#
EXPOSE 8180
