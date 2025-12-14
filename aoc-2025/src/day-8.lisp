;;; day-8.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(in-package #:aoc-2025)

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

(defun day-8-1 (junction-boxes-string)
  0)

(test:define-test+run day-8-1-example-test
    (test:is = 0
             (day-8-1 junction-boxes-string)))

(test:define-test+run day-8-1-example-test
    (let ((junction-boxes-string (uiop:read-file-string "./inputs/day-8.txt")))
      (test:is = 0
               (day-8-1 junction-boxes-string))))

(defun day-8-2 (junction-boxes-string)
  )

(test:define-test+run day-8-2-example-test
    (test:is = 0
             (day-8-2 junction-boxes-string)))

(test:define-test+run day-8-2-test
    (let ((junction-boxes-string (uiop:read-file-string "./inputs/day-8.txt")))
      (test:is = 0
               (day-8-2 junction-boxes-string))))

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
(expt 2 3)

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

(comment
 (let ((lines (str:lines "162,817,812
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
425,690,689"))
       (size 6))
   (i:iter (i:with boxes = (t:transduce (t:comp (t:map (op (str:match _
                                                             ((x "," y "," z)
                                                              (fset:map (:x (parse-integer x))
                                                                        (:y (parse-integer y))
                                                                        (:z (parse-integer z))))))))

                                        #'t:cons
                                        lines))
           (i:for box-a in boxes)
           (fset/iterate:collect-set (i:iter (i:for box-b in boxes)
                                             (i:initially (pprint '~~~~~~~~~~~~~~))
                                             (unless (fset:equal? box-a box-b)
                                               (i:finding (fset:seq (euclidean-distance-3d box-a box-b) (fset:set box-a box-b))
                                                          minimizing #'fset:first
                                                          into x))
                                             (i:finally
                                              (pprint (list box-a x))
                                              (pprint '---------------------)
                                              (return x)))
                                     into pairs)
           (i:finally
            (comment (pprint
                      (sort (reduce #'put-in-bucket
                                    (t:transduce (t:comp (t:map (op (fset:@ _ 1)))
                                                         (t:take size))
                                                 #'t:cons
                                                 (sort (fset:convert 'list pairs)
                                                       #'< :key #'fset:first))
                                    :initial-value '())
                            #'> :key #'fset:size)))
            (t:transduce #'t:pass
                         (t:for #'pprint)
                         (sort (fset:convert 'list pairs)
                               #'< :key #'fset:first))))))
