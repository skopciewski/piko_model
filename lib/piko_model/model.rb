# encoding: utf-8

# Copyright (C) 2016 Szymon Kopciewski
#
# This file is part of PikoModel.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "dothash"
require "forwardable"

module PikoModel
  class Required; end

  class Model
    extend Forwardable

    attr_reader :missing_fields
    @@registered_fields = []
    def_delegators :@values, :[], :fetch, :each, :each_pair, :to_h, :to_hash, :to_a

    def self.field(name, default: Required)
      @@registered_fields << { name: name, default: default }
    end

    def initialize(params = {})
      @values = {}
      @missing_fields = []
      fill_data(Dothash::Hash.with_dots(params))
    end

    def valid?
      @missing_fields.empty?
    end

    private

    def fill_data(params)
      @@registered_fields.each do |field|
        value = params.fetch(field[:name], field[:default])
        if value == Required
          @missing_fields << field[:name]
        else
          @values[field[:name]] = value
        end
      end
    end
  end
end
