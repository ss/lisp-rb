#!/usr/bin/env ruby
require "bundler/setup"
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require "minitest/autorun"
require "pry"

require_relative "../lib/lisp"

class TestLisp < MiniTest::Unit::TestCase

  # parser

  def test_tokenize
    assert_equal ["(", "+", "1", "1", ")"], Lisp.tokenize("(+ 1 1)")
  end

  def test_parse
    assert_raises(RuntimeError) { Lisp.parse(Lisp.tokenize("(")) }
    assert_raises(RuntimeError) { Lisp.parse(Lisp.tokenize(")")) }
  end

  # representation

  def test_representation
    assert_equal [:*, 2, [:+, 1, 0]],                              Lisp.parse(Lisp.tokenize("(* 2 (+ 1 0) )"))
    assert_equal [:lambda, [:r], [:*, 3.141592653, [:*, :r, :r]]], Lisp.parse(Lisp.tokenize("(lambda (r) (* 3.141592653 (* r r)))"))
  end

  # execution

  def test_execution
    assert_equal 1, Lisp.execute(1)
    assert_equal 2, Lisp.execute([:*, 2, [:+, 1, 0]])
  end

  def test_eval
    assert_equal 2, Lisp.eval("(* 2 (+ 1 0) )")
  end

  def test_define
    Lisp.eval("(define pi 3.141592653)")
    assert_equal 6.283185306, Lisp.eval("(* pi 2)")
  end

  def test_if
    assert_equal 2, Lisp.eval("(if(== 1 2) 1 2)")
    assert_equal 1, Lisp.eval("(if(!= 1 2) 1 2)")
  end

  def test_lambda
    Lisp.eval("(define area (lambda (r) (* 3.141592653 (* r r))))")
    assert_equal 28.274333877, Lisp.eval("(area 3)")
    Lisp.eval("(define fact (lambda (n) (if (<= n 1) 1 (* n (fact (- n 1))))))")
    assert_equal 3628800, Lisp.eval("(fact 10)")
  end

  def test_quote
    assert_equal [:a, :b, :c], Lisp.eval('(quote (a b c))')
  end

  def test_assignment
    ex = assert_raises(RuntimeError) { Lisp.eval('(set! foo 42)') }
    assert_equal 'foo must be defined before you can set! it', ex.message

    Lisp.eval('(define foo 3.14)')
    assert_equal 42, Lisp.eval('(set! foo 42)')
    assert_equal 42, Lisp.eval('(* 1 foo)')

    assert_equal -42, Lisp.eval('(set! foo (* -1 foo))')
  end

  def test_sequencing
    assert_equal 4, Lisp.eval('(begin (define x 1) (set! x (+ x 1)) (* x 2))')
  end

  def test_display
    assert_output("Hello World! 42\n")  { Lisp.eval('(display Hello World! 42)') }
    assert_output("Evaluated: 3.14\n") { Lisp.eval('(display Evaluated: (* 1 3.14))') }
  end

end
