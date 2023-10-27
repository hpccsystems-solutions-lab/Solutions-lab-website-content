---
title: Despray
slug: despray
---

# DESPRAY

Despray (or Export) is the process of copying a logical file from a Data Refinery cluster to a single machine location (such as the Landing Zone)

### Syntax

<pre>
<EclCode code="STD.File.DeSpray(logicalname, destinationIP, destinationpath, [timeout], [espserverIPport], [maxConnections], [allowoverwrite])">
</EclCode>
</pre>

| Value | Definition |
| :- | :- |
| Logicalname | A string containing the logical name of the file to spray. |
| destintaionIP | A string containing the destination IP address (source IP address of where the file is located). |
| destinationpath | A string containing the path and the name of the file. |
| timeout | [Optional] An integer that indicates the timeout setting. Default of -1 when omitted. If set to zero (0), immediately returns to the ECL workunit without waiting for the DFU workunit to complete. |
| espserverIPport | [Optional] A string containing the protocol, IP, port and directory, or the DNS equivalent of the ESP server program. Usually, the same IP and port as ECL Watch, with ‘/FileSpray’ appended to it. Default value set to that in lib_system.ws_fs_server. |
| maxConnections | [Optional] An integer that specifies the max number of connections. Default set to -1 when omitted. |
| allowoverwrite | [Optional] A TRUE or FALSE Boolean that indicates whether you want the new file to overwrite the existing file (if one exists with the same name). True meaning ‘YES’ to overwrite and FALSE meaning ‘NO’ don’t overwrite. Default set to FALSE. |

*To acquire the destinationIP, perform the following:
-	Navigate to your landing zone and spray a file
-	Once sprayed, click on your work units and open the work unit which performed the spray
-	Scroll down to the Source section and the IP listed will be the IP address you’ll use for your despray function

**Example**

<pre >
<EclCode 
code="/*Despray Example:*/

// Execute on NOTHOR

IMPORT STD;

// DeSpray function
STD.File.DeSpray(
	logicalName := '~thor::myfile.json',
	destinationIP := '10.2.0.4',
	destinationPath := '/var/lib/HPCCSystems/mydropzone/myfile.json'
);

">
</EclCode>
</pre>
