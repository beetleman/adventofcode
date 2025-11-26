(ns beetleman.aoc-2023.day-6)

(defn posible? [button-pressed time distance]
  (< distance (* button-pressed (- time button-pressed))))

(defn button-pressed-posibilities [max-time distance]
  (filter #(posible? % max-time distance) (range 1 max-time)))

(defn parse-numbers-list [s]
  (map parse-long (re-seq #"\d+" s)))

(defn records [records-string]
  (map (fn [[max-time distance]]
         {:max-time max-time
          :distance distance})
       (map vector
            (parse-numbers-list (re-find #"Time: .+" records-string))
            (parse-numbers-list (re-find #"Distance: .+" records-string)))))

(defn solve [records-string]
  (transduce (comp (map (fn [{:keys [max-time distance]}]
                          (button-pressed-posibilities max-time distance)))
                   (map count))
             *
             (records records-string)))
