#!/bin/bash

# Initialize an empty array to store the image names
models=()

# Prompt the user to enter image names until they enter an empty line
echo "Enter only one model per promt, no spaces"
echo "Example:"
echo "Enter a model to download: llama3"
echo "Enter a model to download: llama2-uncensored"
echo "Enter a model to download: codegemma:2b"
echo "Enter a model to download: mistral:instruct"
echo "Enter a model to download: "
echo "**Models will start downloading after an empty line is input**"
while true; do
  read -p "Enter a model to download: " model
  if [ -z "$model" ]; then
    break
  fi
  models+=("$model")
done

# Loop through the images and execute the docker pull command for each one
for model in ${models[@]}; do
  docker exec -it ollama ollama pull $model
done