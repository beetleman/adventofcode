(defpackage #:adventofcode-2024/day-1
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria)
  (:import-from :serapeum))
(in-package #:adventofcode-2024/day-1)

(defun parse (file-name)
  (loop :for l :in (uiop:read-file-lines file-name)
        :for parsed = (util:parse-numbers-string l)
        :collect (first parsed) :into list-1
        :collect (second parsed) :into list-2
        :finally (return
                   (list list-1 list-2))))

(defun part-1 (file-name)
  (destructuring-bind (list-1 list-2) (parse file-name)
    (loop :for x :in (sort list-1 #'<)
          :for y :in (sort list-2 #'<)
          :sum (abs (- x y)))))

(defun part-2 (file-name)
  (destructuring-bind (list-1 list-2) (parse file-name)
    (loop :for x :in list-1
          :sum (* x (count-if #'(lambda (y) (eql x y))
                              list-2)))))

(util:print-results 1
                    (part-1 "./resources/input-day-1.1.txt")
                    (part-2 "./resources/input-day-1.1.txt"))
