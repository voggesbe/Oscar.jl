using Oscar
using Test

include("integer.jl")
include("rational.jl")
include("mpoly.jl")
include("orderings.jl")
include("mpoly-graded.jl")
include("mpoly-local.jl")
include("mpoly-localizations.jl")
include("mpolyquo-localizations.jl")
include("integer-localizations.jl")
include("nmod-localizations.jl")
include("mpoly-nested.jl")
include("MPolyQuo.jl")
include("groebner.jl")
include("solving.jl")
include("FractionalIdeal.jl")
include("mpoly_affine_algebras.jl")
include("slpolys.jl")

include("NumberField.jl")
include("FunctionField.jl")
include("AbelianClosure.jl")

# FIXME: temporarily disable AlgClosureFp tests until we resolve
# issue https://github.com/oscar-system/Oscar.jl/issues/2691
#include("AlgClosureFp.jl")
include("Laurent.jl")

include("MPolyAnyMap/MPolyRing.jl")
include("MPolyAnyMap/MPolyQuo.jl")
include("MPolyAnyMap/AffineAlgebras.jl")
include("MPolyAnyMap/flattenings.jl")

include("PBWAlgebra.jl")
include("PBWAlgebraQuo.jl")
include("FreeAssAlgIdeal.jl")

include("binomial-ideals.jl")
include("hilbert.jl")

include("ReesAlgebra.jl")
