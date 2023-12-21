(defpackage beetleman.aoc-2023.day-2
  (:use :cl)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-2)

(defun split-lines (s)
  (ppcre:split "\\n" s))

(defun make-keyword (string)
  (alexandria:make-keyword (string-upcase string)))

(defun game-id (game-string)
  (multiple-value-bind (_ value) (ppcre:scan-to-strings "Game (\\d+):" game-string)
    (declare (ignore _))
    (parse-integer (elt value 0))))

(defun game-scores (game-string)
  (loop :for p :in (ppcre:split ";" game-string)
	:collect
	(let ((vals '()))
	  (ppcre:do-register-groups
	      (number color)
	      ("(\\d+) (red|blue|green)" p)
	    (setf (getf vals (make-keyword color)) (parse-integer number)))
	  vals)))

(defun not-possible-score-p (score all-cubes key)
  (< (getf all-cubes key) (getf score key 0)))

(defun ok-p (scores all-cubes)
  (not (some (lambda (score)
	       (or (not-possible-score-p score all-cubes :red)
		   (not-possible-score-p score all-cubes :blue)
		   (not-possible-score-p score all-cubes :green)))
	     scores)))

(defun solve (records all-cubes)
  (loop :for game-string :in (split-lines records)
	:for scores = (game-scores game-string)
	:when (ok-p scores all-cubes)
	  :sum (game-id game-string)))
