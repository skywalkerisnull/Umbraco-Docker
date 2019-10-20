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

""
"Docker will build Umbraco on Version: $Version" 
""

# Build the docker image using the above version and tag them as the current version and latest
docker build --build-arg VERSION=$Version -t skywalkerisnull/umbraco:latest -t skywalkerisnull/umbraco:$Version .