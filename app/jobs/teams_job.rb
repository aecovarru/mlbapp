class TeamsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @@team_params.each do |team_params|
      puts team_params[:name]
      Team.find_or_create_by(team_params)
    end
  end

    @@team_params = [
        { name: "Angels",       abbr: "LAA", alt_abbr: "ANA", city: "Los Angeles",   stadium: "Angels Stadium",            league: "AL", division: "West",    zipcode: "92806",   timezone: -3},
        { name: "Astros",       abbr: "HOU", alt_abbr: "HOU", city: "Houston",       stadium: "Minute Maid Park",          league: "AL", division: "West",    zipcode: "77002",   timezone: -1},
        { name: "Athletics",    abbr: "OAK", alt_abbr: "OAK", city: "Oakland",       stadium: "Oakland Coliseum",          league: "AL", division: "West",    zipcode: "94621",   timezone: -3},
        { name: "Blue Jays",    abbr: "TOR", alt_abbr: "TOR", city: "Toronto",       stadium: "Rogers Centre",             league: "AL", division: "East",    zipcode: "M5V 1J1", timezone: 0 },
        { name: "Braves",       abbr: "ATL", alt_abbr: "ATL", city: "Atlanta",       stadium: "Turner Field",              league: "NL", division: "East",    zipcode: "30315",   timezone: -1},
        { name: "Brewers",      abbr: "MIL", alt_abbr: "MIL", city: "Milwaukee",     stadium: "Miller Park",               league: "NL", division: "Central", zipcode: "53214",   timezone: -1},
        { name: "Cardinals",    abbr: "STL", alt_abbr: "SLN", city: "St Louis",      stadium: "Busch Stadium",             league: "NL", division: "Central", zipcode: "63102",   timezone: -1},
        { name: "Cubs",         abbr: "CHC", alt_abbr: "CHN", city: "Chicago",       stadium: "Wrigley Field",             league: "NL", division: "Central", zipcode: "60613",   timezone: -1},
        { name: "Diamondbacks", abbr: "ARI", alt_abbr: "ARI", city: "Arizona",       stadium: "Chase Field",               league: "NL", division: "West",    zipcode: "85004",   timezone: -3},
        { name: "Dodgers",      abbr: "LAD", alt_abbr: "LAN", city: "Los Angeles",   stadium: "Dodgers Stadium",           league: "NL", division: "West",    zipcode: "90012",   timezone: -3},
        { name: "Giants",       abbr: "SFG", alt_abbr: "SFN", city: "San Francisco", stadium: "AT&T Park",                 league: "NL", division: "West",    zipcode: "94107",   timezone: -3},
        { name: "Indians",      abbr: "CLE", alt_abbr: "CLE", city: "Cleveland",     stadium: "Progressive Field",         league: "AL", division: "Central", zipcode: "44115",   timezone: 0 },
        { name: "Mariners",     abbr: "SEA", alt_abbr: "SEA", city: "Seattle",       stadium: "Safeco Park",               league: "AL", division: "West",    zipcode: "98134",   timezone: -3},
        { name: "Marlins",      abbr: "MIA", alt_abbr: "MIA", city: "Miami",         stadium: "Marlins Park",              league: "NL", division: "East",    zipcode: "33125",   timezone: 0 },
        { name: "Mets",         abbr: "NYM", alt_abbr: "NYN", city: "New York",      stadium: "Citi Field",                league: "NL", division: "East",    zipcode: "11368",   timezone: 0 },
        { name: "Nationals",    abbr: "WSN", alt_abbr: "WAS", city: "Washington",    stadium: "Nationals Park",            league: "NL", division: "East",    zipcode: "20003",   timezone: 0 },
        { name: "Orioles",      abbr: "BAL", alt_abbr: "BAL", city: "Baltimore",     stadium: "Camden Yards",              league: "AL", division: "East",    zipcode: "21201",   timezone: 0 },
        { name: "Padres",       abbr: "SDP", alt_abbr: "SDN", city: "San Diego",     stadium: "Petco Park",                league: "NL", division: "West",    zipcode: "92101",   timezone: -3},
        { name: "Phillies",     abbr: "PHI", alt_abbr: "PHI", city: "Philadelphia",  stadium: "Citizens Bank Park",        league: "NL", division: "East",    zipcode: "19148",   timezone: 0 },
        { name: "Pirates",      abbr: "PIT", alt_abbr: "PIT", city: "Pittsburgh",    stadium: "PNC Park",                  league: "NL", division: "West",    zipcode: "15212",   timezone: 0 },
        { name: "Rangers",      abbr: "TEX", alt_abbr: "TEX", city: "Texas",         stadium: "Rangers Ballpark",          league: "AL", division: "East",    zipcode: "76011",   timezone: -1},
        { name: "Rays",         abbr: "TBR", alt_abbr: "TBA", city: "Tampa Bay",     stadium: "Tropicana Field",           league: "AL", division: "East",    zipcode: "33705",   timezone: 0 },
        { name: "Red Sox",      abbr: "BOS", alt_abbr: "BOS", city: "Boston",        stadium: "Fenway Park",               league: "AL", division: "Central", zipcode: "02215",   timezone: 0 },
        { name: "Reds",         abbr: "CIN", alt_abbr: "CIN", city: "Cincinnati",    stadium: "Great American Ball Park",  league: "NL", division: "West",    zipcode: "45202",   timezone: 0 },
        { name: "Rockies",      abbr: "COL", alt_abbr: "COL", city: "Colorado",      stadium: "Coors Field",               league: "NL", division: "Central", zipcode: "80205",   timezone: -2},
        { name: "Royals",       abbr: "KCR", alt_abbr: "KCA", city: "Kansas City",   stadium: "Kauffman Stadium",          league: "AL", division: "Central", zipcode: "64129",   timezone: -1},
        { name: "Tigers",       abbr: "DET", alt_abbr: "DET", city: "Detroit",       stadium: "Comerica Park",             league: "AL", division: "Central", zipcode: "48201",   timezone: 0 },
        { name: "Twins",        abbr: "MIN", alt_abbr: "MIN", city: "Minnesota",     stadium: "Target Field",              league: "AL", division: "Central", zipcode: "55403",   timezone: -1},
        { name: "White Sox",    abbr: "CHW", alt_abbr: "CHA", city: "Chicago",       stadium: "U.S. Cellular Field",       league: "AL", division: "Central", zipcode: "60616",   timezone: -1},
        { name: "Yankees",      abbr: "NYY", alt_abbr: "NYA", city: "New York",      stadium: "Yankee Stadium",            league: "AL", division: "East",    zipcode: "10451",   timezone: 0 },
        { name: "Marlins",      abbr: "FLA", alt_abbr: "FLO", city: "Florida",       stadium: "Sun Life Stadium",          league: "NL", division: "East",    zipcode: "33056",   timezone: 0 },
        { name: "Devil Rays",   abbr: "TBD", alt_abbr: "TBA", city: "Tampa Bay",     stadium: "Tropicana Field",           league: "AL", division: "East",    zipcode: "33705",   timezone: 0 },
        { name: "Expos",        abbr: "MON", alt_abbr: "MON", city: "Montreal",      stadium: "Olympic Stadium",           league: "NL", division: "East",    zipcode: "H1V 3N7", timezone: 0 },
        { name: "Angels",       abbr: "ANA", alt_abbr: "ANA", city: "Anaheim",       stadium: "Angels Stadium",            league: "AL", division: "West",    zipcode: "92806",   timezone: -3}
      ]
end
