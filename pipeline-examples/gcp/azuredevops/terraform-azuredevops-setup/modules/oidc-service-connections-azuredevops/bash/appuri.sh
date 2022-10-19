#!/bin/bash
# create application URL

Result=$(az ad app update --id $1 --identifier-uris "api://$1" --output json)

JSON="{\"result\": \"$Result\"}"
echo $JSON