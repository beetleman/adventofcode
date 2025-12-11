;;; day-9.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defparameter theater-floor-map
  "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3")

(defun rectangle-area (point-a point-b)
  (* (1+ (abs (- (fset:@ point-a :x) (fset:@ point-b :x))))
     (1+ (abs (- (fset:@ point-a :y) (fset:@ point-b :y))))))

(defun day-9-1 (theater-floor-map)
  (i:iter outher
    (i:with tiles = (t:transduce (t:map (op (str:match _
                                              ((a "," b) (fset:map (:x (parse-integer a))
                                                                   (:y (parse-integer b)))))))
                                 #'t:cons
                                 (str:lines theater-floor-map)))
    (i:for tile-a in tiles)
    (i:iter (i:for tile-b in tiles)
      (i:in outher (i:maximize (rectangle-area tile-a tile-b))))))

(test:define-test+run day-9-1-example-test
  (test:is = 50
           (day-9-1 theater-floor-map)))

(test:define-test+run day-9-1-example-test
  (let ((theater-floor-map (uiop:read-file-string "./inputs/day-9.txt")))
    (test:is = 4777409595
             (day-9-1 theater-floor-map))))

(defun day-9-2 (theater-floor-map)
  )

(test:define-test+run day-9-2-example-test
  (test:is = 0
           (day-9-2 theater-floor-map)))

(test:define-test+run day-9-2-test
  (let ((theater-floor-map (uiop:read-file-string "./inputs/day-9.txt")))
    (test:is = 0
             (day-9-2 theater-floor-map))))
