<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="MvcColleagues.Azure" generation="1" functional="0" release="0" Id="c5cf0871-a6b6-4d53-84f3-1a82643b962d" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="MvcColleagues.AzureGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="MvcColleagues:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/LB:MvcColleagues:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="MvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MapMvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
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
      </channels>
      <maps>
        <map name="MapMvcColleagues:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
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
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;MvcColleagues&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MvcColleagues&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
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
    <implementation Id="c7fdf20e-d817-44b9-84df-b8acc171ee4b" ref="Microsoft.RedDog.Contract\ServiceContract\MvcColleagues.AzureContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="936e62c7-9dc3-4d02-b08a-b75ffe2d5e8a" ref="Microsoft.RedDog.Contract\Interface\MvcColleagues:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/MvcColleagues.Azure/MvcColleagues.AzureGroup/MvcColleagues:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>