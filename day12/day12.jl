open("day12_input.txt") do file
    lines = eachline(file)
    grid = Vector[]

    # Construct grid matrix
    for line in lines
        hill_vector = Int[]
        for char in line
            # Find start
            if Int(char) - Int('a') == -14
                push!(hill_vector, 0)
            # Find end
            elseif Int(char) - Int('a') == -28
                push!(hill_vector, 26)
            else
                push!(hill_vector, Int(char) - Int('a'))
            end
        end
        push!(grid, hill_vector)
    end
    grid_matrix = mapreduce(permutedims, vcat, grid)  
    
    
    # Grab start pos
    starting_positions = findall( x-> x == 0, grid_matrix)
  
    # Breadth-first search. Initialise queue of what to visit next and array of visited
    queue = []
    visited = []

    # Initialise queue with first node
    global_minimum_steps = Inf
    initial_minimum_steps = 0
    for starting_position in starting_positions
        visited = []
        queue = []
        push!(queue, (starting_position, 0))
        while !isempty(queue)

            # Pop the element in the queue
            q, dist = popfirst!(queue)
            # Return the goal if it's met
            if grid_matrix[q] == 26
                if dist < global_minimum_steps
                    println("Current global minimum", ' ', global_minimum_steps)
                    global_minimum_steps = dist
                end
                # Part 1
                if initial_minimum_steps == 0
                    initial_minimum_steps = dist
                end
                break
            elseif any(map(x -> x == Tuple(q), visited))
                continue
            end

            # Add node to visited
            push!(visited, Tuple(q))

            # Run check on adjacent vertices
            for (dx,dy) in [(1,0), (0,1), (-1,0), (0, -1)]
                # Ensure we only check within the defined grid
                if (1 <= Tuple(q)[1] + dx <= size(grid_matrix)[1]) && (1 <= Tuple(q)[2] + dy <= size(grid_matrix)[2])
                    # # Check if the elevation change isn't too big from the initial position
                    if grid_matrix[Tuple(q)[1] + dx, Tuple(q)[2] + dy] -  grid_matrix[Tuple(q)[1], Tuple(q)[2]] <= 1
                            push!(queue, (CartesianIndex((Tuple(q)[1] + dx, Tuple(q)[2] + dy)), dist + 1))
                    end
                end
            end
        end
    end
    println("Initial minimum", ' ', initial_minimum_steps)
    println("Final global minimum", ' ', global_minimum_steps)
end