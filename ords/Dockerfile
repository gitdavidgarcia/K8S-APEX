FROM oraclelinux:8

RUN yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL8/oracle/software/x86_64

ENV ORDS_CONFIG="/opt/oracle/config_ords"

RUN dnf -y -q update
RUN dnf -y install java-17-openjdk unzip zip which wget sudo man
RUN dnf -y install ords
RUN dnf clean all
RUN mkdir /images
COPY ./ords/images /images
COPY ./ords/iniciar_ords.sh /opt/oracle/config_ords/
RUN chmod +x /opt/oracle/config_ords/iniciar_ords.sh 

ENTRYPOINT [ "sh","-c","/opt/oracle/config_ords/iniciar_ords.sh" ]


