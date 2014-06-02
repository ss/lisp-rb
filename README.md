lisp-rb
=======

Lisp Interpreter in Ruby. Inspired by [Lis.py](http://norvig.com/lispy.html).

```
Lisp.eval("(* 2 (+ 1 0) )")
# => 2
```

- [x] __constant literal number__ -	A number evaluates to itself. _Example: 12 or -3.45e+6_

- [x] __procedure call__ - (proc exp...)	If proc is anything other than one of the symbols if, set!, define, lambda, begin, or quote then it is treated as a procedure. It is evaluated using the same rules defined here. All the expressions are evaluated as well, and then the procedure is called with the list of expressions as arguments. _Example: (square 12) ⇒ 144_

- [ ] __variable reference__ - var	A symbol is interpreted as a variable name; its value is the variable's value. _Example: x_

- [ ] __quotation__	- (quote exp) Return the exp literally; do not evaluate it. _Example: (quote (a b c)) ⇒ (a b c)_

- [ ] __conditional__ -	(if test conseq alt)	Evaluate test; if true, evaluate and return conseq; otherwise evaluate and return alt. _Example: (if (< 10 20) (+ 1 1) (+ 3 3)) ⇒ 2_

- [ ] __assignment__ -	(set! var exp)	Evaluate exp and assign that value to var, which must have been previously defined (with a define or as a parameter to an enclosing procedure). _Example: (set! x2 (* x x))_

- [ ] __definition__	- (define var exp)	Define a new variable and give it the value of evaluating the expression exp. _Examples: (define r 3) or (define square (lambda (x) (* x x)))._

- [ ] __procedure__	- (lambda (var...) exp)	Create a procedure with parameter(s) named var... and the expression as the body. _Example: (lambda (r) (* 3.141592653 (* r r)))_

- [ ] __sequencing__ -	(begin exp...)	 Evaluate each of the expressions in left-to-right order, and return the final value. _Example: (begin (set! x 1) (set! x (+ x 1)) (* x 2)) ⇒ 4_