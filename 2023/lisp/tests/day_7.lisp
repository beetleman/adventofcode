(defpackage beetleman.aoc-2023/tests/day-7
  (:use :cl
        :beetleman.aoc-2023.day-7
        :beetleman.aoc-2023/tests/io
        :rove)
  (:export :camel-cards))
(in-package :beetleman.aoc-2023/tests/day-7)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar camel-cards
  "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483")

(deftest solve-test
  (testing "Day 7: Camel Cards"
    (testing "part-1"
      (ok (= 6440
	     (solve-1 camel-cards)))
      (ok (= 251136060
	     (solve-1 (read-file "tests/day_7_input_part_1.txt")))))
    (testing "part-2"
      (ok (= 5905
	     (solve-2 camel-cards)))
      (ok (= 249400220
       	     (solve-2 (read-file "tests/day_7_input_part_2.txt")))))))
