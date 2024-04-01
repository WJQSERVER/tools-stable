version: "3.8"
services:
  sub-store:
    image: xream/sub-store:latest
    container_name: sub-store
    restart: always
    volumes:
      - /root/sub-store-data:/opt/app/data
    networks:
      hypernet:
        ipv4_address: 172.20.20.19      
    environment:
      - SUB_STORE_FRONTEND_BACKEND_PATH=/
    stdin_open: true
    tty: true
networks:
  hypernet:
    external: true   