# Dynnamic programming in Scheme

This is a Scheme translation of dynamic programming techniques from the book The Algorithm Design Manual-Springer (Steven S. Skiena, 2020). I was listening to an interview from Steven in a podcast and they mentioned that dynamic programming is a very hard thing to understand. I decided to give it a try and was surprised to see that it is nothing more than what in Lisp is known as tail recursion. Basically we store in a list (or an array) only the values calculated in the last iteration of a recursive function because that's all that we need to know the next values. This saves a ton of memory.

I begin with `(fib-rec)`and `(fib-dp)`, i.e., recursive and "dynamic programming" implementation of the fibonacci series. I then move on to functions that calculate Pascal's Triangle (as and example that is given in Steven's book). Finally `(pasc-better)` is my optimization on top of it. It optimizes in three conditions:

- The first and last numbers in each "row" of Pascal's triangle is 1, so if k = 0 or k = n (the last number), the function returns 1 immediately.
- The second and second-to-last numbers are equal to the row's index (e. g. `(4, 1)` and `(4, 3)` should return `4`), so if `k = 1` or `k = n - k`, the function returns `n` immediately.
- Lastly, and more importantly, Pascal's triangle is symmetric (e.g. `(10, 3)` is equal to `(10, 8)`. That means we only have to calculate half of it. We never have to calculate `k` for `k * 2 > n`. With this optimization we should have slightly more than double the speed. This is implemented in `(pasc-better)`

You can run and test this implementation at https://replit.com/@CaioFooBarros/DynamicProgramming. Since Scheme is a high-level language it's slower than C, for instance, so you can easily see the effect of the optimization. Check a C implementation of the same optimization at https://github.com/cgbarros/Pascal-Triangle-in-C.
