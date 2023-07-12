using Oscar

GAP.Packages.load("sla")
 
import Base: show, size, getindex

mutable struct RootSystem <: AbstractVector{fmpq}
  roots::Vector
  simple_roots::Vector
  positive_roots::Vector
  root_system_type::Vector{Union{String, Int64}}
  @doc raw"""
    `RootSystem(S::String) -> RootSystem`
  Return the root system of type `S` where `S` is a string consisting out of
  a letter `A`, `B`, `C`, `D`, `E`, `F`, `G` followed by an integer.
  For the exceptional root system, the integers are fixed, e.g. `G2`, `F4`, `E6`, ...
  """
  function RootSystem(S::String)
    # S is a string detailing the type of the indecomposable root system made out of a letter, e.g. "A", "B", "C",... and an integer for the number of simple roots
    l = length(S)
    n = parse(Int64, S[2:l])
    S1 = GAP.Obj(string(S[1]))
    RS = GAP.Globals.RootSystem(S1, n)
    Ro_1 = GAP.Globals.PositiveRoots(RS)
    Ro_2 = GAP.Globals.NegativeRoots(RS)
    sR = GAP.Globals.SimpleSystem(RS)
    sR = [[sR[i][j] for j=1:length(sR[i])] for i=1:length(sR)]
    Ro1 = [[Ro_1[i][j] for j=1:length(Ro_1[i])] for i=1:length(Ro_1)]
    Ro2 = [[Ro_2[i][j] for j=1:length(Ro_2[i])] for i=1:length(Ro_2)]
    Ro = reduce(vcat, (Ro1, Ro2))
    S = Union{String, Int64}[S[1:1], n]
    new(Ro,sR,Ro1,S)
  end
end

###############################################################################
#
#   Basic manipulation
#
###############################################################################
 @doc raw"""
  `size(R::RootSystem, [dim::Int])`
 Return a tuple containing the dimensions of the vector of roots, i.e. the number of roots in the first entry. 
 Optionally you can specify a dimension to just get the length of that dimension.
  """
size(R::RootSystem, dim::Int) = size(R.roots, dim)

size(R::RootSystem) = size(R.roots)

 @doc raw"""
  `getindex(R::RootSystem, r::Int)`
 Return the rth root in the vector of roots in the root system `R`
  """
getindex(R::RootSystem, r::Int) = getindex(R.roots, r)

###############################################################################
#
#   String I/O
#
###############################################################################

function show(io::IO, R::RootSystem)
  print(io, "Root system of type ")
  show(io, R.root_system_type)
end

###############################################################################
#
#   further functions
#
###############################################################################
 @doc raw"""
  `CartanMatrix(S::String) -> Matrix{QQFieldElem}`
 Return the Cartan matrix of the type of root system specified by `S`
  """
function CartanMatrix(S::String)
  S1 = S[1:1]
  l = length(S)
  n = parse(Int64, S[2:l])
  S1 = GAP.Obj(string(S[1:1]))
  RS = GAP.Globals.RootSystem(S1, n)
  CG = GAP.Globals.CartanMatrix(RS)
  C = Matrix{fmpq}(CG)
	return C
end

 @doc raw"""
  `CartanMatrix(R::RootString) -> Matrix{QQFieldElem}`
 Return the Cartan matrix of the type of root system specified by `S`
  """
function CartanMatrix(R::RootSystem)
  S = R.root_system_type
  S2 = S[1] * string(S[2])
	C = CartanMatrix(S2)
	return C
end

function DynkinDiagram(S::String)
  S1 = S[1:1]
	l = length(S)
	n = parse(Int64,S[2:l])
	D = ""
	if S1 == "A"
    for i = 1:(n-1)
       D = D * string(i) * " - "
		end
    D = D * string(n)
	elseif S1 == "B"
	  for i = 1:(n-2)
		  D = D * string(i) * " - "
		end
		D = D * string(n-1) * " >=> " * string(n)
	elseif S1 == "C"
	  for i = 1:(n-2)
      D = D * string(i) * " - "
		end
		D = D * string(n-1) * " <=< " * string(n)
	elseif S1 == "D"
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
	elseif S1 == "E"
		if n == 6
			D = "1 - 3 - 4 - 5 - 6\n        |\n        2"
		elseif n == 7
		  D = "1 - 3 - 4 - 5 - 6 - 7\n        |\n        2"
		elseif n == 8
			D = "1 - 3 - 4 - 5 - 6 - 7 - 8\n        |\n        2"
		end
	elseif S1 == "F"
		D = "1 - 2 >=> 3 - 4"
	elseif S1 == "G"
		D = "1 >>> 2"
	end
	print(D)
end

function DynkinDiagram(R::RootSystem)
	S = R.root_system_type
  S2 = S[1] * string(S[2])
	DynkinDiagram(S2)
end
