(defpackage beetleman.aoc-2023.day-8
  (:use :cl)
  (:import-from :ppcre)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:export :solve-1
	   :solve-2))
(in-package :beetleman.aoc-2023.day-8)

(defstruct node l r)
(defstruct network instructions nodes)

(defun call-instruction (node instruction)
  (if (eql instruction #\L)
      (node-l node)
      (node-r node)))

(defun count-steps (network start-node stop-re)
  (with-slots (nodes instructions) network
    (labels ((recur (current
		     instructions
		     counter)
	       (if (ppcre:scan stop-re current)
                   counter
		   (recur (call-instruction (gethash current nodes)
					    (first instructions))
			  (rest instructions)
			  (+ counter 1)))))
      (recur start-node
	     (apply #'alexandria:circular-list instructions)
	     0))))

(defun parse (map-string)
  (let ((nodes (serapeum:dict))
	(instructions (coerce (ppcre:scan-to-strings "^[LR]+" map-string) 'list)))
    (ppcre:do-register-groups (node l-node r-node)
	("([A-Z0-9]+) = \\(([A-Z0-9]+), ([A-Z0-9]+)\\)" map-string)
      (setf (gethash node nodes) (make-node :l l-node
					    :r r-node)))
    (make-network :nodes nodes
		  :instructions instructions)))

(defun solve-1 (network-string)
  (count-steps (parse network-string)
	       "AAA"
	       "ZZZ"))

(defun solve-2 (network-string)
  (let* ((network (parse network-string))
	 (nodes (network-nodes network)))
    (apply
     #'lcm
     (loop :for node :in (alexandria:hash-table-keys nodes)
	   :when (char= (char node 2)
			#\A)
	     :collect (count-steps network
				 node
				 "..Z")))))
