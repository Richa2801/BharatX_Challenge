$key="46dceebea6de4e36900fb0420fc62f0c"
$endpoint = "https://sentimentanalyzing.cognitiveservices.azure.com/"

# Code to call Text Analytics service to analyze sentiment in text

$txt = Read-Host "Type your tweet: "

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

# Sentiment

$data = @{
    'documents' = @(
        @{
            "id" = "1"
            "text" = "$txt"
        }
    )
} | ConvertTo-Json

write-host "`n`n***Analyzing Sentiment***"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/text/analytics/v3.1/sentiment" `
          -Headers $headers `
          -Body $data | ConvertTo-Json -Depth 6

$analysis = ($result | ConvertFrom-Json)

$sentiment = $analysis.documents.sentiment
$positive = $analysis.documents.confidenceScores.positive
$neutral = $analysis.documents.confidenceScores.neutral
$negative = $analysis.documents.confidenceScores.negative

# Checking the sentiments of the tweet

if ($sentiment -eq 'negative')
{
    Write-Host ("This tweet has been blocked.")
}
else{
    Write-Host($txt)
}