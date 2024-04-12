#!/bin/bash

## A script to remove "DS_Store" and Quarto's rendered file artifacts, "filename.html" and "filename_files"
## Removes files from the current directory only.

# Check if there are any .qmd files or DS_Store files in the current directory
if ! find . -maxdepth 1 \( -name "*.qmd" -o -name "DS_Store" \) -print -quit | grep -q .; then
    echo "No .qmd files or DS_Store found in the current directory."
    exit 1
fi

# Get the list of .qmd files in the current directory
qmd_files=(*.qmd)

# Initialize arrays to store files and directories to be deleted
files_to_delete=()
directories_to_delete=()

# Loop through each .qmd file
for qmd_file in "${qmd_files[@]}"; do
    # Extract basename
    basename=$(basename "$qmd_file" .qmd)
    
    # Check if corresponding .html file exists and add it to the list of files to be deleted
    if [ -f "${basename}.html" ]; then
        files_to_delete+=("${basename}.html")
    fi
    
    # Check if corresponding directory _basename_files exists and add it to the list of directories to be deleted
    if [ -d "${basename}_files" ]; then
        directories_to_delete+=("${basename}_files")
    fi
done

# Add any file named "DS_Store" in the current directory to the list of files to be deleted
if [ -f "DS_Store" ]; then
    files_to_delete+=("DS_Store")
fi


# Check if there are no files or directories to delete
if [ ${#files_to_delete[@]} -eq 0 ] && [ ${#directories_to_delete[@]} -eq 0 ]; then
    echo "No files or directories to delete."
    exit 0
fi

# Display confirmation message listing files and directories to be deleted
echo "The following files and directories will be deleted:"
for file in "${files_to_delete[@]}"; do
    echo "$file"
done
for dir in "${directories_to_delete[@]}"; do
    echo "$dir"
done

# Ask for confirmation before proceeding
read -p "Do you want to proceed? [y/N] " choice
case "$choice" in
  y|Y ) 
    # If confirmed, delete the files and directories
    for file in "${files_to_delete[@]}"; do
        rm "$file"
        echo "Deleted $file"
    done
    for dir in "${directories_to_delete[@]}"; do
        rm -r "$dir"
        echo "Deleted $dir"
    done
    ;;
  * ) 
    # If not confirmed, exit
    echo "Operation aborted."
    exit 0
    ;;
esac
