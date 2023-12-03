(defpackage beetleman.aoc-2023/tests/day-3
  (:use :cl
        :beetleman.aoc-2023.day-3
        :rove))
(in-package :beetleman.aoc-2023/tests/day-3)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar engine-schematic
  "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..")

(deftest solve-test
  (testing "Day 3: Gear Ratios"
    (ok (= 4361 (solve engine-schematic)))
    (ok (= 4361 (solve-serapeum engine-schematic)))))
