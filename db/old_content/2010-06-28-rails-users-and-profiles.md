---
title: "users and profiles"
layout: 'post'
permalink: 2010/06/28/rails-users-and-profiles
published: 2010-06-28 12:13:57 UTC
---
I find myself, yet again^n, considering users and profiles.

Say you have the following models:

- User
- Doctor
- Patient

Of course, the concept of user is not the same as the concept of a person. User might be more accurately called Login, since it could be a bot or a guest login used by 100 various anonymous people. 

your views have access to current_user. We'll make our lives easier by ssuming that current_user is always populated with a valid user.

What I remember thinking last time I was in this bruhaha was that a user could have one or more profiles. That's what we conveniently have here.  A user can be a doctor, and if so, they have a doctor profile... license number, type of practice, whatever. That same person could be a patient. If so, we'll have information like... emergency contact, last_check_up, allergies. 

So you can ask whether a user can see a patient. And obviously this falls under the User model since it's all about authentication and authorization.

--- ruby
class User

  def can_view?( patient )
    (self == patient ) || (self.doctor &amp;&amp; patient.doctor == self.doctor)
  end

end
---


ok... so now I want to welcome this user. If they are a doctor, I want to prepend their name with &quot;Dr.&quot; first_name and last_name are on User.

--- ruby
class User
  def fullname
    [title, first_name, last_name].join(' ')
 end
end
----

ok great. At some point I'm running through a list of doctors and I'll want to output their names.

--- ruby
class Doctor
  def to_s
    self.user.to_s
  end
end
---

(a) we've already said that a user isn't necessarily a doctor; could be a group.
(b) for this app, there's no guarantee a doctor even has a login.

I don't want to store first_name, last_name twice... so that leads me to the conclusion that I need a Person model.

Person
  first_name
  last_name
  dob
  blah

So then we get:
Doctor#person_id
Patient#person_id
User#person_id ????
maybe, instead of that...
Person#user_id

so then
--- ruby
class User
  def to_s
    person.to_s
  end
end

class Person
  def to_s
    title, first_name, last_name
  end
end

class Doctor
  def to_s
    person.to_s
  end
end

# same for patient  
---

ok this seems very sensible.


