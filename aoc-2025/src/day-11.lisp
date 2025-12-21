;;; day-11.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defparameter devices-outputs
  "aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out")

(defun day-11-1 (devices-outputs)
  (labels ((parse (devices-outputs-string)
             (t:transduce (t:comp (t:map (op (str:match _
                                               ((device ": " outputs-string)
                                                (cons device (str:split-omit-nulls " " outputs-string)))))))
                          #'t:hash-table
                          (str:lines devices-outputs-string)))
           (run (start data)
             (if (string= start "out")
                 1
                 (or
                  (i:iter (i:for i in (@ data start))
                    (i:sum (run i data)))
                  0))))
    (run "you" (parse devices-outputs))))

(test:define-test+run day-11-1-example-test
    (test:is = 5
             (day-11-1 devices-outputs)))

(test:define-test+run day-11-1-example-test
    (let ((devices-outputs (uiop:read-file-string "./inputs/day-11.txt")))
      (test:is = 448
               (day-11-1 devices-outputs))))

(defun day-11-2 (devices-outputs)
  0)

(test:define-test+run day-11-2-example-test
    (test:is = 0
             (day-11-2 devices-outputs)))

(test:define-test+run day-11-2-test
    (let ((devices-outputs (uiop:read-file-string "./inputs/day-11.txt")))
      (test:is = 0
               (day-11-2 devices-outputs))))

