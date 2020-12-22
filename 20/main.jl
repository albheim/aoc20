function rotations(img)
    return vcat(([rotl90(img, i), rotl90(img', i)] for i in 0:3)...)
end

function fit(final, count)
    good = true
    if count > size(final, 1)
        good &= final[count][:, 1] == final[count - size(final, 1)][:, end]
    end
    if count % size(final, 1) != 1
        good &= final[count][1, :] == final[count - 1][end, :]
    end
    return good
end

function recurse!(final, imgs, idx, count = 1, used = [])
    if count == length(imgs) + 1
        return true
    end
    for i in setdiff(eachindex(imgs), used)
        for j in eachindex(imgs[i])
            final[count] = imgs[i][j]
            idx[count] = i
            # check it fits
            if fit(final, count)
                if recurse!(final, imgs, idx, count + 1, [used; i])
                    return true
                end
            end
        end
    end
    return false
end

open("20/input.txt") do io
    imgs = Dict()
    id = 0
    mat = []
    for line in eachline(io)
        if occursin("Tile", line)
            id = parse(Int, line[6:end-1])
        elseif line == ""
            n = length(mat[1])
            imgs[id] = zeros(Bool, n, n)
            for i in 1:n, j in 1:n
                imgs[id][i, j] = mat[i][j] == '#'
            end
            mat = []
        else
            push!(mat, line)
        end
    end

    n = round(Int, sqrt(length(imgs)))

    # Nicer solution that works for both
    final = Array{Array{Bool, 2}, 2}(undef, n, n)
    idx = Array{Int, 2}(undef, n, n)

    rotimgs = rotations.(values(imgs))
    recurse!(final, rotimgs, idx)
    idx = map(i -> collect(keys(imgs))[i], idx)

    @show idx[1, 1] * idx[1, end] * idx[end, 1] * idx[end, end]

    # Make complete image
    image = vcat([hcat([final[i, j][2:end-1, 2:end-1] for j in 1:size(final, 1)]...) for i in 1:size(final, 1)]...)

    # Fix monster
    monstertext = "                  # \n#    ##    ##    ###\n #  #  #  #  #  #   "
    monster = hcat([[x == '#' for x in collect(line)] for line in split(monstertext, '\n')]...)'
    msize = count(==('#'), collect(monstertext))

    # Do and convolution and find when it is msize, do xor
    my, mx = size(monster)
    isize = size(image, 1)

    for img in rotations(image)
        roughness = 0
        for i in 1:isize-my+1, j in 1:isize-mx+1
            if sum(monster .& img[i:i+my-1, j:j+mx-1]) == msize
                roughness += 1
            end
        end
        if roughness > 0
            @show sum(img) - msize * roughness
            break
        end
    end
end