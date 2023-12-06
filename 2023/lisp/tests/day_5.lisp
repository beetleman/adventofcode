(defpackage beetleman.aoc-2023/tests/day-5
  (:use :cl
        :beetleman.aoc-2023.day-5
        :rove)
  (:export :cards
	   :almanac))
(in-package :beetleman.aoc-2023/tests/day-5)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar almanac
  "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4")

(deftest solve-test
  (testing "Day 5: If You Give A Seed A Fertilizer"
    (ok (= 35
	   (solve almanac)))))
