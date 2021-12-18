docker stop jenkins-docker && docker rm jenkins-docker

docker container run --name jenkins-docker \
  --restart unless-stopped \
  --detach \
  --privileged --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376\
  docker:dind

docker stop jenkins-blueocean && docker rm jenkins-blueocean

docker container run --name jenkins-blueocean \
  --restart unless-stopped \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --publish 8080:8080 \
  --publish 50000:50000 \
jenkins-blueocean