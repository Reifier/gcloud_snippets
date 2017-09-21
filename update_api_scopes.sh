#!/usr/bin/env bash


ZONE=$(gcloud container clusters list | grep -i environ | tr -s ' ' | cut -d ' ' -f 2)
CLUSTER_NAME=$(gcloud container clusters list --zone=${ZONE} | grep -i environment | cut -d ' ' -f 1)
NUMBER_OF_NODES=$(gcloud container clusters list --zone=us-west1-a | grep -i environment | tr -s ' ' | cut -d ' ' -f 7)
MACHINE_TYPE=$(gcloud container clusters list --zone=us-west1-a | grep -i environment | tr -s ' ' | cut -d ' ' -f 5)
DEFAULT_POOL_NODES=$(kubectl get nodes | grep -i default-pool | cut -d ' ' -f 1)


gcloud container node-pools create nodepool01 --cluster ${CLUSTER_NAME} --zone ${ZONE} --num-nodes ${NUMBER_OF_NODES} --scopes https://www.googleapis.com/auth/devstorage.read_write,https://www.googleapis.com/auth/pubsub,https://www.googleapis.com/auth/monitoring --machine-type ${MACHINE_TYPE}

for node in $DEFAULT_POOL_NODES; do kubectl cordon $node; done
for node in $DEFAULT_POOL_NODES;do kubectl drain $node --force; done

gcloud container node-pools delete default-pool --zone=$ZONE --cluster=$CLUSTER_NAME
