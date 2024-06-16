# Prompt user for model names
Write-Host "Please enter the names of the models you want to download, separated by spaces:"
$models = Read-Host

# Split input into array if multiple models are entered
$modelArray = $models -split ' '

foreach ($model in $modelArray) {
    # Construct and execute docker command for each model
    Invoke-Expression "docker exec -it ollama ollama pull $model"
}