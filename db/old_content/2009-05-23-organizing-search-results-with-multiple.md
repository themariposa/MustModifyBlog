---
title: "Organizing Search Results with Multiple Criteria using SQL"
layout: 'post'
permalink: 2009/05/23/organizing-search-results-with-multiple
published: 2009-05-23 10:07:00 UTC
---
I love ruby; but for hard-core data manipulation, there's no place like the database. (I'm a poet.) Here's an clever way to sort results based on multiple criteria.

Credit for this trick goes to &quot;Erika Valentine&quot;:http://www.linkedin.com/pub/erika-valentine/13/49b/933 , who knows roughly everything about T-SQL. 

Story: 
As a consumer, 
I want to search for shared rides based on start and end location 
so that I can find rides that are most relevant to me.

Acceptance Criteria:
Given that there are rides starting near my start location, 
when I select a radius and search, 
then I see those rides.

Given that there are rides both at my starting location and near it, 
when I search, 
then I see the rides that are exact matches before rides that are close.

Given that there are rides both at my ending location and hear it, 
when I search, 
then I see the rides that are exact matches before rides that are close.

Given that there are rides that are close matches to my start location and close matches to my end location
when I search, 
results with an exact end location and close start location will appear before results with an exact start location and close end_location.

For the sake of simplicity, I'm going to hide logic like the  &quot;Haversine Formula&quot;:http://en.wikipedia.org/wiki/Haversine_formula , which is used to calculate distance. Let's just work with exact matches and close matches.

The second story is looking for exact matches for start_location at the top, followed by inexact matches.

--- sql
SELECT start_location_id, end_location_id  FROM rides
---

Results:
3092   3005
3001   30053012   3003
3001   3007

--- sql
SELECT start_location_id, if(start_location_id=3001, 1, 0) FROM rides
---

3092   3005   0
3001   3005   13012   3003   0
3001   3007   1

--- sql
SELECT start_location_id, if(start_location_id=3001, 1, 0) as matches_start FROM rides ORDER BY matches_start
---

3001   3005   13001   3007   13092   3005   0
3012   3003   0

Great! The third story is looking for exact and close end_locations:
 
--- sql 
SELECT start_location_id, if(start_location_id=3001, 1, 0) as matches_start, if(end_location_id=3005, 1, 0) as matches_end FROM rides ORDER BY matches_start, matches_end
---
3001   3005   1   13001   3007   1   03092   3005   0   1prio
3012   3003   0   0

In the real world, there are lots more variables to consider in terms of result priority.
matches_start_time, matches_stop_time, matches_vehicle_preferenceetc

So how to you prioritize all these fields properly?

---sql
select start_time, start_location, end_time, end_location, vehicle, ( matches_start_time + matches_start_location + matches_end_time + matches_end_location + matches_vehicle_preference ) as priority FROM( SELECT start_time, start_location, end_time, end_location, vehicle, (calc) as matches_start_time, (calc) as matches_end_time, (calc) as matches_start_location, (calc) as matches_end_location, (calc) as matches_vehicle_preference ) results ORDER BY priority
---

Of course your priority calculation will often include logic to make one match more important than the others. For instance, we would probably say (matches_start_location * 2) without bolstering matches_end_location because we have acceptance criteria that specifies that start_location matches appear first.

Two quick caviats:

You can not refer to a calculated column name from the field list. We avoid this problem by creating the surrouding query. This doesn't carry the overhead that traditionally makes sub-queries verboten because the subquery is O(1) rather than O(n ).

You also can't refer to a calculated column name from the where  clause. So, we wouldn't be able to say, where distance_from_start. You can get around this by putting your conditions in a having  clause, which in syntax is exactly like the where  clause, though it has some differences in terms of optimization. Do not  try to use the surrounding-query solution here, as there would be signifigant slowness.
