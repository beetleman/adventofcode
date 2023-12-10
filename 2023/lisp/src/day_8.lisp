(defpackage beetleman.aoc-2023.day-8
  (:use :cl)
  (:import-from :ppcre)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-8)

(defstruct node l r)
(defstruct network instructions nodes)

(defun call-instruction (node instruction)
  (if (eql instruction #\L)
      (node-l node)
      (node-r node)))

(defun count-steps (network)
  (with-slots (nodes instructions) network
    (labels ((recur (current
		     instructions
		     counter)
	       (if (string= "ZZZ" current)
		   counter
		   (recur (call-instruction (gethash current nodes)
					    (first instructions))
			  (alexandria:rotate instructions -1)
			  (+ counter 1)))))
      (recur "AAA"
	     instructions
	     0))))

(defun parse (map-string)
  (let ((nodes (serapeum:dict))
	(instructions (coerce (ppcre:scan-to-strings "^[LR]+" map-string) 'list)))
    (ppcre:do-register-groups (node l-node r-node)
	("([A-Z]+) = \\(([A-Z]+), ([A-Z]+)\\)" map-string)
      (setf (gethash node nodes) (make-node :l l-node :r r-node)))
    (make-network :nodes nodes
		  :instructions instructions)))

(defun solve (network-string)
  (count-steps (parse network-string)))
