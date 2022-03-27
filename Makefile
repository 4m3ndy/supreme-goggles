LITECOIN_VERSION?=0.18.1
LITECOIN_IMAGE_NAME?=4m3ndy/litecoin
LITECOIN_IMAGE_TAG?=v${LITECOIN_VERSION}
KUBECTL_CMD := $(shell which kubectl)
TEMP_MANIFEST_PATH := $(shell mktemp -d /tmp/tmp.k8s.XXXXX)

.PHONY: build push validate deploy all

build:
	cd litecoin && docker build . --build-arg LITECOIN_VERSION=${LITECOIN_VERSION} -f Dockerfile -t ${LITECOIN_IMAGE_NAME}:${LITECOIN_IMAGE_TAG}

push:
	docker push ${LITECOIN_IMAGE_NAME}:${LITECOIN_IMAGE_TAG}

validate:
	grype ${LITECOIN_IMAGE_NAME}:${LITECOIN_IMAGE_TAG} --fail-on high --scope all-layers

deploy:
	${KUBECTL_CMD} kustomize litecoin/kubernetes > ${TEMP_MANIFEST_PATH}/kustomization.template.yaml && \
	export DOCKER_IMAGE_TAG=${LITECOIN_IMAGE_TAG}; \
	export DOCKER_IMAGE_NAME=${LITECOIN_IMAGE_NAME}; \
	export LITECOIN_VERSION=${LITECOIN_VERSION}; \
	envsubst < ${TEMP_MANIFEST_PATH}/kustomization.template.yaml > ${TEMP_MANIFEST_PATH}/kustomization.rendered.yaml && \
	${KUBECTL_CMD} apply -f ${TEMP_MANIFEST_PATH}/kustomization.rendered.yaml || exit 3

all: build validate push deploy
