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

(defun euclidean-distance-3d (x y)
  (sqrt (+ (expt (- (aref x 0)
                    (aref y 0))
                 2)
           (expt (- (aref x 1)
                    (aref y 1))
                 2)
           (expt (- (aref x 2)
                    (aref y 2))
                 2))))

(defun put-in-bucket (buckets data test)
  (loop :with new-bucket = '()
        :for bucket :in buckets
        :for ok = (intersectionp bucket data :test test)
        :if (not ok)
          :collect bucket :into new-buckets
        :else
          :do (setf new-bucket (union new-bucket bucket :test test))
        :finally (return (push (if new-bucket
                                   (union data new-bucket :test test)
                                   data)
                               new-buckets))))

(comment

  (time
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
425,690,689")))
     (i:iter (i:with boxes = (t:transduce (t:comp (t:map (op (str:match _
                                                               ((x "," y "," z)  (vect (parse-integer x)
                                                                                       (parse-integer y)
                                                                                       (parse-integer z)))))))

                                          #'t:cons
                                          lines))
       (i:for box-a in boxes)
       (i:collect (i:iter (i:for box-b in boxes)
                    (unless (vector= box-a box-b)
                      (i:finding (list box-a box-b)
                                 minimizing (euclidean-distance-3d box-a box-b))))
         into pairs)
       (i:finally
        (return (t:transduce (t:comp (t:map #'length)
                                     (t:take 3))
                             #'*
                             (sort (reduce (lambda (acc p)
                                             (put-in-bucket acc p #'vector=))
                                           pairs
                                           :initial-value '())
                                   #'> :key #'length)))))))


  '(#(162 817 812) #(425 690 689))


  (time
   (i:iter (i:with boxes = (t:transduce (t:comp (t:map (op (str:match _
                                                             ((x "," y "," z)  (vect (parse-integer x)
                                                                                     (parse-integer y)
                                                                                     (parse-integer z)))))))

                                        #'t:cons
                                        #p "inputs/day-8.txt"))
     (i:for box-a in boxes)
     (i:collect (i:iter (i:for box-b in boxes)
                  (unless (vector= box-a box-b)
                    (i:finding (list box-a box-b)
                               minimizing (euclidean-distance-3d box-a box-b))))
       into pairs)
     (i:finally
      (return (t:transduce (t:comp (t:map #'length)
                                   (t:take 3))
                           #'*
                           (sort (reduce (lambda (acc p)
                                           (put-in-bucket acc p #'vector=))
                                         pairs
                                         :initial-value '())
                                 #'> :key #'length)))))))
