default:
	$(error Please select a target)

CNAME := prisonbreak-ssh-alt-port

image:
	docker build -t geoder101/$(CNAME) .

run:
	docker run -d \
        --net="host" \
        --restart=on-failure:10 \
        --name $(CNAME) geoder101/$(CNAME)

stop:
	docker stop $(CNAME) || docker kill $(CNAME) || true
	docker rm $(CNAME) || true

clean: stop
	docker rmi geoder101/$(CNAME) || true
