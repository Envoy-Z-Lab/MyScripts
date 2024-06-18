#!/usr/bin/env bash
#
# Script to upload files to GitHub
#

# Prompt the user to input the path to the ROM ZIP file
read -p "Please enter the path to the ROM ZIP: " ROM_ZIP_PATH

# Define the paths to the files that need to be uploaded
FILES=(
    "out/target/product/enchilada/boot.img"
    "out/target/product/enchilada/dtbo.img"
    "out/target/product/enchilada/super_empty.img"
    "out/target/product/enchilada/vbmeta.img"
    "$ROM_ZIP_PATH"
)

# GitHub repository information
GH="https://github.com/Envoy-Z-Lab/Releases"
TAG="EvolutionXYZ-Enchilada"

# Function to upload a file to GitHub
upload_file() {
    local FP=$1
    echo -e "Uploading $FP to GitHub..."
    gh release create $TAG --generate-notes --repo $GH
    gh release upload --clobber $TAG $FP --repo $GH
}

# Iterate over each file in the FILES array and upload it
for file in "${FILES[@]}"; do
    upload_file $file
done
