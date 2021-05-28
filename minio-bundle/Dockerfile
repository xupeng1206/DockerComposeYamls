FROM debian

WORKDIR /root

ARG proxy="true"

RUN set -ex; \
    if [ "${proxy}" = "true" ] ; then \
        mv /etc/apt/sources.list /etc/apt/sources.list.bak; \
        echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\ndeb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib\ndeb http://mirrors.aliyun.com/debian-security buster/updates main\ndeb-src http://mirrors.aliyun.com/debian-security buster/updates main\ndeb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\ndeb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\ndeb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\ndeb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\n" > /etc/apt/sources.list; \
    fi; \
    apt-get update; \
    apt-get install -y openssl; \
    apt-get install -y libssl-dev; \
    rm -rf /var/lib/apt/lists/*

COPY ./kes /bin/kes
COPY ./minio /bin/minio
COPY ./kes-server-config.yml /root/kes-server-config.yml    
COPY ./start_minio.sh /root/start_minio.sh

RUN chmod 777 /root/kes-server-config.yml; \
    chmod 777 /root/start_minio.sh; \
    chmod 777 /bin/kes; \
    chmod 777 /bin/minio


EXPOSE 7373 9000

CMD  [ "/root/start_minio.sh" ]
