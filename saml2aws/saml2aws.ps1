<#
.DESCRIPTION
The script is used to get temporary credentials for one or more AWS accounts via SAML2 authentication and save it in ~/.aws/credentials

.PARAMETER Mode
The access mode of the AWS credentials. Options: ro(readOnly) or rw(read&write). Default: ro.

.PARAMETER AccountID
The AWS Account alias ID to login, e.g. devopstesting. Support multiple values, separate each other with comma ",".

#>
[CmdletBinding(PositionalBinding=$False)]

Param(
    [Parameter(Mandatory=$False)]
    [string]$Mode='ro',

    [Parameter(Mandatory=$True)]
    [string[]]$AccountID
)

function Get-IniContent ($FilePath)
{
    $ini = @{}
    switch -regex -file $FilePath
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function Out-IniFile($content, $file)
{
  $outFile = New-Item -ItemType file -Path $file -Force
  foreach ($i in $content.keys)
  {
    Add-Content -Path $outFile -Value "[$i]"
    Foreach ($j in ($content[$i].keys | Sort-Object))
    {
      Add-Content -Path $outFile -Value "$j=$($content[$i][$j])"
    }
  }
}

# These env variables need to be set
# Parameter help description
$AMAZONIA_URL = $AMAZONIA_URL ? $AMAZONIA_URL : "https://amazonia.ac3.cloud"
$AMAZONIA_ROLE = $AMAZONIA_ROLE ? $AMAZONIA_ROLE : "bp-saml-$Mode"

# Write-Output $AMAZONIA_URL $AMAZONIA_ROLE $AMAZONIA_CLIENTID

$creds = Get-IniContent("~/.aws/credentials")

foreach($id in $AccountID){
  $AMAZONIA_CLIENTID = $id

  $UUID = New-Guid
  $URL = "$AMAZONIA_URL/?clientid=$AMAZONIA_CLIENTID&guid=$UUID&immediate=on&role_select=$AMAZONIA_ROLE"

  Start-Process $URL

  Write-Output "If your browser did not open, please open the following link: $URL"

  $SECONDS = 0
  # We try for 30 seconds
  do
  {
    Start-Sleep 1
    $SAML_B64ENCODED = Invoke-WebRequest -Uri "$AMAZONIA_URL/saml_token?guid=$UUID"
    if( "$SAML_B64ENCODED" -ne "NONE" ){
      $SAMLAssertion = $SAML_B64ENCODED.Content
      # Write-Output [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$SAML"))
      $SAML_B64DECODED = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SAML_B64ENCODED.Content))

      $attr_namespace = @{
        assertion = "urn:oasis:names:tc:SAML:2.0:assertion" 
      }
      
      $attributes = Select-Xml -Content $SAML_B64DECODED -XPath "//assertion:Attribute" -Namespace $attr_namespace
      
      foreach($attr in $attributes){
        switch ($attr.Node.Name){
          # "https://aws.amazon.com/SAML/Attributes/RoleSessionName" { $RoleSessionName = $attr.Node.AttributeValue }
          "https://aws.amazon.com/SAML/Attributes/Role" { 
            $Roles = $attr.Node.AttributeValue -split ','
            $RoleArn = $Roles[0]
            $PrincipalArn = $Roles[1]
          }
          "https://aws.amazon.com/SAML/Attributes/SessionDuration" { $SessionDuration = $attr.Node.AttributeValue }
        }
      }

      $SAMLAssertion_URLEncoded = [System.Web.HttpUtility]::UrlEncode($SAMLAssertion)
      $AssumeRoleWithSAMLURL = "https://sts.amazonaws.com/?Version=2011-06-15&Action=AssumeRoleWithSAML&RoleArn=$RoleArn&PrincipalArn=$PrincipalArn&DurationSeconds=$SessionDuration&SAMLAssertion=$SAMLAssertion_URLEncoded"

      $cred_Xml = (Invoke-WebRequest -Uri $AssumeRoleWithSAMLURL).Content
      $cred_namespace = @{
        cred = "https://sts.amazonaws.com/doc/2011-06-15/"
      }
      $cred_attr = Select-Xml -Content $cred_Xml -Namespace $cred_namespace -XPath "//cred:AssumeRoleWithSAMLResult"
      $aws_access_key_id = $cred_attr.Node.Item("Credentials").AccessKeyId
      $aws_secret_access_key = $cred_attr.Node.Item("Credentials").SecretAccessKey
      $aws_session_token = $cred_attr.Node.Item("Credentials").SessionToken
      $aws_security_token = $cred_attr.Node.Item("Credentials").SessionToken
      $x_principal_arn = $cred_attr.Node.Item("AssumedRoleUser").Arn
      $x_security_token_expires = $cred_attr.Node.Item("Credentials").Expiration


      if(!$creds.containsKey($AMAZONIA_CLIENTID)){
        $creds[$AMAZONIA_CLIENTID] = @{}
      }
      
      
      $creds[$AMAZONIA_CLIENTID]["aws_access_key_id"] = $aws_access_key_id
      $creds[$AMAZONIA_CLIENTID]["aws_secret_access_key"] = $aws_secret_access_key
      $creds[$AMAZONIA_CLIENTID]["aws_session_token"] = $aws_session_token
      $creds[$AMAZONIA_CLIENTID]["aws_security_token"] = $aws_security_token
      $creds[$AMAZONIA_CLIENTID]["x_principal_arn"] = $x_principal_arn
      $creds[$AMAZONIA_CLIENTID]["x_security_token_expires"] = $x_security_token_expires

      Write-Output "Connected to $AMAZONIA_CLIENTID"
      break;
    }
    $SECONDS += 1
  }while($SECONDS -lt 30)
  if( @{} -eq $creds[$AMAZONIA_CLIENTID] ){
    Write-Output "Failed to connect to $AMAZONIA_CLIENTID"
  }
}

Out-IniFile -content $creds -file "~/.aws/credentials"