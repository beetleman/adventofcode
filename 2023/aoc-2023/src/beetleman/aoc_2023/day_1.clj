(ns beetleman.aoc-2023.day-1
  (:require [clojure.string :as str]))

(defn solve [calibration-document]
  (transduce (comp (map #(re-seq #"\d+" %))
                   (remove nil?)
                   (map #(parse-long (str (first %)
                                          (last %)))))
             +
             0
             (str/split-lines calibration-document)))
