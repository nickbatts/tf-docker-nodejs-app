# Configure the Docker provider
provider "docker" {}

# terraform can only pull from public Docker Hub repositories
resource "docker_image" "node" {
  name = "node:alpine"
}

# Create a container
resource "docker_container" "webapp" {
  image = "${docker_image.node.name}"
  name  = "webapp"
  #command = ["npm","install","--save"]
  user = "node"
  entrypoint = ["nohup","node","app/index.js","&"]
  must_run = true
  restart = "unless-stopped"
  publish_all_ports = true

  ports {
  	internal = 3000
  	protocol = "tcp"
  }

  upload {
  	content = "${file("package.json")}"
  	file = "app/package.json"
  }

  upload {
  	content = "${file("index.js")}"
  	file = "app/index.js"
  }

  labels {
  	Description = "terraform-managed docker service for a nodejs app"
  	Version     = "0.5.0"
  	Author      = "Nick Batts"
  }
}



# Create a container
resource "docker_container" "webapp2" {
  image = "${docker_image.node.name}"
  name  = "webapp2"
  entrypoint = ["nohup","node","app/index.js","&"]
  links = ["webapp:webapp"]
  restart = "unless-stopped"
  publish_all_ports = true
  depends_on = ["docker_container.webapp"]


  upload {
  	content = "${file("index.js")}"
  	file = "app/index.js"
  }
 }