#lang at-exp racket

(provide (all-defined-out))

(define albert-einstein 3)
(define ashley-falls 7185)
(define barrio-logan 10640)
(define bird-rock 10617)
(define csu-san-marcos 10528)
(define carmel-del-mar 7184)
(define castle-park-elementary 10658)
(define chabad 10544)
(define country-montessori 10486)
(define deer-canyon 7379)
(define del-mar-hills 7183)
(define del-mar-heights 10503)
(define doyle 7591)
(define east-lake 7159)
(define hillsdale-middle 10642)
(define holly-drive 10510)
(define fleet 10484)
(define fleet-spring 10515)
(define grant 7512)
(define hearst 7517)
(define hickman 7582)
(define high-tech-high 10641)
(define hill-top 10526)
(define jerabek 7593)
(define jcc 10507)
(define JCS 10597)
(define kumeyaay 7600)
(define liberal-arts 10595)
(define language-academy 10508)
(define la-jolla 7526)
(define la-jolla-country-day 10537)
(define country-day-summer 10575)
(define marshall 7165)
(define mira-costa 10576)
(define notre-dame 10502)
(define ocean-air 7181)
(define old-town 7435)
(define painted-rock 10488)
(define sage-canyon 7186)
(define sage-canyon-summer 10520)
(define san-diego-christian-college 10638)
(define san-diego-high 10651)
(define san-marino 10647)
(define serra-mesa-library 10635)
(define sdsu 10572)
(define spreckels 10517)
(define sycamore-ridge 10531)
(define tecolote-shores 10643)
(define tierrasanta 7584)
(define thoughtstem 10558)
(define torrey-hills 7187)
(define torrey-pines 7557)
(define torah-high 10616)
(define ucsd-extension 1)
(define ucsd-summer-camp 10571)
(define urban-discovery 10509)
(define west-wood 7368)


(define python-racket-description
  @~a{
 <p>Over the last few decades, Python has skyrocketed in popularity.
 The language is a top choice for machine learning, data science, and (of course) video game design!
 The Python ecosystem has multiple power tools for making high-quality video games: Pygame, Pymunk, and Pyfizz.
 This camp introduces students to these tools, while helping them to make their very own Python-powered games.
 Languages used in this course are: Python and (for advanced students) Racket.</p>

 <p>A key focus of this course is on the principles of video game design.  What makes for a good game?
 What makes a game exciting?  How do you make stunning art for video games?</p>
 
<p>Students will progress from "Hello World" all the way to their own fully functional video games.
 Games made in this camp can run on any computer with Python, Pymunk, and Pygame installed --
 which means the games will run on Windows, Mac, or Linux.</p>
 }
  )

(define robotics-course-description
  "<p>Learn to <b>build and code robots</b> using the RoKit, designed locally in San Diego by our friends at Robolink. Students will work in teams as they learn and apply both mechanical and software engineering principles. Students will complete a variety of challenges like maze navigation, line following, and sumo competitions. </p>\n<p>There is so much to learn about robotics! That's why this summer we have an A, B, and C version of this camp. Each camp covers different material, so take one camp or all three!<b>This camp is Version A.</b></p>\n<p>We will send daily email reports with the code that students worked on in camp that day, so that they can keep coding at home. After camp, we'll also provide students with information to purchase a robotics kit for continued learning at home.</p>")

