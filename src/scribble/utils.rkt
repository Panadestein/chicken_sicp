#lang racket

(require scribble/core
         scribble/examples
         scribble/html-properties
         scriblib/render-cond
         pict/tree-layout)

(provide my-eval-sicp
         my-eval-racket
         my-eval-lazy
         inject-javascript-inline
         inject-javascript-src)

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

;; Google analytics helper functions

(define (inject-javascript-inline . body)
  (cond-element
   [latex ""]
   [html (make-element (make-style #f (list (make-script-property "text/javascript"
                                                                  body)))
                       '())]
   [text ""]))


(define (inject-javascript-src src)
  (cond-element
   [latex ""]
   [html
    (make-element
     (make-style #f
                 (list
                  (make-alt-tag "script")
                  (make-attributes
                   `((type . "text/javascript")
                     (src  . ,src)))))
     '())]

   [text ""]))
