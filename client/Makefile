default:
	$(error Please select a target)

CNAME := prisonbreak-ssh-tunnel
SSH_KEYS_DIR ?= $(PWD)/.ssh/
SSH_IDENTITY ?= $(PWD)/.ssh/identity
PROXY_PORT ?= 1080

image:
	docker build -t geoder101/$(CNAME) .

run:
	docker run -d \
        -e SSH_USER -e SSH_HOST -e SSH_PORT \
        -p $(PROXY_PORT):1080 \
        -v $(SSH_IDENTITY):/root/.ssh/identity \
        --restart=on-failure:10 \
        --name $(CNAME) geoder101/$(CNAME)

keys:
	docker run -it --rm \
        -v $(SSH_KEYS_DIR):/root/.ssh/ \
        geoder101/$(CNAME) prisonbreak-genkeys

stop:
	docker stop $(CNAME) || docker kill $(CNAME) || true
	docker rm $(CNAME) || true

clean: stop
	docker rmi geoder101/$(CNAME) || true