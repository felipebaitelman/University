class PlansController < ApplicationController
  include Authorize

  before_action :logged

  def start
  end

  def display
    @programs = Program.all
    @programs = Program.all.as_json(:include =>
                               {:sound_sequences => {:only => [:order],
                                                     :include => {:sound => {:only => [:name, :description, :duration, :id],
                                                                             :methods => [:sound_url]
                                                     }}}},
                           :only => [:name, :description, :id])
    @current_sounds = Hash.new
    Program.all.each do | program |
      @current_sounds[program.id] = 1
    end
    current_user.programs.each do |program|
      aux = UserProgram.where(user_id:current_user.id, program_id: program.id).first
      if aux
        @current_sounds[program.id] = aux.current_sound
      end
    end
  end
end
