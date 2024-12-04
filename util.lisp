(defpackage #:adventofcode-2024/util
  (:nicknames #:util)
  (:use :cl)
  (:import-from :cl-ppcre)
  (:import-from :alexandria)
  (:export
   :split-lines
   :make-keyword
   :parse-numbers-string
   :print-results
   :transpose
   :diagonal
   :adiagonal
   :words->char-list
   :char-list->words))
(in-package #:adventofcode-2024/util)

(defun split-lines (s)
  (ppcre:split "\\n" s))

(defun make-keyword (string)
  (alexandria:make-keyword (string-upcase string)))

(defun parse-numbers-string (numbers-string)
  (loop :for m :in (ppcre:all-matches-as-strings "\\d+" numbers-string)
        :collect (parse-integer m)))

(defun print-results* (day part-1 part-2)
  (let ((sep "    "))
    (format t "Day-~a~%~apart-1: ~a~%~apart-2: ~a~%" day sep part-1 sep part-2)))

(defmacro print-results (day part-1 part-2)
  `(time (print-results* ,day ,part-1 ,part-2)))

(defun transpose (l)
  (apply #'mapcar #'list l))

(defun diagonal (l)
  (let* ((max-x (length l))
         (max-y (length (nth 0 l)))
         (diag (loop :repeat (+ max-y max-y -1) :collect '())))
    (loop :for x :from 0 :below max-x :do
      (loop :for y :from 0 :below max-y
            :for itm = (nth y (nth x l)) :do
              (push itm
                    (nth (+ x y) diag))))
    diag))

(defun adiagonal (l)
  (let* ((max-x (length l))
         (max-y (length (nth 0 l)))
         (adiag (loop :repeat (+ max-y max-y -1) :collect '())))
    (loop :for x :from 0 :below max-x :do
      (loop :for y :from 0 :below max-y
            :for itm = (nth y (nth x l)) :do
              (push itm
                    (nth (+ x (- max-y y 1)) adiag))))
    adiag))

(defun words->char-list (words)
  (loop :for w :in words :collect (coerce w 'list)))

(defun char-list->words (char-list)
  (loop :for c :in char-list :collect (coerce c 'string)))
