(ns plugin.formatting-sample
  (:import (java.util AbstractCollection AbstractList AbstractMap AbstractQueue AbstractSequentialList AbstractSet)))

(defn foo [a b c]
  (* a b c))

(defn bar
      [a b c]
  (* a b c))

(defn baz
  "A doc string"
  [a b c]
  (* a b c))

(defn bar
  ([a b] (bar a b 100))
  ([a b c] (* a b c)))

(def my-map {:a     "A value"
             :blarg :another-value
             :foo   {:test "A nested map"
                     :c    :d}})
