using DelimitedFiles

x = readdlm("01/input.txt", ' ', Int, '\n')
n = length(x)

for i in 1:n
    for j in i+1:n
        if x[i] + x[j] == 2020
            @show x[i]*x[j]
        end
        for k in j+1:n
            if x[i] + x[j] + x[k] == 2020
                @show x[i]*x[j]*x[k]
            end
        end
    end
end