# Packer Templates for VoltDB and supporting technologies

## Running Instructions
1. `cd` to your target platform's directory
2. `packer build -var-file=../{PRODUCT.json} -var-file=project-vars.json template.json`

## Issues
1. Installation of Open JDK continues to be a pain. Installation of APT package of default-jdk fails intermittently

## Pending
1. Untar and rename directories while remaining agnostic of the directory name
2. Add stuff to PATH
