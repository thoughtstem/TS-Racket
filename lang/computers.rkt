#lang racket

(provide computer
         ;computer-ready?
         )

(require "./util.rkt" json gregor simple-http pkg/lib setup/getinfo)




(define (computer id)
  (show "computer" id))


(define (updated-at c)
  (define s (hash-ref c 'software_version))
  (parameterize ([current-timezone "UTC"])
    (parse-moment s "y-MM-dd HH:mm:ss")))


;Useful... but runs into github's rate limits.
;  If we really need this, we'll need to use authenticated requests, which means managing a github API token.
;For now, I'm just going to say that computer is up to date if 
(define (most-recent-commit-time org/repo)
  (define token-path (build-path (find-system-path 'home-dir) ".github-api-token"))

  (when (not (file-exists? token-path))
    (raise "Put a valid github api token in ~/.github-api-token"))

  (define github-api-token
    (file->string token-path))

  (define github-com
    (update-headers
      (update-ssl
        (update-host json-requester "api.github.com" ) #t)
      (list (~a "Authorization: token " github-api-token))))

  (define response (get github-com (~a "/repos/" org/repo "/commits")))

  (iso8601->moment
    (hash-ref
      (hash-ref
        (hash-ref (first (json-response-body response)) 'commit)
        'author)
      'date)))

(define (remove-query-params url)
  (second (regexp-match #px"github.com/(.*)\\.git.*" url)))

#|(define (repos-to-watch)
  (remove-duplicates 
    (map remove-query-params (filter 
                               (curryr string-contains? "thoughtstem")
                             (extract-pkg-dependencies (get-info '("kata-installer")))))))

(define (time-of-last-repo-change)
  (first 
    (sort 
      (map most-recent-commit-time (repos-to-watch))
      moment>?)))

(define (computer-ready? id)
   (define cb-update (updated-at (computer id)))
   (define repo-update (time-of-last-repo-change))
   (moment>? cb-update repo-update))
|#





