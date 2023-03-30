param(
  [Parameter()][string]$title = "", 
  [Parameter()][string]$location = "", 
  [Parameter()][string]$startdate = "", 
  [Parameter()][string]$enddate = "", 
  [Parameter()][bool]$isDraft = 1
)

while (-not($title)) {
  $title = Read-Host "Enter a title for the post"
}

while (-not([string]$startdate -as [DateTime])) {
  $startdate = Read-Host "Enter a valid START date for the post, e.g., Apr 20, 1984"
}

if (-not($enddate -eq "")) {
  while (-not([string]$enddate -as [DateTime])) {
    $enddate = Read-Host "Enter a valid END date for the post, e.g., Apr 20, 1984"
  }
}

# get date from start date for post file name
$dateStr = '{0:yyyy-MM-dd}' -f [DateTime]$startdate
$cleanTitle = $title -replace "\.", ""
$hasFirst = $cleanTitle -match "^\w+"
if ($hasFirst) {
  $shortTitle = $matches[0].ToLower()
}
else {
  $shortTitle = $cleanTitle.ToLower() -replace "\s", ""
}

# get the root folder
$root = $MyInvocation.MyCommand.Path | Split-Path -parent

# build post filename
$filePath = Join-Path $root ($isDraft ? "_drafts" : "_posts") "$dateStr-$shortTitle.md"

# setup enddate str depending on empty or not
$enddateStr = (-not([string]$enddate -as [DateTime])) ? "# no end date" : ('{0:yyyy-MM-dd "01:01:01" zzz}' -f [DateTime]$enddate)

# create the new item, fails if exists already
New-Item $filePath;

Add-Content $filePath @"
---
title: $title
location: $location
categories:
  - experiences
author: khrisgriffis
date: $('{0:yyyy-MM-dd "01:01:01" zzz}' -f [DateTime]$startdate)
enddate: $enddateStr
---

"@

code $filePath