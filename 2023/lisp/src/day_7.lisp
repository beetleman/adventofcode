(defpackage beetleman.aoc-2023.day-7
  (:use :cl)
  (:import-from :ppcre)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:export :solve))
(in-package :beetleman.aoc-2023.day-7)

(defun hand-score (hand)
  (let ((hand-structure (serapeum:sort-new
			 (mapcar #'length
				 (serapeum:assort (coerce hand 'list)))
			 #'<)))
    (alexandria:switch (hand-structure :test #'equalp)
      (#(1 1 1 1 1) 1)
      (#(1 1 1 2) 2)
      (#(1 2 2) 3)
      (#(1 1 3) 4)
      (#(2 3) 5)
      (#(1 4) 6)
      (#(5) 7))))

(defvar cards-values
  (loop :with values = (serapeum:dict)
	:for card :across "23456789TJQKA"
	:for score :from 1
	:do (setf (gethash card values) score)
	:finally (return values)))

(defun card-value (card)
  (gethash card cards-values))

(defun hand< (hand-1 hand-2)
  (when (not (string= hand-1 hand-2))
    (loop :for card-1 :across hand-1
	  :for card-2 :across hand-2
	  :when (< (card-value card-1) (card-value card-2))
	    :do (return T)
	  :until (> (card-value card-1) (card-value card-2)))))

(defstruct camel-cards hand bid)

(defun parse (camel-cards-string)
  (let ((camel-cards '()))
    (ppcre:do-register-groups (hand bid-string)
	("(\\w{5}) (\\d+)" camel-cards-string)
      (push (make-camel-cards :hand hand
			      :bid (if bid-string
				       (parse-integer bid-string)
				       0))
	    camel-cards))
    camel-cards))

(defun sort-camel-cards (camel-cards)
  (sort camel-cards
	(lambda (a b)
	  (let ((score-a (hand-score (camel-cards-hand a)))
		(score-b (hand-score (camel-cards-hand b))))
	    (if (= score-a score-b)
		(hand< (camel-cards-hand a)
		       (camel-cards-hand b))
		(< score-a score-b))))))

(defun solve (camel-cards-string)
  (loop :for camel-cards :in (sort-camel-cards (parse camel-cards-string))
	:for i :from 1
	:sum (* i (camel-cards-bid camel-cards))))
