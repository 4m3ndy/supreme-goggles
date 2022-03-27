# supreme-goggles
This repository define a dockerized version of Litecoin node and How to deploy it on top of Kubernetes with a simple Jenkins Pipeline script.

## Requirements (Locally or Jenkins CI agents)
- docker - Jenkins Agent needs to have Docker installed and authenticated with Docker Hub.
- kubectl >= 1.20 - Jenkins Agent should also have kubeconfig configured.
- grype >= 0.34.7 - A vulnerability scanner for container images and filesystems, provided by Anchore.
- envsubst - for replacing environment variables defined in kubernetes manifests.
- GNU Make - for running make targets


## How to run
First you need to set the required environment variables to be used in `Makefile`
```bash
LITECOIN_VERSION?=0.18.1
LITECOIN_IMAGE_NAME?=4m3ndy/litecoin
LITECOIN_IMAGE_TAG?=v${LITECOIN_VERSION}
```
#### Use the following Helper Commands to easily manage the Litecoind deployment process:

| Command | Description |
| --- | --- |
| `make build` | Builds the docker image of the Litecoin |
| `make validate` | Scans container images for vulnerabilities, and show severity of each vulnerability |
| `make push` | Pushes the docker image to the docker registry, Invoke it before `make validate` and `make push` |
| `make deploy` | Deploys the kubernetes manifests to the kuberentes cluster |
| `make all` | Build, Validate, Push and Deploy the Litecoin image |

## Kubernetes Manifests Definition
Assumptions
- There is no namespace `litecoin`
- `storageClassName: default` exists

Additional information
- Using `runAsUser` and `fsGroup` to ensure that it runs with with a non-root user

## Jenkinsfile
This is a Declarative Pipeline defined using Jenkinsfile (Groovy DSL), You need to defined a Pipeline job with:
- repository `https://github.com/4m3ndy/supreme-goggles.git`
- branch `main`