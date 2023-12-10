(defsystem "beetleman.aoc-2023"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("cl-ppcre"
	       "alexandria"
	       "serapeum")
  :components ((:module "src"
                :components
                ((:file "day_1")
		 (:file "day_2")
		 (:file "day_3")
		 (:file "day_4")
		 (:file "day_5")
		 (:file "day_6")
		 (:file "day_7")
		 (:file "day_8"))))
  :description ""
  :in-order-to ((test-op (test-op "beetleman.aoc-2023/tests"))))

(defsystem "beetleman.aoc-2023/tests"
  :author ""
  :license ""
  :depends-on ("beetleman.aoc-2023"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "day_1")
		 (:file "day_2")
		 (:file "day_3")
		 (:file "day_4")
		 (:file "day_5")
		 (:file "day_6")
		 (:file "day_7")
		 (:file "day_8"))))
  :description "Test system for beetleman.aoc-2023"
  :perform (test-op (op c) (symbol-call :rove :run c)))
