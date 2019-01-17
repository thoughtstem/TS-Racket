#lang info

#;(define collection 'multi)

(define version "0.0.1")

(define compile-omit-paths '(
  "tests"
  "scripts"
))

(define deps '("aws" "request" "gregor" "anaphoric"
  "https://github.com/thoughtstem/racket-blocks.git?path=racket-bricks"
  "simple-qr"))
