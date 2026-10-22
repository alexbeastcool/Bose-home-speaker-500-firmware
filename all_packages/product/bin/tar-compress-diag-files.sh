#!/bin/bash

echo "tar-compress-diag-files.sh - START"

# The files to be included in the tarball must be passed in as arguments to the script.
tar -cvzf /mnt/nv/product-persistence/dfs_diagfile.tar.gz -C /mnt/nv/product-persistence $@ 

#gzip $1
echo "tar-compress-diag-files.sh - END"

