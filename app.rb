require 'sinatra'
<<<<<<< HEAD
require 'sinatra/json'
=======
require 'sinatra/base'
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
require 'mongoid'
require 'haml'
require './models'

Mongoid.load!("./mongoid.yml", :development)

enable :sessions

before do
  unless request.path_info == '/login'
    redirect '/login' if session[:auth].nil?
  end
<<<<<<< HEAD
  
  @auth = session[:auth]
=======
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
end

get '/assets/:static_file' do
  redirect :static_file
end

# => To login page
get '/login' do
  haml :login
end

# => Process login
post '/login' do
  u = User.authenticate(params[:username], params[:password])
  if u
    session[:auth] = u
    redirect '/'
  else
    @msg = 'Auth failed'
    haml :login
  end
end

# => Process logout
get '/logout' do
  session[:auth] = nil
  redirect '/login'
end

# => To /
get '/' do
<<<<<<< HEAD
=======
  @auth       = session[:auth]
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  @last_rep   = Report.where(:team => @auth.team, :order => Report.max(:order)).first
  @today_plan = ReportItem.where(:author => @auth, :date => Date.today).first
  haml :index
end

<<<<<<< HEAD
get '/teamview/?:order?' do |order|
  max_order     = Report.max(:order)
  @order        = (order || max_order).to_i
=======
get '/teamview' do
  @auth         = session[:auth]
  max_order     = Report.max(:order)
  @order        = (params[:order] || max_order).to_i
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  @last_rep     = Report.where(:team => @auth.team, :order => @order).first
  @reps_by_date = Report.sort_and_group_by_date(@last_rep)
  @has_next     = @order < max_order
  @has_prev     = @order > Report.min(:order)
  haml :teamview
end

# => Process request of add team
<<<<<<< HEAD
post '/team/new' do
  begin
    @team = Team.create params[:team]
    json :success => true, :team => @team
  rescue
    json :success => false
  end
end

get '/member/new' do
  @teams = Team.all
  haml :member_new
end

# => Process request of add memebers for a ateam
post '/member/new' do
=======
post '/team/add' do
  Team.create params[:team]
  redirect '/'
end

# => Process request of add memebers for a ateam
post '/members/add' do
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  User.create params[:user]
  redirect '/'
end

# => Process request of edit of add a reportitem to given report
<<<<<<< HEAD
get '/report/edit/:date/:repid' do |date,repid|
  # debugger
  @date = date
  begin
    @report = Report.find(repid)
=======
get '/report/edit/:date/:repid' do
  # debugger
  @auth = session[:auth]
  @date = params[:date]
  begin
    @report = Report.find(params[:repid])
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  rescue
    redirect '/' if @report.nil?
  end

<<<<<<< HEAD
  @reportItem = ReportItem.where(:report => @report, :date => date, :author => @auth).first
=======
  @reportItem = ReportItem.where(:report => @report, :date => @date, :author => @auth).first
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  if @reportItem.nil?
    haml :itemnew
  else
    haml :itemedit
  end
end

post '/reportitem/new' do
  ri     = ReportItem.create params[:item]
  redirect '/teamview?order='+ri.report.order.to_s unless ri.nil?
  @error = 'Failed'
  haml :itemnew
end

post '/reportitem/edit' do
  begin
    ri = ReportItem.find(params[:item][:_id])
  rescue
    redirect '/teamview' unless ri.nil?
  end
  ri.plan,ri.complete = params[:item][:plan],params[:item][:complete]
  ri.update
  redirect '/teamview?order='+ri.report.order.to_s unless ri.nil?
end

get '/report/new' do
<<<<<<< HEAD
=======
  @auth  = session[:auth]
>>>>>>> 50c47b082ce838e7a4b047a02c1cf37636d64f35
  @order = Report.max(:order).to_i + 1
  haml :report_new
end

post '/report/new' do
  Report.create params[:report]
  redirect '/teamview'
end


helpers do
  def iterate_time_by_day(start_date,end_date)
    days = []

    while start_date <= end_date
    days << start_date
    start_date += 1
  end

  days
end
end