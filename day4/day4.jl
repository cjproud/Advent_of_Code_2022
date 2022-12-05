open("day4_input.txt") do file
    lines = eachline(file)
    count = 0
    count2 = 0
    for line in lines
        elf1, elf2 = split(line, ',')
        elf1_range = collect(range(parse(Int, split(elf1,'-')[1]), parse(Int, split(elf1, '-')[2])))
        elf2_range = collect(range(parse(Int, split(elf2,'-')[1]), parse(Int, split(elf2, '-')[2])))
        # Check if all overlap
        if issubset(elf1_range, elf2_range) || issubset(elf2_range, elf1_range)
            count += 1
        end
        # Check if any overlap
        if (length(intersect(elf1_range, elf2_range)) >= 1)
            count2 += 1
        end
    end
    println(count)
    println(count2)
end