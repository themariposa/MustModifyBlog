---
title: "Website Vital Signs"
layout: 'post'
permalink: 2008/07/16/website-vital-signs
published: 2008-07-16 04:39:00 UTC
---
Here's a list I'm keeping of website Vital Signs I want to implement in my &quot;Ruby Website Telemetry&quot;:http://blog.mustmodify.com/2008/07/ruby-website-telemetry.html application:

Database
-- Primary / Backup / Reporting Database Availability
-- Queries per Second
-- Average Query Time
-- Sort Buffer Size
-- Query Cache Hit Ratio
-- Thread Pool
-- InnoDB Buffer Pool size / free
-- IO threads
-- Log Size

OS
-- CPU Usage
-- Available RAM
-- Available Disk Space

Apache / Mongrel
-- Total Users
-- Total vs Available instances
-- Request Queue Length
-- Availability of All Expected Ports
-- Log Growth

Ruby / Rails
- MySQL availability
- Benchmarking
- Session Stability

Availability
- Web Service Availability
- Site Availability (using external proxy?)
- email availability?
- feed availability
