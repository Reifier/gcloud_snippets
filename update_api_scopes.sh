#!/usr/bin/env bash

ZONE="us-west1-a"
CLUSTER_NAME=$(gcloud container clusters list --zone=${ZONE} | grep -i environment | cut -d ' ' -f 1)
NUMBER_OF_NODES=$(gcloud container clusters list --zone=${ZONE} | grep -i environment | cut -d ' ' -f 1)
MACHINE_TYPE=

gcloud container clusters list --zone=${ZONE}



