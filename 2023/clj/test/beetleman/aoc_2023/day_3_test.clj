(ns beetleman.aoc-2023.day-3-test
  (:require [beetleman.aoc-2023.day-3 :as sut]
            [clojure.test :as t]))

(def engine-schematic
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

(t/deftest solve-test
  (t/testing "Day 3: Gear Ratios"
    (t/is (= 4361
             (sut/solve engine-schematic)))))
