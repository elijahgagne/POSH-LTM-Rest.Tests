# Variables
$ScriptPath = Split-Path -Parent $PSCommandPath
#$ScriptPath = "C:\Users\d92495j\G\_Tasks\F5 PowerShell\POSH-LTM-Rest.Tests"
$PrivateCredentialScript = $ScriptPath + "\..\Get-F5Credential.ps1"
$PrivateConfigFile = $ScriptPath + "\..\F5-LTM-Config.json"

# Source external files
. $PrivateCredentialScript
. ($ScriptPath + "\_Helpers.ps1")

# Setup the environment for testing
$Credential = Get-F5Credential
$Config = Get-Config $PrivateConfigFile
Update-F5LTM-Module $Config.ModulePath
$F5Session = New-F5Session -LTMName $Config.LTM1 -LTMCredentials $Credential -PassThrough


Describe "Get-Pool" {
    Context "Parameters: Name" {
        It "A pool with the expected fullPath is returned" {
            $pool = Get-Pool -F5Session $F5Session -Name $Config.PoolFullPath1
            $pool.fullPath | Should Be $Config.PoolFullPath1
        }
    }
    Context "Parameters: Name, Application, and Partition" {
        It "A pool with the expected fullPath is returned" {
            $pool = Get-Pool -F5Session $F5Session -Name $Config.Pool1 -Application $Config.Application1 -Partition $Config.Partition1
            $pool.fullPath | Should Be $Config.PoolFullPath1
        }
    }
    Context "Application filtering, Parameters: Application and Partition" {
        It "A pool with the expected fullPath is returned" {
            $pools = Get-Pool -F5Session $F5Session -Application $Config.Application1 -Partition $Config.Partition1
            $pools.Count | Should Be 1
        }
    }
}

Describe "Get-VirtualServer" {
    Context "Parameters: Name" {
        It "A virtual server with the expected fullPath is returned" {
            $virtualServer = Get-VirtualServer -F5Session $F5Session -Name $Config.VirtualServerFullPath1
            $virtualServer.fullPath | Should Be $Config.VirtualServerFullPath1
        }
    }
    Context "Parameters: Name, Application, and Partition" {
        It "A virtual server with the expected fullPath is returned" {
            $virtualServer = Get-VirtualServer -F5Session $F5Session -Name $Config.VirtualServer1 -Application $Config.Application1 -Partition $Config.Partition1
            $virtualServer.fullPath | Should Be $Config.VirtualServerFullPath1
        }
    }
}

Describe "Get-iRule" {
    Context "Parameters: Name" {
        It "An iRule with the expected fullPath is returned" {
            $iRule = Get-iRule -F5Session $F5Session -Name $Config.iRuleFullPath1
            $iRule.fullPath | Should Be $Config.iRuleFullPath1
        }
    }
    Context "Parameters: Name and Partition" {
        It "An iRule with the expected fullPath is returned" {
            $iRule = Get-iRule -F5Session $F5Session -Name $Config.iRule1 -Partition $Config.Partition2
            $iRule.fullPath | Should Be $Config.iRuleFullPath1
        }
    }
}

Describe "Get-Node" {
    Context "Parameters: Address and Partition" {
        It "A node with the expected fullPath is returned" {
            $node = Get-Node -F5Session $F5Session -Address $Config.Node1 -Partition $Config.Partition1
            $node.fullPath | Should Be $Config.NodeFullPath1
        }
    }
    Context "Parameters: Name and Partition" {
        It "A node with the expected fullPath is returned" {
            $node = Get-Node -F5Session $F5Session -Name $Config.Node1 -Partition $Config.Partition1
            $node.fullPath | Should Be $Config.NodeFullPath1
        }
    }
}

Describe "Get-HealthMonitor" {
    Context "Parameters: Name, Partition, and Type" {
        It "A monitor with the expected fullPath is returned" {
            $monitor = Get-HealthMonitor -F5Session $F5Session -Name $Config.Monitor1 -Partition $Config.Partition3 -Type $Config.MonitorType1
            $monitor.fullPath | Should Be $Config.MonitorFullPath1
        }
    }
    Context "Parameters: Name, Application, Partition, and Type" {
        It "A monitor with the expected fullPath is returned" {
            $monitor = Get-HealthMonitor -F5Session $F5Session -Name $Config.MonitorFullPath2 -Type $Config.MonitorType2
            $monitor.fullPath | Should Be $Config.MonitorFullPath2
        }
    }
    Context "Parameters: Name and Type" {
        It "A monitor with the expected fullPath is returned" {
            $monitor = Get-HealthMonitor -F5Session $F5Session -Name $Config.MonitorFullPath2 -Type $Config.MonitorType2
            $monitor.fullPath | Should Be $Config.MonitorFullPath2
        }
    }
}

