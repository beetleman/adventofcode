;;; day-7.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defparameter  tachyon-manifold-diagram-string
  ".......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............")

(defun day-7-1 (tachyon-manifold-diagram-string)
  (labels ((splitterp (ch)
             (eql ch #\^)))
    (loop :with beams = (list (position #\S tachyon-manifold-diagram-string))
          :with split = 0
          :for line :in (cdr (str:lines tachyon-manifold-diagram-string))
          :do (loop :with next-beams = '()
                    :with splits = '()
                    :for beam :in beams
                    :if (~> line (aref beam) splitterp)
                      :do (setf splits (adjoin (1+ beam) splits :test #'=)
                                splits (adjoin (1- beam) splits :test #'=)
                                split (1+ split))
                    :else
                      :do (push beam next-beams)
                    :finally
                       (setf beams (union splits next-beams)))
          :finally (return split))))

(test:define-test+run day-7-1-example-test
  (test:is = 21
           (day-7-1 tachyon-manifold-diagram-string)))

(test:define-test+run day-7-1-example-test
  (let ((tachyon-manifold-diagram-string (uiop:read-file-string "./inputs/day-7.txt")))
    (test:is = 1635
             (day-7-1 tachyon-manifold-diagram-string))))

(defun day-7-2 (tachyon-manifold-diagram-string)
  ;; store position and all how possible ways to get in this position in complex number
  ;; where `#C(position number-of-path-to-this-position)'
  (labels ((splitterp (ch)
             (eql ch #\^))
           (compact-beam (beams)
             (reduce (lambda (acc n)
                       (+ acc (complex 0 (imagpart n))))
                     beams)))
    (loop :with beams = (list (complex (position #\S tachyon-manifold-diagram-string) 1))
          :for line :in (cdr (str:lines tachyon-manifold-diagram-string))
          :do (loop :with next-beams = '()
                    :for beam :in beams
                    :if (~> line (aref (realpart beam)) splitterp)
                      :do (push (1- beam) next-beams)
                          (push (1+ beam) next-beams)
                    :else
                      :do (push beam next-beams)
                    :finally
                       (setf beams
                             (mapcar #'compact-beam
                                     (assort next-beams :key #'realpart :test #'=))))
          :finally (return (reduce #'+ beams :key #'imagpart)))))

(test:define-test+run day-7-2-example-test
  (test:is = 40
           (day-7-2 tachyon-manifold-diagram-string)))

(test:define-test+run day-7-2-test
  (let ((tachyon-manifold-diagram-string (uiop:read-file-string "./inputs/day-7.txt")))
    (test:is = 58097428661390
             (day-7-2 tachyon-manifold-diagram-string))))
