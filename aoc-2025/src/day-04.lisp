;;; day-4.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun get-from-map (map pos)
  (destructuring-bind (x . y) pos
    (~>> map
         (nth x)
         (nth y))))

(defun parse-map (map-string)
  (loop :for line :in (str:lines map-string)
        :collect (loop :for ch :across line
                       :collect ch)))

(defun all-neighbors (pos max-x max-y)
  (let ((neighbors '()))
    (destructuring-bind (x . y) pos
      (when (< 0 x)
        (when (< 0 y)
          (push (cons (1- x)
                      (1- y))
                neighbors))
        (push (cons (1- x)
                    y)
              neighbors)
        (when (< y max-y)
          (push (cons (1- x)
                      (1+ y))
                neighbors)))

      (when (< 0 y)
        (push (cons x
                    (1- y))
              neighbors))
      (when (< y max-y)
        (push (cons x
                    (1+ y))
              neighbors))

      (when (< x max-x)
        (when (< 0 y)
          (push (cons (1+ x)
                      (1- y))
                neighbors))
        (push (cons (1+ x)
                    y)
              neighbors)
        (when (< y max-y)
          (push (cons (1+ x)
                      (1+ y))
                neighbors))))
    neighbors))

(defun day-4-1 (map-string)
  (let* ((map (parse-map map-string))
         (max-x (~> map length 1-))
         (max-y (~>> map (nth 0) length 1-)))
    (loop :for x :from 0 :to max-x
          :sum (loop :for y :from 0 :to max-y
                     :when (and (eq #\@ (get-from-map map (cons x y)))
                                (< (t:transduce (t:filter (op (eq #\@ (get-from-map map _))))
                                                #'t:count
                                                (all-neighbors (cons x y) max-x max-y))
                                   4))
                       :sum 1))))

(defun day-4-2 (map-string)
  (let* ((map (parse-map map-string))
         (max-x (~> map length 1-))
         (max-y (~>> map (nth 0) length 1-))
         (deleted (dict)))
    (loop
      :for rolls = (loop :for x :from 0 :to max-x
                         :sum (loop :for y :from 0 :to max-y
                                    :for pos = (cons x y)
                                    :when (and (not (@ deleted pos))
                                               (eq #\@ (get-from-map map pos))
                                               (< (t:transduce (t:comp (t:filter (op (not (@ deleted _))))
                                                                       (t:filter (op (eq #\@ (get-from-map map _)))))
                                                               #'t:count
                                                               (all-neighbors pos max-x max-y))
                                                  4))
                                      :sum (progn
                                             (setf (@ deleted (cons x y)) t)
                                             1)))
      :until (zerop rolls)
      :sum rolls)))

(test:define-test+run day-4-1-example-test
    (let* ((map-string "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."))
      (test:is = 13
               (day-4-1 map-string))))

(test:define-test+run day-4-1-test
    (let* ((map-string (uiop:read-file-string #p "./inputs/day-4.txt")))
      (test:is = 1464
               (day-4-1 map-string))))

(test:define-test+run day-4-1-example-test
    (let* ((map-string "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."))
      (test:is = 43
               (day-4-2 map-string))))

(test:define-test+run day-4-1-example-test
    (let* ((map-string (uiop:read-file-string #p "./inputs/day-4.txt")))
      (test:is = 8409
               (day-4-2 map-string))))
