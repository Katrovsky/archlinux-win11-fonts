#!/bin/bash

# Check if wget is installed and install it if not
if ! command -v wget &> /dev/null; then
    echo "wget is not found. Installing wget..."
    sudo pacman -Sy wget --noconfirm
fi

# Create the 'Fonts' directory if it doesn't exist
mkdir -p Fonts

# List of URLs for downloading packages
urls=(
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-japanese-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-korean-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-other-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-sea-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-thai-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-zh_cn-10.0.22631.2506-1-any.pkg.tar.zst"
    "https://github.com/Katrovsky/archlinux-win11-fonts/raw/main/ttf-ms-win11-zh_tw-10.0.22631.2506-1-any.pkg.tar.zst"
)

# Download and install packages
for url in "${urls[@]}"
do
    wget --continue "$url" -P Fonts/
    package=$(basename "$url")
    sudo pacman -U "Fonts/$package" --noconfirm
done

# Update the font cache
sudo fc-cache -f

# Prompt for deleting the 'Fonts' directory
read -p "Do you want to delete the 'Fonts' directory? (Y/n): " answer
answer=${answer:-Y} # Default to positive answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    rm -rf Fonts
else
    echo "The 'Fonts' directory will not be deleted."
fi