when not declared ATCODER_BINARY_TREE_UTILS_HPP:
  const ATCODER_BINARY_TREE_UTILS_HPP* = 1
  include atcoder/extra/structure/binary_tree_node_utils
  type SomeSortedTree* = concept x, type T
    T.Tree is BinaryTree
    T.K is typedesc
    T.V is typedesc
    T.Node is typedesc
    T.multi is typedesc
    T.p
    x.End
  type SomeSortedSet* = concept x, type T
    T is SomeSortedTree
    T.V is void
    T.multi is void
  type SomeSortedMap* = concept x, type T
    T is SomeSortedTree
    T.V isnot void
    T.multi is void
  type SomeSortedMultiSet* = concept x, type T
    T is SomeSortedTree
    T.V is void
    T.multi isnot void
  type SomeSortedMultiMap* = concept x, type T
    T is SomeSortedTree
    T.V isnot void
    T.multi isnot void

  proc getKey*[T:SomeSortedTree](self: T, t:T.Node):auto =
    when T.V is void: t.key
    else: t.key[0]

  template calc_comp*[T:SomeSortedTree](self:T, x, y:T.K):bool =
    when T.p[0] is typeof(nil):
      x < y
    else:
      let comp = T.p[0]
      comp(x, y)

  proc lower_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    if t.isLeaf: return t
    if t != self.End and self.calc_comp(self.getKey(t), x):
      return self.lower_bound(t.r, x)
    else:
      var t2 = self.lower_bound(t.l, x)
      if t2.isLeaf: return t
      else: return t2

  proc lower_bound*[T:SomeSortedTree](self:var T, x:T.K):auto =
    assert self.root != nil
    self.lower_bound(self.root, x)

  proc upper_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    if t.isLeaf: return t
    if t == self.End or self.calc_comp(x, self.getKey(t)):
      var t2 = self.upper_bound(t.l, x)
      if t2.isLeaf: return t
      else: return t2
    else:
      return self.upper_bound(t.r, x)

  proc upper_bound*[T:SomeSortedTree](self: var T, x:T.K):T.Node =
    assert self.root != nil
    self.upper_bound(self.root, x)

#  proc find*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
#    echo "find:  ", t.key
#    if t == self.End or t.isLeaf: return self.End
#    if self.calc_comp(x, self.getKey(t)): return self.find(t.l, x)
#    elif self.calc_comp(self.getKey(t), x): return self.find(t.r, x)
#    else: return t
  proc find*[T:SomeSortedTree](self:var T, x:T.K):T.Node =
    var t = self.lower_bound(x)
    if t != self.End and self.getKey(t) == x: return t
    else: return self.End
#    result = self.find(self.root, x)
  proc contains*[T:SomeSortedTree](self: var T, x:T.K):bool =
    self.find(x) != self.End

  proc insert*[T:SomeSortedMultiSet](self: var T, x:T.K) =
    T.Tree(self).insert(self.upper_bound(x), x)
  proc insert*[T:SomeSortedMultiMap](self: var T, x:(T.K, T.V)) =
    T.Tree(self).insert(self.upper_bound(x[0]), x)

  proc insert*[T:SomeSortedSet](self: var T, x:T.K) =
    var t = self.lower_bound(x)
    if t != self.End and t.key == x: return
    T.Tree(self).insert(t, x)
  proc insert*[T:SomeSortedMap](self: var T, x:(T.K, T.V)) =
    var it = self.lower_bound(x[0])
    if it != self.End and it.key[0] == x[0]: it.key[1] = x[1]
    else:
      T.Tree(self).insert(it, x)
  template getAddr*[T:SomeSortedMap](self:var T, x:T.K):auto =
    mixin default
    var t = self.lower_bound(x)
    if t == self.End or t.key[0] != x:
      var v = T.V.default
      t = T.Tree(self).insert(t, (x, v))
    t.key[1].addr

  template `[]`*[T:SomeSortedMap](self: var T, x:T.K):auto =
    var t = self.getAddr(x)
    t[]
  proc `[]=`*[T:SomeSortedMap](self: var T, x:T.K, v:T.V) =
    var t = self.getAddr(x)
    t[] = v

  proc erase*[T:SomeSortedTree](self: var T, x:T.K) =
    mixin erase
    var t = self.lower_bound(x)
    if t == self.End or self.getKey(t) != x: return
    T.Tree(self).erase(t)
  proc erase*[T:SomeSortedTree](self: var T, t:T.Node) =
    T.Tree(self).erase(t)
  proc kth_element*[T:SomeSortedTree](self: var T, t:T.Node, k:int):T.Node =
    let p = t.l.cnt
    if k < p: return self.kth_element(t.l, k)
    elif k > p: return self.kth_element(t.r, k - p - 1)
    else: return t
  
  proc kth_element*[T:SomeSortedTree](self: var T, k:int):T.Node =
    return self.kth_element(T.Tree(self).root, k)
  proc `{}`*[T:SomeSortedTree](self: var T, k:int):T.Node =
    return self.kth_element(k)

  iterator items*[T:SomeSortedSet or SomeSortedMultiSet](self:T):T.K =
    var it = self.Begin
    while it != self.End:
      yield it.key
      it.inc
  iterator pairs*[T:SomeSortedMap or SomeSortedMultiMap](self:T):(T.K, T.V) =
    var it = self.Begin
    while it != self.End:
      yield it.key
      it.inc


