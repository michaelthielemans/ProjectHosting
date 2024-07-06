# HELM

## Introduction
Helm is a packet manager for deploying applications to kubernetes. A package is called a CHART.

## Installation of Helm
Helm should be installed on your local machine, you also can install it on the masternode but that is not really needed.

Install procedure can be found on https://helm.sh/docs/intro/install/

## structure of a char.

## Best practices
** naming convention **
- always use lowercase chart and filenames
- use versioning labeling as: MAJOR.MINOR.PATCH like 12.03.1

** yaml syntax **
- use 2 spaces as indentation, do not use tabs!

** variables inside charts **
- use camelcase (for example: aNewVariable)
