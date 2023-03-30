# HelloID-Task-SA-Target-ExchangeOnline-SharedMailboxDelete
#########################################################
# Form mapping
$formobject = @{
    Identity               = $form.Identity
}
[bool] $IsConnected = $false
try {

    Write-Information "Executing ExchangeOnline action: [SharedMailboxDelete] for: [$($formObject.DisplayName)]"

    $null = Import-Module ExchangeOnlineManagement

    $securePassword = ConvertTo-SecureString $ExchangeOnlineAdminPassword -AsPlainText -Force
    $credential = [System.Management.Automation.PSCredential]::new($ExchangeOnlineAdminUsername, $securePassword)
    $null = Connect-ExchangeOnline -Credential $credential -ShowBanner:$false -ShowProgress:$false -ErrorAction Stop
    $IsConnected = $true

    $Mailbox = Get-Mailbox -Identity $formobject.Identity

    if ($Mailbox)
    {
        $DeletedMailbox = Remove-Mailbox -Identity $formobject.Identity -Confirm $false -ErrorAction stop

        $auditLog = @{
            Action            = 'DeleteResource'
            System            = 'ExchangeOnline'
            TargetIdentifier  = "$($formobject.Identity)"
            TargetDisplayName = "$($formobject.Identity)"
            Message           = "ExchangeOnline action: [SharedMailboxDelete] for: [$($formobject.Identity)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ExchangeOnline action: [SharedMailboxDelete] for: [$($formobject.Identity)] executed successfully"
    }
    else {
        $auditLog = @{
            Action            = 'DeleteResource'
            System            = 'ExchangeOnline'
            TargetIdentifier  = "$($formobject.Identity)"
            TargetDisplayName = "$($formobject.Identity)"
            Message           = "ExchangeOnline action: [SharedMailboxDelete] for: [$($formobject.Identity)]. The Mailbox cannot be found in the AD. Possibly already deleted"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ExchangeOnline action: [SharedMailboxDelete] for: [$($formObject.Identity)]. The Mailbox cannot be found in the AD. Possibly already deleted"
    }
}
catch {
    $ex = $_

    $auditLog = @{
        Action            = 'DeleteResource'
        System            = 'ExchangeOnline'
        TargetIdentifier  = "$($formobject.Identity)"
        TargetDisplayName = "$($formobject.Identity)"
        Message           = "Could not execute ExchangeOnline action: [SharedMailboxDelete] for: [$($formObject.Identity)], error: $($ex.Exception.Message), Details : $($ex.Exception.ErrorDetails)"
        IsError           = $true
    }

    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute ExchangeOnline action: [SharedMailboxDelete] for: [$($formObject.Identity)], error: $($ex.Exception.Message), Details : $($ex.Exception.ErrorDetails)"
}
finally{
    if ($IsConnected){
        $exchangeSessionEnd = Disconnect-ExchangeOnline -Confirm:$false -Verbose:$false
    }
}

#########################################################
