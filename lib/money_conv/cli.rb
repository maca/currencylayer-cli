require 'thor'

module MoneyConv
  class Cli < Thor
    desc "1 euro mxn", "Convert currency"

    long_desc <<-DESC
      Convert currency

      If the input is unambigous the convertion will be printed to stdout
      otherwise the possible matches will be printed to stderr and the program will
      exit with a non zero exit code

      Examples:
        money_conv 10 euro mxn -t <your currency layer token>
        money_conv 10 euros to mxn pesos -t <your currency layer token>
        money_conv 10 euros to quetzal -t <your currency layer token>
        money_conv 10 British pound to mxn peso -t <your currency layer token>
        money_conv '10 euros to lebanese pounds' -t <your currency layer token>

      Options:
        -t --access_key
           For the time being a currency layer
           <https://currencylayer.com/> token has to be provided

      Todo:
        - Read access key from ENV variable or ~/config-file
        - Stemming for better matching plural currency names
    DESC

    option :access_key, type: :string, alias: :t, required: true

    def convert(first, *rest)
      args = rest.unshift first

      access_key = options[:access_key]
      converter  = Converter.new(access_key)

      if args.size == 3
        result = converter.convert(*args)
      else
        result = converter.parse(args.join(' '))
      end

      exit 1 unless result
      puts result
    end
  end
end
