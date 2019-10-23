#lang info

#;(define collection 'multi)

(define version "0.0.1")

(define compile-omit-paths '(
  "tests"
  "scripts"
  "examples"
))

(define deps '("aws" "request" "gregor" "anaphoric"
  "simple-qr"
  "simple-http"
  ;"https://github.com/thoughtstem/kata-installer.git"
  ))
