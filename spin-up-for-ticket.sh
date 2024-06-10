#!/bin/bash
name=$1
url=$OCTOPUS_HOST
apikey=$OCTOPUS_API_KEY

octopus login --server $url --api-key $apikey
octopus space create --name $name --team Everyone --user admin --space default --no-prompt
docker run --platform linux/amd64 -d --env ServerPort=10943 --env ACCEPT_EULA=Y --env ServerApiKey=$apikey --env Space="$name" --env TargetWorkerPool="Default Worker Pool" --env ServerUrl="http://host.docker.internal:8066" --env DISABLE_DIND=Y --name "$name" octopusdeploy/tentacle

octopus environment create --space $name --name dev --no-prompt
octopus environment create --space $name --name test --no-prompt

octopus project create --space $name --name $name --lifecycle 'Default Lifecycle' --group 'Default Project Group' --no-prompt 
