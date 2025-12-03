;;; day-3.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun day-3-1-xform (battery-limit)
  (labels ((into-number (x)
             (loop :for i :in x
                   :for n :from 0
                   :sum (* i (expt 10 n))))
           (joltage (bank)
             (loop :with stack = '()
                   :with n = (length bank)
                   :for digit :in bank
                   :for i :from 0
                   :do (loop :while (and stack
                                         (< (car stack) digit)
                                         (> (+ (length stack) (- n i)) battery-limit))
                             :do (setf stack (cdr stack)))
                   :when (< (length stack) battery-limit)
                     :do (push digit stack)
                   :finally (return (into-number stack)))))
    (t:comp (t:map (lambda (bank-line)
                     (mapcar #'parse-integer
                             (str:split "" bank-line :omit-nulls t))))
            (t:map #'joltage))))

(test:define-test+run day-3-1-example-test
  (let ((banks-lines (str:lines "987654321111111
811111111111119
234234234234278
818181911112111")))
    (test:is = 357
             (t:transduce (day-3-1-xform 2)
                          #'+
                          banks-lines))))

(test:define-test+run day-3-1-test
  (test:is = 17613
           (t:transduce (day-3-1-xform 2)
                        #'+
                        #p "./inputs/day-3.txt")))

(test:define-test+run day-3-2-example-test
  (let ((banks-lines (str:lines "987654321111111
811111111111119
234234234234278
818181911112111")))
    (test:is = 3121910778619
             (t:transduce (day-3-1-xform 12)
                          #'+
                          banks-lines))))


(test:define-test+run day-3-2-test
  (test:is = 175304218462560
           (t:transduce (day-3-1-xform 12)
                        #'+
                        #p "./inputs/day-3.txt")))
