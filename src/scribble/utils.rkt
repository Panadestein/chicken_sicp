#lang racket

(require scribble/examples
         pict
         pict/tree-layout)

(provide my-eval-sicp
         my-eval-racket
         my-eval-lazy)

;; Evaluators to be used in Scribble examples

(define my-eval-sicp
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
