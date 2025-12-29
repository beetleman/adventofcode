;;; day-6.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun day-6-1 (math-homework-string)
  (~>> math-homework-string
       (str:lines)
       (t:transduce (t:comp (t:map (op (str:split-omit-nulls " " _)))
                            (t:map (lambda (s)
                                     (loop :for i :in s
                                           :collect (if (str:digit? i)
                                                        (parse-integer i)
                                                        (switch (i :test #'string=)
                                                          ("+" #'+)
                                                          ("-" #'-)
                                                          ("*" #'*)
                                                          ("/" #'/)))))))
                    #'t:cons)
       (apply #'mapcar #'list)
       (t:transduce (t:map (lambda (x)
                             (apply (lastcar x)
                                    (butlast x))))
                    #'+)))

(test:define-test+run day-6-1-example-test
  (let ((math-homework-string "123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +
"))
    (test:is = 4277556
             (day-6-1 math-homework-string))))

(test:define-test+run day-6-1-example-test
  (let ((math-homework-string (uiop:read-file-string "./inputs/day-6.txt")))
    (test:is = 5381996914800
             (day-6-1 math-homework-string))))

(defun day-6-2 (math-homework-string)
  (let* ((math-homework-lines (str:lines math-homework-string))
         (max-length (loop :for i :in math-homework-lines
                           :maximize (length i))))
    (reduce #'+
            (mapcar (lambda (f n)
                      (apply f n))
                    (mapcar (op (switch (_ :test #'string=)
                                  ("+" #'+)
                                  ("-" #'-)
                                  ("*" #'*)
                                  ("/" #'/)))
                            (reverse (str:split-omit-nulls " " (lastcar math-homework-lines))))
                    (~>> math-homework-lines
                         butlast
                         (mapcar (op (str:pad-right max-length _ :pad-char " ")))
                         (mapcar (op (coerce _ 'list)))
                         (apply #'mapcar 'list)
                         reverse
                         (split-sequence-if (lambda (x)
                                              (every (op (eq #\  _))
                                                     x)))
                         (mapcar (lambda (x)
                                   (mapcar (op (parse-integer
                                                (t:transduce (t:filter (complement #'str:blank?))
                                                             #'t:string
                                                             _)))
                                           x))))))))

(test:define-test+run day-6-2-example-test
  (let ((math-homework-string "123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +"))
    (test:is = 3263827
             (day-6-2 math-homework-string))))

(test:define-test+run day-6-2-test
  (let ((math-homework-string (uiop:read-file-string "./inputs/day-6.txt")))
    (test:is = 9627174150897
             (day-6-2 math-homework-string))))
