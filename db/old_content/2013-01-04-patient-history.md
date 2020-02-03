---
title: "storing patient history via HL7 / LOINC"
layout: 'post'
permalink: 2013/01/04/patient-history
published: 2013-01-04 02:02:15 UTC
---
In addition to storing data about a patient's current visit, my clients want to store a patient history. Thus, I need to store fields like:

- history of breast cancer? y/n
- history of lung cancer? y/n
- history of x cancer? y/n

and then:
- if yes, any evidence of cancer in the last 5 years?

What medicines are you taking?

Have you been hospitalized for a stroke?

etc.

My initial visit to &quot;the LOINC search engine&quot;:http://search.loinc.org/ did not reveal any codes for &quot;history of breast cancer&quot; etc. Perhaps there is some other term medical professionals use?

h2. HL7 to the rescue, sort of.

&quot;Evaluation of family history information .... &quot;:http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2995709/ shows that there is quite a bit of work being done to solve this problem. ( Apparently much of it involves HL7 v3, which I have read is a big tangled mess. ) This paper mentions three standards for modeling family history, listed in order from least to most helpful (according to the authors):

* HL7 Clinical Statement Model
* HL7 Clinical Genomics Family History Model
* Merged Family History Model ( not HL7; created by the document's authors.)

They also mention the &quot;My Family History Portrait&quot; program, which (apparently) does something similar to what we're considering.

h2. American Health Information Community Family Health History Workgroup

According to the Family History report I cited above, &quot;the American Health Information Community Family Health History Workgroup recently outlined a core family history dataset for future EHR systems.&quot;


