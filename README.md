aj [10:38 AM]
@here would anyone be interested in a lunch and learn on elm? and anything in particular you would want to know about it if so?

charypar [10:39 AM]
It would be really interesting to cover their approach to JSON parsing. It's pretty mind bending at first, but really clever at the same time @aj

aj [10:40 AM]
yeah it’s awesome and intimidating at the same time :smile:
I’ll make sure I cover it
interestingly in my huge writeup i’ve been doing while learning elm, I have written nothing about JSON parsing, because it starts off being like :open_mouth: then becomes so simple and powerful you forget about it :smile:

charypar [10:42 AM]
Especially when you decide to do a custom type parsing... maybe when you have like a special string which is really an enum which should turn into a tagged union rather than string :slightly_smiling_face:
Yea that^! I remember feeling the same about it. Scratching my head for like a day, and then it suddenly became really natural

aj [10:43 AM]
I get the feeling you want a whole lunch and learn on elm decoders @charypar

charypar [10:44 AM]
hahaha :smile: not really, there's a bunch of other interesting stuff to cover. They just demonstrate really well how Elm uses all the really "hardcore" functional patterns without ever asking you to understand what a monad is :slightly_smiling_face: (edited)

aj [10:45 AM]
yeah I still don’t even pretend to know

charypar [10:45 AM]
And yet you've used a bunch of them :slightly_smiling_face: every `andThen` is a sign of them

aj [10:48 AM]
cool, thanks everyone, I’ll put something together for you and schedule something in the calendar

tom [10:56 AM]
I’d be interested to know some aspects of the practical side of elm. Did it take you long to become productive? Would you feel comfortable using it in production? Do you think it would scale well? Is it lacking any tools? That sort of thing
