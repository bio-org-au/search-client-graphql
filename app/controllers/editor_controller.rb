# frozen_string_literal: true

# Controller
class EditorController < ApplicationController
  def toggle
    session[:editor] ||= false
    session[:editor] = !session[:editor]
    render js: "changeEditorSwitch(#{session[:editor]});"
  end
end
