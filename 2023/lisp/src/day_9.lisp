(defpackage beetleman.aoc-2023.day-9
  (:use :cl)
  (:import-from :ppcre)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-9)

(defun deltas (sensor-data)
  (cdr (serapeum:deltas sensor-data)))

(defun predict-reading (sensor-data)
  (labels ((recur (results sensor-data)
	     (let ((deltas (deltas sensor-data)))
	       (if (or (every #'zerop deltas)
		       (not sensor-data))
		   (reduce #'+ results)
		   (recur (cons (alexandria:lastcar deltas) results)
			  deltas)))))
    (+ (recur '() sensor-data)
       (alexandria:lastcar sensor-data))))

(defun parse (sensors-data-string)
  (loop :for line :in (ppcre:split "\\n" sensors-data-string)
	:collect (mapcar #'parse-integer
			 (ppcre:all-matches-as-strings "[-]?\\d+" line))))

(defun solve (sensors-data-string)
  (loop :for sensor-data :in (parse sensors-data-string)
	:sum (predict-reading sensor-data)))
