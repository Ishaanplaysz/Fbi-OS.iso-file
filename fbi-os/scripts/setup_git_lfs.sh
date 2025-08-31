#!/bin/bash
# Setup Git LFS for FBI-OS repo

git lfs install
git lfs track "fbi-os/build/*.iso"
git lfs track "fbi-os/assets/*"
echo "Git LFS setup complete."
