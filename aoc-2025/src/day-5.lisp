;;; day-5.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun day-5-1 (inventory-string)
  (loop :with ranges = '()
        :with fresh = '()
        :for i :in (str:lines inventory-string :omit-nulls t)
        :do (str:match i
              ((a "-" b) (push (cons (parse-integer a)
                                     (parse-integer b))
                               ranges))
              ((id) (let ((id (parse-integer id)))
                      (when (some (op (destructuring-bind (a . b) _
                                        (<= a id b)))
                                  ranges)
                        (push id fresh)))))
        :finally (return (length fresh))))

(test:define-test+run day-5-1-example-test
  (let ((inventory-string "3-5
10-14
16-20
12-18

1
5
8
11
17
32
"))
    (test:is = 3
             (day-5-1 inventory-string))))

(test:define-test+run day-5-1-example-test
  (let ((inventory-string (uiop:read-file-string "./inputs/day-5.txt")))
    (test:is = 701
             (day-5-1 inventory-string))))

(defun day-5-2 (inventory-string)
  (loop :with ranges = '()
        :for i :in (str:lines inventory-string :omit-nulls t)
        :do (str:match i
              ((a "-" b) (push (cons (parse-integer a)
                                     (parse-integer b))
                               ranges)))
        :finally (return (loop :with compacted-ranges = '()
                               :with sorted = (sort ranges #'< :key #'car)
                               :with curr-range = (car sorted)
                               :for range :in (cdr sorted)
                               :if (and (<= (car range) (cdr curr-range)))
                                 :do (setf (cdr curr-range) (max (cdr range)
                                                                 (cdr curr-range)))
                               :else
                                 :do (push curr-range compacted-ranges)
                                     (setf curr-range range)
                               :finally (return (t:transduce (t:map (op (destructuring-bind (a . b) _
                                                                          (- b a -1))))
                                                             #'+
                                                             (push curr-range compacted-ranges)))))))

(test:define-test+run day-5-2-example-test
  (let ((inventory-string "3-5
10-14
16-20
12-18

1
5
8
11
17
32
"))
    (test:is = 14
             (day-5-2 inventory-string))))

(test:define-test+run day-5-2-test
  (let ((inventory-string (uiop:read-file-string "./inputs/day-5.txt")))
    (test:is = 352340558684863
             (day-5-2 inventory-string))))
