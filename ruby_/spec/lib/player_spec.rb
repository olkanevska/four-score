require 'spec_helper'

module FourScore
  describe Player do
    context 'initialize' do
      it 'should raise an error without proper options' do
        expect { Player.new }.to raise_error ArgumentError
      end

      it 'should have a name and token' do
        player = Player.new(name: 'Korben', token: 'X')
        expect(player.name).to eq 'Korben'
        expect(player.token).to eq 'X'
      end
    end
  end
end
