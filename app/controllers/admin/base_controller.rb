class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :require_login
end