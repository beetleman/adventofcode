(defpackage beetleman.aoc-2023.day-6
  (:use :cl)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-6)

(defun parse-integer-list (string)
  (mapcar #'parse-integer (ppcre:all-matches-as-strings "\\d+" string)))

(defun posible-p (button-pressed time distance)
  (< distance (* button-pressed (- time button-pressed))))

(defun button-pressed-posibilities (max-time distance)
  (loop :for x :from 1 :below max-time
	:when (posible-p x max-time distance)
	  :collect x))

(defstruct record
  time
  distance)

(defun records (records-string)
  (loop :for time :in (parse-integer-list (ppcre:scan-to-strings "Time: .+" records-string))
	:for distance :in (parse-integer-list (ppcre:scan-to-strings "Distance: .+" records-string))
	:collect (make-record :time time :distance distance)))

(defun solve (records-string)
  (reduce #'*
	  (loop :for record :in (records records-string)
		:collect (length (button-pressed-posibilities (record-time record)
							      (record-distance record))))))
