---
title: "[fix for] interpolation syntax in I18n messages is deprecated"
layout: 'post'
permalink: 2010/09/30/fix-for-interpolation-syntax-in-i18n-messages-is-deprecated
published: 2010-09-30 07:43:14 UTC
---
Somehow, Rails3 was installed in my 1.8 rvm gemset. rails3 depends on i18n v &gt;= 0.4. Uninstalling i18n (and rails3, since it doesn't run in 1.8 anyway) corrected this issue.
