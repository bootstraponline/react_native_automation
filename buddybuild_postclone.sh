#!/usr/bin/env bash

# list rubies (ruby-2.2.5, ruby-2.3.1)
chruby

# select ruby
chruby ruby-2.3.1

# list all files
# find / . > files.txt

# install gcloud sdk
curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-141.0.0-darwin-x86_64.tar.gz | tar xz

# add 'gcloud' to path
export PATH="`pwd`/google-cloud-sdk/bin:$PATH"

# authenticate
echo $GCLOUD_KEY | base64 --decode > "gcloudkey.json"
gcloud config set project "$GCLOUD_PROJECT"
gcloud auth activate-service-account --key-file "gcloudkey.json" "$GCLOUD_USER"

# list folders
ls -la

# exit early
echo "finished"
exit 1
