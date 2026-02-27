# Configure the Docker provider
provider "docker" {}

# terraform can only pull from public Docker Hub repositories
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "node" {
  name = "node:alpine"
}

resource "docker_network" "private_network" {
  name = "node_app_network"
}

# Create a container
resource "docker_container" "webapp" {
  image = docker_image.node.name
  name  = "webapp"
  env   = ["NODE_PORT=3000"]

  #command = ["npm","install","--save"]
  user              = "node"
  entrypoint        = ["nohup", "node", "app/index.js", "&"]
  must_run          = true
  restart           = "always"
  publish_all_ports = true

  networks_advanced {
      name = "node_app_network"
  }

  ports {
    internal = 3000
    protocol = "tcp"
  }

  upload {
    content = file("package.json")
    file    = "app/package.json"
  }

  upload {
    content = file("index.js")
    file    = "app/index.js"
  }

  labels {
    label = "Description"
    value = "terraform-managed docker service for a nodejs app"
  }

  labels {
    label = "Version"
    value = "1.0.0"
  }

  labels {
    label = "Author"
    value = "Nick Batts"
  }
}

# Create container #2
resource "docker_container" "webapp2" {
  image = docker_image.node.name
  name  = "webapp2"
  env   = ["NODE_PORT=3001"]

  #command       = ["npm","install","--save"]
  user              = "node"
  entrypoint        = ["nohup", "node", "app/index.js", "&"]
  must_run          = true
  restart           = "always"
  publish_all_ports = true

  networks_advanced {
      name = "node_app_network"
  }

  ports {
    internal = 3001
    protocol = "tcp"
  }

  upload {
    content = file("package.json")
    file    = "app/package.json"
  }

  upload {
    content = file("index.js")
    file    = "app/index.js"
  }

  labels {
    label = "Description"
    value = "terraform-managed docker service for a nodejs app"
  }

  labels {
    label = "Version"
    value = "1.0.0"
  }

  labels {
    label = "Author"
    value = "Nick Batts"
  }
}

# Create NGINX container
resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx"

  #command          = ["rm -rf etc/nginx/conf.d/default.conf"]
  #entrypoint       = ["/usr/sbin/nginx -g"]
  #links = ["webapp:webapp", "webapp2:webapp2"]

  must_run          = true
  restart           = "always"
  publish_all_ports = false
  depends_on        = [docker_container.webapp]

  networks_advanced {
      name = "node_app_network"
  }

  ports {
    internal = 8080
    external = 8888
    protocol = "tcp"
  }

  upload {
    content = file("nginx.conf")
    file    = "/etc/nginx/nginx.conf"
  }
}

output "nginx_ip" {
  value = docker_container.nginx.ip_address
}

output "node_1_ip" {
  value = docker_container.webapp.ip_address
}
