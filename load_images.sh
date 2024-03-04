#!/bin/bash

# Get the list of images from 'docker images' command
image_list=$(docker images --format "{{.Repository}}:{{.Tag}}")

# Load images into Kind cluster
for image in $image_list; do
    kind load docker-image "$image" --name kubeagi
done