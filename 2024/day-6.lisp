(defpackage #:adventofcode-2024/day-6
  (:use :cl)
  (:import-from :adventofcode-2024/util)
  (:import-from :alexandria :switch)
  (:import-from :serapeum)
  (:import-from :cl-ppcre))
(in-package #:adventofcode-2024/day-6)

(defconstant direction-up #\^)
(defconstant direction-down #\v)
(defconstant direction-right #\>)
(defconstant direction-left #\<)
(defconstant nothing #\.)
(defconstant obstacle #\#)

(defstruct Guard x y direction visited moves)

(defun create-guard (x y direction)
  (make-guard :x x
              :y y
              :direction direction
              :visited (list (list x y))))

(defmethod next-move ((g Guard))
  (with-slots (x y direction) g
    (switch (direction)
      (direction-up (list (1- x) y))
      (direction-down (list (1+ x) y))
      (direction-left (list x (1- y)))
      (direction-right (list x (1+ y))))))

(defmethod turn ((g Guard))
  (setf (guard-direction g)
        (switch ((guard-direction g))
          (direction-up direction-right)
          (direction-down direction-left)
          (direction-left direction-up)
          (direction-right direction-down))))

(defmethod move ((g Guard) pos)
  (setf (guard-x g) (first pos)
        (guard-y g) (second pos)
        (guard-visited g) (adjoin pos (guard-visited g) :test #'equal)
        (guard-moves g) (cons (cons (guard-direction g) pos)
                              (guard-moves g))))

(defmethod loop? ((g Guard) pos)
  (with-slots (direction moves) g
    (loop :for (d x y) :in moves
          :thereis (and (= x (first pos))
                        (= y (second pos))
                        (eql d direction)))))

(defstruct Lab guard map max-x max-y)

(defmethod end? ((l Lab) pos)
  (destructuring-bind (x y) pos
    (with-slots (max-x max-y) l
      (or (< max-x x)
          (> 0 x)
          (> 0 y)
          (< max-y y)))))

(defmethod obstacle? ((l Lab) pos)
  (with-slots (map) l
    (eql (util:nth2 (first pos) (second pos) map)
         obstacle)))

(defun parse (file-name)
  (let* ((map (util:words->char-list (uiop:read-file-lines file-name)))
         (max-x (1- (length map)))
         (max-y (1- (length (first map))))
         (lab (make-lab :max-x max-x
                        :max-y max-y
                        :map map)))
    (flet ((guard? (x y)
             (loop :for d in (list direction-up direction-down direction-right direction-left)
                   :with g = (util:nth2 x y map)
                   :thereis (eql d g))))
      (loop :for x :from 0 :below max-x :do
        (loop :for y :from 0 :below max-y
              :when (guard? x y)
                :do (setf (lab-guard lab) (create-guard x y (util:nth2 x y map))
                          (util:nth2 x y map) nothing)))
      lab)))

(defun copy-map (map)
  (loop :for l :in map
        :collect (copy-list l)))

(defun run-lab (l)
  (loop :for next-pos = (next-move (lab-guard l))
        :do
           (cond
             ((end? l next-pos) (return :end))
             ((loop? (lab-guard l) next-pos) (return :loop))
             ((obstacle? l next-pos) (turn (lab-guard l)))
             (:else (move (lab-guard l) next-pos)))))

(defun part-1 (file-name)
  (let ((l (parse file-name)))
    (run-lab l)
    (length (guard-visited (lab-guard l)))))

(defun part-2 (file-name)
  (let* ((l (parse file-name))
         (x (guard-x (lab-guard l)))
         (y (guard-y (lab-guard l)))
         (direction (guard-direction (lab-guard l))))
    (run-lab l)
    (with-slots (map guard max-x max-y) l
      (loop :for pos :in (guard-visited guard)
            :for new-map = (let ((m (copy-map map)))
                             (setf (util:nth2 (first pos) (second pos) m) obstacle)
                             m)
            :for new-lab = (make-lab :guard (create-guard x y direction)
                                     :map   new-map
                                     :max-x max-x
                                     :max-y max-y)
            
            :for r = (run-lab new-lab)
            :when (eql :loop r)
              :count pos))))

;; slooooow
;;TODO: optimise!
(print "Day-6
    part-1: 5331
    part-2: 1812")
(when nil
  (util:print-results 6
                      (part-1 "./resources/input-day-6.1.txt")
                      (part-2 "./resources/input-day-6.1.txt")))
