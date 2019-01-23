#lang at-exp racket

(provide (all-defined-out))

(define albert-einstein 3)
(define ashley-falls 7185)
(define bird-rock 10617)
(define csu-san-marcos 10528)
(define carmel-del-mar 7184)
(define chabad 10544)
(define country-montessori 10486)
(define deer-canyon 7379)
(define del-mar-hills 7183)
(define del-mar-heights 10503)
(define east-lake 7159)
(define fleet 10484)
(define fleet-spring 10515)
(define grant 7512)
(define hearst 7517)
(define hickman 7582)
(define jerabek 7593)
(define jcc 10507)
(define JCS 10597)
(define kumeyaay 7600)
(define liberal-arts 10595)
(define language-academy 10508)
(define la-jolla 7526)
(define la-jolla-country-day 10537)
(define marshall 7165)
(define mira-costa 10576)
(define notre-dame 10502)
(define ocean-air 7181)
(define old-town 7435)
(define painted-rock 10488)
(define sage-canyon 7186)
(define sdsu 10572)
(define spreckels 10517)
(define sycamore-ridge 10531)
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

(define k-2nd-spring-selling-points
  (list
   "Learn how to use MIT's Scratch programming interface"
   "Create video games using their own superhero art"
   "Gain proficiency with computers, mice, and keyboards and will become confident with technology!"))


(define 3rd-5th-winter-selling-points
  (list
   "Students will code & design their own 2D survival games with game features similar to favorites like Minecraft and Fortnite"
   "Students will learn how to code game features like health, day-night cycles, and crafting mechanics"
   "Students can share their game with friends and family!"))

(define 3rd-5th-spring-selling-points
  (list
   "Code & design their own 2D battle arena games with features from games like Pokemon and Final Fantasy"
   "Learn how to code character attacks, defenses, magic, and a turn-based rule system"
   "Be able to share their game with friends and family!"))

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
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (camp-b-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & algebraic logic through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing skills in mathematics, specifically algebra. This is a great introduction for young students, who have likely never been exposed to algebraic logic before.</p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (camp-c-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & abstract reasoning skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing abstract reasoning skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (camp-d-description name)
  (~a "<p>It’s never too early for children to start learning the language of computers! This course is designed with our youngest future coders and engineers in mind.</p>
<p>In this camp, we'll explore coding & pattern recognition skills through a newly developed programming language that combines the ease of visual programming with the benefits of typed programming. This particular camp will focus on developing pattern recognition skills, one of the many benefits of learning computer science. </p>
<p>ThoughtSTEM has been funded by the National Science Foundation to build cutting edge programming languages that prepare students of all ages for the future. The curriculum we've developed for this camp is intended for K-2nd students of all skill levels. We're proud to be providing the most innovative coding educational opportunities for San Diego students.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))

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
  (list "Simple, visual Racket programming language: K-2nd"
        (camp-c-description school)
        ""
        (list "K-2nd")))
(define (k2-camp-d-bundle school)
  (list "Simple, visual Racket programming language: K-2nd"
        (camp-d-description school)
        ""
        (list "K-2nd")))











