(defpackage #:adventofcode-2024/day-4
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:import-from :cl-ppcre))
(in-package #:adventofcode-2024/day-4)

(defun crossword (words)
  (let* ((l (util:words->char-list words)))
    (append words
            (util:char-list->words (util:transpose l))
            (util:char-list->words (util:diagonal l))
            (util:char-list->words (util:adiagonal l)))))

(defun part-1 (file-name)
  (loop :for l :in (crossword (uiop:read-file-lines file-name))
        :sum (+ (length (ppcre:all-matches-as-strings "XMAS" l))
                (length (ppcre:all-matches-as-strings "SAMX" l)))))

(defun part-2 (file-name)
  (let* ((l (util:words->char-list (uiop:read-file-lines file-name)))
         (max-x (length l))
         (max-y (length (nth 0 l)))
         (result 0))
    (flet ((element (x y)
             (nth y (nth x l)))
           (masp (l)
             (or (equal l '(#\M #\A #\S))
                 (equal l '(#\S #\A #\M)))))
      (loop :for x :from 1 :below (- max-x 1) :do
        (loop :for y :from 1 :below (- max-y 1)
              :for line-1 = (list (element (- x 1) (- y 1))
                                  (element x y)
                                  (element (+ x 1) (+ y 1)))
              :for line-2 = (list (element (- x 1) (+ y 1))
                                  (element x y)
                                  (element (+ x 1) (- y 1)))
              :do
                 (when (and (masp line-1)
                            (masp line-2))
                   (incf result))))
      result)))

(util:print-results 4
                    (part-1 "./resources/input-day-4.1.txt")
                    (part-2 "./resources/input-day-4.1.txt"))
