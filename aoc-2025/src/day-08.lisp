;;; day-8.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

(defun euclidean-distance-3d (a b)
  (sqrt (+ (expt (- (fset:@ a :x)
                    (fset:@ b :x))
                 2)
           (expt (- (fset:@ a :y)
                    (fset:@ b :y))
                 2)
           (expt (- (fset:@ a :z)
                    (fset:@ b :z))
                 2))))

(defun put-in-bucket (buckets data)
  (i:iter (i:for bucket in buckets)
    (if (fset:disjoint? bucket data)
        (i:collect bucket into new-buckets)
        (i:for new-bucket
               first bucket
               then (fset:union new-bucket bucket)))
    (i:finally (return (push (if new-bucket
                                 (fset:union new-bucket data)
                                 data)
                             new-buckets)))))


(defparameter junction-boxes-string
  "162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689")

(defun day-8-1 (junction-boxes-string size)
  (i:iter outer
    (i:with boxes = (mapcar (op (str:match _
                                  ((x "," y "," z)
                                   (fset:map (:x (parse-integer x))
                                             (:y (parse-integer y))
                                             (:z (parse-integer z))))))
                            (str:lines junction-boxes-string)))
    (i:for box-a in boxes)
    (i:for boxes* on boxes)
    (i:iter (i:for box-b in (cdr boxes*))
      (i:in outer
            (i:collect (cons (euclidean-distance-3d box-a box-b) (fset:set box-a box-b))
              into pairs)))
    (i:finally
     (return-from outer
       (t:transduce (t:comp (t:map #'fset:size)
                            (t:take 3))
                    #'*
                    (sort (reduce (lambda (buckets el)
                                    (put-in-bucket buckets (cdr el)))
                                  (take size (sort pairs #'< :key #'car))
                                  :initial-value '())
                          #'> :key #'fset:size))))))

(test:define-test+run day-8-1-example-test
    (test:is = 40
             (day-8-1 junction-boxes-string 10)))

(test:define-test+run day-8-1-example-test
    (let ((junction-boxes-string (uiop:read-file-string "./inputs/day-8.txt")))
      (test:is = 66640
               (day-8-1 junction-boxes-string 1000))))

(defun day-8-2 (junction-boxes-string)
  (i:iter outer
    (i:with boxes = (mapcar (op (str:match _
                                  ((x "," y "," z)
                                   (fset:map (:x (parse-integer x))
                                             (:y (parse-integer y))
                                             (:z (parse-integer z))))))
                            (str:lines junction-boxes-string)))
    (i:for box-a in boxes)
    (i:for boxes* on boxes)
    (i:iter (i:for box-b in (cdr boxes*))
      (i:in outer
            (i:collect (cons (euclidean-distance-3d box-a box-b) (fset:set box-a box-b))
              into pairs)))
    (i:finally
     (return-from outer
       (i:iter
         (i:with target-boxes = (fset:convert 'fset:set boxes))
         (i:with current-boxes = (fset:set))
         (i:for el in (sort pairs #'< :key #'car))
         (i:for pair = (cdr el))
         (setq current-boxes (fset:union current-boxes pair))
         (when (fset:equal? target-boxes current-boxes)
           (i:leave (fset:reduce '*
                                 pair
                                 :initial-value 1
                                 :key (op (fset:@ _ :x))))))))))

(test:define-test+run day-8-2-example-test
    (test:is = 25272
             (day-8-2 junction-boxes-string)))

(test:define-test+run day-8-2-test
    (let ((junction-boxes-string (uiop:read-file-string "./inputs/day-8.txt")))
      (test:is = 78894156
               (day-8-2 junction-boxes-string))))
