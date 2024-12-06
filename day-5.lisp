(defpackage #:adventofcode-2024/day-5
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria)
  (:import-from :serapeum)
  (:import-from :cl-ppcre))
(in-package #:adventofcode-2024/day-5)

(defun create-checker (a b)
  (lambda (l)
    (loop :with bp = nil
          :for i :in l
          :when (eql i b) :do
            (setq bp t)
          :never (and bp
                      (eql i a)))))

(defun create-replacer (a b)
  (lambda (l)
    (let ((l (copy-list l)))
      (flet ((a? (n)
               (eql (nth n l) a))
             (b? (n)
               (eql (nth n l) b)))
        (loop
          :with result = (copy-list l)
          :with i = 0
          :with j = (1- (length l))
          :always (< i j)
          :when (and (b? i) (a? j))
            :do (setf (nth i l) a
                      (nth j l) b
                      i (1+ i)
                      j (1- j))
          :unless (b? i)
            :do (incf i)
          :unless (a? j)
            :do (decf j))
        l))))

(defstruct Rule checker replacer)

(defun create-rule (a b)
  (make-rule :checker (create-checker a b)
             :replacer (create-replacer a b)))

(defun center (l)
  (nth (floor (/ (length l) 2))
       l))

(defun parse (file-name)
  (loop :for l :in (uiop:read-file-lines file-name)
        :with rules = '()
        :with pages = '()
        :with pagesp = nil
        :for numbers = (util:parse-numbers-string l)
        :do (cond
              ((string= l "") (setq pagesp t))
              ((not pagesp)
               (push (apply #'create-rule numbers) rules))
              (pagesp (push numbers pages)))
        :finally (return (list pages rules))))

(defun check (rules pages)
  (loop :for rule :in rules
        :always (funcall (rule-checker rule) pages)))

(defun fix (rules pages)
  (loop
    :for p = pages :then (reduce (lambda (pages r)
                                   (funcall (rule-replacer r) pages))
                                 rules
                                 :initial-value p)
    :when (check rules p)
      :do (return p)))

(defun part-1 (file-name)
  (destructuring-bind (pages rules) (parse file-name)
    (loop :for p :in pages
          :when (check rules p)
            :sum (center p))))

(defun part-2 (file-name)
  (destructuring-bind (pages rules) (parse file-name)
    (loop :for p :in pages
          :unless (check rules p)
            :sum  (center (fix rules p)))))

(util:print-results 5
                    (part-1 "./resources/input-day-5.1.txt")
                    (part-2 "./resources/input-day-5.1.txt"))
