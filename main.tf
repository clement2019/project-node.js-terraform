resource "docker_container" "hello_docker_app" {
  image   = "hello_docker_app:latest"
  name    = "superdockerapp"
  restart = "always"
  volumes {
    container_path = "/myapp"
    # replace the host_path with full path for your project directory starting from root directory /
   # host_path = "data/src/"
    read_only = false
  }
  ports {
    internal = 8080
    external = 80
  }
}