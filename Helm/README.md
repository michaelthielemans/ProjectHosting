# HELM

## Introduction
Helm is a packet manager for deploying applications to kubernetes. A package is called a CHART.

## Installation of Helm
Helm should be installed on your local machine, you also can install it on the masternode but that is not really needed.

Install procedure can be found on https://helm.sh/docs/intro/install/

## Structure of a chart.

```
wordpress/
  Chart.yaml          # A YAML file containing information about the chart
  LICENSE             # OPTIONAL: A plain text file containing the license for the chart
  README.md           # OPTIONAL: A human-readable README file
  values.yaml         # The default configuration values for this chart
  values.schema.json  # OPTIONAL: A JSON Schema for imposing a structure on the values.yaml file
  charts/             # A directory containing any charts upon which this chart depends.
  crds/               # Custom Resource Definitions
  templates/          # A directory of templates that, when combined with values, will generate valid Kubernetes manifest files.
  templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes
```

## Best practices
**naming convention**
- always use lowercase chart and filenames
- use versioning labeling as: MAJOR.MINOR.PATCH like 12.03.1

**yaml syntax**
- use 2 spaces as indentation, do not use tabs!

**variables inside charts**
- use camelcase (for example: aNewVariable)
