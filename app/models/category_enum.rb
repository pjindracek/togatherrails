class CategoryEnum
  @@categories = [
      {symbol: :culture, label: 'Culture'},
      {symbol: :business, label: 'Business'},
      {symbol: :sport, label: 'Sport'},
      {symbol: :social, label: 'Social'},
      {symbol: :family, label: 'Family'},
      {symbol: :religion, label: 'Religion'},
      {symbol: :food, label: 'Food'},
      {symbol: :technology, label: 'Technology'},
      {symbol: :hobbies, label: 'Hobbies'},
      {symbol: :pets, label: 'Pets'}
  ].freeze

  def self.categories
    @@categories
  end

  def self.label(symbol)
    begin
      @@categories.select { |item| item[:symbol] == symbol }.first[:label]
    rescue
      exception
    end
  end

  def self.index(symbol)
    begin
      @@categories.index { |item| item[:symbol] == symbol }
    rescue
      exception
    end
  end

  def self.[](index)
    @@categories[index][:symbol]
  end

  private

  def self.exception
    raise 'Such category does not exist!'
  end

end