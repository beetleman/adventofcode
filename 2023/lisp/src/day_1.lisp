(defpackage beetleman.aoc-2023.day-1
  (:use :cl)
  (:export :solve-1))
(in-package :beetleman.aoc-2023.day-1)

(defparameter re-numbers (ppcre:create-scanner "\\d"))

(defun solve-1 (calibration-document)
  (reduce '+
	  (loop for line in (ppcre:split "\\n" calibration-document)
		collect (let ((numbers (ppcre:all-matches-as-strings re-numbers line)))
			  (if numbers
			      (parse-integer (format nil
						     "~a~a"
						     (first numbers)
						     (car (last numbers))))
			      0)))))
