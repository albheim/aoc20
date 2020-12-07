
open("04/input.txt") do io
    required = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    passports = [Dict()]
    tags = []
    for line in eachline(io)
        if length(line) == 0
            push!(passports, Dict())
        else
            for (key, value) in map(x -> Tuple(split(x, ":")), split(line, " "))
                passports[end][key] = value
            end
        end
    end
    valid1 = count(x -> issubset(required, Set(keys(x))), passports)

    valid2 = count(x -> 
        issubset(required, Set(keys(x))) && 
        "1920" <= x["byr"] <= "2002" && 
        "2010" <= x["iyr"] <= "2020" && 
        "2020" <= x["eyr"] <= "2030" && 
        if x["hgt"][end-1:end] == "cm"
            "150" <= x["hgt"][1:end-2] <= "193"
        elseif x["hgt"][end-1:end] == "in"
            "59" <= x["hgt"][1:end-2] <= "76"
        else
            false
        end && 
        occursin(r"^#[a-f0-9]{6}$", x["hcl"]) && 
        x["ecl"] in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] && 
        occursin(r"^[0-9]{9}$", x["pid"])
    , passports)

    @show valid1, valid2
end