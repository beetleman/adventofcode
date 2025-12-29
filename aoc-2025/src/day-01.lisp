;;; day-1.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun entrance-safe-document-xform ()
  (t:map (lambda (x)
           (str:match x
             (("R" x) (parse-integer x))
             (("L" x) (- (parse-integer x)))))))

(defun entrance-safe-positions-xform ()
  (let ((pos 50)
        (max 99))
    (t:map (lambda (x)
             (setf pos (let ((new-pos (rem (+ pos x) (1+ max))))
                         (if (<= 0 new-pos)
                             new-pos
                             (+ max new-pos 1))))
             pos))))

(defun day-1-1-xform ()
  (t:comp (entrance-safe-document-xform)
          (entrance-safe-positions-xform)
          (t:filter #'zerop)))

(test:define-test+run day-1-1-example-test
  (let ((lines "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"))
    (test:is = 3
             (t:transduce (day-1-1-xform)
                          #'t:count
                          (str:lines lines)))))

(test:define-test+run day-1-1-test
  (test:is = 1147
           (t:transduce (day-1-1-xform)
                        #'t:count
                        #p "./inputs/day-1.txt")))

(defun day-1-2-xform ()
  (t:comp (entrance-safe-document-xform)
          (t:map (lambda (x)
                   (repeat-sequence (list (if (negative-integer-p x)
                                              -1
                                              1))
                                    (abs x))))
          #'t:concatenate
          (entrance-safe-positions-xform)
          (t:filter #'zerop)))

(test:define-test+run day-1-2-example-test
  (let ((lines "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"))
    (test:is = 6
             (t:transduce (day-1-2-xform)
                          #'t:count
                          (str:lines lines)))))

(test:define-test+run day-1-2-test
  (test:is = 6789
           (t:transduce (day-1-2-xform)
                        #'t:count
                        #p "./inputs/day-1.txt")))
