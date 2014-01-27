#!/usr/local/bin/ruby
# -*- co#ding: utf-8 -*-

module Img
    def resize(filename, size, dest_filename)
        require 'RMagick'
        begin
            img = Magick::ImageList.new(filename)
            img.resize!(size['width'], size['height'])
            img.write(dest_filename)
            return true
        rescue
            return false
        end
    end
    module_function :resize
end
