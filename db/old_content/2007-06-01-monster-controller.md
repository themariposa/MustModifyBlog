---
title: "The Monster Controller"
layout: 'post'
permalink: 2007/06/01/monster-controller
published: 2007-06-01 08:24:00 UTC
---
OUR PREDICAMENT

There is a controller I loath. I am reticent to touch it. It makes me think of the word quagmire. Every action is mired in a maze of tangled other actions, blocks, loops, cryptic hacks, and more. The views are a nightmare of fragmented, over ajaxified junk. It is the Time Entry controller.

When we started this project, none of the developers at Praeses had worked with Ruby on Rails. (That's a whole 'nother entry.) Frankly, it was a painful time. Due to a lack of experience, we made a lot of sophomoric mistakes. We went full steam ahead into territory we didn't understand. We didn't know where models should stop and controllers should start. We didn't know about resources. Controllers were just a place to put code... a name space for views and grouping together all the related models.

I'd experienced a nagging feeling as the controller grew, but couldn't put my finger on the problem. It started to get complicated to maintain. We started making hacks to the models and views that were involved, just to get the existing controller to work with the least amount of immediate pain. Changes here meant changes there, there, and over there, plus interface chances across the board and hoping there were no mysteries.

Suddenly we were way over budget. There was pressure to stop writing tests to reduce production time. Every step forward seemed to come with two steps back.

THE SOLUTION PRESENTS ITSELF

After the problem developed into a critical mass of unhappiness, a developer outside Praeses mentioned the value of following CRUD. The idea made a lot of sense to everyone on the team. We learned about looking at controllers as resources. CRUD was exactly the kind of straight-jacket our controllers needed.

That Create, Read, Update and Destroy were such a prevalent part of developing a large application was something I understood at some level years ago. I was working on an e-commerce application in &quot;PHP&quot;:http://www.php.net/ for &quot;MassageKing&quot;:http://www.massageking.com/ . Out of frustration at the awkwardness of the one-file-per-page nature of PHP, I accidentally created a pretty straight-forward custom framework for PHP. I noticed that I was doing a lot of creating, reading, updating, destroying. A fellow developer pushed our application toward models. I didn't understand the value of it and went back to what I was doing. Looking back, it would have been a great time to apply some meta-programming techniques.

Sometimes it takes an outside perspective to turn something you already know into something revolutionary. Once we got a push toward CRUD and resources, all the developers saw the value of it. Even if there are no other benefits, the tenants of CRUD mean there is that much less chance of creating another time-entry-esque controller.
