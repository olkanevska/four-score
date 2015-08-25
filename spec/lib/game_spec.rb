require "spec_helper"

module FourScore
  describe Game do

    let (:korben) { Player.new({name: "Korben", token: "X"}) }
    let (:leeloo) { Player.new({name: "Leeloo", token: "O"}) }
    let (:game) { Game.new([korben, leeloo]) }

    context "#initialize" do
      it "assigns players" do
        expect(game.current_player.name).to eq 'Korben'
        expect(game.next_player.name).to eq 'Leeloo'
      end
    end

    context "#switch_players" do
      it "switches players' turns" do
        game.switch_players
        expect(game.current_player.name).to eq 'Leeloo'
        expect(game.next_player.name).to eq 'Korben'
      end
    end

    context "#move_prompt" do
      it "outputs a string to prompt the current player" do
        expect(game.move_prompt.class).to eq String
        expect(game.move_prompt.include?(game.current_player.name)).to eq true
      end
    end

    context "#get_move" do
      it "returns an integer" do
        expect(game.get_move(1).is_a?(Integer)).to eq true
      end
    end

  end
end
