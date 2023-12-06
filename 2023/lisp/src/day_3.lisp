(defpackage beetleman.aoc-2023.day-3
  (:use :cl)
  (:export :solve
	   :solve-serapeum))
(in-package :beetleman.aoc-2023.day-3)

(defun engine-schematic-width (engine-schematic)
  (ppcre:scan "\\n" engine-schematic))

(defun engine-symbol-p (engine-schematic idx)
  (if (or (< idx 0)
	  (<= (length engine-schematic) idx))
    nil
    (let ((ch (char engine-schematic idx)))
      (not (or (digit-char-p ch)
               (eql ch #\.))))))

(defun symbol-attached-p (width engine-schematic start end)
  (flet ((the-engine-symbol-p (idx) (engine-symbol-p engine-schematic idx)))
    (or (the-engine-symbol-p (1- start)) ;; symbol before number
	(the-engine-symbol-p end) ;; symbol after number
	;; line before number
	(loop for idx from (- start width 2) to (- end width 1)
	      when (the-engine-symbol-p idx)
		return T)
	(loop for idx from (+ start width) to (+ end width 1)
	      when (the-engine-symbol-p idx)
		return T))))

(defun solve (engine-schematic)
  (let ((width (engine-schematic-width engine-schematic))
	(counter 0))
    (ppcre:do-matches (start end "\\d+" engine-schematic)
      (when (symbol-attached-p width engine-schematic start end)
	(setf counter (+ counter
			 (parse-integer (subseq engine-schematic start end))))))
    counter))

(defun solve-serapeum (engine-schematic)
  (let ((width (engine-schematic-width engine-schematic))
	(matches (serapeum:batches (ppcre:all-matches "\\d+" engine-schematic) 2)))
    (loop for (start end) in matches
	  when (symbol-attached-p width engine-schematic start end)
	    sum (parse-integer (subseq engine-schematic start end)))))
