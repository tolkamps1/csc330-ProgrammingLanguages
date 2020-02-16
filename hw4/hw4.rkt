#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; these definitions are simply for the purpose of being able to run the tests
;; you MUST replace them with your solutions
;;

(define (sequence low high stride)
  (cond [(<= low high)
         (cons low (sequence (+ low stride) high stride))]
        [#t '()]))


(define (string-append-map xs suffix)
  (map (lambda (str)
         (string-append str suffix)) xs))



(define (list-nth-mod xs n)
  (cond [(null? xs) (error "list-nth-mod: empty list")]
        [(< n 0) (error "list-nth-mod: negative number")]
        [#t (car (list-tail xs (remainder n (- (length xs) 1))))]
        )
  )

(define stream-for-n-steps null)

(define funny-number-stream null)

(define cat-then-dog null)

(define stream-add-zero null)


(define cycle-lists null)

(define vector-assoc null)

(define cached-assoc null)


