(defpackage beetleman.aoc-2023.day-1
  (:use :cl)
  (:export :solve-1
	   :solve-2))
(in-package :beetleman.aoc-2023.day-1)

(defparameter re-numbers (ppcre:create-scanner "(\\d)"))
(defparameter re-numbers-en
  (ppcre:create-scanner "(?=(zero|one|two|three|four|five|six|seven|eight|nine|\\d))"))

(defparameter number-to-digit-mapping
  (alexandria:alist-hash-table
   (mapcar (lambda (n)
	     (cons (format nil "~r" n) n))
	   (alexandria:iota 10))
   :test #'equal))

(defun find-numbers (regex string transform)
  (let ((numbers '()))
    (ppcre:do-register-groups (n) (regex string)
      (push (funcall transform n) numbers))
    (reverse numbers)))

(defun solve* (calibration-document regex transform)
  (loop :for line :in (ppcre:split "\\n" calibration-document)
	:for numbers = (find-numbers regex line transform)
	:when numbers
	  :summing (parse-integer (format nil
					  "~a~a"
					  (first numbers)
					  (car (last numbers))))))

(defun solve-1 (calibration-document)
  (solve* calibration-document re-numbers #'identity))

(defun solve-2 (calibration-document)
  (solve* calibration-document
	  re-numbers-en
	  (lambda (n)
	    (or (gethash n number-to-digit-mapping)
		n))))
