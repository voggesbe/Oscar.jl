mutable struct RootSystem
  roots::Vector{Vector{Int}}
  simple_roots::Vector{Vector{Int}}
  positive_roots::Vector{Vector{Int}}
  root_system_type::Tuple{Symbol, Int64}
  function RootSystem(S::Symbol, n::Int64)
    # S is a symbol detailing the type of the indecomposable root system 
    # e.g. "A", "B", "C",... and n is an integer for the number of simple roots
    S1 = GAP.Obj(S)
    RS = GAP.Globals.RootSystem(S1, n)
    sR = Vector{Vector{Int}}(GAP.Globals.SimpleSystem(RS))
    Ro1 = Vector{Vector{Int}}(GAP.Globals.PositiveRoots(RS))
    Ro2 = Vector{Vector{Int}}(GAP.Globals.NegativeRoots(RS))
    Ro = vcat(Ro1, Ro2)
    t = (S, n)
    return new(Ro, sR, Ro1, t)
  end
end

###############################################################################
#
#   Basic manipulation
#
###############################################################################
@doc raw"""
  number_of_roots(R::RootSystem)

Return the numbers of roots in the root system `R`
"""
number_of_roots(R::RootSystem) = size(R.roots)[1]

@doc raw"""
  number_of_roots(S::String)

Return the numbers of roots in the root system of type `S`
"""
number_of_roots(S::Symbol, n::Int64) = number_of_roots(RootSystem(S, n))

@doc raw"""
  getindex(R::RootSystem, r::Int)

Return the `r`-th root of the root system `R`.
"""
getindex(R::RootSystem, r::Int) = getindex(R.roots, r)

@doc raw"""
  root_system_type(R::RootSystem)

Return the Dynkin type of the root system `R`.
"""
root_system_type(R::RootSystem) = R.root_system_type

###############################################################################
#
#   String I/O
#
###############################################################################

function show(io::IO, R::RootSystem)
  print(io, "Root system of type ")
  show(io, string(R.root_system_type[1]) * string(R.root_system_type[2]))
end

###############################################################################
#
#   Comparison
#
###############################################################################

function Base.:(==)(R1::RootSystem, R2::RootSystem)
  return R1.roots == R2.roots &&
         R1.root_system_type != R2.root_system_type
end

function Base.hash(R::RootSystem, h::UInt)
  b = 0x9d96557cb5f07773 % UInt
  h = hash(R.positive_roots, h)
  h = hash(R.root_system_type, h)
  h = hash(R.roots, h)
  h = hash(R.simple_roots, h)
  return xor(h, b)
end
###############################################################################
#
#   Constructor
#
###############################################################################
@doc raw"""
  root_system(S::String) -> root_system
Return the root system of type `S` where `S` is a string consisting out of
a letter `A`, `B`, `C`, `D`, `E`, `F`, `G` followed by an integer.
For the exceptional root system, the integers are fixed, e.g. `G2`, `F4`, `E6`, ...
"""
function root_system(S::Symbol, n::Int64)
  @req S in [:A, :B, :C, :D, :E, :F, :G] "Unknown Dynkin type"
  # S is a symbol detailing the type of the indecomposable root system 
  # e.g. "A", "B", "C",... and n is an integer for the number of simple roots
  return RootSystem(S, n)
end

###############################################################################
#
#   further functions
#
###############################################################################
 @doc raw"""
   cartan_matrix(S::String) -> Matrix{QQFieldElem}

 Return the Cartan matrix of the type of root system specified by `S`
  """
function cartan_matrix(S::Symbol, n::Int64)
  @req S in [:A, :B, :C, :D, :E, :F, :G] "Unknown Dynkin type"
  S1 = GAP.Obj(S)
  RS = GAP.Globals.RootSystem(S1, n)
  CG = GAP.Globals.CartanMatrix(RS)
  C = matrix(QQ, CG)
  return C
end

 @doc raw"""
   cartan_matrix(R::RootSystem) -> Matrix{QQFieldElem}

 Return the Cartan matrix of the type root system `R`
"""
function cartan_matrix(R::RootSystem)
  S = R.root_system_type
  S1 = GAP.Obj(S[1])
  RS = GAP.Globals.RootSystem(S1, S[2])
  CG = GAP.Globals.CartanMatrix(RS)
  C = matrix(QQ, CG)
  return C
end
 
@doc raw"""
   dynkin_diagram(S::String)

 Return the Dynkin diagram of the type of root system specified by `S`
"""
function dynkin_diagram(S::Symbol, n::Int64)
  @req S in [:A, :B, :C, :D, :E, :F, :G] "Unknown Dynkin type"
   D = ""
  
  if S == :A
    for i = 1:(n-1)
      D = D * string(i) * " - "
    end
    D = D * string(n)
    
  elseif S == :B
    for i = 1:(n-2)
      D = D * string(i) * " - "
    end
    D = D * string(n-1) * " >=> " * string(n)
    
  elseif S == :C
  
    for i = 1:(n-2)
      D = D * string(i) * " - "
    end
    D = D * string(n-1) * " <=< " * string(n)
    
  elseif S == :D
    if n >= 4
      for i = 1:4*n-10
        D = D * " "
      end
      D = D * string(n-1) * "\n"
      for i = 1:4*n-11
        D = D * " "
      end
      D = D * "/\n"
      for i = 1:n-3
        D = D * string(i) * " - "
      end
      D = D * string(n-2) * "\n"
      for i = 1:4*n-12
        D = D * " "
      end
      D = D * " \\ \n"
      for i = 1:4*n-10
        D = D * " "
      end
      D = D * string(n)
    else
      error("This root system doesn't exist.")
    end
    
  elseif S == :E
    if n == 6
      D = "1 - 3 - 4 - 5 - 6\n        |\n        2"
    elseif n == 7
      D = "1 - 3 - 4 - 5 - 6 - 7\n        |\n        2"
    elseif n == 8
      D = "1 - 3 - 4 - 5 - 6 - 7 - 8\n        |\n        2"
    else
      error("This root system doesn't exist.")
    end
  
  elseif S == :F
    if n == 4
      D = "1 - 2 >=> 3 - 4"
    else
      error("This root system doesn't exist.")
    end
  elseif S == :G
    if n == 2
      D = "1 >>> 2"
    else
      error("This root system doesn't exist.")
    end
  else
    error("This root system doesn't exist.")
  end
  print(D)
end
@doc raw"""
   dynkin_diagram(R::RootSystem)

 Return the Dynkin diagram of the root system `R`
"""
function dynkin_diagram(R::RootSystem)
  S = R.root_system_type
  return dynkin_diagram(S[1],S[2])
end

