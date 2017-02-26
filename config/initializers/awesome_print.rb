unless Rails.env.production?
  require 'awesome_print'
  AwesomePrint.pry!
end