# docker-powershell-msgraph
Docker container with specific MS Graph PowerShell versions. 

## Why?
Coz when I am troubleshooting why a specific cmdlet isn't working I'd like to easily switch to different version of the cmdlets instead of uninstalling/ reinstalling etc. 

## Building & Running this locally
Here's what I do:

For the latest version:

```
docker build --progress=plain --no-cache . --network host -t graph-latest

docker run -it --network host --rm \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    graph-latest
```

For a specific version (2.10.0 in this case):

```
version="2.10.0"
docker build --progress=plain --no-cache . --network host --build-arg="GRAPH_VERSION=$version" -t graph-$version

docker run -it --network host --rm \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    graph-$version
```

Also see the Notes section below.

## Running from Image
If you just want to run the Docker image, assuming a version you want is already published under [packages](https://github.com/rakheshster/docker-powershell-msgraph/pkgs/container/docker-powershell-msgraph):

```
version="2.10.0"
docker pull ghcr.io/rakheshster/docker-powershell-msgraph:$version

docker run -it --network host --rm \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    ghcr.io/rakheshster/powershell-msgraph:$version
```

In this case I am pulling version 1.21.0. The version number is that of the Graph module.

Also see the Notes section below.

## NOTES
You may not need the `--network host` switch. I needed it coz of the way I was running Docker. 

I use the `-v` switch to mount some of my folders containing scripts + the PowerShell profile into the container. This way everything is in place as expected. They are mounted RO in this case. 

The `docker run` command will put you in a PowerShell prompt from which you can `Connect-MgGraph` and so on. 

Also see [my blog post](https://rakhesh.com/azure/docker-powershell-microsoft-graph/) where I talked about it first.

I have since made a Bash function like this:
```
function docker-graph() {
    docker run -it --network host --rm \
        -v /path/to/Scripts:/root/Scripts:ro \
        -v /path/to/MoreScripts:/root/MoreScripts:ro \
        -v /HOME/.config/powershell:/root/.config/powershell:ro \
    ghcr.io/rakheshster/powershell-msgraph:$1
}
```

This way I can do `docker-graph 2.10.0` and it will download and put me in that. If the image doesn't exist it errors:
```
$ docker-graph 2.9.0
Unable to find image 'ghcr.io/rakheshster/powershell-msgraph:2.9.0' locally
docker: Error response from daemon: manifest unknown.
See 'docker run --help'.
```

### DockerHub version
The image is also available on [DockerHub](https://hub.docker.com/repository/docker/rakheshster/powershell-msgraph/general). Instead of `ghcr.io/rakheshster/powershell-msgraph:xxx` above use `rakheshster/powershell-msgraph:xxx`.

### Multi-arch support
The original version of this container used the [Ubuntu Powershell](https://github.com/PowerShell/PowerShell-Docker/blob/master/release/7-4/ubuntu22.04/docker/Dockerfile) image from Microsoft as its base. Now it uses the [CBL Mariner PowerShell](https://github.com/PowerShell/PowerShell-Docker/blob/master/release/7-4/mariner2-arm64/docker/Dockerfile) image as its base. Reason for this switch is so I can create both amd64 and arm64 images - the latter is useful for those running Docker on M1 Macs. 

Microsoft [does not support](https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.4#supported-versions) arm64 on Ubuntu. There's no mention of arm64 with Linux anywhere actually, but I found the CBL Mariner images so I figure it is supported. 