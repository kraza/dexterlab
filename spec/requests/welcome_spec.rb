# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'spec_helper'
require 'capybara/rspec'

#require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WelcomeController do
  before(:each) do
    visit "/"
  end

  it 'welcomes the user' do
    #visit '/'
    page.should have_content('Welcome')
  end

end

