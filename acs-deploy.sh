#!/bih/sh

ssh-keygen -p -P "" -N "" `pwd`/azure-acs-private
ssh -L 2375:localhost:2375 -f -o "PasswordAuthentication no" -o "StrictHostKeyChecking no" -N derui@samplemgmt.japaneast.cloudapp.azure.com -p 2200 -i `pwd`/azure-acs-private

export DOCKER_HOST=":2375"

docker run -d -p 5000:5000 --name swarmregistry -e "REGISTRY_STORAGE_AZURE_ACCOUNTKEY=$AZURE_ACCOUNT_KEY" "localhost:50000/swarm-registry"
docker rm -f api
docker run --name api -d -p 80:80  "localhost:5000/flask:$CIRCLE_SHA1"
