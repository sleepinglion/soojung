# encoding: utf-8

class BoardController < ApplicationController
  impressionist :actions=>[:show]
  before_action :authenticate_user!, :except => [:index,:show]
 
  def initialize(*params)
    super(*params)
    @script="board/index"
    @controller_name='게시판'
  end
end