# Find the latest version of Umbraco
"Please note, this method may be flakey as it is using the NuGet directory that may be out of sync with the download location of the pre-built version of Umbraco that can be otherwise downloaded"
Function Get-RedirectedUrl {
	Param (
		[Parameter(Mandatory=$true)]
		[String]$URL
	)
	$request = [System.Net.WebRequest]::Create($url)
	$request.AllowAutoRedirect=$false
	$response=$request.GetResponse()
	If ($response.StatusCode -eq "Found")
	{
		$response.GetResponseHeader("Location")
	}
}

$FileName = [System.IO.Path]::GetFileName((Get-RedirectedUrl "https://www.nuget.org/api/v2/package/UmbracoCms"))
$FileName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
$Version = $FileName.Replace("umbracocms.","")
$ContainerName = "skywalkerisnull/umbraco"

""
"Docker will build Umbraco on Version: $Version" 
""
# Clean up the existing images
$output = docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | findstr $ContainerName)
if ($LastExitCode -ne 0)
{
	""
	"No existing images for $ContainerName are found on the system"
	""
}
else {
	""
	"Existing images for $ContainerName have been removed from the system"
	""	
}
# Build the docker image using the above version and tag them as the current version and latest
docker build --no-cache --pull --build-arg VERSION=$Version -t $ContainerName":latest" -t $ContainerName":$Version" .
