FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 5001
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src

RUN apt-get update && \
    apt-get install git wget apt-transport-https software-properties-common -y && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell nuget && \
    git clone https://github.com/umbraco/Umbraco-CMS.git && \
    cd Umbraco-CMS && \
    git checkout v9/dev

WORKDIR /src/Umbraco-CMS/src

RUN dotnet restore umbraco-netcore-only.sln && \
    dotnet build umbraco-netcore-only.sln -c Release -o /app/build


FROM build AS publish
RUN dotnet publish umbraco-netcore-only.sln -c Release -o /app/publish


FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Umbraco.Web.UI.NetCore.dll"]