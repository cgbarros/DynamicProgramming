;; fibonacci using a recursive definition
(define (fib-rec n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fib-rec (- n 1)) (fib-rec (- n 2))))))

;; fibonacci using dinnamic programming
(define (fib-dp n) 
  (define (aux back1 back2 i)
      (if (= i n)
        back2
        (aux (+ back1 back2) back1 (+ i 1))))
  (if (= n 0)
    0
  (aux 1 0 0)))

;; pascal triangle using a recursive deffinition
(define (pasc-rec n k)
  (if (or (= k 0) (= n k)) 
      1
      (+ (pasc-rec (- n 1) (- k 1))
         (pasc-rec (- n 1) k))))

;; pascal triangle using dinnamic programming (in lisp lingo: using tail-recursion)
(define (pasc-list n k)
  (define (aux previous_row current_row i j)
    (cond 
      ((= i n) (+ (list-ref previous_row k)
                  (list-ref previous_row (- k 1))))
      ((= i j) (aux (append current_row '(1)) '(1) (+ i 1) 1))
      (else (aux previous_row 
                 (append current_row 
                         (list (+ (list-ref previous_row j)
                            (list-ref previous_row (- j 1)))))
                 i
                 (+ j 1)))))
  (if (or (= k 0) (= n k))
      1
      (aux '(1 1) '(1 2) 2 2)))

;; my optimizaiton on top of it
(define (pasc-better n k)
  (define (aux prev-row cur-row i j)
    (cond
      ((= i n) (cond ((> (* k 2) n) (+ (list-ref prev-row (- n k))
                                       (list-ref prev-row (- (- n k) 1))))
                     ((= (* k 2) n) (* (list-ref prev-row (- k 1)) 2))
                     (else (+ (list-ref prev-row k) (list-ref prev-row (- k 1))))))
      ((> (* j 2) i) (aux cur-row '(1) (+ i 1) 1))
      ((= (* j 2) i) (aux (append cur-row (list (* 2 (list-ref prev-row (- j 1)))))
                          '(1)
                          (+ i 1)
                          1))
      (else (aux prev-row 
                 (append cur-row (list (+ (list-ref prev-row j)
                                          (list-ref prev-row (- j 1)))))
                 i
                 (+ j 1)))))
  (cond ((or (= k 0) (= n k)) 1)
        ((or (= k 1) (= n (+ k 1))) n)
        (else (aux '(1 3) '(1) 4 1))))