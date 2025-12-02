;;; day-2.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun day-2-xform (number-scanner)
  (t:comp
   (t:map #'str:trim)
   (t:map (lambda (s)
            (str:match s
              ((a "-" b) (list (parse-integer a)
                               (parse-integer b))))))
   (t:map (lambda (x)
            (destructuring-bind (a b) x
              (range a (1+ b)))))
   #'t:concatenate
   (t:filter (lambda (n)
               (ppcre:scan number-scanner (write-to-string n))))))

(defun day-2-1-xform ()
  (day-2-xform (ppcre:create-scanner "^(\\w{1,})\\1$")))


(test:define-test+run day-2-1-example-test
  (let ((gift-db-sequence "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124"))
    (test:is = 1227775554
             (t:transduce
              (day-2-1-xform)
              #'+
              (str:split "," gift-db-sequence)))))

(test:define-test+run day-2-1-test
  (let ((gift-db-sequence (uiop:read-file-string #p "./inputs/day-2.txt")))
    (test:is = 32976912643
             (t:transduce
              (day-2-1-xform)
              #'+
              (str:split "," gift-db-sequence)))))

(defun day-2-2-xform ()
  (day-2-xform (ppcre:create-scanner "^(\\w{1,})\\1+$")))

(test:define-test+run day-2-2-example-test
  (let ((gift-db-sequence "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124"))
    (test:is = 4174379265
             (t:transduce
              (day-2-2-xform)
              #'+
              (str:split "," gift-db-sequence)))))

(test:define-test+run day-2-2-test
  (let ((gift-db-sequence (uiop:read-file-string #p "./inputs/day-2.txt")))
    (test:is = 54446379122
             (t:transduce
              (day-2-2-xform)
              #'+
              (str:split "," gift-db-sequence)))))
