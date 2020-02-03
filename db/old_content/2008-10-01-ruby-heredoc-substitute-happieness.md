---
title: "Ruby Heredoc Substitute - happiness through readability"
layout: 'post'
permalink: 2008/10/01/ruby-heredoc-substitute-happieness
published: 2008-10-01 05:52:00 UTC
---
Sometimes you just have a paste a crazy-long string into your code. I find myself doing this often when it comes to testing. It might even have single and double quotes, so it's awkward to put quotes around the area and escape the quotes.

One solution is Ruby's implementation of the heredoc. Essentially, you're saying, &quot;This is a string. Go ahead and process this as a string until I give you the magic word . In the following example, &quot;DOCUMENT&quot; is the magic word.

---ruby
&gt;&gt; secret = 'PASSWORD'
=&gt; &quot;PASSWORD&quot;

&gt;&gt; my_text =&lt;&lt;-DOCUMENT Yoda says, 'confusing to escape this is: &quot;&quot;&quot; &quot;&quot;&quot;&quot; ;;;; ''''' .'
 My password is secretly #{secret}
 you could go on for a while here. DOCUMENT

=&gt; &quot; Yoda says, 'confusing to escape this is: \&quot;\&quot;\&quot; \&quot;\&quot;\&quot;\&quot; ;;;; ''''' .'\n My password is secretly PASSWORD\n you could go on for a while here.\n&quot;
---

So that's nice. Assuming you don't have #{} anywhere in your text, this works great. However, the word DOCUMENT doesn't exactly jump out as obvious.

&quot;Andy Stone&quot;:http://blog.stonean.com/ showed a syntax he often uses. Though the syntax is perl-like in it cryptic-ness, if that is a word, and I think that it is not, still, it seems better. Closing token is a pipe ( ), which Andy says he doesn't often find in strings.

---ruby
&gt;&gt; my_text = %|
Yoda says, 'confusing to escape this is: &quot;&quot;&quot; &quot;&quot;&quot;&quot; ;;;; ''''' .'
My password is secretly #{secret}
you could go on for a while here.|

=&gt; &quot;\n Yoda says, 'confusing to escape this is: \&quot;\&quot;\&quot; \&quot;\&quot;\&quot;\&quot; ;;;; ''''' .'\n My password is secretly PASSWORD\n you could go on for a while here.\n&quot;
---

It's not perfect, but certainly better. Certainly the pipe is a nicer closing token.
