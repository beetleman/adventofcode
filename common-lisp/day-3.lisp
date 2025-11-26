(defpackage #:adventofcode-2024/day-3
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:import-from :cl-ppcre))
(in-package #:adventofcode-2024/day-3)

(defun part-1 (file-name)
  (let ((memory-string (uiop:read-file-string file-name)))
    (let ((result 0))
      (ppcre:do-register-groups ((#'parse-integer a) (#'parse-integer b))
          ("mul\\((\\d+),(\\d+)\\)" memory-string)
        (setq result (+ result (* a b))))
      result)))

(defun part-2 (file-name)
  (let ((memory-string (uiop:read-file-string file-name)))
    (let ((result 0)
          (enabled t))
      (ppcre:do-register-groups (op _ (#'parse-integer a) (#'parse-integer b))
          ("(do|don't|mul)(\\(\\)|\\((\\d+),(\\d+)\\))" memory-string)
        (declare (ignore _))
        (cond
          ((string= op "do")
           (setq enabled t))

          ((string= op "don't")
           (setq enabled nil))

          (enabled
           (setq result (+ result (* a b))))))
      result)))

(util:print-results 3
                    (part-1 "./resources/input-day-3.1.txt")
                    (part-2 "./resources/input-day-3.1.txt"))
