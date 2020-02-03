---
title: "HL7 Issues Facing Developers"
layout: 'post'
permalink: 2013/01/24/inconsistent-use-of-hl7-value-types
published: 2013-01-24 21:37:19 UTC
---
h2. Inconsistent use of HL7 Value Types

Trying to increase quality control, I set told my import agent not to flag any observations where the value type wasn't what my app would have selected as the value type. The results were surprising.

|Field|Quest's Value Type|Quest's Value|LabCorp Value Type|LabCorp Value|Expected|
|eGFR|ST|&gt;60|ST|&gt;59|NM|
|Vitamin D2|TX|&lt; 4|||NM|
|BUN/Creatinine Ratio|TX|NOTE|||NM|

So I guess the moral of the story is that Inequalities aren't considered numeric by LabCorp or Quest. It might be ST or TX. And also ST and/or TX might be used for random other things like &quot;Please see note.&quot;

h2. Storing notes in the value

Although I think it is overused, HL7 does provide a convenient note segment, NTE, that allows a lab to attach notes to an observation, patient, etc.

I received the following observation (OBX) from Access Labs:

value type: ST
identifier: 127^CRP, Cardio^L
value: 0.4 Low Risk of CVD
units: mg/L+  (sic)

Seriously. WHAT IS GOING ON HERE?

---
OBX|59|ST|127^CRP, Cardio^L||0.8 Low Risk of CVD|mg/L+|                    |N||S|F||||||||||||ACCESS MEDICAL LABORATORIES|5151 CORPORATE WAY^^JUPITER^FL^334583101
NTE|1|L|                         Low Risk of Cardiovascular Disease: CRP &lt; 1   mg/L
NTE|2|L|                         Medium Risk(&lt;2-fold increase)     : CRP 1-3   mg/L
NTE|3|L|                         High Risk(Approx.2-fold increase) : CRP  &gt;3   mg/L
---