;3-6
(define (harry-potter-36-description name)
  (~a "<p>This summer, students will learn the fundamentals of computer science by developing their own wizard-themed video games. Using <i>Harry Potter</i> as a point of inspiration, we will teach students how to craft their own adventure game inside a unique wizarding world. In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Students are going to love coding their own wizarding world full of mystery & magic! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (star-wars-36-description name)
  (~a "<p>This summer, students will learn how to use the force of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Students are going to love creating their own <i>Star Wars</i>-themed games! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (lord-rings-36-description name)
  (~a "<p>This summer, students will learn how to create their own fantasy world of elves, dwarves, dragons, and hobbits! Using the famous Lord of the Rings trilogy for inspiration, students will create an adventure-style video game in which the main character sets off on an epic quest with a story they craft themselves! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We think LOTR fans of all ages will love building their own fantasy video games by recreating elements from the original trilogy.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (marvel-36-description name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, The Avengers, for inspiration, students will create a battle arena video game that pens their favorite superheroes against their least favorite villians in an endless battle between good and evil! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We think our young Marvel fans will love building their own battle arena games and coding their own unique superheroes with their own special powers.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (minecraft-36-description name)
  (~a "<p>This summer, students will learn how to code a 2D version of their favorite video game - Minecraft! Drawing on the video game mechanics of the hit 3D game, students will code their own 2D blocky survival game with day night cycles, health bars, and enemies like Creepers to hide from at night! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Minecraft has always been a great way for our students to learn how to code, but we think this summer's Minecraft camp will take students' coding skills to the next level! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (fortnite-36-description name)
  (~a "<p>This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game Fortnite! In this camp, students will learn how to code different features of Fortnite, like enemies, armor, weapons, and potions, into their own unique 2D games! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>Note: We understand Fortnite is a video game that has violent elements that might be inappropriate for young students. We at ThoughtSTEM are 100% committed to making sure students are not exposed to violent content in our camps. This is why we often modify video game content to meet students' educational needs, while still engaging them in a game they love. We believe video games like Fortnite provide an exceptional gateway into computer science for students, and ThoughtSTEM curriculum developers are paving the way to create new coding educational content for students inspired by the video games they love. </p>
<p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (pokemon-36-description name)
  (~a "<p>This summer, students will learn how to code a novel Pokemon-themed survival video game! First, students will learn how to create their own Pokemon-like characters with walking animations. Then students will code video games where their pokemon is trying to survive in a world in which mean Pokemon trainers are throwing pokeballs at them all the time to try to capture them! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fiction video game with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>After this camp, students will go home thinking Gotta code em all! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (mario-36-description name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, Mario titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the Mario-franchise, like mushrooms and power-ups, for inspiration! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 3rd-6th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages with educational scaffolding appropriate for a 3rd-6th grade level. </p>
<p>We're excited to work with students to create unique Mario-inspired games that they can share with friends and family! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))


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
<p>Students are going to love learning college-level fundamentals of computer science while creating their own wizarding world full of mystery & magic! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (star-wars-710-description name)
  (~a "<p>This summer, students will learn how to use the force of coding to create their own epic space-themed video games. Drawing our inspiration from the <i>Star Wars</i> universe, students will explore their favorite characters, powers, and dramatic moments, and from there, begin to incorporate their own characters and game dynamics into a battle arena video game of their own creation! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>We're looking forward to working with students to build their own <i>Star Wars</i>-themed games! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (fortnite-710-description name)
  (~a "<p>This summer, students will learn how to build a 2D video game with all the exciting elements of the popular 3D video game <i>Fortnite</i>! In this camp, students will learn how to code different features of <i>Fortnite</i>, like enemies, armor, weapons, and potions, into their own unique 2D games! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>Although <i>Fortnite</i> itself isn't code-able, students who take this course will learn computer science skills that will enable them to develop their own <i>Fortnite</i>-like games in the future.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (mario-710-description name)
  (~a "<p>This summer, students will learn how to create their own Mario-themed adventure games! Since its release in 1985, Mario titles have been a huge hit with gamers of all ages. In this camp, students will learn how to code an adventure video game that draws on elements of the Mario-franchise, like mushrooms and power-ups, for inspiration! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>We're excited to work with students to create unique Mario-inspired games that will help them build out their portfolios for college! </p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))
(define (marvel-710-description name)
  (~a "<p>This summer, students will learn how to code their own video games that explore a Marvel-like universe! Using the popular movie series, The Avengers, for inspiration, students will create a battle arena video game that pens their favorite superheroes against their least favorite villians in an endless battle between good and evil! In addition to learning how to code, students will also be guided in the ways of digital citizenship and how to appropriately and safely share their fan-fictional work with the world. </p>
<p>In each of our 7th-10th camps, students will learn a typed programming language called Racket, which is a language used to build other programming languages. Although Racket is normally taught in college undergraduate courses, ThoughtSTEM has been funded by the National Science Foundation to build new Racket video game programming languages that prepare students for collegiate-level computer science coursework. </p>
<p>By learning college-level computer science fundamentals now, our students truly will be the superheroes of technology in the future.</p> <p><b>Note: This camp includes lunch in the dining hall</b></p>"))

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















         


