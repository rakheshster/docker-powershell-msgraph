FROM mcr.microsoft.com/powershell
LABEL org.opencontainers.image.description="PowerShell + MS Graph container"
LABEL org.opencontainers.image.source=https://github.com/rakheshster/docker-powershell-msgraph
ARG GRAPH_VERSION
COPY Install-Graph.ps1 /root/
RUN pwsh /root/Install-Graph.ps1 $GRAPH_VERSION
CMD [ "pwsh" ]