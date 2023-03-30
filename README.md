
# HelloID-Task-SA-Target-ExchangeOnline-SharedMailboxDelete

## Prerequisites
Before using this snippet, verify you've met with the following requirements:
- [ ] The powershell EXO v3 module must be installed on the server running the Agent. See
https://learn.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2?view=exchange-ps for instructions

- [ ] User defined variables: `ExchangeOnlineAdminUsername` and `$ExchangeOnlineAdminPassword` created in your HelloID portal.
  see also https://docs.helloid.com/en/variables/custom-variables.html

## Description

This code snippet executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties of the shared mailbox to be deleted, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "Identity" :                "testshared1@myenvironment.onmicrosoft.com"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.

2. Constructs a powershell credential object from the supplied administrative username and password

3. Connects with the credentials to the Exchange online environment by means of the `Connect-ExchangeOnline` cmdlet

4. Calls the `Get-Mailbox` cmdlet to lookup the mailbox

5. Calls the `Remove-Mailbox` cmdlet to delete the mailbox.

6. Disconnects from the Exchange environment by means of the `Disconnect-ExchangeOnline` cmdlet
