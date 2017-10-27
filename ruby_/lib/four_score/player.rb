module FourScore
  class Player
    attr_reader :name, :token
    def initialize(options)
      @name = options.fetch(:name)
      @token = options.fetch(:token)
    end
  end
end
