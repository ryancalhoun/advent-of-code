require 'fiddle'

module Spellbook
  def self.load
    Dir['*.so'].map do |lib|
      load_lib lib
    end
  end

  def self.load_lib(lib)
    l = Lib.new lib

    Class.new do
      define_method :initialize do |t|
        @t = t
        @l = l
      end

      def active_at?(t)
        if @l.duration
          (1..@l.duration).include? t - @t
        else
          @t == t
        end
      end

      def method_missing(name, *args, &block)
        @l.method(name).call *args, &block rescue nil
      end
    end
  end

  class Lib
    attr_reader :name, :cost, :damage, :armor, :heal, :duration, :mana
    def initialize(lib)
      Fiddle.dlopen(File.expand_path lib).tap do |h|
        @name = call(h, 'name', Fiddle::TYPE_VOIDP).to_s
        @cost = call(h, 'cost')
        @damage = call(h, 'damage')
        @heal = call(h, 'heal')
        @armor = call(h, 'armor')
        @mana = call(h, 'mana')
        @duration = call(h, 'duration')

        h.close
      end
    end
    def call(handle, name, type = Fiddle::TYPE_INT)
      begin
        Fiddle::Function.new(handle[name], [], type).call
      rescue
      end
    end
  end
end

