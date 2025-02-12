module LieAlgebras

using ..Oscar

import Oscar: GAPWrap, IntegerUnion, MapHeader

# not importet in Oscar
using AbstractAlgebra: CacheDictType, ProductIterator, get_cached!, ordinal_number_string

using AbstractAlgebra.PrettyPrinting

# functions with new methods
import ..Oscar:
  _iso_oscar_gap,
  action, 
  base_ring,
  basis,
  basis_matrix,
  canonical_injection,
  canonical_injections,
  canonical_projection,
  canonical_projections,
  center,
  centralizer,
  characteristic,
  coeff,
  coefficient_ring,
  coefficients,
  compose,
  derived_series,
  dim,
  direct_sum,
  dual,
  elem_type,
  expressify,
  exterior_power,
  gen,
  gens,
  hom,
  hom_tensor,
  identity_map,
  ideal,
  image,
  inv,
  is_abelian,
  is_exterior_power,
  is_isomorphism,
  is_nilpotent,
  is_perfect,
  is_simple,
  is_solvable,
  is_welldefined,
  kernel,
  lower_central_series,
  matrix,
  ngens,
  normalizer,
  parent_type,
  sub,
  symbols,
  symmetric_power,
  tensor_product,
  zero_map,
  ⊕,
  ⊗

import Base: getindex, deepcopy_internal, hash, inv, isone, issubset, iszero, one, parent, rand, setindex!, show, zero,  +, -, *, ^, ==, !=

export AbstractLieAlgebra, AbstractLieAlgebraElem
export LieAlgebra, LieAlgebraElem
export LieAlgebraHom
export LieAlgebraIdeal
export LieSubalgebra
export LieAlgebraModule, LieAlgebraModuleElem
export LieAlgebraModuleHom
export LinearLieAlgebra, LinearLieAlgebraElem
export RootSystem
export SimpleLieAlgebra, SimpleLieAlgebraElem

export abelian_lie_algebra
export abstract_module
export base_lie_algebra
export base_module
export base_modules
export bracket
export cartan_matrix
export chevalley_basis
export coefficient_vector
export coerce_to_lie_algebra_elem
export combinations
export derived_algebra
export dynkin_diagram
export exterior_power
export general_linear_lie_algebra
export highest_weight_module
export hom_direct_sum
export hom_power
export is_direct_sum
export is_dual
export is_self_normalizing
export is_standard_module
export is_symmetric_power
export is_tensor_power
export is_tensor_product
export lie_algebra
export matrix_repr_basis
export multicombinations
export number_of_roots
export permutations
export permutations_with_sign
export root_system
export root_system_type
export special_linear_lie_algebra
export special_orthogonal_lie_algebra
export standard_module
export symmetric_power
export tensor_power
export trivial_module
export universal_enveloping_algebra

include("Combinatorics.jl")
include("Util.jl")
include("LieAlgebra.jl")
include("AbstractLieAlgebra.jl")
include("LinearLieAlgebra.jl")
include("LieSubalgebra.jl")
include("LieAlgebraIdeal.jl")
include("LieAlgebraHom.jl")
include("LieAlgebraModule.jl")
include("LieAlgebraModuleHom.jl")
include("iso_oscar_gap.jl")
include("iso_gap_oscar.jl")
include("GapWrapper.jl")
include("root_systems.jl")
include("simple_lie_algebra.jl")

end

using .LieAlgebras

export AbstractLieAlgebra, AbstractLieAlgebraElem
export LieAlgebra, LieAlgebraElem
export LieAlgebraHom
export LieAlgebraIdeal
export LieAlgebraModule, LieAlgebraModuleElem
export LieAlgebraModuleHom
export LieSubalgebra
export LinearLieAlgebra, LinearLieAlgebraElem
export RootSystem
export SimpleLieAlgebra, SimpleLieAlgebraElem

export abelian_lie_algebra
export abstract_module
export base_lie_algebra
export base_module
export base_modules
export bracket
export cartan_matrix
export chevalley_basis
export coerce_to_lie_algebra_elem
export derived_algebra
export dynkin_diagram
export exterior_power
export general_linear_lie_algebra
export highest_weight_module
export hom_direct_sum
export hom_power
export is_direct_sum
export is_dual
export is_self_normalizing
export is_standard_module
export is_symmetric_power
export is_tensor_power
export is_tensor_product
export lie_algebra
export matrix_repr_basis
export number_of_roots
export root_system
export root_system_type
export special_linear_lie_algebra
export special_orthogonal_lie_algebra
export standard_module
export symmetric_power
export tensor_power
export trivial_module
export universal_enveloping_algebra
