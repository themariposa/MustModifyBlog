---
title: "Automating Reports from Misys Tiger"
layout: 'post'
permalink: 2013/04/12/misys-tiger-reports
published: 2013-04-12 20:19:19 UTC
---
My client has asked me to automate the monthly generation of reports from AllScripts/Misys Tiger.

I have a list of reports that must be generated:

* Daily Recap - for a given month, show one row for every day
** Day of Month
** Charges
** Misc Charges
** Charge Adjustments
** Insurance Write-Offs
** Net Charges = charges + misc_charges - charge adjustments - Insurance WriteOffs
** Balance Transfer
** Personal Receipts
** Insurance Receipts
** Total Receipts = Personal + Insurance
** Receipt Adjustments
** Ending AR

* Doctor's Financial - For a given year, show one row for every month of the current year. Then yearly totals. Then show the same table for last year. 
** Day of Month
** Charges
** Misc Charges
** Charge Adjustments
** Insurance Write-Offs
** Net Charges = charges + misc_charges - charge adjustments - Insurance WriteOffs
** Balance Transfer
** Personal Receipts
** Insurance Receipts
** Total Receipts = Personal + Insurance
** Receipt Adjustments
** Ending AR

* Procedure Analysis -- totals for doctor/location and for doctor
** Doctor
** Location
** Procedure ( Post Operative; Trigger Point I; ADX; Microscope, Hospital Visit )
** Month To Date
*** Units
*** Dollars
** Year To Date
*** Units
*** Dollars

* Receipt Analysis -- 
** Doctor
** Category ( Personal Receipts, Insurance Receipts, etc ) and then TOTAL
** MTD Total
** YTD Total

* Aging by Dr. Totals ( age  by posting date )
** Doctor ( and then grand total )
** Pending Total
** 0-30
** 31-60
** 61-90
** 91-120
** 121-150
** &gt; 150
** Patient Balance
** Total Balance


* Aging by Dr. Detail -- separate report for each doctor
** Patient
*** Type/Cycle/Number
*** Name
*** CS
*** Pending Insurance
*** Aged Total
**** 0-30
**** 31-60
**** ...
*** Patient Balance
*** Total Balance

* Dept. Analysis
** Doctor Name
** Department ( Evaluation and Man.. 99201, 99202, ... )
** Procedure Name ( Office Visit, Second Op, Consult, Ear Molds, etc)
** MTD
*** Units
*** Dollars
** YTD
*** Units
*** Dollars


The client remotely connects to the Tiger server, where she runs the reports. In October of 2011 she contacted Mysis asking whether these reports could be generated automatically. The response was that because it required sending parameters, she could not do that.

To complicate matters further, some of these doctors need visibility on a group level.

h2. Options

I'm considering a few options.

* Interfacing with AllScripts/Misys Query++ to generate the reports by command-line or ... other ... api, though the idea that they would provide an API seems laughable +++
* interfacing with the main Tiger code. Definitely not my first choice.
* creating a web service to automatically generate these reports directly from the database.

h2. Questions

* What is Cognos and how does it fit in with Query?
* Is there a CLI or API for Query?
* Where are the report definitions?
* Can I reproduce the production of these reports based on their report definition and mimicking their internal process?
* If not, what data feeds these reports? Exceptions? What calculations are involved?

++ the worst-name-ever for a reporting tool.

+++ Interoperability seems more like tooth pulling than the default. I think this has to do with the personality of winforms.


