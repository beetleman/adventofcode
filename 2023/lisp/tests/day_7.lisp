(defpackage beetleman.aoc-2023/tests/day-7
  (:use :cl
        :beetleman.aoc-2023.day-7
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
    (ok (= 6440
	   (solve camel-cards)))
    (ok (= 251136060
	   (solve (alexandria:read-file-into-string #P"tests/day_7_input.txt"))))))
