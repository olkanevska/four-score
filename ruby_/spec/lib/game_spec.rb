require "spec_helper"

module FourScore
  describe Game do

    let (:korben) { Player.new({name: "Korben", token: "X"}) }
    let (:leeloo) { Player.new({name: "Leeloo", token: "O"}) }
    let (:game) { Game.new([korben, leeloo]) }

    describe "PUBLIC METHODS" do

      context "#initialize" do
        it "assigns players" do
          expect(game.current_player.name).to eq 'Korben'
          expect(game.next_player.name).to eq 'Leeloo'
        end
      end

    end

    describe "PRIVATE METHODS" do

      context "#switch_players" do
        it "switches players' turns" do
          game.send(:switch_players)
          expect(game.current_player.name).to eq 'Leeloo'
          expect(game.next_player.name).to eq 'Korben'
        end
      end

      context "#move_prompt" do
        it "outputs a string to prompt the current player" do
          expect(game.send(:move_prompt).class).to eq String
          expect(game.send(:move_prompt).include?(game.current_player.name)).to eq true
        end
      end

      context "#open_prompt" do
        it "outputs a string to prompt for an open column" do
          expect(game.send(:open_prompt, 1).include?('1')).to eq true
          expect(game.send(:open_prompt, 1).include?('open')).to eq true
        end
      end

    end
  end
end
