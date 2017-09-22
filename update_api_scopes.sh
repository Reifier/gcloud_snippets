#!/usr/bin/env bash


ZONE=$(gcloud container clusters list | grep -i environ | tr -s ' ' | cut -d ' ' -f 2)
CLUSTER_NAME=$(gcloud container clusters list --zone=${ZONE} | grep -i environment | cut -d ' ' -f 1)
NUMBER_OF_NODES=$(gcloud container clusters list --zone=us-west1-a | grep -i environment | tr -s ' ' | cut -d ' ' -f 7)
MACHINE_TYPE=$(gcloud container clusters list --zone=us-west1-a | grep -i environment | tr -s ' ' | cut -d ' ' -f 5)
DEFAULT_POOL_NODES=$(kubectl get nodes | grep -i default-pool | cut -d ' ' -f 1)


echo "Creating a pool"
gcloud container node-pools create nodepool01 --cluster ${CLUSTER_NAME} --zone ${ZONE} --num-nodes ${NUMBER_OF_NODES} --scopes https://www.googleapis.com/auth/devstorage.read_write,https://www.googleapis.com/auth/pubsub,https://www.googleapis.com/auth/monitoring --machine-type ${MACHINE_TYPE}

echo "Cordoning nodes"
for node in $DEFAULT_POOL_NODES; do kubectl cordon $node; done
echo "Draining nodes"
for node in $DEFAULT_POOL_NODES;do kubectl drain $node --force --delete-local-data --ignore-daemonsets; done

echo "Enabling monitoring"
gcloud beta container clusters update $CLUSTER_NAME --monitoring-service=monitoring.googleapis.com --zone=$ZONE

echo "Will delete a pool in 10 sec"
sleep 10

gcloud container node-pools delete default-pool --zone=$ZONE --cluster=$CLUSTER_NAME
