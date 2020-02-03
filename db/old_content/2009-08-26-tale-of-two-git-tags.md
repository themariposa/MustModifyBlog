---
title: "A Tale of Two Git Tags"
layout: 'post'
permalink: 2009/08/26/tale-of-two-git-tags
published: 2009-08-26 07:04:00 UTC
---
Git's documentation is pretty lacking. I was looking for information about git's tags and found a fantastic explaination-by-demonstration at RockStarProgrammer.org (not sure how they got what should have been my domain.)

 &quot;Git Tag does wrong thing by default&quot;:http://www.rockstarprogrammer.org/post/2008/oct/16/git-tag-does-wrong-thing-default/ 

I'm not sure I agree with his conclusion that git 'does the wrong thing' by default, but the example is pretty clear.

git tag tag_name - names the most recent commit ( an object in git )
git tag -a - creates a tag object and names it
git tag -s - creates a tag object, names it, and signs it


