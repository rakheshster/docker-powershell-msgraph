FROM mcr.microsoft.com/powershell
ARG GRAPH_VERSION
COPY Install-Graph.ps1 /root/
RUN pwsh /root/Install-Graph.ps1 $GRAPH_VERSION
CMD [ "pwsh" ]