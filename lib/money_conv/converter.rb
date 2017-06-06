module MoneyConv
  class Converter
    attr_reader :client, :currencies

    def initialize(token)
      @client = ApiClient.new(token)
    end

    def convert(amount, from_str, to_str)
      from_ary = curencies_for(from_str)
      to_ary   = curencies_for(to_str)
      input_is_ambigous = from_ary.size > 1 || to_ary.size > 1

      if input_is_ambigous
        Utils.error "I got a few results for you, but the input is ambigous"
      end

      Utils.notice generate_table(amount, from_ary, to_ary)

      return if input_is_ambigous
      from, _ = from_ary.first
      to, _   = to_ary.first
      client.convert(amount, from, to)
    end

    def parse(input)
      if match = input.match(/(\d+(?:.\d+)?) (.+)( to )(.+)/)
        _, amount, from, _, to = match.to_a
        convert(amount, from, to)
      end
    end

    private

    def generate_table(amount, from_ary, to_ary)
      Terminal::Table.new do |table|
        from_ary.each do |from, from_name|
          to_ary.each do |to, to_name|
            conversion = client.convert(amount, from, to)
            input  = Utils.format_output(amount.to_f, from, from_name)
            output = Utils.format_output(conversion, to, to_name)
            table << [input, output]
          end
        end
      end
    end

    def curencies_for(input)
      currencies = matched_currencies(input)

      if currencies.empty?
        Utils.error "I could not figure the currency `#{input}`"
        exit 1
      end

      currencies
    end

    def matched_currencies(input)
      currencies.inject([]) do |ary, curr|
        code, name = curr
        return [curr] if code == input.upcase

        perms = Utils.permutations(code, name)
        [Array(code), *perms].each do |enum|
          enum.each do |elem|
            dist = Utils.compare(input, elem)
            ary.push([dist, curr]) if dist < 3
          end
        end

        ary
      end.sort_by(&:first).map(&:last).uniq.take(10)
    end

    def currencies
      @map ||= client.currencies
    end
  end
end
