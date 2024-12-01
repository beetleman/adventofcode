(defpackage #:adventofcode-2024/util
  (:use :cl)
  (:import-from :cl-ppcre)
  (:import-from :alexandria))
(in-package #:adventofcode-2024/util)

(defun split-lines (s)
  (ppcre:split "\\n" s))

(defun make-keyword (string)
  (alexandria:make-keyword (string-upcase string)))

(defun parse-numbers-string (numbers-string)
  (loop :for m :in (ppcre:all-matches-as-strings "\\d+" numbers-string)
        :collect (parse-integer m)))
