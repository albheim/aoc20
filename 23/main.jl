function runcupsgame(cups, iter)
    ptr = cups[1]
    links = cups[sortperm(cups) .% length(cups) .+ 1]
    for i in 1:iter
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

ptr = links[1]
for _ in 2:length(links)
    print(findfirst(==(ptr), eachindex(links)))
    ptr = links[ptr]
end

links = runcupsgame([cups; maximum(cups)+1:1_000_000], 10_000_000)

@show links[1] * links[links[1]]
