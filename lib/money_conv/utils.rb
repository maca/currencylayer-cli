module MoneyConv
  module Utils
    extend self

    def permutations(code, curr_name)
      ary = curr_name.scan(/\p{word}+/).unshift(code)
      (1..ary.size).map { |size| ary.permutation(size) }
    end

    def compare(input, *args)
      DamerauLevenshtein.distance(input.downcase, args.join(' ').downcase, 0, 5)
    end

    def format_output(amount, code, name)
      "#{amount} #{code} (#{name})"
    end

    def error(str)
      STDERR.puts "\e[31m#{str}\e[0m"
    end

    def notice(str)
      STDERR.puts "\e[32m#{str}\e[0m"
    end
  end
end
