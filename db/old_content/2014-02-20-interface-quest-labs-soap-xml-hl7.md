---
title: "Results-Only Interface with Quest via SOAP / HL7"
layout: 'post'
permalink: 2014/02/20/interface-quest-labs-soap-xml-hl7
published: 2014-02-20 19:01:51 UTC
---
&lt;Rant&gt;

Just as a note, I think SOAP is a terrible tragedy. There are dramatically better options. Check out [Designing Hypermedia APIs](http://www.designinghypermediaapis.com/) by Steve Klabnik.

&lt;/Rant&gt;

Get Results ( HL7 w/ Embedded PDF )
-----------------------------------

I'm using the action 'get_results' with parameters like this:
```
     'resultsRequest' =>
          {
            'startDate' => self.start_date.to_date.to_s(:mdy),
            'endDate' => self.end_date.to_date.to_s(:mdy),
            'maxMessages' => 30,
            'providerAccounts' => 'THO',
            'retrieveFinalsOnly' => 'false'
          }
```

and the request looks like this:

```
SOAP request: https://cert.hub.care360.com/resultsHub/observations/hl7
SOAPAction: "getResults"
Content-Type: text/xml;charset=UTF-8
Content-Length: 828

<?xml version="1.0" encoding="UTF-8"?><env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsdl="http://medplus.com/resultsHub/observations" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ins0="java:com.medplus.serviceHub.results.webservice" xmlns:ins1="java:com.medplus.serviceHub.results.webservice.printable" xmlns:ins2="java:javax.xml.rpc" xmlns:ins3="java:javax.xml.soap" xmlns:ins4="java:language_builtins.lang"><env:Body><getResults><wsdl:resultsRequest><wsdl:startDate>08/01/2013</wsdl:startDate><wsdl:endDate>09/01/2013</wsdl:endDate><wsdl:maxMessages>30</wsdl:maxMessages><wsdl:providerAccounts>THO</wsdl:providerAccounts><wsdl:retrieveFinalsOnly>false</wsdl:retrieveFinalsOnly></wsdl:resultsRequest></getResults></env:Body></env:Envelope>
```

response looks like this:

```
<?xml version="1.0"?>
<env:Envelope xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <env:Header/>
  <env:Body env:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <m:getResultsResponse xmlns:m="http://medplus.com/resultsHub/observations">
      <result xmlns:n1="java:com.medplus.serviceHub.results.webservice" xsi:type="n1:ResultsResponse">
        <HL7Messages soapenc:arrayType="xsd:string[2]">
          <string xsi:type="xsd:string">MSH|^~\&|LAB|QTE||12345|20130404215632||ORU^R01|80000000000000053080|D|2.3.1
PID|1|PID13|CB045678A||TEST^TC13||19700615|F|||||^^^^^972^9163000|||||0404135|111220001
NTE|1|TX|TEST CASE 13
ORC|RE||CB018665A||CM|||||||1122334455^ALLEN^JOSEPH^^^^^^^^^^NPI
OBR|1||CB018665A|3020^URINALYSIS, COMPLETE W/REFLEX TO CULTURE^^3020SBX=^URINALYSIS, COMPLETE W/REFLEX TO CULTURE|||20130404093200|||||||20130404083500||1122334455^ALLEN^JOSEPH^^^^^^^^^^NPI|||||CB^Quest Diagnostics-Wood Dale^1355 Mittel Blvd^Wood Dale^IL^60191-1024^Anthony V Thomas, M.D.|20130805171655|||F
OBX|1|ST|5778-6^Color Ur^LN^30005500^COLOR^QDIWDL||AMBER||YELLOW|A|||F|||20130805171655|CB
OBX|2|ST|5767-9^Appearance Ur^LN^30005600^APPEARANCE^QDIWDL||TURBID||CLEAR|A|||F|||20130805171655|CB
OBX|3|NM|5811-5^Sp Gr Ur Strip^LN^30006000^SPECIFIC GRAVITY^QDIWDL||1.032||1.001-1.035|N|||F|||20130805171655|CB
OBX|4|NM|5803-2^pH Ur Strip^LN^30006200^PH^QDIWDL||7.8||5.0-8.0|N|||F|||20130805171655|CB

<snip />

OBR|9||CB018665A|ClinicalPDFReport1^Clinical PDF Report CB018665A-1^^ClinicalPDFReport1^Clinical PDF Report CB018665A-1|||20130404093200|||||||20130404083500||1122334455^ALLEN^JOSEPH^^^^^^^^^^NPI||||||20130805171655|||F
OBX|1|ED|ClinicalPDFReport1^Clinical PDF Report CB018665A-1^^ClinicalPDFReport1^Clinical PDF Report CB018665A-1||QTE^Image^PDF^Base64^JVBERi0xLjQKJeLjz9MKMyAwIG9iago8PC9GaWx0ZXIvRmxhdGVEZWNvZGUvTGVuZ3RoIDEwPj5zdHJlYW0KeJwr5AIAAO4AfAplbmRzdHJlYW0KZW5kb2JqCjQgMCBvYmoKPDwvRmlsdGVyL0ZsYXRlRGVjb2RlL0xlbmd0aCA2Mz4+c3RyZWFtCnicUwjkKuRyCuHSj8g0VLBUCEnjMlQwAEJDBVNjIwVjA4WQXC6NAEd3VwUjBX83BSPNkCwu1xCuQC4AVXQLzApl

<snip content="large chunks of base64 encoded PDF" />

l0+PnN0cmVhbQp4nGNgYPj/n4mBiYGBUfEKkGDgBxHRDAwgMUZGhtsQFieIYGYUYYJwWUAEK4hgAxHsIIIDRDAxck4FGqCwGUQ8ZIAAAKN5Bx4KZW5kc3RyZWFtCmVuZG9iagpzdGFydHhyZWYKOTE0MAolJUVPRgo=||||||F
</string>
        </HL7Messages>
        <isMore xsi:type="xsd:boolean">false</isMore>
        <requestId xsi:type="xsd:string">551514a50a801e1512b2a98ed5f30b36</requestId>
      </result>
    </m:getResultsResponse>
  </env:Body>
</env:Envelope>

```

Acknowledgement
---------------

Using the response document above, I need the request ID and the message control IDs. The request ID comes from the SOAP document. The message control IDs come from the HL7 MSH segment.

```
>> response_document.xpath('//requestId').text
=> "551514a50a801e1512b2a98ed5f30b36"
```

And here's what I send to Quest...
```
SOAP request: https://cert.hub.care360.com/resultsHub/observations/hl7
SOAPAction: "acknowledgeResults"
Content-Type: text/xml;charset=UTF-8
Content-Length: 1029


<?xml version="1.0" encoding="UTF-8"?><env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsdl="http://medplus.com/resultsHub/observations" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ins0="java:com.medplus.serviceHub.results.webservice" xmlns:ins1="java:com.medplus.serviceHub.results.webservice.printable" xmlns:ins2="java:javax.xml.rpc" xmlns:ins3="java:javax.xml.soap" xmlns:ins4="java:language_builtins.lang"><env:Body><acknowledgeResults><wsdl:requestId>552173510a801e1512b2a98ee228b506</wsdl:requestId><wsdl:acknowledgeMessages><wsdl:message>MSH|^~&|PhysioAge Reporting|12345|LAB|QTE|201310091854||ACK|1372089260531|D|2.3.1
MSA|CA|80000000000000053080</wsdl:message></wsdl:acknowledgeMessages><wsdl:acknowledgeMessages><wsdl:message>MSH|^~&|PhysioAge Reporting|12345|LAB|QTE|201310091854||ACK|1372089260531|D|2.3.1
MSA|CA|80000000000000059438</wsdl:message></wsdl:acknowledgeMessages></acknowledgeResults></env:Body></env:Envelope>
```


and I get back:


```
<env:Envelope xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><env:Header></env:Header><env:Body env:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><m:acknowledgeResultsResponse xmlns:m="http://medplus.com/resultsHub/observations"></m:acknowledgeResultsResponse></env:Body></env:Envelope>
```



