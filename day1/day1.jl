open("day1_input.txt") do file
    calories = readlines(file)
    current_elf_calories = 0
    per_elf_calories = []
    for (idx, line) in enumerate(calories)
        # Get each elf's calories
        if isempty(line)
            push!(per_elf_calories, current_elf_calories)
            current_elf_calories = 0 
        # Deal with the final elf
        elseif idx == length(calories)
            current_elf_calories += parse(Int64, line)
            push!(per_elf_calories, current_elf_calories)
        else 
            current_elf_calories += parse(Int64, line)
        end
    end
    # Part 1
    println("Elf with largest calories is carrying: $(findmax(per_elf_calories)[1])")
    # Part 2
    println("The sum of the three elves with the largest amount of calories is: $(sum(sort(per_elf_calories, rev=true)[1:3]))")
end