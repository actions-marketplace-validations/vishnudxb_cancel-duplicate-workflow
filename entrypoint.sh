#!/bin/sh

set -e

REPO=$1
ID=$2
TOKEN=$3
BRANCH_NAME=$4

# Check the status of the branch

branch_status=$(curl -s -X GET -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $TOKEN" "https://api.github.com/repos/$REPO/actions/runs?branch=$BRANCH_NAME&status=in_progress" | jq '.workflow_runs[].status')

if [[ "$branch_status" == "in_progress" ]];
then
  echo "$BRANCH_NAME is running, so cancelling this build..."  
  curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $TOKEN" https://api.github.com/repos/$REPO/actions/runs/$ID/cancel
else
  echo "$BRANCH_NAME is not running, so continuing with this build"  
fi