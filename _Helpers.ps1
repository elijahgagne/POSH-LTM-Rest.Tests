function Get-Config {
    param(
        [Parameter(Mandatory=$true)]
        [string]$File
    )
    process {
        Get-Content -Raw -Path $File | ConvertFrom-Json
    }
}

function Update-F5LTM-Module {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ModulePath
    )
    process {
        try {
            remove-module F5-LTM | out-null
            
        }
        catch { }

        import-module $ModulePath
    }
}