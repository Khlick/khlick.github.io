param ($type, $message = "Updating site: " + (Get-Date -UFormat "%d-%B-%Y") + ".")
# get the root folder
$root = $MyInvocation.MyCommand.Path | Split-Path -parent
$cur = Get-Location
# move to root if not there
if ($root -ne $cur) {
  Set-Location -Path $root
}
# parse environment file
# should return:
# $JKL_MYCONFIGS
# $GH_BRANCH
Get-Content "_site.env" | ForEach-Object {
  $keys = $_ -split "="
  New-Variable -Name $keys[0] -Value $keys[1]
}
# helper function to move drafts
function moveDrafts {
  Write-Host "Moving *.md from $root\_drafts\ to $root\_posts\"
  Get-Item -Path "$root\_drafts\*.md" | Move-Item -Destination "$root\_posts\"
}

switch -Wildcard ($type) {
  "serve*" { 
    $out = "bundle exec jekyll serve $JKL_MYCONFIGS --watch --drafts $(($type.Contains('nof')) ? '' : '--future') --verbose"
    Invoke-Expression $out
    # $chromepath = Join-Path $env:ProgramFiles "Google" "Chrome" "Application" "chrome.exe"
    # Start-Process -FilePath $chromepath "localhost:4000"
    Break
  }
  "prod*" {
    $out = "bundle exec jekyll build $JKL_MYCONFIGS --verbose"
    Invoke-Expression $out
    Break
  }
  "pub*" {
    if ($type.Contains("d")) { 
      moveDrafts
    }
    $out = "bundle exec jekyll build $JKL_MYCONFIGS --verbose"
    Write-Host "Calling $out"
    Invoke-Expression $out
    # publish will push to git
    git checkout $BH_BRANCH
    git add .
    git commit -m $message
    git push origin $BH_BRANCH
  }
  Default {
    Write-Host "Type arg must be one of: serve, production, publish, publishdraft"
    exit
  }
}
Write-Host "Done!"