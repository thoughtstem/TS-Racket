#lang at-exp racket

(provide (all-defined-out))

(define albert-einstein 3)
(define ocean-air 7181)
(define ashley-falls 7185)
(define sage-canyon 7186)
(define sycamore-ridge 10531)
(define torrey-hills 7187)
(define carmel-del-mar 7184)
(define del-mar-hills 7183)
(define kumeyaay 7600)
(define liberal-arts 10595)
(define jerabek 7593)
(define JCS 10597)
(define deer-canyon 7379)
(define language-academy 10508)
(define thoughtstem 10558)
(define spreckels 10517)
(define torah-high 10616)
(define bird-rock 10617)
(define ucsd-extension 1)
(define hearst 7517)

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
  (~a "<p>This Spring, " name " 3rd-5th students will design & code their very own 2D battle arena video games. What's a battle arena game? Think <i>Pokemon</i> or <i>Final Fantasy</i>! Students will learn how to code their characters' attacks and defenses, create battle animations, and program a turn-based rule system with a user interface. At the end of this course, students will be able to share their survival games with friends and family. <i>Note: Students are welcome to join us in the Spring without having taken the Fall and ani programs.</i></p>
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
  (~a "<p>This Spring, Spreckels K-2nd students will learn how to create their own video games with code! Students will learn how to use MIT's Scratch programming interface to create video games featuring important video game design aspects, like game rules, character movement, and scoreboards. Students will continue to gain proficiency in critical technology skills, including typing, use of a mouse, and use of an internet browser. At the end of the course, students will be able to share their superhero-themed games with family and friends! <i>Note: Students are welcome to join us in the Spring without having taken the Fall and Winter programs.</i></p>
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


(define k-2nd-del-mar-selling-points
  (list
   "Students will learn how to build their own video games using MIT's Scratch language"
   "Students will program small robots using another powerful visual programming language"
   "Students will gain proficiency with computers, mice, and keyboards"))


