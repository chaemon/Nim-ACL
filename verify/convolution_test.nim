# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

import atcoder/header, atcoder/modint
import atcoder/convolution
import sequtils, strutils

let N, M = nextInt()
let a = newSeqWith(N, nextInt())
let b = newSeqWith(M, nextInt())
echo convolution[998244353, int](a, b).join(" ")
