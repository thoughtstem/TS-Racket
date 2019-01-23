#lang info

#;(define collection 'multi)

(define version "0.0.1")

(define compile-omit-paths '(
  "tests"
  "scripts"
))

(define deps '("aws" "request" "gregor" "anaphoric"
  "simple-qr"))
