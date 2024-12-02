(defpackage #:adventofcode-2024/day-2
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria)
  (:import-from :serapeum))
(in-package #:adventofcode-2024/day-2)

(defun parse (file-name)
  (loop :for l :in (uiop:read-file-lines file-name)
        :collect (util:parse-numbers-string l)))

(defun safep (report)
  (and (or (apply #'< report)
           (apply #'> report))
       (loop :for (a b) :on report
             :while b
             :when (not (< 0 (abs (- a b)) 4))
               :do (return nil)
             :finally (return t))))

(defun part-1 (file-name)
  (loop :for l :in (parse file-name)
        :when (safep l)
          :count l))

(defun part-2 (file-name)
  (loop :for l :in (parse file-name)
        :when (or (safep l)
                  (loop :for i :from 0 :below (length l)
                        :when (safep (serapeum:splice-seq l :start i :end (+ 1 i)))
                          :do (return t)
                        :finally (return nil)))
          :count l))

(util:print-results 2
                    (part-1 "./resources/input-day-2.1.txt")
                    (part-2 "./resources/input-day-2.1.txt"))
