#lang racket

(require ts-racket)

(set-env! PROD)

(cards->pages (badges (course 1201)))