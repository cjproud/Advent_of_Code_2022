open("day5_input.txt") do file
    # Initialise dict
    lines = eachline(file)
    # Initialise warehouse
    crate_dict = Dict()
    map(range(1,9)) do x
        crate_dict[x] = []
    end
    # Initial warehouse for CrateMover9001
    crate_dict2 = deepcopy(crate_dict)
    for (i,line) in enumerate(lines)
        # Populate initial warehouse
        if i < 9
            starting_pos = Iterators.partition(line, 4)
            for (j,crate_column) in enumerate(starting_pos)
                if !isspace(crate_column[2])
                   push!(crate_dict[j], crate_column[2])
                   push!(crate_dict2[j], crate_column[2])
                end
            end
      
        # Apply the actual crate moves
        elseif i > 10
            # Get the moves
            crate_amt, from, to =  map(x -> parse(Int, x), getindex(split(line, ' '), [2,4,6]))
            # Apply the moves
            prepend!(crate_dict[to],reverse!(crate_dict[from][1:crate_amt]))
            prepend!(crate_dict2[to],crate_dict2[from][1:crate_amt])
            # Remove the crates from where we moved
            deleteat!(crate_dict[from], 1:crate_amt)
            deleteat!(crate_dict2[from], 1:crate_amt)
        end
    end
    # Sort dictionary by keys and extract top crate
    for (k,v) in sort(collect(crate_dict), by = x->x[1])
        print(v[1])
    end
    print("\n")
    # Part 2
    # Sort dictionary by keys and extract top crate
    for (k,v) in sort(collect(crate_dict2), by = x->x[1])
        print(v[1])
    end
end
