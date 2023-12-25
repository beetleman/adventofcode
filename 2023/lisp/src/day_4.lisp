(defpackage beetleman.aoc-2023.day-4
  (:use :cl)
  (:export :solve-1))
(in-package :beetleman.aoc-2023.day-4)

(defun parse-numbers-string (numbers-string)
  (loop :for m :in (ppcre:all-matches-as-strings "\\d+" numbers-string)
	:collect (parse-integer m)))

(defun score (numbers wining-numbers)
  (let ((intersection (intersection numbers wining-numbers)))
    (if intersection
	(expt 2 (1- (length intersection)))
	0)))

(defun solve-1 (cards-string)
  (let ((cards-score 0))
    (ppcre:do-register-groups (wining-numbers-string numbers-string)
	("Card +\\d+: ([\\d ]+)\\|([\\d ]+)" cards-string)
      (incf cards-score (score (parse-numbers-string wining-numbers-string)
			       (parse-numbers-string numbers-string))))
    cards-score))
