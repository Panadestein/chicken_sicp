;; First contact with S-expressions

(+ (* 3
      (+ (* 2 4)
	 (+ 3 5)))
   (+ (- 10 7)
      6)) ;; 57


;; Exercise 1

10 					;; 10
(+ 5 3 4) 				;; 12
(- 9 1) 				;; 8
(/ 6 2) 				;; 3
(+ (* 2 4) (- 4 6)) 			;; 6
(define a 3) 				;; In Chicken #<unspecified>
(define b (+ a 1))                      ;; In Chicken #<unspecified>
(+ a b (* a b))  			;; 19
(= a b) 				;; #f

(if (and (> b a) (< b (* a b)))
    b
    a) 					;; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) 			;; 16

(+ 2 (if (> b a) b a)) 			;; 6

(* (cond ((> a b) a)
	 ((< a b) b)
	 (else -1))
   (+ a 1)) 				;; 16


;; Exercise 2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7))) 		;; -37/150


;; Exercise 3
;; This solution is too explicit, it is better to define
;; a procedure that adds the sum of two squares

(define (sqlar a b c)
  (cond ((and (<= a b) (<= a c)) (+ (* b b) (* c c)))
	((and (<= b a) (<= b c)) (+ (* a a) (* c c)))
	(else (+ (* a a) (* b b)))))
(sqlar 1 2 3)  				;; 36


;; Exercise 4

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; Description:
;; This procedure adds or subtract the numbers a and b depending on
;; the sign of b

(a-plus-abs-b 1 2) 			;; 3


;; Exercise 5

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

;; Normal-order  -->  fully expand and then reduce
;; Applicative-order  -->  evaluate the arguments and then apply

;; In applicative-order the expression will enter an infinite loop
;; In normal-order the answer is zero
