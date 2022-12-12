open("day10_input.txt") do file
    lines = eachline(file)
    # Initialise x_register values
    x_register_values = []
    x_register_value = 1
    # Initialise tick values and tick vector to track when additions should occur
    tick = 0
    tick_vector = []
    # Part 2
    crt_vector = []
    current_crt_vector = []

    # Construct operation vector
    for (i,line) in enumerate(lines)
        if occursin("addx", line)
            # Append when to apply the operation and what the operation does
            if !isempty(tick_vector)
                push!(tick_vector, (tick_vector[i-1][1]+2, parse(Int,split(line,' ')[2])))
            else
                push!(tick_vector, (tick+2,  parse(Int,split(line,' ')[2])))
            end
        else
            if !isempty(tick_vector)
                push!(tick_vector, (tick_vector[i-1][1]+1, 0))
            else
                push!(tick_vector, (tick+1, 0))
            end
        end
        tick +=1
    end

    # Tick through operations
    tick = 1
    signal_strength = 0
    crt_row = 0

    while tick <= 240
        
        # Part 1: Grab signal strength
        if tick in [20,60,100,140,180,220]
            signal_strength += (tick * x_register_value)
        end

        # Part 2: Sprite position
        sprite_position = collect(range(x_register_value-1, x_register_value+1))

        # Reset crt vector on every 40th tick
        if tick % 40 == 0
            if tick-(40*crt_row)-1 in sprite_position
                push!(current_crt_vector, "#")
            else
                push!(current_crt_vector, ".")
            end
            crt_row +=1
            # Push current crt vector to crt vector then reset
            push!(crt_vector, current_crt_vector)
            current_crt_vector = []
        else
            if tick-(40*crt_row)-1 in sprite_position
                push!(current_crt_vector, "#")
            else
                push!(current_crt_vector, ".")
            end
        end
        # Apply to register
        operation_to_apply_idx = map(x->x[1] == tick, tick_vector)
        if any(operation_to_apply_idx)
            # Apply operation to register
            x_register_value += tick_vector[operation_to_apply_idx][1][2]
        end
        # Push register value and cycle to register vector
        push!(x_register_values, (tick, x_register_value))
        tick +=1
    end
    println(signal_strength)

    # Write to file to visualise
    open("day10_output.txt","a") do io
        for crt_row in crt_vector
            for (i,char) in enumerate(crt_row)
                print(io,char)
                if i==40
                    print(io,'\n')
                end
            end
        end
    end

end