#lang racket

(require scribble/examples)
(provide my-eval
         my-eval-racket
         my-eval-lazy)

(define my-eval
  (make-base-eval
   #:pretty-print? #t
   #:lang 'sicp))

(define my-eval-racket
  (make-base-eval
   #:pretty-print? #t
   #:lang 'racket))

(define my-eval-lazy
  (make-base-eval
   #:pretty-print? #t
   #:lang 'lazy))
