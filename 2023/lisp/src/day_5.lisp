(defpackage beetleman.aoc-2023.day-5
  (:use :cl)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-5)

(defun parse-integer-list (string)
  (mapcar #'parse-integer (ppcre:all-matches-as-strings "\\d+" string)))

(defun seeds (almanac-string)
  (ppcre:register-groups-bind (numbers)
      ("seeds: ([\\d ]+)\\n" almanac-string)
    (parse-integer-list numbers)))

(defun ranges (ranges-string)
  (loop :for (destination source range)
	  :in (serapeum:batches (parse-integer-list ranges-string) 3)
	:collect (serapeum:dict :source source
				:destination destination
				:range range)))

(defun steps (almanac-string)
  (let ((steps (serapeum:dict)))
    (ppcre:do-register-groups (source destination ranges-string)
	("([a-z]+)-to-([a-z]+) map:\\n([\\d \\n]+)" almanac-string)
      (setf (gethash source steps)
	    (serapeum:dict :source source
                           :destination destination
			   :ranges (ranges ranges-string))))
    steps))

(defun coordinate (number step)
  (or (loop :for ranges :in (gethash :ranges step)
	    :for source = (gethash :source ranges)
	    :for destination = (gethash :destination ranges)
	    :for range = (gethash :range ranges)
	    :when (< (1- source) number (+ source range))
	      :return (+ destination
			 (- number source)))
      number))

(defun proces-steps (start stop steps value)
  (labels ((recur (source value)
	     (let ((step (gethash source steps)))
	       (if (string= stop (gethash :destination step))
                   (coordinate value step)
		   (recur (gethash :destination step)
			  (coordinate value step))))))
    (recur start value)))

(defun solve (almanac-string)
  (let ((seeds (seeds almanac-string))
	(steps (steps almanac-string)))
    (reduce #'min
	    (mapcar (serapeum:partial #'proces-steps "seed" "location" steps)
		    seeds))))
