lines = readlines("19/input_fixed.txt")

rules = Dict() 

i = 1
while lines[i] != ""
    n, line = split(lines[i], ": ") 
    n = parse(Int, n)
    if occursin("\"", line)
        rules[n] = split(line, "\"")[2][1]
    else
        rules[n] = []
        for l in split(line, " | ")
            push!(rules[n], parse.(Int, split(l, " ")))
        end
    end
    i += 1
end

messages = lines[i+1:end]

function check_rule(rules, i, message, idx)
    if idx > length(message)
        return []
    elseif typeof(rules[i]) == Char
        if message[idx] == rules[i]
            return [idx + 1]
        else
            return []
        end
    else
        matched = []
        for opt in rules[i]
            lastidxs = idx
            for subrule in opt
                newidxs = []
                for j in lastidxs
                    append!(newidxs, check_rule(rules, subrule, message, j))
                end
                lastidxs = newidxs
            end
            append!(matched, lastidxs)
        end
        return matched
    end
end

check_rule_wrapper(message) = !isnothing(findfirst(check_rule(rules, 0, message, 1) .== length(message) .+ 1))

@show count(check_rule_wrapper, messages)