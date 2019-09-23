# This docker file setups Umbraco to run with no files required on your local machine
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019

# Delete all files in the default IIS folders
RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

# Install of the site to C:/Umbraco
WORKDIR C:/Umbraco

# Configure IIS with the website
RUN powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    New-IISSite -Name "Site" -PhysicalPath C:\Umbraco -BindingInformation "*:8080:"

# Release from this page: https://github.com/umbraco/Umbraco-CMS/releases update to the latest version required
ADD http://umbracoreleases.blob.core.windows.net/download/UmbracoCms.8.1.5.zip .

# Expand the archive with powershell
RUN powershell -NoProfile -Command Expand-Archive UmbracoCms.8.1.5.zip .; \
    Remove-Item UmbracoCms.8.1.5.zip

EXPOSE 8080
EXPOSE 80

# TODO: Be able to get the latest release automatically
# TODO: Use the dockerfile "ARGS" and replace UmbracoCMS.8.1.3 with the one varible
# TODO: Set IIS to use SSL on the site
