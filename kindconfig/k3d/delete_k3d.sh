#!/bin/sh

# for cluster in $(k3d cluster list); do
# 	echo "deleting.. $cluster"
# 	k3d cluster delete $cluster
# done

cluster="k3d-1"
k3d cluster delete $cluster
