defmodule TextClient.Player do
    alias TextClient.{Mover, Prompter, State, Summary}

    def play(%State{tally: %{ game_state: :won}}), do: exit_with_msg "You WON!"

    def play(%State{tally: %{ game_state: :lost}}), do: exit_with_msg "Sorry, you lost!"

    def play(game = %State{tally: %{ game_state: :good_guess}}) do
        continue_with_msg(game, "Good guess!")
     end

    def play(game = %State{tally: %{ game_state: :bad_guess}}) do
        continue_with_msg(game, "Bad guess!")
    end

    def play(game = %State{tally: %{ game_state: :already_used}}) do
        continue_with_msg(game, "You've already used this letter")
    end

    def play(game), do: continue game

    def continue(game) do
        game
        |> Summary.display
        |> Prompter.accept_move
        |> Mover.make_move
        |> play

    end

    def prompt(game), do: game
    def make_move(game), do: game

    defp continue_with_msg(game, msg) do
        IO.puts msg
        continue game
    end
    defp exit_with_msg(msg) do
        IO.puts msg
        exit(:normal)
    end
end