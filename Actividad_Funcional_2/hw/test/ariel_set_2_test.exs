#    Tests for the set of problems by Ariel Ortiz
#    Applications of the general concepts of functional programming
#
#    Gilberto Echeverria
#    2022_03_04

defmodule Hw.Ariel2Test do
  use ExUnit.Case
  alias Hw.Ariel2

  # Functions

  test "test insert" do
    assert Ariel2.insert([], 14) == [14]
    assert Ariel2.insert([5, 6, 7, 8], 4) == [4, 5, 6, 7, 8]
    assert Ariel2.insert([1, 3, 6, 7, 9, 16], 5) == [1, 3, 5, 6, 7, 9, 16]
    assert Ariel2.insert([1, 5, 6], 10) == [1, 5, 6, 10]
  end

  test "test insertion_sort" do
    assert Ariel2.insertion_sort([]) == []
    assert Ariel2.insertion_sort([4, 3, 6, 8, 3, 0, 9, 1, 7]) == [0, 1, 3, 3, 4, 6, 7, 8, 9]
    assert Ariel2.insertion_sort([1, 2, 3, 4, 5, 6]) == [1, 2, 3, 4, 5, 6]
    assert Ariel2.insertion_sort([5, 5, 5, 1, 5, 5, 5]) == [1, 5, 5, 5, 5, 5, 5]
  end

  test "test rotate_left" do
    assert Ariel2.rotate_left([], 5) == []
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 0) == [:a, :b, :c, :d, :e, :f, :g]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 1) == [:b, :c, :d, :e, :f, :g, :a]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -1) == [:g, :a, :b, :c, :d, :e, :f]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 3) == [:d, :e, :f, :g, :a, :b, :c]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -3) == [:e, :f, :g, :a, :b, :c, :d]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 8) == [:b, :c, :d, :e, :f, :g, :a]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -8) == [:g, :a, :b, :c, :d, :e, :f]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 45) == [:d, :e, :f, :g, :a, :b, :c]
    assert Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -45) == [:e, :f, :g, :a, :b, :c, :d]
  end

  test "test prime_factors" do
    assert Ariel2.prime_factors(1) == []
    assert Ariel2.prime_factors(6) == [2, 3]
    assert Ariel2.prime_factors(96) == [2, 2, 2, 2, 2, 3]
    assert Ariel2.prime_factors(666) == [2, 3, 3, 37]
  end

  test "test gcd" do
    assert Ariel2.gcd(0, 0) == 0
    assert Ariel2.gcd(3, 0) == 3
    assert Ariel2.gcd(0, 2) == 2
    assert Ariel2.gcd(2, 2) == 2
    assert Ariel2.gcd(10, 8) == 2
    assert Ariel2.gcd(8, 10) == 2
    assert Ariel2.gcd(270, 192) == 6
    assert Ariel2.gcd(13, 7919) == 1
    assert Ariel2.gcd(20, 16) == 4
    assert Ariel2.gcd(54, 24) == 6
    assert Ariel2.gcd(6307, 1995) == 7
  end

  test "test deep_reverse" do
    assert Ariel2.deep_reverse([]) == []
    assert Ariel2.deep_reverse([:a, :b]) == [:b, :a]
    assert Ariel2.deep_reverse([:a, :b, :c]) == [:c, :b, :a]
    assert Ariel2.deep_reverse([:a, [:b, :c, :d], 3]) == [3, [:d, :c, :b], :a]
    assert Ariel2.deep_reverse([[1, 2], 3, [4, [5, 6]]]) == [[[6, 5], 4], 3, [2, 1]]
  end

  test "test insert_everywhere" do
    assert Ariel2.insert_everywhere(:x, []) == [[:x]]
    assert Ariel2.insert_everywhere(:x, [:a]) == [[:x, :a], [:a, :x]]

    assert Ariel2.insert_everywhere(:x, [:a, :b, :c]) ==
             [[:x, :a, :b, :c], [:a, :x, :b, :c], [:a, :b, :x, :c], [:a, :b, :c, :x]]

    assert Ariel2.insert_everywhere(:x, [:a, :b, :c, :d, :e]) ==
             [
               [:x, :a, :b, :c, :d, :e],
               [:a, :x, :b, :c, :d, :e],
               [:a, :b, :x, :c, :d, :e],
               [:a, :b, :c, :x, :d, :e],
               [:a, :b, :c, :d, :x, :e],
               [:a, :b, :c, :d, :e, :x]
             ]
  end

  test "test pack" do
    assert Ariel2.pack([]) == []
    assert Ariel2.pack([:a]) == [[:a]]

    assert Ariel2.pack([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
             [[:a, :a, :a, :a], [:b], [:c, :c], [:a, :a], [:d], [:e, :e, :e, :e]]

    assert Ariel2.pack([1, 2, 3, 4, 5]) == [[1], [2], [3], [4], [5]]
    assert Ariel2.pack([9, 9, 9, 9, 9]) == [[9, 9, 9, 9, 9]]
  end

  test "test compress" do
    assert Ariel2.compress([]) == []
    assert Ariel2.compress([:a]) == [:a]

    assert Ariel2.compress([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
             [:a, :b, :c, :a, :d, :e]

    assert Ariel2.compress([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert Ariel2.compress([9, 9, 9, 9, 9]) == [9]
  end

  test "test encode" do
    assert Ariel2.encode([]) == []
    assert Ariel2.encode([:a]) == [{1, :a}]

    assert Ariel2.encode([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
             [{4, :a}, {1, :b}, {2, :c}, {2, :a}, {1, :d}, {4, :e}]

    assert Ariel2.encode([1, 2, 3, 4, 5]) == [{1, 1}, {1, 2}, {1, 3}, {1, 4}, {1, 5}]
    assert Ariel2.encode([9, 9, 9, 9, 9]) == [{5, 9}]
  end

  test "test encode_modified" do
    assert Ariel2.encode_modified([]) == []
    assert Ariel2.encode_modified([:a]) == [:a]

    assert Ariel2.encode_modified([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
             [{4, :a}, :b, {2, :c}, {2, :a}, :d, {4, :e}]

    assert Ariel2.encode_modified([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert Ariel2.encode_modified([9, 9, 9, 9, 9]) == [{5, 9}]
  end

  test "test decode" do
    assert Ariel2.decode([]) == []
    assert Ariel2.decode([:a]) == [:a]

    assert Ariel2.decode([{4, :a}, :b, {2, :c}, {2, :a}, :d, {4, :e}]) ==
             [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]

    assert Ariel2.decode([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
    assert Ariel2.decode([{5, 9}]) == [9, 9, 9, 9, 9]
  end

  #  test "test args_swap" do
  #    assert Ariel2.args_swap(list).(1, 2) == [2, 1]
  #    assert Ariel2.args_swap(/).(8, 2) == 1/4
  #    assert Ariel2.args_swap(cons).([1, 2, 3], [4, 5, 6]) == [(4, 5, 6], 1, 2, 3)
  #    assert Ariel2.args_swap(map).([-1, 1, 2, 5, 10], /) == [-1, 1, 1/2, 1/5, 1/10]
  #  end
  #
  #  test "test there_exists_one?" do
  #    assert Ariel2.there_exists_one?(positive?, []) == #f
  #    assert Ariel2.there_exists_one?(positive?, [-1, -10, 4, -5, -2, -1]) == #t
  #    assert Ariel2.there_exists_one?(positive?, [-1, -10, 4, -5, 2, -1]) == #f
  #    assert Ariel2.there_exists_one?(negative?, [-1]) == #t
  #    assert Ariel2.there_exists_one?(symbol?, [4, 8, 15, 16, 23, 42]) == #f
  #    assert Ariel2.there_exists_one?(symbol?, [4, 8, 15, sixteen, 23, 42]) == #t
  #  end
  #
  #  test "test linear_search" do
  #    assert Ariel2.linear_search([], 5, =) == #f
  #    assert Ariel2.linear_search([48, 77, 30, 31, 5, 20, 91, 92, 69, 97, 28, 32, 17, 18, 96], 5, =) == 4
  #    assert Ariel2.linear_search(["red" "blue" "green" "black" "white"], "black", string=?) == 3
  #    assert Ariel2.linear_search([:a, :b, :c, :d, :e, :f, :g, :h], :h, equal?) == 7
  #  end
end
