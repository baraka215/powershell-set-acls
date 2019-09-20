SharesPermissionModel = “\\servername\pathname”

 

# $FileShares = "$DataDir", "$DataDir2", "$DataDir3", "$DataDir4"

#$SharesToSet = "$LogsShare", "$AppShare", "$AgentShare", "$WindowsShare"

 

# $SharesToSet = "$LogsShare"

 

$SharesToSet = "$AppShare"

 

$servers = ("server1", "server2","server3")

 

function set-acls (){

 

   [cmdletbinding(SupportsShouldProcess=$True)]

   param()

 

foreach ($server in $servers){

   

    $LogsShare =  join-path “\\"$server"\LogsShare"

    $AppShare =  join-path “\\"$server"\SIG.BNRApps"

    $AgentShare =  join-path “\\"$server"\AgentShare"

    $WindowsShare =  join-path “\\"$server"\WindowsShare"

   

   

 

    $GoldenSDDL = (Get-Acl $SharesPermissionModel).Sddl

 

    $LogsShareSD = Get-Acl $LogsShare

    $LogsShareSD.SetSecurityDescriptorSddlForm($GoldenSDDL)

    # Set-Acl $LogsShare -AclObject $LogsShareSD #This sets the Acl

 

    $AppShareSD = Get-Acl $AppShare

    $AppShareSD.SetSecurityDescriptorSddlForm($GoldenSDDL)

    Set-Acl $AppShare -AclObject $AppShareSD

 

    $AgentShareSD = Get-Acl $AgentShare

    $AgentShareSD.SetSecurityDescriptorSddlForm($GoldenSDDL)

    Set-Acl $AgentShare -AclObject $AgentShareSD

 

    $WindowsShareSD = Get-Acl $WindowsShare

    $WindowsShareSD.SetSecurityDescriptorSddlForm($GoldenSDDL)

    Set-Acl $WindowsShare -AclObject $WindowsShareSD

 

 

        foreach ($FilesShare in $SharesToSet) {

 

        get-acl $LogsShare  | Select-Object -ExpandProperty Path | fl | Out-File C:\youruser\YourFolder\new-YourGroupName-DataDir-share-settings.txt -Append

        get-acl $AppShare | Select-Object -ExpandProperty Access | Where IdentityReference -like "*YourGroupName*" | fl | Out-File C:\youruser\YourFolder\new-YourGroupName-DataDir-share-settings.txt -Append

        get-acl $AgentShare | Select-Object -ExpandProperty Access | Where IdentityReference -like "*YourGroupName*" | fl | Out-File C:\youruser\YourFolder\new-YourGroupName-DataDir-share-settings.txt -Append

        get-acl $WindowsShare | Select-Object -ExpandProperty Access | Where IdentityReference -like "*YourGroupName*" | fl | Out-File C:\youruser\YourFolder\new-YourGroupName-DataDir-share-settings.txt -Append

 

  }

 

}

 

 

}

 

 

set-acls