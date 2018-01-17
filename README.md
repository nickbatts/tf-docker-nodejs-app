# Node.js App Docker Boilerplate

![MIT license](https://img.shields.io/apm/l/vim-mode.svg "MIT license")
![Build passing](https://img.shields.io/circleci/project/github/badges/shields.svg "Build passing")
![Version 0.5.0](https://img.shields.io/badge/release-0.5.0-yellow.svg "Version 0.5.0")

Dockerized node.js app with optional Terraform deploy.

## Table of Contents

- [Overview](#overview)
- [Install tools](#install-tools)
- [Quick start](#quick-start)
- [Customization](#customization)
- [Build multi-node cluster](#build-multi-node-cluster)
- [Technical notes](#technical-notes)

## Overview

This is a boilerplate to get started with deploying a node.js app to a docker cluster using either _docker-compose_ or [Terraform](https://www.terraform.io/intro/index.html).

The index.js is the entry point for the app and 

The entire infrastructure can be deployed to a docker host using Terraform.

Other possible Terrraform implementations are:
* The node.js app can be deployed to a bare EC2 instance on AWS.
* The node.js app can be deployed to a docker swarm cluster on AWS.


## Install tools

Instructions for [Terraform](http://www.terraform.io/downloads.html) (MacOS):

```bash
    $ brew update
    $ brew install terraform
```

For other platforms, follow the links and instructions on the Terraform site. Remember to periodically update these packages. 

## Quick start

#### Clone the repo:
```
$ git clone https://github.com/nickbatts/tf-docker-nodejs-app.git
$ cd tf-docker-nodejs-app
$ docker stack deploy --compose-file docker-compose.yml nodeapp 
```
#### Terraform version:
```bash
$ terraform plan terraform-docker-nodejs-server.tf
$ terraform apply terraform-docker-nodejs-server.tf
```

#### Run terraform from Docker container (Optional)
Instead of installing terraform on your local machine,
there is Docker build for a container with all the necessary tools installed:
```bash
$ docker run -it hashicorp/terraform:light plan terraform-docker-nodejs-server.tf
```

## Customization
  
The _index.js_ & _package.json_ files can be changed to match your node.js project

#### To build:
```
$ docker build -t nodejs-server:latest .Sending build context to Docker daemon   5.12kB
Step 1/6 : FROM node:alpine
 ---> b5f94997f35f
Step 2/6 : WORKDIR /app
 ---> Using cache
 ---> c20d6bbd0a0b
Step 3/6 : COPY . .
 ---> Using cache
 ---> a73ee70d8901
Step 4/6 : EXPOSE 3000
 ---> Using cache
 ---> 628949a45bb1
Step 5/6 : USER node
 ---> Using cache
 ---> 9a0681bee832
Step 6/6 : CMD ["node","index.js"]
 ---> Using cache
 ---> c5c2dbdeafdc
Successfully built c5c2dbdeafdc
Successfully tagged nodejs-server:latest
```

#### View containers logs:

```
$ docker logs <container-id>
server is listening on 3000
```
#### Destroy all resources

```
$ terraform destroy
```
This will destroy ALL resources created by this project. You will be asked to confirm before proceeding.

## Build multi-node cluster

The number of app worker nodes are defined in *docker-compose.yml*

Change the replicas in the file to scale cluster.
_eg_, change to 3:

```
    deploy:
      mode: replicated
      replicas: 3
```


## Technical notes
* File tree

```
./
|-- Dockerfile							# docker build file
|-- docker-compose.yml					# docker service definition
|-- index.js							# node app entry point
|-- package.json						# app package definitions
`-- terraform-docker-nodejs-server.tf	# deploy with terraform
```
* You may need to edit the docker host variable in the terraform template if not using local docker.

## Helpful Commands

### Docker administration
* `$ docker ps` - view running docker processes
* `$ docker service ls` - view running docker services if using _docker-compose.yml_
* `$ docker stop $(docker ps -aq) && docker rm $(docker ps -aq)` - stop and remove all docker containers

* `terraform init` - initialize terraform and install modules

## Authors

* Nick Batts

## License

This project is licensed under the terms of the MIT license.
