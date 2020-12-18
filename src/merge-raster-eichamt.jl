### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 0d72abba-33cc-11eb-17d9-dd6b7b0e20ea
import CSV

# ╔═╡ 2afa63bc-33cc-11eb-17ee-775f761bafd1
import DataFrames

# ╔═╡ b8ea3d76-33f6-11eb-035a-e75f6aa022eb
demographic = CSV.read("/Users/rene/Data/UNIQA/DemographicData/raster250-hole-austria-with-generalized-latlaon.csv")

# ╔═╡ 56cdd0c8-33f7-11eb-148d-6b58e4ee88dc
demographic.LAT

# ╔═╡ fe64378c-33f6-11eb-2b46-877c21a7e605
DataFrames.describe(demographic)

# ╔═╡ 34151992-33cc-11eb-1194-fbb0c1dcbb9f
function mergecrspcompkernel(;crsp=error("crsp is required"), comp=error("comp is required"))
  ###Merge one permno at a time, linking each crsp row to a compid (comp row)
  scrsps = groupby(crsp, :permno)
  scomps = groupby(comp, :permno)
  comp.compid = 1:size(comp,1) |> collect
  crsp.compid = Vector{Union{Int, Missing}}(undef, size(crsp,1))

  #faster to work within the rows for a particular permno
  Threads.@threads for permno ∈ keys(scomps)
    scomp = scomps[permno]
    crsppermnokey = permno |> Tuple
    (!haskey(scrsps,crsppermnokey)) && continue
    #because the key originates from comp, cant use it directly on crsp- instead need its value
    scrsp = scrsps[crsppermnokey]

    #the idea here is to select all of the crsp rows between the effective date
    #and the end date of the comp row
    for r ∈ eachrow(scomp)
      targetrows = view(scrsp, (r.effdate .≤ scrsp.date) .& (scrsp.date .≤ r.enddate), :compid)
      if length(targetrows) > 0
        #under no circumstances should this be assigned, since date and permno should be unique
        (targetrows .=== missing) |> all || error(
          "multiple crsp rows found for a particular compid!!")
        targetrows .= r.compid
      end
    end
  end

  crsp = crsp[crsp.compid .!== missing, :]

  #now merge the linked rows
  rename!(comp, :permno=>:lpermno)
  panel = innerjoin(crsp, comp, on=:compid)

  #sanity checks
  @assert size(panel,1) == size(crsp,1)
  @assert (crsp.permno .== panel.permno) |> all
  @assert (crsp.date .== panel.date) |> all

  return panel
end

# ╔═╡ Cell order:
# ╠═0d72abba-33cc-11eb-17d9-dd6b7b0e20ea
# ╠═2afa63bc-33cc-11eb-17ee-775f761bafd1
# ╠═b8ea3d76-33f6-11eb-035a-e75f6aa022eb
# ╠═56cdd0c8-33f7-11eb-148d-6b58e4ee88dc
# ╠═fe64378c-33f6-11eb-2b46-877c21a7e605
# ╠═34151992-33cc-11eb-1194-fbb0c1dcbb9f
