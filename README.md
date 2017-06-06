# Currency Layer API CLI

## Instalation

```
$ git clone https://github.com/maca/money_conv.git
$ cd money_conv
$ gem build money_conv.gemspec
$ gem install money_conv-0.1.0.gem
```

## Usage

Examples:

```
$ money_conv 10 usd mxn -t <your currency layer token> 
$ money_conv 10 euros to mxn pesos -t <your currency layer token>
$ money_conv 10 euros to quetzal -t <your currency layer token>
$ money_conv 10 British pound to mxn peso -t <your currency layer token>
$ money_conv '10 euros to lebanese pounds' -t <your currency layer token>
```

If the input is unambigous the convertion will be printed to stdout
otherwise the possible matches will be printed to stderr and the program will
exit with a non zero exit code

```
Options:
  -t --access_key
     For the time being a currency layer
     <https://currencylayer.com/> token has to be provided
```

Todo:
  - Read access key from ENV variable or ~/config-file
  - Stemming for better matching plural currency names
  - Improve cli interface and help

