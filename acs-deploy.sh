#!/bih/sh

ssh -L 2375:localhost:2375 -f -o PasswordAuthintication=no -o StrictHostKeyChecking=no -N derui@samplemgmt.japaneast.cloudapp.azure.com -p 2200 -i `pwd`/azure-acs-private

export DOCKER_HOST=":2375"

docker-compose up -d swarm-registry
docker rm -f api
docker run --name api -d -p 80:80  "localhost:5000/flask:$CIRCLE_SHA1"
