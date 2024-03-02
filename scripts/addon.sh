#!/bin/bash


if [ -z "$1" ]; then
  cd "$1" || exit
fi

if [ ! -f "package.json" ]; then
  echo "package.json not found in the current directory."
  exit 1
fi

# Read the 'name' field from package.json
name=$(jq -r '.name' package.json)

# Check if name is empty or not found
if [ -z "$name" ]; then
  echo "The 'name' field is not set in package.json."
  exit 1
fi

# Remove the existing directory under /addons if it exists
if [ -d "/addons/$name" ]; then
  echo "Removing existing directory /addons/$name..."
  rm -rf "/addons/$name"
fi

# Copy the addon directory to /addons with the name from package.json
echo "Copying ./addon to /addons/$name..."
cp -r ./addon "/addons/$name"

echo "Operation completed successfully."
