(defpackage beetleman.aoc-2023.day-7
  (:use :cl)
  (:import-from :ppcre)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:export :solve-1
           :solve-2))
(in-package :beetleman.aoc-2023.day-7)

(defvar score-high-card 1)
(defvar score-one-pair 2)
(defvar score-two-pair 3)
(defvar score-three-of-kind 4)
(defvar score-full-house 5)
(defvar score-four-of-kind 6)
(defvar score-five-of-kind 7)

(defun hand-score (hand)
  (let ((hand-structure (serapeum:sort-new
			 (mapcar #'length
				 (serapeum:assort (coerce hand 'list)))
			 #'<)))
    (alexandria:switch (hand-structure :test #'equalp)
      (#(1 1 1 1 1) score-high-card)
      (#(1 1 1 2) score-one-pair)
      (#(1 2 2) score-two-pair)
      (#(1 1 3) score-three-of-kind)
      (#(2 3) score-full-house)
      (#(1 4) score-four-of-kind)
      (#(5) score-five-of-kind)
      ;; 1 jokers
      (#(1 1 1 1) score-one-pair)
      (#(1 1 2) score-three-of-kind)
      (#(2 2) score-full-house)
      (#(1 3) score-four-of-kind)
      (#(4) score-five-of-kind)
      ;; 2 jokers
      (#(1 1 1) score-three-of-kind)
      (#(1 2) score-four-of-kind)
      (#(3) score-five-of-kind)
      ;; 3 jokers
      (#(1 1) score-four-of-kind)
      (#(2) score-five-of-kind)
      ;; 4 jokers
      (#(1) score-five-of-kind)
      ;; 5 jokers
      (#() score-five-of-kind))))

(defvar cards-values-part-1
  (loop :with values = (serapeum:dict)
	:for card :across "23456789TJQKA"
	:for score :from 1
	:do (setf (gethash card values) score)
	:finally (return values)))

(defvar cards-values-part-2
  (loop :with values = (serapeum:dict)
	:for card :across "J23456789TQKA"
	:for score :from 1
	:do (setf (gethash card values) score)
	:finally (return values)))

(defun hand< (hand-1 hand-2 card-values)
  (when (not (string= hand-1 hand-2))
    (loop :for card-1 :across hand-1
	  :for card-2 :across hand-2
	  :when (< (gethash card-1 card-values)
		   (gethash card-2 card-values))
	    :do (return T)
	  :until (> (gethash card-1 card-values)
		    (gethash  card-2 card-values)))))

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

(defun sort-camel-cards (camel-cards card-values hand-score)
  (sort camel-cards
	(lambda (a b)
	  (let ((score-a (funcall hand-score (camel-cards-hand a)))
		(score-b (funcall hand-score (camel-cards-hand b))))
	    (if (= score-a score-b)
		(hand< (camel-cards-hand a)
		       (camel-cards-hand b)
		       card-values)
		(< score-a score-b))))))

(defun solve* (camel-cards-string cards-values hand-score)
  (loop :for camel-cards :in (sort-camel-cards (parse camel-cards-string)
					       cards-values
					       hand-score)
	:for i :from 1
	:sum (* i (camel-cards-bid camel-cards))))

(defun solve-1 (camel-cards-string)
  (solve* camel-cards-string cards-values-part-1 #'hand-score))

(defun solve-2 (camel-cards-string)
  (solve* camel-cards-string cards-values-part-2
	  (lambda (hand)
	    (hand-score (ppcre:regex-replace-all "J" hand "")))))
