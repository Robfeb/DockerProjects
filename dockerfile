FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENV chocolateyUseWindowsCompression=false
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN mkdir c:\\git
RUN mkdir c:\\temp


# SHELL ["cmd", "/S", "/C"]

ADD ./vs_buildtools2019.exe C:/temp/vs_buildtools2019.exe

RUN C:\temp\vs_buildtools2019.exe --wait --quiet --norestart --nocache \
    --installPath C:\BuildTools \
    --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools \
    --add Microsoft.VisualStudio.Workload.VCTools \
    --add Microsoft.VisualStudio.Workload.NodeBuildTools \
    --add Microsoft.VisualStudio.Workload.MSBuildTools \
    --add Microsoft.VisualStudio.Workload.WebBuildTools \
    --add Microsoft.VisualStudio.Workload.AzureBuildTools \
    --add Microsoft.VisualStudio.Workload.VisualStudioExtensionBuildTools \
    --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools \
    --add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools \
    --add Microsoft.VisualStudio.Workload.NetCoreBuildTools \
    --add Microsoft.VisualStudio.Component.VC.v141.MFC \
    --add Microsoft.VisualStudio.Component.VC.v141.ATL \
    --remove Microsoft.VisualStudio.Component.Windows81SDK \
    --includeRecommended \
    --includeOptional 


RUN choco install \
    nodejs.install \
    --confirm \
    --version 10.16.3 \
    --limit-output \
    --timeout 216000 

RUN choco install \
    cmake.install \
    --confirm \
    --installArgs 'ADD_CMAKE_TO_PATH=System' \
    --version 3.14.1 \
    --limit-output \
    --timeout 216000  

RUN choco install \
    git \
    --confirm \
    --limit-output \
    --timeout 216000
ADD ./dotnet-install.ps1 .
RUN ./dotnet-install.ps1

WORKDIR /azp

COPY start.ps1 .


ENTRYPOINT .\start.ps1 