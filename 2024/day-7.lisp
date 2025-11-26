(defpackage #:adventofcode-2024/day-7
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria :switch)
  (:import-from :serapeum)
  (:import-from :cl-ppcre))
(in-package #:adventofcode-2024/day-7)

(defstruct Equation
  result numbers)

(defstruct Op check undo)

(defconstant op-plus
  (make-op :check (constantly t)
           :undo #'-))

(defconstant op-div
  (make-op :check (lambda (n1 n2)
                    (zerop (mod n1 n2)))
           :undo #'/))

(defconstant op-concatenate
  (make-op :check (lambda (n1 n2)
                    (let ((s1 (write-to-string n1))
                          (s2 (write-to-string n2)))
                      (when (< (length s2) (length s1))
                        (string= s1 s2 :start1 (- (length s1)
                                                  (length s2))))))
           :undo (lambda (n1 n2)
                   (let ((s1 (write-to-string n1))
                         (s2 (write-to-string n2)))
                     (parse-integer s1 :end (- (length s1)
                                               (length s2)))))))

(defun undo-op (op n1 n2)
  (funcall (op-undo op)  n1 n2))

(defun check-op (op n1 n2)
  (funcall (op-check op)  n1 n2))

(defun parse (file-name)
  (loop :for line :in (uiop:read-file-lines file-name)
        :for numbers = (util:parse-numbers-string line)
        :collect (make-equation :result (first numbers)
                                :numbers (rest numbers))))

(defun solvable? (result numbers ops)
  (labels ((solvable? (result numbers)
             (cond
               ((not numbers) (zerop result))
               ((< 0 result)
                (destructuring-bind (number &rest numbers) numbers
                  (loop :for op :in ops
                        :thereis (when (check-op op result number)
                                   (solvable? (undo-op op result number) numbers))))))))
    (solvable? result (reverse numbers))))

(defun part-1 (file-name)
  (loop :for e :in (parse file-name)
        :when (solvable? (equation-result e)
                         (equation-numbers e)
                         (list op-div op-plus))
          :sum (equation-result e)))

(defun part-2 (file-name)
  (loop :for e :in (parse file-name)
        :when (solvable? (equation-result e)
                         (equation-numbers e)
                         (list op-div op-plus op-concatenate))
          :sum (equation-result e)))

(util:print-results 7
                    (part-1 "./resources/input-day-7.1.txt")
                    (part-2 "./resources/input-day-7.1.txt"))
