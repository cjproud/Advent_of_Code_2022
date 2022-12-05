function find_alphabet_idx(letter)
    alphabet_string = "abcdefghijklmnopqrstuvwxyz"
    # Grab index in alphabet string
    alphabet_idx = findfirst(letter, alphabet_string)
    # Check if it's upper or lowercase
    if isnothing(alphabet_idx)
        priority = findfirst(lowercase(letter), alphabet_string) + 26
    else 
        priority = alphabet_idx
    end
    return priority
end

open("day3_input.txt") do file
    lines = readlines(file)
    count = 0
    count2 = 0
    for line in lines
        unique_values = unique(line)
        # Part 1
        for uv in unique_values
            # Find if any values are duplicated
            value_indices = findall(x -> x == uv, line)
            if any([v <= length(line)/2 for v in value_indices]) && any([v > length(line)/2 for v in value_indices])
                count += find_alphabet_idx(uv)
            end
        end
    end
    println(count)


    # Part 2
    # Chunk the lines into groups of 3
    for lg in Iterators.partition(lines,3)
        # Find unique values in all three groups
        unique_values = intersect(lg[1], lg[2], lg[3])
        count2 += find_alphabet_idx(unique_values[1])
    end
    println(count2)
end

