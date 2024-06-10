#!/bin/bash

name=$1
url=$OCTOPUS_HOST
apikey=$OCTOPUS_API_KEY

octopus login --server $url --api-key $apikey
octopus space delete $name -s $name -y --no-prompt
docker stop $name
docker rm $name --force