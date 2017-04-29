# Boilerplate
p := $(p).x
dirstack_$(p) := $(d)
d := $(dir)

# Local rules and targets
ifndef SCALA_VERSION
$(error SCALA_VERSION is undefined)
endif
ifndef KAFKA_VERSION
$(error KAFKA_VERSION is undefined)
endif

DOCKER_IMAGE_$(d) := b9company/kafka
DOCKER_TAG_$(d) := $(SCALA_VERSION)-$(KAFKA_VERSION)

BUILD := $(BUILD) build_$(d)
PUSH := $(PUSH) push_$(d)

build_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
build_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
build_$(d): DOCKER_CONTEXT := $(d)
build_$(d): KAFKA_MIRROR := http://apache.crihan.fr/dist/kafka
build_$(d): KAFKA_LOGDIRS := /var/log/kafka
build_$(d): $(d)/Dockerfile
	docker build \
		--build-arg SCALA_VERSION="$(SCALA_VERSION)" \
		--build-arg KAFKA_VERSION="$(KAFKA_VERSION)" \
		--build-arg KAFKA_MIRROR="$(KAFKA_MIRROR)" \
		--build-arg KAFKA_LOGDIRS="$(KAFKA_LOGDIRS)" \
		$(if $(KAFKA_ARCHIVE),--build-arg KAFKA_ARCHIVE="$(KAFKA_ARCHIVE)") \
		-t "$(DOCKER_IMAGE):$(DOCKER_TAG)" "$(DOCKER_CONTEXT)"

push_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
push_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
push_$(d):
	docker push "$(DOCKER_IMAGE):$(DOCKER_TAG)"

# Boilerplate
d := $(dirstack_$(p))
p := $(basename $(p))
