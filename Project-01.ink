/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

/* ---------------------------------

This isn't the project I wanted it to be, but for the sake of realistic time it's going to be shorter than I previously intended.

 ----------------------------------*/

/* ---------------------------------

    - Create at least one major choice that the player can make [DONE]
    - Reflect that choice back to the player [DONE]
    - Include at least one loop [DONE]

   
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages [DONE]
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item [DONE]
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa) [DONE]
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested) [DONE?]

 ----------------------------------*/



VAR waitingCounter = 0
VAR holePresent = 0
VAR doorUnblocked = 0
VAR energy = 3
-> STARTING_AREA

==STARTING_AREA==
{not waitingCounter>0 and not THROUGH_HOLE: You wake up in a weird place. The ground is made up of some weird shimmering cloud material, and there are walls made of golden bricks all around you.}
{waitingCounter==1 and not DIG_UNDER: You wait.}
{waitingCounter==2 and not DIG_UNDER: You wait some more.}
{waitingCounter==3 and not CROWBAR and not HOLE_PRESENT_KNOT: Eventually, you wait for so long that somebody actually comes to you. You hear screaming before somebody smashes through the golden walls, their skin bubbling and seared. They scramble on the ground to get their footing, but a black tentacle shoots through the hole in the wall and yanks the screaming stranger away, their screams quickly fading. After processing this, you notice that the person dropped a crowbar. ->HOLE_PRESENT_KNOT }
{THROUGH_HOLE: You are back where you started. {KEEP_DIGGING and not CROWBAR: You notice that there's a crowbar on the floor here now.}}
{waitingCounter>3 and not BACK_OUT: You get the feeling that waiting won't bring about anything else.}
+ {not BACK_OUT} [Wait]
  ~waitingCounter += 1
  -> STARTING_AREA
* {waitingCounter >=3 or BACK_OUT or KEEP_DIGGING} [Grab the crowbar]
  ->CROWBAR
* [Dig under the wall]
  ->DIG_UNDER
+ {holePresent==1} [Go through the hole]
  ->THROUGH_HOLE

==HOLE_PRESENT_KNOT==
  ~holePresent = 1
  ->STARTING_AREA


==DIG_UNDER==
{holePresent==1: You don't see the point in doing this anymore, as there is a hole present already. ->STARTING_AREA}
  You decide to dig under the wall. The ground is soft enough and is very allowing for you to dig with just your bare hands. Eventually, you make a tunnel under the wall, but while doing so, you hear a strange noise above you, something that sounds like screaming.
  * [Back out and check out the noise]
    ->BACK_OUT
  * [Ignore it and keep digging]
    ->KEEP_DIGGING

==BACK_OUT==
  You back out of the tunnel... when you poke your head out, all you see is a flicker of motion, and then nothing else, the sound that now definitely sounds like human screaming fading away. You see that there is now a hole in one of the walls, as well as a crowbar on the ground.
  ~holePresent = 1
    ->STARTING_AREA
    
==KEEP_DIGGING==
  You decide to put it out of your head and keep digging... eventually you make it to the other side. Strangely, the wall behind you has a huge hole in it now. Weird. Regardless, you do feel a little stronger after having dug so much. You feel slightly winded, however.
  ~ holePresent = 1
  ~ energy -= 1
  
  ->THROUGH_HOLE


==CROWBAR==
  You pick up the crowbar. It has a nice weight to it.
  ~waitingCounter = 3
  ->STARTING_AREA

==THROUGH_HOLE==
  {not KEEP_DIGGING and not BACK_OUT: Trying to put the terrifying image of whatever monster was past this hole, you peek through the break in the wall before stepping on through.} {BACK_OUT and not BARRICADED_DOOR:You go through the hole.} {not BARRICADED_DOOR: It looks to be a hallway. On  the right side there is a boarded up door, on the left is an open doorframe, and at the end of the hall is a strange noise.} {BARRICADED_DOOR and LEFT_ROOM: You are in the hallway.}
  + {doorUnblocked==0} [Try to unblock the right door]
    ->BARRICADED_DOOR
  + {doorUnblocked==1} [Go through the now-open right door]
    ->BARRICADED_ROOM
  + [Go back through the hole]
    ->STARTING_AREA
  * [Go through the left doorframe]
    ->LEFT_ROOM
  * [Go through the door at the end]
    ->MONSTER_ROOM
    

==LEFT_ROOM==
  You go through the empty doorframe... it leads to a long hall that has something shimmering at the end.
  + [Go back]
    ->THROUGH_HOLE
  * [Run to the end]
    ->RUN
  * [Walk to the end]
    ->WALK
    
==WALK==
  You choose to walk... it takes a while, and you are dissapointed when you get to the end and find that it's just a shard of glass. Grumbling some, you go back to the hallway.
    ->THROUGH_HOLE
  
==RUN==
  You choose to run to the end... and you are dissapointed when you find out that the shining thing was just a shard of glass. On the upside though, you do feel like running should be easier for you! You do feel more winded from using up that energy though.
  ~ energy -= 1
  You choose to go back the way you came from.
    ->THROUGH_HOLE
    
==MONSTER_ROOM==
  You go through the door at the end of the hall... you can see an open doorway with light coming out from it at the end of the room. However, as you go towards it... a monstrous tentacle bursts from the floor and goes for you!
    {energy <= 0: Unfortunately, you just don't have the energy to do anything about it... you are helpless as the tentacle lurches towards you, wraps around you, and drags you down to the scorching depths below... ->BAD_END}
  {not RUN and not BLADE: However, unarmed and with no skills, you are helpless as the tentacle lurches for you, wrapping around you before dragging you down to the scorching depths below... ->BAD_END}
  * {energy >= 2 and RUN} [Evade the Monster]
    ->EVADE
  * {BLADE and energy >= 1} [Attack the Monster]
    ->SLAY

==SLAY==
  Using your blade, you slice heroically at the tentacle... and watch as it slices clean through! The tentacle going limp and falling to the ground, you valiantly make your way through the open doorway... and find yourself free from this hell! 
  CONGRATULATIONS! YOU WIN!
  ->END
==EVADE==
  You decide to use your new agility, along with the energy you still have, to dodge its attacks and try to maneuver to the exit. With a few near hits and plenty of adrenaline running through you, you manage to thrust yourself through the exit... and you find yourself free of this hell!
  CONGRATULATIONS! YOU WIN!
  ->END

==BAD_END==
...
  YOU LOST.
  You were so close, too...
  ->END

==BARRICADED_ROOM==
  You enter the room. It is in absolute disarray, full of rubble and debris. You notice in the clutter a blade that lightly glows.
  + [Go back]
    ->THROUGH_HOLE
  * [Pick up the blade]
    ->BLADE

==BLADE==
  You pick up the blade. it shimmers with an ethereal energy.
  ->BARRICADED_ROOM


==BARRICADED_DOOR==
  You try to pry off the wood blocking off the door {not CROWBAR:, but you can't seem to do it with your hands alone.}{not KEEP_DIGGING and CROWBAR:, but even using the crowbar you just don't seem to be strong enough to do it.}{KEEP_DIGGING and CROWBAR:, and you manage to do it with the crowbar. The way through is now open, though that did take some steam out of you. ->DOOR_UNBLOCK_KNOT}
    ->THROUGH_HOLE

==DOOR_UNBLOCK_KNOT==
  ~doorUnblocked = 1
  ~energy -= 1
  ->THROUGH_HOLE
