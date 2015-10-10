class LiquidFilter
  def self.init
    Liquid::Template.register_filter(ArrayFilter)
  end

  module ArrayFilter
    def random(input, seed)
      input.shuffle(random: Random.new(seed))
    end
  end
end
