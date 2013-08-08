<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="MvcColleagues.Azure" generation="1" functional="0" release="0" Id="d9e5b682-7240-4ea5-bb26-d69be84ae344" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="MvcColleagues.AzureGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="MvcColleagues:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/LB:MvcColleagues:Endpoint1" />
          </inToChannel>
        </inPort>
        <inPort name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" protocol="tcp">
          <inToChannel>
            <lBChannelMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/LB:MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="Certificate|MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapCertificate|MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </maps>
        </aCS>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" />
          </maps>
        </aCS>
        <aCS name="MvcColleaguesInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleaguesInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:MvcColleagues:Endpoint1">
          <toPorts>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Endpoint1" />
          </toPorts>
        </lBChannel>
        <lBChannel name="LB:MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput">
          <toPorts>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </toPorts>
        </lBChannel>
        <sFSwitchChannel name="SW:MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp">
          <toPorts>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
          </toPorts>
        </sFSwitchChannel>
      </channels>
      <maps>
        <map name="MapCertificate|MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" kind="Identity">
          <certificate>
            <certificateMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </certificate>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </setting>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </setting>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </setting>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </setting>
        </map>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" />
          </setting>
        </map>
        <map name="MapMvcColleaguesInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleaguesInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="MvcColleagues" generation="1" functional="0" release="0" software="d:\Bersin\MvcColleagues\MvcColleagues.Azure\csx\Debug\roles\MvcColleagues" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" protocol="tcp" />
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp" portRanges="3389" />
              <outPort name="MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/SW:MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;MvcColleagues&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MvcColleagues&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
            <storedcertificates>
              <storedCertificate name="Stored0Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" certificateStore="My" certificateLocation="System">
                <certificate>
                  <certificateMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
                </certificate>
              </storedCertificate>
            </storedcertificates>
            <certificates>
              <certificate name="Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
            </certificates>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleaguesInstances" />
            <sCSPolicyUpdateDomainMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleaguesUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleaguesFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="MvcColleaguesUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="MvcColleaguesFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="MvcColleaguesInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="36acf4de-649f-4d5d-be0e-fb804f87d0c2" ref="Microsoft.RedDog.Contract\ServiceContract\MvcColleagues.AzureContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="f0c95617-16d3-4d4f-b98f-34912775f004" ref="Microsoft.RedDog.Contract\Interface\MvcColleagues:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues:Endpoint1" />
          </inPort>
        </interfaceReference>
        <interfaceReference Id="303de9be-d8ce-47e4-9a51-41bbc84edf19" ref="Microsoft.RedDog.Contract\Interface\MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>