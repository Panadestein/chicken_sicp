#lang racket

(require scribble/examples)
(provide my-eval
         my-eval-lazy)

(define my-eval
  (make-base-eval #:lang 'sicp))

(define my-eval-lazy
  (make-base-eval #:lang 'lazy))
