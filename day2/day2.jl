open("day2_input.txt") do file
    # Dict of equipment score and what it loses to
    score_loser_dict = Dict(
        "X" => (1, "Y"),
        "Y" => (2, "Z"),
        "Z" => (3, "X"),
        )

    # Initialise scores
    score = 0
    score2 = 0

    lines = eachline(file)
    for line in lines
        opponent, me = split(line)

        ## Part 1
        # Grab the equipment score
        score += score_loser_dict[me][1]

        # See if I won or not. Firstly, translate the opponents equipment to my equipments relation.
        opponent_translated = string("XYZ"[first(findfirst(opponent, "ABC"))])
        # Check if my opponents equipment is the same as mine
        if me == opponent_translated
            score += 3
            println("I drew")
        # If it's not the same, check if it's the winning equipment
        elseif score_loser_dict[me][2] != opponent_translated
            score += 6
            println("I won")
        else
            println("I lost")
        end

        ## Part 2
        # See if I need to lose, draw or win
        # I need to win
        if me == "Z"
            score2 += 6
            # This is the equipment to win with
            my_equipment = score_loser_dict[opponent_translated][2]
            # Grab the equipment score
            score2 += score_loser_dict[my_equipment][1]
        # I need to draw
        elseif me == "Y"
            score2 += 3
            # Grab the equipment score using my opponent's equipment to ensure a draw
            score2 += score_loser_dict[opponent_translated][1]
        # I need to lose
        else 
            # Grab the equipment that isn't my opponents (draw) and which doesn't win me the duel
            my_equipment = [x for x in collect(keys(score_loser_dict)) if !(x in [opponent_translated, score_loser_dict[opponent_translated][2]])][1]
            # Grab the equipment score
            score2 += score_loser_dict[my_equipment][1]
        end
    end
    println("My total score is $(score)")
    println("My total score with the new rules is $(score2)")
end
