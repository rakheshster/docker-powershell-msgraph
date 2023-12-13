# docker-powershell-msgraph
Docker container with specific MS Graph PowerShell versions. 

## Why?
Coz when I am troubleshooting why a specific cmdlet isn't working I'd like to easily switch to different version of the cmdlets instead of uninstalling/ reinstalling etc. 

## Building & Running this locally
Here's what I do:

For the latest version:

```
docker build --progress=plain --no-cache . --network host -t graph-latest

docker run -it --network host \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    graph-latest
```

For a specific version (2.10.0 in this case, be sure to change it in THREE places below):

```
docker build --progress=plain --no-cache . --network host --build-arg="GRAPH_VERSION=2.10.0" -t graph-2.10.0

docker run -it --network host \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    graph-2.10.0
```

Please see the Notes section below.

## Running from Image
If you just want to run the Docker image, assuming a version you want is already published under [packages](https://github.com/rakheshster/docker-powershell-msgraph/pkgs/container/docker-powershell-msgraph):

```
docker pull ghcr.io/rakheshster/docker-powershell-msgraph:1.21.0

docker run -it --network host \
    -v /path/to/Scripts:/root/Scripts:ro \
    -v /path/to/MoreScripts:/root/MoreScripts:ro \
    -v /HOME/.config/powershell:/root/.config/powershell:ro \
    ghcr.io/rakheshster/docker-powershell-msgraph:1.21.0
```

In this case I am pulling version 1.21.0. The version number is that of the Graph module.

Please see the Notes section below.

## NOTES
You may not need the `--network host` switch. I needed it coz of the way I was running Docker. 

I use the `-v` switch to mount some of my folders containing scripts + the PowerShell profile into the container. This way everything is in place as expected. They are mounted RO in this case. 

The `docker run` command will put you in a PowerShell prompt from which you can `Connect-MgGraph` and so on. 

Also see [my blog post](https://rakhesh.com/azure/docker-powershell-microsoft-graph/) where I talked about it first.