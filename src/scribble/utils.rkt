#lang racket

(require scribble/examples
         pict
         pict/tree-layout)

(provide my-eval-sicp
         my-eval-racket
         my-eval-lazy
         tree-drawer)

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

;; Generate bracktrace graphs

(define (make-node sexp-atom)
  (cc-superimpose
   (disk 25 #:color "white")
   (text (if (symbol? sexp-atom)
             (symbol->string sexp-atom)
             (number->string sexp-atom)))))

(define (make-tree make-atom-node sexp)
  (cond ((null? sexp) #f) 
        ((list? sexp)
         (match sexp
           ((cons func arguments)
            (apply tree-layout
                   #:pict (make-atom-node func)
                   (map (curry make-tree make-atom-node) arguments)))
           (_ #f)))
        (else
         (tree-layout #:pict (make-atom-node sexp)))))

(define (tree-drawer sexp)
  (make-tree make-node sexp))
