# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_set_range_composite

include atcoder/extra/header/chaemon_header

import atcoder/extra/structure/reversible_splay_tree

import atcoder/modint

type mint = modint998244353

block:
  let N, Q = nextInt()
  proc f(a, b:(mint,mint)):(mint,mint) = (a[0] * b[0], a[1] * b[0] + b[1])
  
  var seg = initReversibleSplayTree[(mint, mint)](f, (a:(mint, mint)) => a, (mint(1), mint(0)))
  
  var V = newSeqWith(N, (mint(nextInt()), mint(nextInt())))
  
  var root = seg.build(V)

  for i in 0..<Q:
    let t = nextInt()
    if t == 0:
      let p = nextInt()
      let a, b = mint(nextInt())
      seg.set_element(root, p, (a, b))
    else:
      let l, r = nextInt()
      let x = nextInt().mint
      let ret = seg.query(root, l, r)
      echo ret[0] * x + ret[1]
