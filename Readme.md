
## PROJECT NODE.JS USING TERRAFORM
This project entails the provisioning of a Docker container and inside that image container is a node.js application showing "hello world" on the browser once its deployed on port: 80

When looking for perfect javascript library React comes into mind, In an application React will give a component based structure for everything inclusive while allowing abstraction if and when required to reduce duplication.
For any application to truely gets its value after development and for it to provide the needed value, it is bery critical tht it be shown to the rest of the world.Although there are many options opened for such application to exposed but it can be a difficult task trying to pick the right solution to adopt.

### Projects Requirements and Featured technologies
•	Node.js: An open-source JavaScript run-time environment for executing server-side JavaScript code.
•	Cloud: Accessing computer and information technology resources through the Internet.
•	Container Orchestration:  Scaling and management of containerized applications.
### Steps
### Prerequisites

First download and install the terraform using this link
As a first step, install terraform (see: https://www.terraform.io/downloads)) and select your machine version if its windows and if its mac you can select accordingly and install the requirements:
### To check if terraform was installed

$ terraform --version

Download and run the AWS CLI MSI installer for Windows (64-bit) and add the IAM user credentails gotten from AWS the secret_key and the access_key

https://awscli.amazonaws.com/AWSCLIV2.msi

## Terraform Access Provisioing and Docker requirements for this project:

I created the provider.tf file and insert the follwing code snippeets below
terraform {

  required_providers {

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"

    }
  }
}
provider "docker" {

  host    = "npipe:////.//pipe//docker_engine"
}

I used vscode for this project and on my local terminal i have Docker Deskstop already installed, to check for the installation

$ docker --version
Then next i  downloaded a node.js using this link https://nodejs.org/en/download/current/ and select the windows installer

Then inside the terminal of my vscode for the project i ran the following command below

$ npm init

### then i ran the command

$ npm install --express

The above automatically generated the package.json , packagelock.json and node_modules files for the project


Then i created the an app.js or the default page as shown below with the code

const express = require('express')

const app = express()

const port = 8080 

app.get('/', (req, res) => res.send('Welcome to my page!')) 

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`))

The code shows the the port that app server will listen at port 8080

Next i created the Dockerfile and inside expose the the conatiner image at 8080 whith a base image of node:alpine as hsown below
in this Dockerfile

FROM node:10

RUN mkdir /myapp

### Create app directory
WORKDIR /myapp

COPY ./package.json /myapp/package.json
COPY ./package-lock.json /myapp/package-lock.json

RUN npm install
RUN npm install -g nodemon

### Bundle app source
COPY . /myapp

EXPOSE 8080

CMD [ "nodemon", "app.js" ]

### Then i build the image using bthe Dockerfile above i used the command below

$ docker build -t hello_docker_app:latest .

i checked the image locally  by using the command below 
$ docker images
check for container images using the command 
$ docker ps

Then i now have to provision my docker_container resource using the terraform code while i specifivally quaoted the locally buuild image in the resource
as shown below,i quoted the volume because of persistence volume managmenets so that data inside the resource folder will be persistence

resource "docker_container" "hello_docker_app" {
  image   = "hello_docker_app:latest"
  name    = "superdockerapp"
  restart = "always"
  volumes {
    container_path = "/myapp"
    ### replace the host_path with full path for your project directory starting from root directory /
   ### host_path = "data/src/"
    read_only = false
  }
  ports {
    internal = 8080
    external = 80
  }
}




