module DataMapperUtils
  def initialize(source_data)
    @data = source_data
  end

  private

  attr_reader :data
end