gcloudcontext () {
    if [ $1="fluentd-test-cluster" ]; then
      gcloud container clusters get-credentials fluentd-test-cluster --zone us-west1-b --project poc-tier1;
      gcloud config set project poc-tier1
      echo "Changed to $1"
    elif [ $1="poc-environment" ]; then
      gcloud container clusters get-credentials poc-environment --zone us-west1-a --project poc-tier1
      gcloud config set project poc-tier1
      echo "Changed to $1"
    elif [ $1="integration-environment" ]; then
      gcloud container clusters get-credentials integration-environment --zone us-west1-a --project integration-tier1
      gcloud config set project integration-tier1
      echo "Changed to $1"
    elif [ $1="staging-environment" ]; then
      gcloud container clusters get-credentials staging-environment --zone us-west1-a --project staging-tier1
      gcloud config set project staging-tier1
      echo "Changed to $1"
    elif [ $1="performance-environment" ]; then
      gcloud container clusters get-credentials performance-environment --zone us-west1-a --project performance-tier1
      gcloud config set project performance-tier1
      echo "Changed to $1"
    elif [ $1="production-environment" ]; then
      gcloud container clusters get-credentials production-environment --zone us-west1-a --project production-tier1
      gcloud config set project production-tier1
      echo "Changed to $1"
    fi
}
