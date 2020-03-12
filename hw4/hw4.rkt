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

(define (stream-for-n-steps s n)
  (letrec ([f (lambda (s num)
                (let ([pr (s)])
                  (if (eqv? num 1) (list (car pr))
                      (cons (car pr) (f (cdr pr) (- num 1)))
                  )))])
    (f s n))
)



(define funny-number-stream
  (letrec ([f (lambda (x)
                (if (eqv? (modulo x 5) 0)
                    (cons (* x -1) (lambda () (f (+ x 1))))
                    (cons x (lambda () (f (+ x 1))))
                    ))])
    (lambda () (f 1)))
  )


(define cat-then-dog
  (letrec ([f (lambda (x)
                (if (eqv? (modulo x 2) 0)
                    (cons "dog.jpg" (lambda () (f (+ x 1))))
                    (cons "cat.jpg" (lambda () (f (+ x 1))))
                    ))])
      (lambda () (f 1)))
  )


(define (stream-add-zero s)
  (letrec ([f (lambda (s)
                (let ([pr (s)])
                  (write (cons 0 (car pr)))
                      (cons (cons 0 (car pr)) (lambda ()(f (cdr pr))))
                  ))])
  (lambda () (f s)))
  )


(define cycle-lists null)

(define vector-assoc null)

(define cached-assoc null)


