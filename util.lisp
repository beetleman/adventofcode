(defpackage #:adventofcode-2024/util
  (:nicknames #:util)
  (:use :cl)
  (:import-from :cl-ppcre)
  (:import-from :alexandria)
  (:export
   :split-lines
   :make-keyword
   :parse-numbers-string
   :print-results))
(in-package #:adventofcode-2024/util)

(defun split-lines (s)
  (ppcre:split "\\n" s))

(defun make-keyword (string)
  (alexandria:make-keyword (string-upcase string)))

(defun parse-numbers-string (numbers-string)
  (loop :for m :in (ppcre:all-matches-as-strings "\\d+" numbers-string)
        :collect (parse-integer m)))

(defun print-results* (day part-1 part-2)
  (let ((sep "    "))
    (format t "Day-~a~%~apart-1: ~a~%~apart-2: ~a~%" day sep part-1 sep part-2)))

(defmacro print-results (day part-1 part-2)
  `(time (print-results* ,day ,part-1 ,part-2)))
