# Umbraco-Docker

Can be viewed on the Docker Hub: https://hub.docker.com/r/skywalkerisnull/umbraco

This small repo is to build docker image to run Umbraco v8: https://github.com/umbraco/Umbraco-CMS

The powershell scripts do the following functions:

* build.ps1 - Find the latest version of Umbraco on the Github page and build a new docker image
* push.ps1 - Push the latest build version of Umbraco to your Docker repo (cannot build windows based docker images on https://hub.docker.com )
* run.ps1 - Runs the image with some standard options set
