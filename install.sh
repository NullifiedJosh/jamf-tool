#!/bin/sh

# ------------------------------
# jamf-tool installer
#
# This script will download
# the jamf-tool from GitHub
# and install it to /usr/local/bin
# ------------------------------

# Set the GitHub URL
GITHUB_ACCOUNT="NullifiedJosh"
GITHUB_REPO="jamf-tool"
GITHUB_BRANCH="master"
GITHUB_URL="https://raw.githubusercontent.com/$GITHUB_ACCOUNT/$GITHUB_REPO/$GITHUB_BRANCH/"

echo "Downloading jamf-tool from GitHub..."
echo "Location: $GITHUB_URL"

# Get the latest release
LATEST_RELEASE=$(curl -s https://api.github.com/repos/$GITHUB_ACCOUNT/$GITHUB_REPO/releases/latest | grep "tag_name" | cut -d '"' -f 4) || { echo "Failed to get latest release."; exit 1;}

# Check not null
if [ -z "$LATEST_RELEASE" ]; then
	echo "Failed to get latest release."
	exit 1
fi

echo "Latest release: $LATEST_RELEASE"

# Download the latest release into temp
curl -s -L -o /tmp/jamf-tool $GITHUB_URL/jamf-tool || { echo "Download failed."; exit 1; }

echo "Download complete."

# Make the file executable
chmod +x /tmp/jamf-tool

# Move the file to /usr/local/bin
mv /tmp/jamf-tool /usr/local/bin/jamf-tool

echo "Installation complete."

# Exit
exit 0
