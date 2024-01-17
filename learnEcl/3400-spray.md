---
title: Spray
slug: spray
---

# SPRAY

Spray (or Import) is the process of copying a data file from one location (such as a Landing Zone) to a Data Refinery cluster.

## SPRAYXML

**Syntax**
<pre>
	<EclCode code="STD.File.SprayXML(sourceIP, sourcepath, [maxrecordsize], srcRowTag, [srcEncoding], destinationgroup, desinationlogicalname [timeout] [espserverIPport] [maxConnections] [allowoverwrite] [replicate] [compress], [failIfNoSourceFile], [expireDays], [dfuServerQueue], [noSplit], [noCommon], [sourcePlane], [destinationNumParts])">
	</EclCode>
</pre>

| Value | Definition |
| :- | :- |
| sourceIP | A string containing the IP address or hostname of the Dropzone where the file is located. |
| sourcepath | A string containing the path and name of the file. |
| maxrecordsize | [Optional] An integer containing the max number of records in the file. Default set to 8192 when omitted. |
| srcRowTag | A string containing the row delimiting XML tag. |
| srcEncoding | [Optional] A string containing the encoding type. Default set to ‘utf8’ when omitted. |
| destinationgroup | A string containing the name of the specific supercomputer within the target cluster. |
| desinationlogicalname | A string containing the logical name of the file. |
| timeout | [Optional] An integer that indicates the timeout setting. Default of -1 when omitted. If set to zero (0), immediately returns to the ECL workunit without waiting for the DFU workunit to complete. |
| espserverIPport | [Optional] A string containing the protocol, IP, port and directory, or the DNS equivalent of the ESP server program. Usually, the same IP and port as ECL Watch, with ‘/FileSpray’ appended to it. Default value of that in lib_system.ws_fs_server. |
| maxConnections | [Optional] An integer that specifies the max number of connections. Default set to -1 when omitted. |
| allowoverwrite | [Optional] A TRUE or FALSE boolean that indicates whether you want the new file to overwrite the existing file (if one exists with the same name). True meaning ‘YES’ to overwrite and FALSE meaning ‘NO’ don’t overwrite. Default is set to FALSE when omitted. |
| replicate | [Optional] A TRUE or FALSE boolean indicating whether to replicate the new file. Default set to FALSE when omitted. |
| compress | [Optional] A TRUE or FALSE Boolean that indicates whether to compress the new file. Default set to FALSE when omitted. |
| failIfNoSourceFile | [Optional] A TRUE or FALSE Boolean that indicates whether to trigger a failure upon a missing file. Default set to FALSE when omitted. |
| expireDays | [Optional] Specifies that the file be sprayed/imported temporarily for a set number of days beginning on the read date. Default set to -1 (never expires). If set to zero (0), the file expires based on the threshold set in Sasha Server’s expiryDefault setting. |
| dfuServerQueue | [Optional] The name of target DFU Server queue. Default is '' (empty) for the first DFU queue in the environment. |
| noSplit | [Optional] A TRUE or FALSE Boolean that indicates whether to NOT split a file to multiple target parts. Default set to FALSE when omitted. |
| noCommon | [Optional]  A TRUE or FALSE boolean for "commoning up" of pull or push processes on same host. Set to FALSE to "common up" the operation on same host. Default can be set in configuration. Use GetNoCommonDefault to retrieve default setting. The value of this parameter can have a significant impact on performance. |
| sourcePlane | [Optional] The name of the landing zone containing the file |
| destinationNumParts | [Optional] Override the number of parts to be created when spraying. The default is 0 which means it will create the same number of parts as the target cluster. |


**Example**
<pre >
	<EclCode 
	code="/*Despray Example:*/

	// Despray function
	STD.File.SprayXML(
		'10.5.0.4',
		'/var/lib/HPCCSystems/mydropzone/myfile.xml',,
		'/',,
		'myroxie',
		'.::myfile.xml
	);">
	</EclCode>
</pre>
