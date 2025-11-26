(ns beetleman.aoc-2023.day-2
  (:require [clojure.string :as str]))

(defn parse-row [row]
  {:id    (->> row
            (re-find #"Game (\d+)+:")
            last
            parse-long)
   :cubes (into []
               (map (fn [s]
                      (into {}
                            (map (fn [[_ i b]]
                                   [(keyword b) (parse-long i)]))
                            (re-seq #"(\d+) (blue|red|green)" s))))
               (str/split row #";\W*"))})

(defn ok? [{:keys [blue red green]} {:keys [cubes]}]
  (nil? (some #(or (< red (:red % 0))
                   (< blue (:blue % 0))
                   (< green (:green % 0)))
              cubes)))

(defn solve [records all-cubes]
  (transduce (comp (map parse-row)
                   (filter (partial ok? all-cubes))
                   (map :id))
             +
             (str/split-lines records)))
