require "sinatra"
require "json"
require "pry"

def teams_data
  unprocessed_data = File.read("roster.json")
  JSON.parse(unprocessed_data)
end

get "/" do
  redirect "/teams"
end

get "/teams" do
  erb :"teams/index", locals: { team_names: teams_data.keys }
end

get '/teams/:team_name' do
  team_name = params[:team_name]
  erb :"teams/show", locals: { team_name: team_name, roster: teams_data[team_name] }
end

get "/positions" do
  first_team_roster = teams_data.values.first
  positions = first_team_roster.keys
  erb :"positions/index", locals: { positions: positions }
end

get "/positions/:position_name" do
  position = params[:position_name]
  erb :"positions/show", locals: { position: position, teams_data: teams_data }
end
