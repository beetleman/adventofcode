;;; day-10.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defparameter machines-manual
  "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}")

(defun day-10-1 (machines-manual)
  (labels ((parse-state (state-string)
             (let ((state (make-array (length state-string) :element-type 'bit)))
               (i:iter (i:for idx index-of-string state-string)
                 (setf (bit state idx)
                       (if (eq #\# (aref state-string idx))
                           1
                           0)))
               state))
           (parse-button (button-string size)
             (let ((state-mask (make-array size :element-type 'bit)))
               (i:iter (i:for i in (ppcre:all-matches-as-strings "[0-9]+" button-string))
                 (setf (bit state-mask (parse-number i)) 1))
               (lambda (state)
                 (bit-xor state state-mask))))
           (parse-machines-manual (machines-manual-string)
             (t:transduce (t:map (op (str:match _
                                       (("\\[" state "\\] " buttons " {" joltage "}" )
                                        (dict :state (parse-state state)
                                              :final-state (make-array (length state) :element-type 'bit)
                                              :buttons (i:iter (i:for b in (str:split-omit-nulls " " buttons))
                                                         (i:collect
                                                             (parse-button b (length state))))
                                              :joltage joltage)))))
                          #'t:cons
                          (str:lines machines-manual-string)))
           (solved-in (machine size)
             (first (with-collector (val)
                      (block nil
                        (map-combinations (lambda (fs)
                                            (when (vector= (@ machine :final-state)
                                                           (reduce (lambda (state f)
                                                                     (funcall f state))
                                                                   fs
                                                                   :initial-value (@ machine :state)))
                                              (return (val size))))
                                          (@ machine :buttons)
                                          :length size))))))
    (i:iter outer
      (i:for machine in (parse-machines-manual machines-manual))
      (i:sum (i:iter (i:for size from 1 to (~> machine (@ :buttons) length))
               (i:thereis (solved-in machine size)))))))

(test:define-test+run day-10-1-example-test
    (test:is = 7
             (day-10-1 machines-manual)))

(test:define-test+run day-10-1-example-test
    (let ((machines-manual (uiop:read-file-string "./inputs/day-10.txt")))
      (test:is = 542
               (day-10-1 machines-manual))))

(defun day-10-2 (machines-manual)
  0)

(test:define-test+run day-10-2-example-test
    (test:is = 0
             (day-10-2 machines-manual)))

(test:define-test+run day-10-2-test
    (let ((machines-manual (uiop:read-file-string "./inputs/day-10.txt")))
      (test:is = 0
               (day-10-2 machines-manual))))
