#lang racket



(provide (all-defined-out))

(require "./util.rkt" )
  
(define (student id)
  (show "student" id))

(define (password->student pw)
  (show "student" pw))

(define/contract (first-name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'first_name #f))

(define/contract (last-name h)
  (-> hash? (or/c string? boolean?))
  (hash-ref h 'last_name #f))

(define/contract (code-snippets h)
  (-> hash? list?)
  (map (curryr set-type "code_snippet")
       (hash-ref h 'code_snippets #f)))


(define (code-snippet key id)
  (show "code_snippet" (~a "no-password-needed::" key "::" id)))


(define/contract (value h)
  (-> hash? string?)
  (hash-ref h 'value #f))


(define (new-code-snippet key snippet-string student-pw snippet-nickname)
  (hash 'the-type "code_snippet"
        'key key
        'value snippet-string
        'nickname snippet-nickname
        'id (~a student-pw "::" snippet-nickname "::" key)))


(define (store-snippet-f student-pw snippet-nickname key snippet-string)
  (save
   (new-code-snippet key snippet-string student-pw snippet-nickname)))


(define-syntax-rule (enable-snippets nick pw)
  (begin
    (set-env! PROD)
    (define-namespace-anchor a)
    (define nick (list
                  (namespace-anchor->namespace a)
                  'pw
                  'nick))))


(define-syntax (get-snippet stx)
  (syntax-case stx ()
    ((_ nick key)
     #`(let ([code-string
              (value (code-snippet (~a (third nick))
                                   (~a 'key)))])
         
         
         (eval (read (open-input-string code-string))
               (first nick))))))

(define-syntax (store-snippet stx)
  (syntax-case stx ()
    ((_ nick key snippet)
     #`(let ([code-string (~s 'snippet)])
         (store-snippet-f (~a (second nick)) ;OMG refactor this list bs..
                          (~a (third nick))
                          (~a 'key)
                          code-string)))))