Describe "Get-PoolMember" {
    Context "Parameters: PoolName and Partition" {
        It "Two pool members with the expected fullPaths are returned" {
            $poolMember = Get-PoolMember -PoolName $Config.PoolFullPath1 -Partition $Config.Partition1
            $poolMember[0].fullPath | Should Be $Config.PoolMemberFullPath1
            $poolMember[1].fullPath | Should Be $Config.PoolMemberFullPath2
        }
    }
    Context "Parameters: PoolName, Name, and Partition" {
        It "A pool member with the expected fullPath is returned" {
            $poolMember = Get-PoolMember -PoolName $Config.PoolFullPath1 -Name $Config.PoolMember1 -Partition $Config.Partition1
            $poolMember.fullPath | Should Be $Config.PoolMemberFullPath1
        }
    }
    Context "Parameters: PoolName, Address, and Partition" {
        It "A pool member with the expected fullPath is returned" {
            $poolMember = Get-PoolMember -PoolName $Config.PoolFullPath1 -Address $Config.PoolMemberAddress1 -Partition $Config.Partition1
            $poolMember.fullPath | Should Be $Config.PoolMemberFullPath1
        }
    }
}

Describe "Get-PoolMember" {
    Context "Parameters: PoolName and Partition" {
        It "Two pool member stats with the expected fullPaths are returned" {
            $poolMemberStat = Get-PoolMemberStats -PoolName $Config.PoolFullPath1 -Partition $Config.Partition1
            $poolMemberStat[0].addr.description | Should Be $Config.PoolMemberAddress1
            $poolMemberStat[1].addr.description | Should Be $Config.PoolMemberAddress2
        }
    }
    Context "Parameters: PoolName, Name, and Partition" {
        It "A pool member stat with the expected fullPath is returned" {
            $poolMemberStat = Get-PoolMemberStats -PoolName $Config.PoolFullPath1 -Name $Config.PoolMember1 -Partition $Config.Partition1
            $poolMemberStat.addr.description | Should Be $Config.PoolMemberAddress1
        }
    }
    Context "Parameters: PoolName, Address, and Partition" {
        It "A pool member stat with the expected fullPath is returned" {
            $poolMemberStat = Get-PoolMemberStats -PoolName $Config.PoolFullPath1 -Address $Config.PoolMemberAddress1 -Partition $Config.Partition1
            $poolMemberStat.addr.description | Should Be $Config.PoolMemberFullPath1
        }
    }
}

Describe "Test-Pool" {
    Context "Parameters: Name" {
        It "True is returned if the pool is found" {
            $result = Test-Pool -F5Session $F5Session -Name $Config.PoolFullPath1
            $result | Should Be $True
        }
    }
    Context "Parameters: Name, Application, and Partition" {
        It "True is returned if the pool is found" {
            $result = Test-Pool -F5Session $F5Session -Name $Config.Pool1 -Application $Config.Application1 -Partition $Config.Partition1
            $result | Should Be $True
        }
    }
}

Describe "Test-VirtualServer" {
    Context "Parameters: Name" {
        It "True is returned if the virtual server is found" {
            $result = Test-VirtualServer -F5Session $F5Session -Name $Config.VirtualServerFullPath1
            $result | Should Be $True
        }
    }
    Context "Parameters: Name, Application, and Partition" {
        It "True is returned if the virtual server is found" {
            $result = Test-VirtualServer -F5Session $F5Session -Name $Config.VirtualServer1 -Application $Config.Application1 -Partition $Config.Partition1
            $result | Should Be $True
        }
    }
}

Describe "Test-HealthMonitor" {
    Context "Parameters: Name, Partition, and Type" {
        It "True is returned if the monitor is found" {
            $result = Test-HealthMonitor -F5Session $F5Session -Name $Config.Monitor1 -Partition $Config.Partition3 -Type $Config.MonitorType1
            $result | Should Be $True
        }
    }
}

Describe "Test-Node" {
    Context "Parameters: Name and Address" {
        It "True is returned if the virtual server is found" {
            $result = Test-Node -F5Session $F5Session -Address $Config.Node1 -Partition $Config.Partition1
            $result | Should Be $True
        }
    }
    Context "Parameters: Name and Partition" {
        It "True is returned if the virtual server is found" {
            $result = Test-Node -F5Session $F5Session -Name $Config.Node1 -Partition $Config.Partition1
            $result | Should Be $True
        }
    }
}


