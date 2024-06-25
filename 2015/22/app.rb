#!/usr/bin/env ruby

require_relative 'effects'
require_relative 'spent'
require_relative 'boss'
require_relative 'wizard'

def play(active, passive, spent, effects, turn = 0)

  if ENV['PART'].to_i == 2
    return unless active.before_turn!
  end

  effects.active_at(turn).tap do |all|
    active.apply_all all
    passive.apply_all all
  end

  return active.win unless passive.alive?
  return passive.win unless active.alive?

  active.take_turn spent, effects, turn do |immediate|
    a, p = active.dup, passive.dup
    if immediate
      p.apply a, immediate
    end

    if p.alive?
      spent.amount = play(p, a, spent, effects, turn + 1)
    else
      spent.amount = a.win
    end
  end

  spent.amount
end

v = Hash[STDIN.read.lines.map {|line| line.split(/: /)}]

w = Wizard.new((ENV['POINTS'] || 50).to_i, (ENV['MANA'] || 500).to_i)
b = Boss.new(v['Hit Points'].to_i, v['Damage'].to_i)

puts play(w, b, Spent.new, Effects.new)
