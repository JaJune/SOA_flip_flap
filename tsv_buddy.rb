# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  attr_accessor :data
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @data = []
    lines = []
    tsv.each_line do |line|
      lines << line
    end
    key = lines[0].split("\t")
    key.map!(&:chomp)

    value_lines = lines[1..-1]
    value_lines.each do |line|
      value = line.split("\t")
      result = {}
      key.each_index do |index|
        result[key[index]] = value[index].chomp
      end
      @data << result
    end
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    first_line = @data[0].keys
    result = @data.map! { |results| results.values.join("\t") }
    ([first_line.join("\t")] + result).join("\n") + "\n"
  end
end
