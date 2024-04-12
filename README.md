# cleanup

A script to remove Mac's "DS_Store" file and Quarto's rendered file artifacts, "filename.html" and "filename_files" from the current directory.

## installation
Download the script and make it executable

```bash
curl https://raw.githubusercontent.com/kmasiello/cleanup/main/cleanup.sh -o cleanup.sh

chmod u+w cleanup.sh
```
Optionally, put the script somewhere on your `$PATH`, e.g., `/usr/local/bin`

## usage

```
cd target_directory_to_clean
cleanup.sh
```
