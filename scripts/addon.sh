#!/bin/bash
# Reset
NC='\033[0m' # No Color


# Bold
BOLD='\033[1m'
BOLD_RED='\033[1;31m'
BOLD_CYAN='\033[1;36m'

if [ -z "$1" ]; then
  cd "$1" || exit
fi

if [ ! -f "package.json" ]; then
  echo -e "${BOLD_RED}package.json${NC} not found in the current directory."
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
  echo -e "Removing existing directory ${BOLD}/addons/$name...${NC}"
  rm -rf "/addons/$name"
fi

# Copy the addon directory to /addons with the name from package.json
echo -e "Copying ${BOLD_CYAN}./addon${NC} to ${BOLD_CYAN}/addons/$name...${NC}"
cp -r ./addon "/addons/$name"

echo "Operation completed successfully."
