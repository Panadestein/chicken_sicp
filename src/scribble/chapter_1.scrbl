#lang scribble/manual

@(require scribble/examples
          scribble-math/dollar)
@(require (for-label racket))
@(require "utils.rkt")

@(define-syntax-rule (sample a . text)
   (codeblock #:context #'a #:keep-lang-line? #f
              "#lang scribble/base" "\n" a . text))

@(use-mathjax)

@title[#:version "" #:tag "chapter-1" #:style 'quiet]{Building Abstractions with Procedures}

@section[#:style 'unnumbered  #:tag "preamble"]{Preamble}

First contact with S-expressions

@examples[#:eval my-eval-sicp
          #:label #f
          #:no-inset
          (+ (* 3
                (+ (* 2 4)
                   (+ 3 5)))
             (+ (- 10 7)
                6))
          ]

@section[#:style 'unnumbered #:tag "e1.1"]{Exercise 1.1}

@examples[#:eval my-eval-sicp
          #:label "Solution:"
          #:no-inset
          10
          (+ 5 3 4)
          (- 9 1)
          (/ 6 2)
          (+ (* 2 4) (- 4 6))
          (define a 3)
          (define b (+ a 1))
          (+ a b (* a b))
          (= a b)

          (if (and (> b a) (< b (* a b)))
              b
              a)

          (cond ((= a 4) 6)
                ((= b 4) (+ 6 7 a))
                (else 25))

          (+ 2 (if (> b a) b a))

          (* (cond ((> a b) a)
                   ((< a b) b)
                   (else -1))
             (+ a 1))
          ]

@section[#:style 'unnumbered #:tag "e1.2"]{Exercise 1.2}

@examples[#:eval my-eval-sicp
          #:label "Solution:"
          #:no-inset
          (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
             (* 3 (- 6 2) (- 2 7)))
          ]

@section[#:style 'unnumbered #:tag "e1.3"]{Exercise 1.3}

This solution is too explicit, it is better to define a procedure that adds the sum of two squares.

@examples[#:eval my-eval-sicp
          #:label "Solution:"
          #:no-inset
          (define (sqlar a b c)
            (cond ((and (<= a b) (<= a c)) (+ (* b b) (* c c)))
                  ((and (<= b a) (<= b c)) (+ (* a a) (* c c)))
                  (else (+ (* a a) (* b b)))))
          (sqlar 1 2 3)
          ]

@section[#:style 'unnumbered #:tag "e1.4"]{Exercise 1.4}

This procedure adds or subtract the numbers a and b depending on the sign of b:

@examples[#:eval my-eval-sicp
          #:label "Solution:"
          #:no-inset
          (define (a-plus-abs-b a b)
            ((if (> b 0) + -) a b))
          (a-plus-abs-b 1 2)
          ]

@section[#:style 'unnumbered #:tag "e1.5"]{Exercise 1.5}

@itemlist[
 @item{Normal-order: fully expand and then reduce}
 @item{Applicative-order: evaluate the arguments and then apply}
 ]

In applicative-order the expression will enter an infinite loop. In normal-order the answer is zero:

@examples[#:eval my-eval-lazy
          #:label "Code:"
          #:no-inset
          (define (p) (p))
          (define (test x y)
            (if (= x 0) 0 y))
          (test 0 (p))
          ]

Of course, I have used @bold{lazy evaluation} in the above code, which can be achieved
in @racketmodname[scribble/base] as follows:

@sample|{
@examples[#:eval my-eval-lazy
#:label "Code:"
#:no-inset]
}|

with:

@racketblock[
 (define my-eval-lazy
   (make-base-eval #:lang 'lazy))
 ]

@section[#:style 'unnumbered #:tag "e1.6"]{Exercise 1.6}

The @tt{sqrt} procedure can be tested with and without the @tt{new-if} procedure here:

@examples[#:eval my-eval-sicp
          #:label "Answer:"
          #:no-inset
          (define (new-if predicate then-clause else-clause)
            (cond (predicate then-clause)
                  (else else-clause)))

          (define (sqrt-iter guess x)
            (if (quality-of-guess? guess x)
                guess
                (sqrt-iter (improve-guess guess x) x)))

          (define (square x)
            (* x x))

          (define (abs x)
            (cond ((< x 0) (- x))
                  (else x)))

          (define (quality-of-guess? guess x)
            (< (abs (- (square guess) x)) 0.001))

          (define (average x y)
            (/ (+ x y) 2))

          (define (improve-guess guess x)
            (average guess (/ x guess)))

          (define (sqrt x)
            (sqrt-iter 1.0 x))

          (sqrt 0.000001)
          ]

If we toggle the @tt{new-if} procedure instead of the @racket[if] special form the applicative
order of Scheme will bite us and we will enter and infinite loop,
in particular due to the third parameter.

@section[#:style 'unnumbered #:tag "e1.7"]{Exercise 1.7}

The usual limitations of floating point arithmetic apply here. Squaring big numbers can
result in overflow, adding very small and large numbers lead to loss of precision.
For large number the separation between two consecutive numbers is bigger.
In addition, the initial absolute tolerance of 0.001 will be obviously insufficient
to deal with numbers smaller than it. 

@examples[#:eval my-eval-sicp
          #:label "Answer:"
          #:no-inset
          (define (quality-of-guess? guess x)
            (< (abs (- guess
                       (improve-guess guess x)))
               (* (abs guess) 0.01)))
          ]

@section[#:style 'unnumbered #:tag "e1.8"]{Exercise 1.8}

Implementing the cube root formula.

@examples[#:eval my-eval-sicp
          #:label "Answer:"
          #:no-inset
          (define (cubic-iter guess x)
            (if (quality-of-guess? guess x)
                guess
                (cubic-iter (improve-cubic-guess guess x) x)))

          (define (improve-cubic-guess guess x)
            (/ (+ (/ x (* guess guess))
                  (* guess 2))
               3))

          (define (quality-of-guess? guess x)
            (< (abs (- guess
                       (improve-cubic-guess guess x)))
               (* (abs guess) 0.001)))

          (define (cubert x)
            (cubic-iter 1.0 x))

          (cubert 100)
          ]

@section[#:style 'unnumbered #:tag "e1.9"]{Exercise 1.9}

The first of the processes generated by the following procedures is recursive,
the second one is iterative. Both procedures are recursive, though.

@racketblock[
 (define (+ a b)
   (if (= a 0)
       b
       (inc (+ (dec a) b))))
 (define (+ a b)
   (if (= a 0)
       b
       (+ (dec a) (inc b))))
 ]

We can apply the substitution model to verify this claim:

@racketblock[
 (+ 4 5)
 (inc (+ 3 5))
 (inc (inc (+ 2 5)))
 (inc (inc (inc (+ 1 5))))
 (inc (inc (inc (inc (+ 0 5)))))
 (inc (inc (inc (inc 5))))
 (inc (inc (inc 6)))
 (inc (inc 7))
 (inc 8)
 9]

@racketblock[
 (+ 4 5)
 (+ 3 6)
 (+ 2 7)
 (+ 1 8)
 (+ 0 9)
 9]

@section[#:style 'unnumbered #:tag "e1.10"]{Exercise 1.10}

@examples[#:eval my-eval-sicp
          #:label "Answer:"
          #:no-inset
          (define (A x y)
            (cond ((= y 0) 0)
                  ((= x 0) (* 2 y))
                  ((= y 1) 2)
                  (else (A (- x 1) (A x (- y 1))))))
          (A 1 10)
          (A 2 4)
          (A 3 3)
          ]

Here is the process generated by the first call:

@racketblock[
 (A 1 10)
 (A 0 (A 1 9))
 (A 0 (A 0 (A 1 8)))
 (A 0 (A 0 (A 0 (A 1 7))))
 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))
 (A 0 (A 0 (A 0 (A 0 64))))
 (A 0 (A 0 (A 0 128)))
 (A 0 (A 0 256))
 (A 0 512)
 1024
 ]

Mathematical definitions:

@racketblock[
 (define (f n) (A 0 n))
 ]
@($ "2n")

@racketblock[
 (define (g n) (A 1 n))
 ]
@($ "2^n")

@racketblock[
 (define (h n) (A 2 n))
 ]
This is a nice @(hyperlink "https://en.wikipedia.org/wiki/Tetration" "tetration")
@($ "^n2 = 2^{2^{2^{.^{.^{.}}}}}")

@section[#:style 'unnumbered #:tag "com1"]{First memento}

In Section @(hyperlink "https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e2" "1.2.2")
we can read:

@margin-note{
             In general, the number of steps required by a tree-recursive process will be proportional
             to the number of nodes in the tree, while the space required will
             be proportional to the maximum depth of the tree.}

I find the above to be a non-trivial statement. It is true, because in applicative order there
will be successive expansions on one branch followed by the corresponding contractions, instead
of the full expansion that we would have in normal order. There is a good discussion about it in
@(hyperlink
  "https://stackoverflow.com/questions/27345652/tree-recursive-fibonacci-algorithm-requires-linear-space"
  "SO").

@section[#:style 'unnumbered #:tag "e1.11"]{Exercise 1.11}

@($$ "f(n) =
\\begin{cases}
   n & n < 3 \\\\
   f(n-1) + 2f(n-2) + 3f(n-3) & n \\geq 3
\\end{cases}")

I am assuming the following functions will be evaluated on natural numbers, for integers
you need to add a check to catch negative values.

@examples[#:eval my-eval-racket
          #:label "Recursive:"
          #:no-inset
          (define (f n)
            (cond ((< n 3) n)
                  (else (+ (f (- n 1))
                           (* (f (- n 2)) 2)
                           (* (f (- n 3)) 3)))))
          (map f '(0 1 2 5))                                      
          ]

@examples[#:eval my-eval-racket
          #:label "Iterative:"
          #:no-inset
          (define (f n)
            (fiter 2 1 0 n))
          (define (fiter a b c count)
            (cond ((= count 0) c)
                  (else (fiter (+ a (* 2 b) (* 3 c))
                               a
                               b
                               (- count 1)))))
          (map f '(0 1 2 5))
          ]

@section[#:style 'unnumbered #:tag "e1.12"]{Exercise 1.12}

@examples[#:eval my-eval-racket
          #:label "Solution:"
          #:no-inset
          (define (pascal n m)
            (cond ((or (< n m) (< m 0)) #f)
                  ((or (= m 0) (= m (- n 1))) 1)
                  (else
                   (+ (pascal (- n 1) m)
                      (pascal (- n 1) (- m 1))))))
          ]

The above function is zero-based, so the n@(superscript "th") argument corresponds to
the n - 1 power of the binomial. For example:

@examples[#:eval my-eval-racket
          #:label #f
          #:no-inset
          (map (lambda (row elem) (pascal row elem))
               (make-list 5 5)
               (build-list 5 values))
          ]

Of course, the previous test was neither fancy nor extensive. We can do better,
although we are not supposed to use the following tools at the current stage
of the book:

@examples[#:eval my-eval-racket
          #:label #f
          #:no-inset
          (define (print-pascal n row)
            (string-append (make-string (- n row) #\space)
                           (string-join (map (lambda (col)
                                               (~a (pascal row col)))
                                             (build-list row values)))
                           "\n"))
          
          (display
           (string-join
            (map (lambda (row) (print-pascal 5 row))
                 (build-list 5 (lambda (idx) (+ idx 1))))
            ""))
          ]

On a side note, it would be more efficient to build the triangle's elements using
Pascal's rule:

@($$ "\\binom{n}{k} = \\binom{n-1}{k-1} + \\binom{n-1}{k}")

@section[#:style 'unnumbered #:tag "e1.13"]{Exercise 1.13}

We will prove by induction that the n@(superscript "th") Fibonacci number is given by:

@($$ "\\text{Fib}(n) = \\frac{\\phi^n-\\psi^n}{\\sqrt{5}}")

with @($ "\\phi = \\frac{1+\\sqrt{5}}{2}") and @($ "\\psi = \\frac{1-\\sqrt{5}}{2}").

@bold{Proof}:

@itemlist{
          @item{Base case:}
          }

@($$ "\\text{Fib}(0) = \\frac{\\phi^0-\\psi^0}{\\sqrt{5}} = 0")
@($$ "\\text{Fib}(1) = \\frac{\\frac{2\\sqrt{5}}{2}}{\\sqrt{5}} = 1")

@itemlist{
          @item{Induction step:}
          }

@($$ "
\\begin{align}
  \\text{Fib}(n+1) &= \\text{Fib}(n) + \\text{Fib}(n-1) \\\\
                   &= \\frac{\\phi^n-\\psi^n + \\phi^{n-1}-\\psi^{n-1}}{\\sqrt{5}} \\\\
                   &= \\frac{\\phi^{n+1}\\frac{(\\phi+1)}{\\phi^2}
                            -\\psi^{n+1}\\frac{(\\psi+1)}{\\psi^2}}{\\sqrt{5}} \\\\
                   &= \\frac{\\phi^{n+1}-\\psi^{n+1}}{\\sqrt{5}} \\quad \\blacksquare.
\\end{align}
")

In the proof, we have exploited the fact that both @($ "\\phi") and @($ "\\psi") are solutions of the
quadratic Golden Ratio's equation. This concludes the first part of the problem. In the second one,
we want to prove that:

@($$ "\\text{nint}(\\frac{\\phi^n}{\\sqrt{5}}) = \\text{Fib}(n)")

@(bold "Proof"):

Suppose the nearest integer is @($ "m"), then:

@($$ "|\\frac{\\phi^n}{\\sqrt{5}}-m|\\leq \\frac{1}{2}")

or:

@($$ "
\\begin{align}
|\\text{Fib}(n)-m+\\frac{\\psi^n}{\\sqrt{5}}|&\\leq \\frac{1}{2} \\\\
-\\frac{1}{2}- \\frac{\\psi^n}{\\sqrt{5}}\\leq \\text{Fib}(n)-m &\\leq
 \\frac{1}{2}-\\frac{\\psi^n}{\\sqrt{5}}
\\end{align}
")








