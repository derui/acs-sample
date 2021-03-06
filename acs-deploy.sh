#!/bih/sh

ssh -L 2375:localhost:2375 -f -o "StrictHostKeyChecking no" -N derui@samplemgmt.japaneast.cloudapp.azure.com -p 2200 -i `pwd`/azure-acs-private

export DOCKER_HOST=":2375"

if [ "`docker ps -q | grep swarmregistry | wc -l`" != "1" ]; then
    docker build -f Dockerfile.registry -t swarm-registry .
    docker run -d -p 5000:5000 --name swarmregistry -e "REGISTRY_STORAGE_AZURE_ACCOUNTKEY=$AZURE_ACCOUNT_KEY" swarm-registry
fi
docker rm -f api
docker run --name api -d -p 80:80  "localhost:5000/flask:$CIRCLE_SHA1"
