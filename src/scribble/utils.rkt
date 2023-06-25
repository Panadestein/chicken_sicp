#lang racket

(require scribble/core
         scriblib/render-cond
         scribble/examples
         pict/tree-layout)

(provide my-eval-sicp
         my-eval-racket
         my-eval-lazy
         inject-google-tag)

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

;; Adds Google tag script to the rendered HTML output

(define (inject-google-tag id)
  (cond-element
   [latex ""]
   [html (list
          (make-element
           'script '((src . ,(string-append "https://www.googletagmanager.com/gtag/js?id=" id))
                     (async . ""))
           '())
          (make-element 'script '((type . "text/javascript"))
                        (list (string-append
                         "window.dataLayer = window.dataLayer || [];\n"
                         "function gtag(){dataLayer.push(arguments);}\n"
                         "gtag('js', new Date());\n"
                         "gtag('config', '" id "');"))))]
   [text ""]))
