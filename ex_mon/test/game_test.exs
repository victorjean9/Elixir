defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{computer: %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"}, player: %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Victor"}, status: :started, turn: :player}

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{computer: %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"}, player: %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Victor"}, status: :started, turn: :player}

      assert expected_response == Game.info()

      new_state = %{computer: %ExMon.Player{life: 85, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"}, player: %ExMon.Player{life: 50, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Victor"}, status: :started, turn: :player}

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "return the player info" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      player_expected = Game.player()

      expected_response = %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Victor"}

      assert player_expected == expected_response
    end
  end

  describe "turn/0" do
    test "return the current turn" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      turn_expected = Map.get(Game.info(),:turn)

      expected_response = :player

      assert turn_expected == expected_response
    end
  end

  describe "fetch_player/0" do
    test "return the fetched player info" do
      player = Player.build("Victor", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      player_expected = Game.fetch_player(:player)
      expected_player_response = %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Victor"}
      assert player_expected == expected_player_response

      computer_expected = Game.fetch_player(:computer)
      expected_computer_response = %ExMon.Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"}
      assert computer_expected == expected_computer_response
    end
  end
end
