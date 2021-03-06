# LongDouble {{{
when not declared ATCODER_LONGDOUBLE_HPP:
  const ATCODER_LONGDOUBLE_HPP* = 1
  type LongDouble* {.importcpp: "long double", nodecl .} = object
    discard
  
  proc getLongDouble*(a:SomeNumber):LongDouble {.importcpp: "(long double)(#)", nodecl.}
  proc initLongDouble*(a:float):LongDouble = getLongDouble(a.cdouble)
  converter toLongDouble*(a:int):LongDouble = getLongDouble(a.cint)
  converter toLongDouble*(a:float):LongDouble = getLongDouble(a.cdouble)
#  converter toLongDouble*(a:LongDouble):LongDouble = a
  proc toCDouble*(a:LongDouble):cdouble {.importcpp: "(double)(#)", nodecl.}
  converter toFloat*(a:LongDouble):float = toCDouble(a).float
  converter toFloat64*(a:LongDouble):float64 = toCDouble(a).float64
  converter toFloat32*(a:LongDouble):float32 = toCDouble(a).float32
  proc init*(T:typedesc[LongDouble], a:SomeNumber):LongDouble = LongDouble(a)
  
  proc `+`*(a, b:LongDouble):LongDouble {.importcpp: "(#) + (@)", nodecl.}
  proc `-`*(a, b:LongDouble):LongDouble {.importcpp: "(#) - (@)", nodecl.}
  proc `*`*(a, b:LongDouble):LongDouble {.importcpp: "(#) * (@)", nodecl.}
  proc `/`*(a, b:LongDouble):LongDouble {.importcpp: "(#) / (@)", nodecl.}
  proc `+=`*(a:var LongDouble, b:LongDouble) {.importcpp: "(#) += (@)", nodecl.}
  proc `-=`*(a:var LongDouble, b:LongDouble) {.importcpp: "(#) -= (@)", nodecl.}
  proc `*=`*(a:var LongDouble, b:LongDouble) {.importcpp: "(#) *= (@)", nodecl.}
  proc `/=`*(a:var LongDouble, b:LongDouble) {.importcpp: "(#) /= (@)", nodecl.}
  proc `<`*(a, b:LongDouble):bool {.importcpp: "(#) < (@)", nodecl.}
  proc `<=`*(a, b:LongDouble):bool {.importcpp: "(#) <= (@)", nodecl.}
  proc `>`*(a, b:LongDouble):bool {.importcpp: "(#) > (@)", nodecl.}
  proc `>=`*(a, b:LongDouble):bool {.importcpp: "(#) >= (@)", nodecl.}
  proc `-`*(a:LongDouble):LongDouble {.importcpp: "-(#)", nodecl.}
  proc getString*(a:LongDouble, s:var cstring) {.header:"<string>", importcpp: "(@) = std::to_string(#).c_str()", nodecl.}
  proc `$`*(a:LongDouble):string =
    var s:cstring
    getString(a, s)
    return $s
  proc `abs`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "abs(#)", nodecl.}
  proc `sqrt`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "sqrtl(#)", nodecl.}
  proc `exp`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "expl(#)", nodecl.}
  proc `sin`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "sinl(#)", nodecl.}
  proc `cos`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "cosl(#)", nodecl.}
  proc `acos`*(a:LongDouble):LongDouble {.header: "<cmath>", importcpp: "acosl(#)", nodecl.}
  proc `llround`*(a:LongDouble):int {.header: "<cmath>", importcpp: "llround(#)", nodecl.}
  proc `pow`*(a:LongDouble, b:SomeNumber):LongDouble {.header: "<cmath>", importcpp: "powl((#), (long double)(@))", nodecl.}
# }}}
