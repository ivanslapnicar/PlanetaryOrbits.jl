### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ b9eba282-67d3-11eb-3734-033538ed6c62
using AstroLib, Dates, Plots

# ╔═╡ cf3f5210-67e4-11eb-2b2b-bb38ff2d21b3
md"
# Planetary Orbits

This notebook draws the lines connecting two planets (`Planet1` and `Planet2`) in 2D projection of their respective heliocentric coordinates from `Date1` until `Date2` in positions which are `δDays` apart.

Planets are `1=Mercury`, `2=Venus`, `3=Earth`, `4=Mars`, `5=Jupyter`, `6=Saturnus`, `7=Uranius`, `8=Neptun`, `9=Pluto`.

See also [link1](https://en.wikipedia.org/wiki/Orbit#Planetary_orbits) and [link2](https://www.keplerstern.com/signature-of-the-celestial-spheres/) for extended information.

The notebook uses Julia packages [AstroLib.jl](https://github.com/JuliaAstro/AstroLib.jl) and [Plots.jl](https://github.com/JuliaPlots/Plots.jl), and the module  [Dates](https://julia-doc.readthedocs.io/en/latest/manual/dates/).
"

# ╔═╡ 7cfe5360-69ed-11eb-3fea-8daf1f2706ec
Planets=["Mercury", "Venus", "Earth", "Mars", "Jupyter", "Saturn", "Uranus","Neptune","Pluto"]

# ╔═╡ 44da6540-696c-11eb-2705-efcff349ece8
begin
	Date1=DateTime(2001,1,1)
	Date2=DateTime(2021,1,1)
	δDays=Day(10)
	Planet1=3
	Planet2=4
end

# ╔═╡ 06a3a6b0-67d7-11eb-0c38-5599b546084b
# Range od days in DateTime format
drange=Date1:δDays:Date2

# ╔═╡ d385a4c0-67d8-11eb-2682-2fecbef2468a
# Convert to number of Julian calendar days since epoch -4713-11-24T12:00:00.
jrange=jdcnv.(drange)

# ╔═╡ c657a82e-696c-11eb-26d8-afb78bbd18f7
# Number of timesteps
length(jrange)

# ╔═╡ 9c5221f0-67d7-11eb-0779-09121e38cfb3
# Weekly (or δDays) coordinates of Planet1 in heliocentric spherical system
coord1=[helio(i,Planet1,true) for i in jrange]

# ╔═╡ f9268460-67d8-11eb-0efc-6390d7311ece
# 2D Cartesian projection od heliocentric coordinates of Planet1
xy1=[(i[1]*cos(i[2])*cos(i[3]),i[1]*sin(i[2])*cos(i[3])) for i in coord1]

# ╔═╡ 1592c830-67d8-11eb-2532-6128ac089578
# Weekly (or δDays) coordinates of Planet2 in heliocentric spherical system
coord2=[helio(i,Planet2,true) for i in jrange]

# ╔═╡ 2850f972-67e1-11eb-0ade-dfaff95058dc
# 2D Cartesian projection od heliocentric coordinates of Planet2
xy2=[(i[1]*cos(i[2])*cos(i[3]),i[1]*sin(i[2])*cos(i[3])) for i in coord2]

# ╔═╡ 284659d0-67db-11eb-1c13-75528f34153b
begin
	plotly()
	label1=Planets[Planet1]
	label2=Planets[Planet2]
	scatter(xy1,label=label1,aspect_ratio=1)
	scatter!(xy2,label=label2)
end

# ╔═╡ 067f952e-67dd-11eb-0be6-73f7cd45d333
begin
	plotly()
	title=Planets[Planet1]*"-"*Planets[Planet2]
	plot(color=:white, background=:lightgreen, showaxis=:hide, axis=nothing, 		grid=false, leg=false, aspect_ratio=1,size=(400,400),title=title,fg=:white)
	for i=2:length(xy2)
		plot!([xy1[i],xy2[i]], color=:blue, w=0.5)
	end
	plot!([xy1[1],xy2[1]], color=:white,w=1)
	scatter!([xy1[1],xy2[1]], mcolor=[:red,:red],mscolor=[:red,:red])
end

# ╔═╡ 993655e0-69ee-11eb-2201-6bc1eca2f420
# savefig(title*".svg")

# ╔═╡ Cell order:
# ╟─cf3f5210-67e4-11eb-2b2b-bb38ff2d21b3
# ╠═98cfdfff-6884-4967-a356-19e9e94d5be1
# ╠═b9eba282-67d3-11eb-3734-033538ed6c62
# ╠═7cfe5360-69ed-11eb-3fea-8daf1f2706ec
# ╠═06a3a6b0-67d7-11eb-0c38-5599b546084b
# ╠═d385a4c0-67d8-11eb-2682-2fecbef2468a
# ╠═c657a82e-696c-11eb-26d8-afb78bbd18f7
# ╠═9c5221f0-67d7-11eb-0779-09121e38cfb3
# ╠═1592c830-67d8-11eb-2532-6128ac089578
# ╠═f9268460-67d8-11eb-0efc-6390d7311ece
# ╠═2850f972-67e1-11eb-0ade-dfaff95058dc
# ╠═284659d0-67db-11eb-1c13-75528f34153b
# ╠═44da6540-696c-11eb-2705-efcff349ece8
# ╠═067f952e-67dd-11eb-0be6-73f7cd45d333
# ╠═993655e0-69ee-11eb-2201-6bc1eca2f420
