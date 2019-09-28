# This pushes the latest build up to the Docker repo that is connected. It will all tags for the specified image
$Image = "skywalkerisnull/umbraco"
$DockerImages = {docker images}.Invoke()
[System.Collections.ArrayList]$UmbracoArray = @()
for ($i = 0; $i -le ($DockerImages.Count - 1); $i++){
    [string[]]$dockerArray = $DockerImages.Item($i).split(" ").Where({ "" -ne $_ })
    if ($dockerArray[0].ToString() -eq "$Image") # skywalkerisnull/umbraco
    {
        $UmbracoArray.Add($dockerArray)
    }
}

foreach ($tag in $UmbracoArray)
{
    $ImageTag = "$Image" + ":" + $tag[1]
    $ImageTag
    docker push $ImageTag
}