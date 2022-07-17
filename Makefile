build:
	docker build --no-cache -t guoqiao/pgcli:latest .

push:
	docker push guoqiao/pgcli:latest
