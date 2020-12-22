open("21/input.txt") do io
    allingr = []
    aidict = Dict()
    for line in eachline(io)
        a, b = split(line[1:end-1], "(contains ")
        ingredients = split(a)
        allergens = split(b, ", ")

        append!(allingr, ingredients)
        for allergen in allergens
            ingr = get(aidict, allergen, Set(ingredients))
            intersect!(ingr, ingredients)
            aidict[allergen] = ingr
        end
    end

    noallergens = filter(x -> !any(x .∈ values(aidict)), allingr)
    @show length(noallergens)
    
    ans = Dict()
    while true
        idx = findfirst(==(1), map(length, values(aidict)))
        isnothing(idx) && break
        key = collect(keys(aidict))[idx]
        val = first(aidict[key])
        ans[key] = val
        map!(x -> setdiff(x, [val]), values(aidict))
    end

    perm = sortperm(collect(keys(ans)))
    @show join(collect(values(ans))[perm], ",")
end

