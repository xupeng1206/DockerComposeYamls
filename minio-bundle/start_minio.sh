#!/bin/sh
cd /root/

openssl ecparam -genkey -name prime256v1 | openssl ec -out server.key
openssl req -new -x509 -days 3650 -key server.key -out server.cert -subj "/C=/ST=/L=/O=/CN=localhost" -addext "subjectAltName = IP:127.0.0.1"
kes tool identity new --key=minio.key --cert=minio.cert MinIO

export MINIO_IDENTITY=$(kes tool identity of minio.cert)
kes server --config=/root/kes-server-config.yml --auth=off &

sleep 3

export KES_CLIENT_CERT=minio.cert
export KES_CLIENT_KEY=minio.key
kes key create -k my-minio-key

export MINIO_KMS_KES_ENDPOINT=https://127.0.0.1:7373
export MINIO_KMS_KES_CERT_FILE=minio.cert
export MINIO_KMS_KES_KEY_FILE=minio.key
export MINIO_KMS_KES_CA_PATH=server.cert
export MINIO_KMS_KES_KEY_NAME=my-minio-key
export MINIO_KMS_AUTO_ENCRYPTION=on

minio server /data
