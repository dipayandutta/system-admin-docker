FROM ubuntu:20.04 AS stage0
RUN apt-get update && apt-get install -y vim 

FROM stage0 AS stage1
RUN apt-get install nginx -y
EXPOSE 80
ENTRYPOINT ["nginx","-g"]
CMD ["daemon off;"]
