# change this variable to the path to your project directory
$work="C:\Users\Username\csci350"
$docker_compose=".\docker-compose.yml"
$img_name="cs350_docker"

# TODO: check if work/docker-compose variables are set
if (-Not (Test-Path $work)) {
  Write-Output "Invalid path to project directory: $work"
  Return
} else {
  $env:work=$work
}

function usage() {
  Write-Output "this script manages the linux container"
  Write-Output "  start - run the docker container"
  Write-Output "  shell - start a shell to run commands in xv6"
  Write-Output "  stop  - kill the linux container"
}

function docker_up() {
  $built=( docker images  | Select-String -Pattern "$img_name")

  if ( [string]::IsNullOrEmpty($built) ) {
    Write-Output "Running Docker image"
  } else {
    Write-Output "Pulling Docker image"
  }

  docker-compose -f "$docker_compose" up -d
}

function docker_down () {
  docker-compose -f "$docker_compose" down
}

function docker_shell() {
  $container=(docker ps | Select-String -Pattern "$img_name" -AllMatches)
  if ( $container.Matches.Count -eq 0 ) {
    Write-Output "No container running. Please run first!"
    Return
  }
  docker exec -it "$img_name" /bin/bash
}


if ($args.Count -lt 1) {
  Write-Output "Please specify a command to run"
}

$Command=$args[0]

if ($Command -eq "start") {
  docker_up
} elseif ($Command -eq "stop") {
  docker_down
} elseif ($Command -eq "shell") {
  docker_shell
} else {
  usage
}