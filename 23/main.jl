function runcupsgame(cups, iter)
    ptr = cups[1]
    links = []
    for i in 1:length(cups)
        nidx = findfirst(==(i), cups) % length(cups) + 1
        push!(links, cups[nidx])
    end
    for i in 1:iter
        if i % 10000 == 0
            @show i
        end
        tripleidxs = [links[ptr], links[links[ptr]], links[links[links[ptr]]]]

        target = (ptr + length(links) - 2) % length(links) + 1
        while target in tripleidxs
            target = (target + length(links) - 2) % length(links) + 1
        end

        ptr = links[ptr] = links[tripleidxs[3]]
        links[tripleidxs[3]] = links[target]
        links[target] = tripleidxs[1]
    end
    return links
end

inp = 315679824
cups = parse.(Int, collect("$inp"))

links = runcupsgame(cups, 100)

ptr = 1
for _ in eachindex(links)
    print(findfirst(==(ptr), eachindex(links)))
    ptr = links[ptr]
end
println()

links = runcupsgame([cups; maximum(cups)+1:1000000], 10000000)

@show links[1] * links[links[1]]