(define (code-your-game-description name)
  (~a "<p>This Fall, " name " students will design & code their very own 2D story-based, adventure games. Students will be able to choose their favorite characters from <i>Minecraft</i>, <i>Harry Potter</i>, <i>Fortnite</i>, and <i>Pokemon</i> to create an open world for players to explore. ThoughtSTEM's expert instructors will teach students how to program common adventure game elements like quests and NPCs into their games using a powerful, typed language. At the end of this course, students will be able to share their game with friends and family.</p>
<p><i>Did you know? Computer science college graduates earn 40% more income over their lifetime compared to other college graduates?</i></p>"))

(define code-your-game-screenshot
  "https://www.thoughtstem.com/system/images/W1siZiIsIjIwMTgvMDgvMjAvMjAvMzYvNDIvNDMwLzN0bzVjdXJyaWN1bHVtZ2lmLmdpZiJdXQ/3to5curriculumgif.gif")

(define (code-your-game-winter-description name)
  (~a "<p>This Winter, " name " 3rd-5th students will design & code their very own 2D survival games. Students will learn how to build critical features that make survival games like <i>Minecraft</i> and <i>Fortnite</i> fun! Students will use a powerful, typed language to code features like health bars, day-night cycles, and crafting/recipe mechanics. At the end of this course, students will be able to share their survival games with friends and family. <i>Note: Students are welcome to join us in the Winter without having taken the Fall program.</i></p>
<p><i><b>Did you know?</b> That coding is becoming an integral aspect of other important sciences, including Biology, Chemistry, and the Physical Sciences.</i></p>"))

(define code-your-game-winter-screenshot
  "https://ts-automation-files.s3.amazonaws.com/production/admin_notes/2499/Summer_circuit.jpeg")

(define (code-your-game-spring-description name)
  (~a "<p>This Spring, " name " 3rd-5th students will design & code their very own 2D battle arena video games. What's a battle arena game? Think <i>Pokemon</i> or <i>Final Fantasy</i>! Students will learn how to code their characters' attacks and defenses, create battle animations, and program a turn-based rule system with a user interface. At the end of this course, students will be able to share their survival games with friends and family. <i>Note: Students are welcome to join us in the Spring without having taken the Fall and Winter programs.</i></p>
<p><i><b>Did you know?</b> That different programming languages are really like different dialects of the same language. Like studying other foreign languages, students should focus on becoming an expert in just one language, instead of focusing on a bunch of different dialects.</i></p>"))

(define code-your-game-spring-screenshot
  "https://ts-automation-files.s3.amazonaws.com/production/admin_notes/2498/carlos_thumbs_up_smaller.jpeg")

(define (digital-comics-description name)
  (~a "<p>This Fall, " name " K-2 students will learn how to express their creativity through digital art! We'll teach students how to turn their personal art into digital art by helping them create a portfolio of comic book art. Students will learn how to use MIT's Scratch programming interface to create their art. Students will gain important computer literacy skills, including proficiency with computers, mice, and keyboards. At the end of the course, students can share their portfolio with family!</p>
<p><i>Did you know? The average student prefers the Arts and Computer Science over all other subjects taught commonly in schools?</i></p>"))

(define digital-comics-screenshot
  "https://www.thoughtstem.com/system/images/W1siZiIsIjIwMTgvMDgvMjAvMjIvMDMvMTAvNDU3L3NjcmF0Y2hfZ2lmLmdpZiJdXQ/scratch_gif.gif")

(define (superhero-animations-description name)
  (~a "<p>This Winter, " name " K-2nd students will learn how to take their coding to the next level! We'll teach students how to turn their digital art into digital animations with code. Students will learn how to use MIT's Scratch programming interface to create animated stories involving their own artistic creations. Students will gain important computer literacy skills, including proficiency with computers, mice, and keyboards. At the end of the course, students will be able to share their animated stories with family and friends! <i>Note: Students are welcome to join us in the Winter without having taken the Fall program.</i></p>
<p><i><b>Did you know?</b> 90% of parents want their students to learn how to code, but only 40% of schools teach any form of coding education!</i></p>"))

(define superhero-animations-screenshot
  "https://ts-automation-files.s3.amazonaws.com/production/admin_notes/2503/k2-winter.gif")

(define (superhero-games-description name)
  (~a "<p>This Spring, " name " K-2nd students will learn how to create their own video games with code! Students will learn how to use MIT's Scratch programming interface to create video games featuring important video game design aspects, like game rules, character movement, and scoreboards. Students will continue to gain proficiency in critical technology skills, including typing, use of a mouse, and use of an internet browser. At the end of the course, students will be able to share their superhero-themed games with family and friends! <i>Note: Students are welcome to join us in the Spring without having taken the Fall and Winter programs.</i></p>
<p><i><b>Did you know?</b> 58% of all new STEM jobs being created right now are in computing?</i></p>"))

(define superhero-games-screenshot
  "https://ts-automation-files.s3.amazonaws.com/production/admin_notes/2500/AiLAwfDMEA2nTFytSq.gif")

(define game-design-and-robotics-description
  "This Fall, the most experienced computer science instructors in San Diego will teach Del Mar K-2 students how to build their own video games and program small robots using powerful visual programming languages. Founded by UCSD Computer Science PhD students, ThoughtSTEM has been bringing the best in computer science education to Del Mar Union schools since 2014. Teacher to student ratios average 1:5, meaning students get more 1-on-1 mentorship than any other technology program.")

(define game-design-and-robotics-screenshot
  "https://www.thoughtstem.com/system/images/W1siZiIsIjIwMTcvMDgvMjkvMTkvMjcvMjcvNzMwL296b2JvdHNfc2FsZXNfaW1hZ2UucG5nIl1d/ozobots_sales_image.png")


(define coding-and-engineering-description
  "This Fall, the most experienced computer science instructors in San Diego will teach Del Mar 3rd-6th grade students how to program the inputs and outputs of micro-controllers and hoaw to engineer fun electronic devices like Star Wars light sabers, using real text-based languages. Founded by UCSD Computer Science PhD students, ThoughtSTEM has been bringing the best in computer science education to Del Mar Union schools since 2014. Teacher to student ratios average 1:5, meaning students get more 1-on-1 mentorship than any other technology program. ")

(define coding-and-engineering-screenshot
  "http://www.thoughtstem.com/system/images/W1siZiIsIjIwMTcvMDgvMDgvMTYvNTMvNTUvOTM5L2V6Z2lmLmNvbV9vcHRpbWl6ZS5naWYiXV0/ezgif.com-optimize.gif")


(define k-2nd-fall-2019-selling-points
  (list "Learn to code by making games involving fun, animal characters!"
        "Gain critical skills with a mouse and keyboard, which every student needs to truly succeed with technology."
        "Coding knowledge is critical for the future! We believe kids should start becoming fluent in technology now!"))

(define 3rd-5th-fall-2019-selling-points
  (list "Learn to code by making games with quests, crafting, and student designed cut-scenes."
        "Level up fluency in programming languages through cutting-edge language-learning curriculum."
        "Earn badges & prizes in a fun, engaging learning environment with awesome educators."))

(define 3rd-5th-del-mar-selling-points
  (list
   "Students will explore important technical concepts like electrical engineering, conductivity, and I/O."
   "Students will complete projects using micro-controllers"
   "Typed programming: great for students who have used Scratch previously!"
   "Transparency: parents will receive weekly classroom reports sharing their students' work in class"))

(define 3rd-5th-selling-points
  (list
   "Students will code their own game using characters from Minecraft, Harry Potter, Fortnite, Pokemon, etc."
   "Students will learn how to design features like quests, NPCs, and open world exploration"
   "By the end, students will be able to share games with friends!"))

(define k-2nd-selling-points
  (list
   "Students will create a portfolio of digital art"
   "Students will gain proficiency with computers, mice, and keyboards"
   "Students will learn creativity through digital art that can be shared with family"))

(define k-2nd-winter-selling-points
  (list
   "Students will learn how to use MIT's Scratch programming interface"
   "Students will create animations of their digital superhero art"
   "Students will gain proficiency with computers, mice, and keyboards and will become confident with technology!"))

(define 3rd-5th-winter-selling-points
  (list
   "Students will code & design their own 2D survival games with game features similar to favorites like Minecraft and Fortnite"
   "Students will learn how to code game features like health, day-night cycles, and crafting mechanics"
   "Students can share their game with friends and family!"))

(define k-2nd-spring-selling-points
  (list
   "Students will learn the fundamentals of coding"
   "Students will create video games involving their favorite superheroes"
   "Students will gain proficiency with computers, mice, and keyboards and will become confident with technology!"))

(define 3rd-5th-spring-selling-points
  (list
   "Students will code & design their own 2D battle arena games with game features similar to favorites like Minecraft and Fortnite"
   "Students will learn how to code game features like weapons, armor, and potions"
   "Students can share their game with friends and family!"))

(define k-2nd-del-mar-selling-points
  (list
   "Students will learn how to build their own video games using MIT's Scratch language"
   "Students will program small robots using another powerful visual programming language"
   "Students will gain proficiency with computers, mice, and keyboards"))

(define (code-your-game-bundle-winter school)
  (list "Coding Club: Code Your Own Survival Game: 3rd-5th Grade (Winter)"
        (code-your-game-winter-description school)
        code-your-game-winter-screenshot
        (list "3rd-5th")))

(define (code-your-game-bundle-spring school)
  (list "Coding Club: Code Your Own Battle Arena Game: 3rd-5th Grade (Spring)"
        (code-your-game-spring-description school)
        code-your-game-spring-screenshot
        (list "3rd-5th")))

(define (superhero-animations-winter school)
  (list "Coding Club: Digital Animation with Superheroes: K-2nd (Winter)"
        (superhero-animations-description school)
        superhero-animations-screenshot
        (list "K-2nd")))

(define (superhero-game-spring school)
  (list "Coding Club: Superhero Video Games: K-2nd (Spring)"
        (superhero-games-description school)
        superhero-games-screenshot
        (list "K-2nd")))

;Generic Course Bundle
(define (generic-course-description)
  (~a "<p>This session's course curriculum has not yet been finalized. Please check back soon!</i></p>"))

(define (generic-course-k-2 school)
  (list "ThoughtSTEM K-2 Coding Club"
        (generic-course-description)
        ""
        (list "K-2nd")))

(define (generic-course-3-5 school)
  (list "ThoughtSTEM 3-5 Coding Club"
        (generic-course-description)
        ""
        (list "3rd-5th")))

(define (barrio-logan-hs school)
  (list "Barrio Logan High School Course"
        (generic-course-description)
        ""
        (list "3rd-5th")))

(define (torrey-pines-in-school school)
  (list "Torrey Pines In-School: "
        (generic-course-description)
        ""
        (list "K-2nd")))


;DMUSD Spring 2019 bundles
(define (superhero-scratch-game-description name)
  (~a "<p>This Spring," name "K-2nd students will learn how to take their coding to the next level! We'll teach students how to turn their digital art into digital animations with code and MIT's Scratch programming interface. Students will learn how to create animated stories involving their own artistic creations and to create video games featuring important video game design aspects, like game rules, character movement, and scoreboards.
 Students will gain important computer literacy skills, including proficiency with computers, mice, and keyboards. At the end of the course, students will be able to share their superhero-themed games with family and friends!</i></p>"))


(define (survival-battle-game-description name)
  (~a "<p>This Spring," name "3rd-6th students will design & code their very own 2D survival and battle arena games. Students will learn how to build critical features that make survival games like <i>Minecraft</i> and <i>Fortnite</i> fun! Students will use a powerful, typed language to code features like health bars, day-night cycles, and crafting/recipe mechanics.
 They'll also learn how to code their characters' attacks and defenses and create battle animations. At the end of this course, students will be able to share their survival and battle arena games with friends and family.</i><p>")) 


(define (superhero-scratch-game-bundle school)
  (list "Super Hero Animations and Video Games: K-2nd"
        (superhero-scratch-game-description school)
        superhero-games-screenshot
        (list "K-2nd")))


(define (survival-battle-game-bundle school)
  (list "Survival and Battle Arena Video Game Design: 3rd-6th"
        (survival-battle-game-description school)
        code-your-game-spring-screenshot
        (list "3rd-6th")))

;Summer Camp 2019 Bundles

;K-2
(define (camp-a-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & critical thinking skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing critical thinking skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p>"))
(define (camp-b-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & algebraic logic through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing skills in mathematics, specifically algebra. This is a great introduction for young students, who have likely never been exposed to algebraic logic before.</p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p>"))
(define (camp-c-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & abstract reasoning skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing abstract reasoning skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p>"))
(define (camp-d-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & pattern recognition skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing pattern recognition skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p>"))

(define (k2-camp-a-bundle school)
  (list "Adventures in Coding and Critical Thinking: K-2nd"
        (camp-a-description school)
        ""
        (list "K-2nd")))
(define (k2-camp-b-bundle school)
  (list "Adventures in Coding and Algebraic Logic: K-2nd"
        (camp-b-description school)
        ""
        (list "K-2nd")))
(define (k2-camp-c-bundle school)
  (list "Adventures in Coding and Abstract Reasoning: K-2nd"
        (camp-c-description school)
        ""
        (list "K-2nd")))
(define (k2-camp-d-bundle school)
  (list "Adventures in Coding and Pattern Recognition: K-2nd"
        (camp-d-description school)
        ""
        (list "K-2nd")))











;3-6
(define (harry-potter-36-description name)
  (~a "<p>This summer, students will learn the fundamentals of computer science by developing their own wizard-themed video games. Using <i>Harry Potter</i> as a point of inspiration, we will teach students how to craft their own adventure game inside a unique wizarding world. In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Students are going to love coding their own wizarding world full of mystery & magic! </p>"))
(define (star-wars-36-description name)
  (~a "<p>This summer, students will learn how to use the force of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Students are going to love creating their own <i>Star Wars</i>-themed games! </p>"))
(define (lord-rings-36-description name)
  (~a "<p>This summer, students will learn how to create their own fantasy world of elves, dwarves, dragons, and hobbits! Using the famous Lord of the Rings trilogy for inspiration, students will create an adventure-style video game in which the main character sets off on an epic quest with a story they craft themselves! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We think LOTR fans of all ages will love building their own fantasy video games by recreating elements from the original trilogy.</p>"))
(define (marvel-36-description name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, The Avengers, for inspiration, students will create a battle arena video game that pens their favorite superheroes against their least favorite villians in an endless battle between good and evil! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We think our young Marvel fans will love building their own battle arena games and coding their own unique superheroes with their own special powers.</p>"))
(define (minecraft-36-description name)
  (~a "<p>This summer, students will learn how to code a 2D version of their favorite video game - Minecraft! Drawing on the video game mechanics of the hit 3D game, students will code their own 2D blocky survival game with day night cycles, health bars, and enemies like Creepers to hide from at night! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Minecraft has always been a great way for our students to learn how to code, but we think this summer's Minecraft camp will take students' coding skills to the next level! </p>"))
(define (fortnite-36-description name)
  (~a "<p>This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game Fortnite! In this camp, students will learn how to code different features of Fortnite, like enemies, armor, weapons, and potions, into their own unique 2D games! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Note: We understand Fortnite is a video game that has violent elements that might be inappropriate for young students. We at ThoughtSTEM are 100% committed to making sure students are not exposed to violent content in our camps. This is why we often modify video game content to meet students' educational needs, while still engaging them in a game they love. We believe video games like Fortnite provide an exceptional gateway into computer science for students, and ThoughtSTEM curriculum developers are paving the way to create new coding educational content for students inspired by the video games they love. </p>
"))
(define (pokemon-36-description name)
  (~a "<p>This summer, students will learn how to code a novel Pokemon-themed survival video game! First, students will learn how to create their own Pokemon-like characters with walking animations. Then students will code video games where their pokemon is trying to survive in a world in which mean Pokemon trainers are throwing pokeballs at them all the time to try to capture them! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fiction video game with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>After this camp, students will go home thinking Gotta code em all! </p>"))
(define (mario-36-description name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, Mario titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the Mario-franchise, like mushrooms and power-ups, for inspiration! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We're excited to work with students to create unique Mario-inspired games that they can share with friends and family! </p>"))


(define (36-harry-potter-camp-bundle school)
  (list "Coding for Harry Potter Fans: 3rd-6th"
        (harry-potter-36-description school)
        ""
        (list "3rd-6th")))

(define (36-star-wars-camp-bundle school)
  (list "Coding for Star Wars Fans: 3rd-6th"
        (star-wars-36-description school)
        ""
        (list "3rd-6th")))

(define (36-lord-rings-camp-bundle school)
  (list "Coding for Lord of the Rings Fans: 3rd-6th"
        (lord-rings-36-description school)
        ""
        (list "3rd-6th")))

(define (36-marvel-camp-bundle school)
  (list "Coding for Marvel Fans: 3rd-6th"
        (marvel-36-description school)
        ""
        (list "3rd-6th")))

(define (36-minecraft-camp-bundle school)
  (list "Coding for Minecraft Fans: 3rd-6th"
        (minecraft-36-description school)
        ""
        (list "3rd-6th")))

(define (36-fortnite-camp-bundle school)
  (list "Coding for Fortnite Fans: 3rd-6th"
        (fortnite-36-description school)
        ""
        (list "3rd-6th")))

(define (36-pokemon-camp-bundle school)
  (list "Coding for Pokemon Fans: 3rd-6th"
        (pokemon-36-description school)
        ""
        (list "3rd-6th")))

(define (36-mario-camp-bundle school)
  (list "Coding for Mario Fans: 3rd-6th"
        (mario-36-description school)
        ""
        (list "3rd-6th")))

        


;7th-10th
(define (harry-potter-710-description name)
  (~a "<p>This summer, students will learn the fundamentals of computer science by developing their own wizard-themed video games. Using <i>Harry Potter</i> as a point of inspiration, we will teach students how to craft their own adventure game inside a unique wizarding world. In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>Students are going to love learning college-level fundamentals of computer science while creating their own wizarding world full of mystery & magic! </p>"))
(define (star-wars-710-description name)
  (~a "<p>This summer, students will learn how to use the force of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>We're looking forward to working with students to build their own <i>Star Wars</i>-themed games! </p>"))
(define (fortnite-710-description name)
  (~a "<p>This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game <i>Fortnite</i>! In this camp, students will learn how to code different features of <i>Fortnite</i>, like enemies, armor, weapons, and potions, into their own unique 2D games! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>Although <i>Fortnite</i> itself isn't code-able, students who take this course will learn computer science skills that will enable them to develop their own <i>Fortnite</i>-like games in the future.</p>"))
(define (mario-710-description name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, Mario titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the Mario-franchise, like mushrooms and power-ups, for inspiration! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>We're excited to work with students to create unique Mario-inspired games that will help them build out their portfolios for college! </p>"))
(define (marvel-710-description name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, The Avengers, for inspiration, students will create a battle arena video game that pens their favorite superheroes against their least favorite villians in an endless battle between good and evil! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>By learning college-level computer science fundamentals now, our students truly will be the superheroes of technology in the future.</p>"))

(define (710-harry-potter-camp-bundle school)
  (list "Coding for Harry Potter Fans: 7th-10th"
        (harry-potter-710-description school)
        ""
        (list "3rd-6th")))

(define (710-star-wars-camp-bundle school)
  (list "Coding for Star Wars Fans: 7th-10th"
        (star-wars-710-description school)
        ""
        (list "3rd-6th")))

(define (710-fortnite-camp-bundle school)
  (list "Coding for Fortnite Fans: 7th-10th"
        (fortnite-710-description school)
        ""
        (list "3rd-6th")))

(define (710-mario-camp-bundle school)
  (list "Coding for Mario Fans: 7th-10th"
        (mario-710-description school)
        ""
        (list "3rd-6th")))

(define (710-marvel-camp-bundle school)
  (list "Coding for Marvel Fans: 7th-10th"
        (marvel-710-description school)
        ""
        (list "3rd-6th")))


; ASP Fall 2019 Bundles

(define (k2-awesome-animals-description name)
  (~a "<p>Our popular Coding Club is a fun & effective way for kids to learn how to code through video game design! ThoughtSTEM’s novel approach to computer science education is
 backed by the latest scientific research that shows learning how to code is more like learning a foreign language than learning math. Therefore, we leverage the entire field of language acquisition so that our students are ready for a future where they’ll need to speak the languages of computers fluently. We also keep the emphasis on FUN, so throughout the course students will earn badges and prizes as they expand their knowledge of computer science. During this session of Coding Club, students will be designing video games featuring animals
 - they'll learn how to customize the colors of & heal their animal game characters, and also avoid enemies!</p>"))

(define (3-5-epic-quest-description name)
  (~a "<p>Our popular Coding Club is a fun & effective way for kids to learn how to code through video game design! ThoughtSTEM’s novel approach to computer science education is backed by the latest scientific research that shows learning how to code is more like learning a foreign language than learning math. Therefore, we leverage the entire field of language acquisition so that our students are ready for a future where they’ll need to speak the languages of computers fluently. We also keep the emphasis on FUN, so throughout the course students
will earn badges and prizes as they expand their knowledge of computer science. During this session of Coding Club, students will be designing video games that involve quests, crafting, and building their own in-game cut-scenes!</p>"))

(define k2-awesome-animals-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/k-2.gif")

(define 3-5-epic-quest-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/adventure.gif")


(define (k2-awesome-animals-bundle school)
  (list "Coding Club: Awesome Animals: K-2nd (Fall)"
        (k2-awesome-animals-description school)
        k2-awesome-animals-screenshot
        (list "K-2nd")))

(define (3-5-epic-quest-bundle school)
  (list "Coding Club: Epic Quest: 3rd-5th (Fall)"
        (3-5-epic-quest-description school)
        3-5-epic-quest-screenshot
        (list "3rd-5th")))


; Asp Winter 2019-20 Bundles

(define (k2-winter-2020-description name)
  (~a "<p>Class description coming soon...</p>"))

(define (3-5-3D-worlds-description name)
  (~a "<p>The magic of turning code into an immersive 3D world is something that only coders will ever experience. In our Winter program, students at" name "Elementary will learn a powerful programming language for designing and customizing beautiful interactive worlds that they can walk (or fly!) through.
Beginners will be surprised to find that with just a few lines of code, they are able to create places that have never existed before. Advanced students will be pleasantly surprised at how deep and subtle the art of world-building really is. In this session, students will earn badges as they become more and more fluent in coding.<p>"))

(define k2-winter-2020-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/DSC_0603_370_200.jpg")

(define 3-5-3D-worlds-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/vr-engine.gif")

(define (k2-winter-2020-bundle school)
  (list "Coding Club: K-2nd (Winter)"
        (k2-winter-2020-description school)
        k2-winter-2020-screenshot
        (list "K-2nd")))

(define (3-5-3D-worlds-bundle school)
  (list "Coding Club: Exploring 3D Worlds: 3rd-5th (Winter)"
        (3-5-3D-worlds-description school)
        3-5-3D-worlds-screenshot
        (list "3rd-5th")))


; Asp Spring 2020 Bundles

(define (k2-spring-2020-description name)
  (~a "In our Spring program, students at" name "will code their own Pokemon-themed whack-a-mole games! K-2nd students will learn how to customize their games however they want: Are they a Pokemon trainer collecting all the Pikachus? Are they a Bulbasaur collecting Pokemon friends, but avoiding the poison Pokemon? Students don't need to be Pokemon fans to enjoy this course. This course will not only strengthen students’ coding skills, but also their keyboard and mouse skills.
Throughout the course, students will earn physical badges that demonstrate their mastery and inspire them to keep coding!<p>"))
(define (3-5-spring-2020-description name)
  (~a "Space... the final frontier. We're preparing 3rd-5th grade students at" name "for space exploration by teaching them how to code their own solar systems and galaxies! In our Spring program, students will learn how to build 3D galaxies that include orbiting planets and stars, which they can customize and texture. Students will build our actual solar system, and imagine other solar systems not yet discovered. Beginner coders will enjoy learning how a few lines of code can create a whole digital world at their fingertips;
advanced students will take their knowledge to infinite and beyond! In this session, students will continue to earn badges as they become more and more fluent in coding.<p>"))

(define k2-spring-2020-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/DSC_0922_370_200.jpg")
(define 3-5-spring-2020-screenshot
  "https://s3-us-west-1.amazonaws.com/ts-email-assets-and-stuff/DSC_0495_370_200.jpg")

(define (k2-spring-2020-bundle school)
  (list "Coding Club: Pokemon Clicker Games: K-2nd (Spring)"
        (k2-spring-2020-description school)
        k2-spring-2020-screenshot
        (list "K-2nd")))

(define (3-5-spring-2020-bundle school)
  (list "Coding Club: Coding That's Out of This World!: 3rd-5th (Spring)"
        (3-5-spring-2020-description school)
        3-5-spring-2020-screenshot
        (list "3rd-5th")))



; Summer Camp 2020 Bundles (ThoughtSTEM)

;K-2

(define (zoo-animals-k2-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & critical thinking skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming.  Students will enjoy learning how to code their own zoo adventure with animals like elephants, giraffes, and lions! This particular camp will focus on developing critical thinking skills, one of the many benefits of learning computer science.</p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting-edge programming languages that prepare students of all ages for the future. That means, no one else in San Diego teaches K-2 students like we do! Throughout our camps, students will also earn embroidered badges that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or their ThoughtSTEM hoodie!
<p>Your children are going to love learning coding with us this summer!</p>"))

(define (cartoons-k2-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & creativity through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. Students will enjoy learning how to code video games that they can share with friends & family after camp. Students will be able to choose from a unique array of cartoon characters, items, and scenes so that they can exercise their creativity while designing their games!</p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting-edge programming languages that prepare students of all ages for the future. That means, no one else in San Diego teaches K-2 students like we do! Throughout our camps, students will also earn embroidered badges that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Your children are going to love learning coding with us this summer!</p>"))

(define (farm-animals-k2-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & abstract reasoning skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. Students will enjoy learning how to code their own farm adventure with animals like horses, cows, and sheep!  This particular camp will focus on developing abstract reasoning skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting-edge programming languages that prepare students of all ages for the future. That means, no one else in San Diego teaches K-2 students like we do! Throughout our camps, students will also earn embroidered badges that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Your children are going to love learning coding with us this summer!</p>"))

(define (pokemon-k2-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & communication skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. Students will enjoy learning how to code games using popular Pokemon characters.  This particular camp will focus on developing communication skills, with students learning how to translate from English instructions to code, but also explain their code to instructors. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting-edge programming languages that prepare students of all ages for the future. That means, no one else in San Diego teaches K-2 students like we do! Throughout our camps, students will also earn embroidered badges that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Your children are going to love learning coding with us this summer!</p>"))

(define zoo-animals-k2-screenshot
  "https://www.thoughtstem.com/img/summer/zoo-animal.gif")
(define cartoons-k2-screenshot
  "https://www.thoughtstem.com/img/summer/clicker-cartoon.gif")
(define farm-animals-k2-screenshot
  "https://www.thoughtstem.com/img/summer/farm-animal.gif")
(define pokemon-k2-screenshot
  "https://www.thoughtstem.com/img/summer/clicker-pokemon.gif")

(define (zoo-animals-k2-bundle school)
  (list "Adventures in Coding and Zoo Animals (K-2nd)"
        (zoo-animals-k2-description school)
        zoo-animals-k2-screenshot
        (list "K-2nd")))

(define (cartoons-k2-bundle school)
  (list "Adventures in Coding and Cartoons (K-2nd)"
        (cartoons-k2-description school)
        cartoons-k2-screenshot
        (list "K-2nd")))

(define (farm-animals-k2-bundle school)
  (list "Adventures in Coding and Farm Animals (K-2nd)"
        (farm-animals-k2-description school)
        farm-animals-k2-screenshot
        (list "K-2nd")))

(define (pokemon-k2-bundle school)
  (list "Adventures in Coding and Pokemon (K-2nd)"
        (pokemon-k2-description school)
         pokemon-k2-screenshot
         (list "K-2nd")))
;3rd-6th

(define (harry-potter-3-6-definition name)
  (~a "<p>This summer, students will learn the fundamentals of computer science by developing their own wizard-themed video games. Using <i>Harry Potter</i> as a point of inspiration, we will teach students how to craft their own adventure game inside a unique wizarding world. Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Students are going to love coding their own wizarding world full of mystery & magic! </p>"))

(define (star-wars-3-6-definition name)
  (~a "<p>This summer, students will learn how to <i>use the force</i> of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language.All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Students are going to love creating their own <i>Star Wars</i>-themed games! </p>"))

(define (marvel-3-6-definition name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, <i>The Avengers</i>, for inspiration, students will create a battle arena video game that pits their favorite superheroes and villains against each other in an endless battle between good and evil! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Young Marvel fans will love building their own battle arena games and coding their own unique superheroes!</p>"))

(define (minecraft-3-6-definition name)
  (~a "<p>This summer, students will learn how to code a 2D version of their favorite video game - <i>Minecraft</i>! Drawing on the video game mechanics of the hit 3D game, students will code their own 2D blocky survival game with day night cycles, health bars, and enemies like Creepers to hide from at night! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Minecraft has always inspired new coders; this summer's Minecraft camp will take students' coding skills to the next level!</p>"))

(define (fortnite-3-6-defintions name)
  (~a "<p>This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game, <i>Fortnite</i>! In this camp, students will learn how to code different features of <i>Fortnite</i>, like enemies, armor, weapons, and potions, into their own unique 2D games! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Note: We understand <i>Fortnite</i> is a video game that has violent elements that might be inappropriate for young students. We at ThoughtSTEM are 100% committed to making sure students are not exposed to violent content in our camps. This is why we often modify video game content to meet students' educational needs, while still engaging them in a game they love. We believe video games like <i>Fortnite</i> provide an exceptional gateway into computer science for students, and ThoughtSTEM curriculum developers are paving the way to create new coding educational content for students inspired by the video games they love. </p>"))

(define (pokemon-3-6-definition name)
  (~a "<p>This summer, students will learn how to code a novel <i>Pokemon</i>-themed survival video game! Students will code video games in which their Pokemon is trying to survive in a world in which mean Pokemon trainers are throwing pokeballs at them trying to capture them! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>After this camp, students will go home thinking ""Gotta code 'em all!"" </p>"))

(define (mario-3-6-definition name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, <i>Mario</i> titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the <i>Mario</i> franchise, like mushrooms and power-ups, for inspiration! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 3rd-6th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>We're excited to work with students to create unique <i>Mario</i>-inspired games that they can share with friends and family! </p>"))

(define harry-potter-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/harrypotter.gif")
(define star-wars-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/starwars.gif")
(define marvel-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/avengers.gif")
(define minecraft-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/minecraft.gif")
(define fortnite-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/fortnite.gif")
(define pokemon-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/pokemon.gif")
(define mario-3-6-screenshot
  "https://www.thoughtstem.com/img/summer/mario.gif")

(define (harry-potter-3-6-bundle school)
  (list "Coding for Harry Potter Fans (3rd-6th)"
        (harry-potter-3-6-definition school)
         harry-potter-3-6-screenshot
         (list "3rd-6th")))

(define (star-wars-3-6-bundle school)
  (list "Coding for Star Wars Fans (3rd-6th)"
        (star-wars-3-6-definition school)
        star-wars-3-6-screenshot
        (list "3rd-6th")))

(define (marvel-3-6-bundle school)
  (list "Coding for Marvel Fans (3rd-6th)"
        (marvel-3-6-definition school)
        marvel-3-6-screenshot
        (list "3rd-6th")))

(define (minecraft-3-6-bundle school)
  (list "Coding for Minecraft Fans (3rd-6th)"
        (minecraft-3-6-definition school)
        minecraft-3-6-screenshot
        (list "3rd-6th")))

(define (fortnite-3-6-bundle school)
  (list "Coding for Fortnite Fans (3rd-6th)"
        (fortnite-3-6-defintions school)
        fortnite-3-6-screenshot
        (list "3rd-6th")))

(define (pokemon-3-6-bundle school)
  (list "Coding for Pokemon Fans (3rd-6th)"
        (pokemon-3-6-definition school)
         pokemon-3-6-screenshot
         (list "3rd-6th")))

(define (mario-3-6-bundle school)
  (list "Coding for Mario Fans (3rd-6th)"
        (mario-3-6-definition school)
         mario-3-6-screenshot
         (list "3rd-6th")))
;7th-10th

(define (harry-potter-7-10-definition name)
  (~a "<p>This summer, students will learn the fundamentals of computer science by developing their own wizard-themed video games. Using <i>Harry Potter</i> as a point of inspiration, we will teach students how to craft their own adventure game inside a unique wizarding world. Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 7th-10th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Students are going to love learning college-level fundamentals of computer science while creating their own wizarding world full of mystery & magic! </p>"))

(define (star-wars-7-10-definition name)
  (~a "<p>This summer, students will learn how to ""use the force"" of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 7th-10th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>We're looking forward to working with students to build their own <i>Star Wars</i>-themed games! </p>"))

(define (fortnite-7-10-definition name)
  (~a "This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game <i>Fortnite</i>! In this camp, students will learn how to code different features of <i>Fortnite</i>, like enemies, armor, weapons, and potions, into their own unique 2D games! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 7th-10th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>Although <i>Fortnite</i> itself isn't code-able, students who take this course will learn computer science skills that will enable them to develop their own <i>Fortnite</i>-like games in the future.</p>"))

(define (mario-7-10-defintion name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, <i>Mario</i> titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the <i>Mario</i> franchise, like mushrooms and power-ups, for inspiration! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 7th-10th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>We're excited to work with students to create unique Mario-inspired games that will help them build out their portfolios for college! </p>
"))

(define (marvel-7-10-definition name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, <i>The Avengers</i>, for inspiration, students will create a battle arena video game that pens their favorite superheroes against their least favorite villians in an endless battle between good and evil! Our camps also go beyond the computer screen, utilizing ""unplugged"" games and social activities to round out the summer camp experience. In addition to leveling up their coding skills, students practice communication, teamwork, problem-solving, and abstract reasoning: indispensable skills for coders -- and humans -- everywhere!</p>
<p>In each of our 7th-10th grade camps, students will learn a different programming language. All languages are created by our development team to engage young students and grow with their skills, using programming techniques not usually seen until undergraduate courses! Returning students will reinforce their skills and go beyond the beginner-level material. New students will be amazed by how much they can create with code by the end of camp. All students will earn embroidered badges throughout camp that represent their ongoing development as a coder! These can be pinned to their ThoughtSTEM lanyard or ThoughtSTEM hoodie!</p> <p>By learning college-level computer science fundamentals now, our students truly will be the superheroes of technology in the future.</p>"))

(define harry-potter-7-10-screenshot
  "https://www.thoughtstem.com/img/summer/harrypotter.gif")
(define star-wars-7-10-screenshot
  "https://www.thoughtstem.com/img/summer/starwars.gif")
(define fortnite-7-10-screenshot
  "https://www.thoughtstem.com/img/summer/fortnite.gif")
(define mario-7-10-screenshot
  "https://www.thoughtstem.com/img/summer/mario.gif")
(define marvel-7-10-screenshot
  "https://www.thoughtstem.com/img/summer/avengers.gif")

(define (harry-potter-7-10-bundle school)
  (list "Coding for Harry Potter Fans (7th-10th)"
        (harry-potter-7-10-definition school)
        harry-potter-7-10-screenshot
        (list "7th-10th")))

(define (star-wars-7-10-bundle school)
  (list "Coding for Star Wars Fans (7th-10th)"
        (star-wars-7-10-definition school)
        star-wars-7-10-screenshot
        (list "7th-10th")))

(define (fortnite-7-10-bundle school)
  (list "Coding for Fortnite Fans (7th-10th)"
        (fortnite-7-10-definition school)
        fortnite-7-10-screenshot
        (list "7th-10th")))

(define (mario-7-10-bundle school)
  (list "Coding for Mario Fans (7th-10th)"
        (mario-7-10-defintion school)
        mario-7-10-screenshot
        (list "7th-10th")))

(define (marvel-7-10-bundle school)
  (list "Coding for Marvel Fans (7th-10th)"
        (marvel-7-10-definition school)
        marvel-7-10-screenshot
        (list "7th-10th")))










 






















         


