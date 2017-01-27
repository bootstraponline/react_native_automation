#!/usr/bin/env bash

# list rubies (ruby-2.2.5, ruby-2.3.1)
chruby

# select ruby
chruby ruby-2.3.1

# list all files
# find / . > files.txt

curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-141.0.0-darwin-x86_64.tar.gz | tar xz

# tar -zxf google-cloud-sdk-*.tar.gz

ls -la

echo "finished"
exit 1
