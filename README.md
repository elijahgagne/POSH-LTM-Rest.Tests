# POSH-LTM-Rest.Tests

This project assumes there are two private files, both stored one folder above the project folder:
- F5-LTM-Config.json: this file stores the configuration necessary to run the test. See EXAMPLE.F5-LTM-Config.json for the structure of this file.
- Get-F5Credential.ps1: this file builds a credential to use. See EXAMPLE.Get-F5Credential.ps1.

This project assumes that Pester is installed. Here are steps to install Pester.

```
$url = "https://github.com/pester/Pester/archive/master.zip"
$file = $env:UserProfile + "\Desktop\Pester.zip"
Invoke-WebRequest -Uri $url -OutFile $file

Unblock-File -Path $file

add-type -assemblyname System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}
$target = $env:UserProfile + "\Desktop"
Unzip $file $target

$source = $env:UserProfile + "\Desktop\Pester-master"
$target = $env:UserProfile + "\Documents\WindowsPowerShell\Modules\Pester"
copy-item -r $source $target
```

After the two private files are created and edited and Pester is installed, run Full.Tests.ps1 to test F5-LTM functions.
