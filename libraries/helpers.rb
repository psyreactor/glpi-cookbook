# Encoding: utf-8
require 'base64'

module Glpi
# helper Glpi
  module Helpers
    def glpi_encrypt(password)
      result = ''
      key = [167, 71, 76, 80, 73, 194, 163, 105, 39, 115, 110, 97, 114, 115, 115, 39, 195, 167, 71, 76, 80, 73, 194, 163, 105, 39, 115, 110, 97, 114, 115, 115, 39, 195, 167, 71, 76, 80, 73, 194]
      (password.length).times do |i|
        char = password[i, 1]
        char = (char.ord + key[i])
        char = char % 256 if char > 256
        result += char.chr
      end
      Base64.encode64(result)
    end
  end
end

Chef::Recipe.send(:include, Glpi::Helpers)
