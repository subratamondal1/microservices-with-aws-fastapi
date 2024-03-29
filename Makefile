install:
	# install commands
	pip install --upgrade pip && pip install -r requirements.txt
post-install:
	python -m textblob.download_corpora
format:
	# format code
	black *.py mylib/*.py
lint:
	# flake8 or pylint
	pylint --disable=R,C *.py mylib/*py
test:
	# test
	python -m pytest --cov=mylib test_logic.py
build:
	# build build
	docker build -t fastapi-wiki .
run:
	# docker run
	docker run -p 127.0.0.1:8080:8080 b19ef7dfd01b
deploy:
	# deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 561744971673.dkr.ecr.us-east-1.amazonaws.com
	docker build -t fastapi-wiki .
	docker tag fastapi-wiki:latest 561744971673.dkr.ecr.us-east-1.amazonaws.com/fastapi-wiki:latest
	docker push 561744971673.dkr.ecr.us-east-1.amazonaws.com/fastapi-wiki:latest
install-local:
	# use this to work with poetry in your local environment, github actions were throwing error
	poetry install --no-root
all: install post-install format lint test deploy
