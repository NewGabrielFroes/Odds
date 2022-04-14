<?php
class Placard extends Platform {
	private $field_type = 'Placard';
	private $url = 'https://api.oddsplacardpt.com/api/odds/events/global/all/all/all/all/all/all/all/all';


	public function __construct($pdo) {
		parent::__construct($pdo);
		$this->set_field_type($this->field_type);
		$this->set_url($this->url);
		$this->set_json_decoded($this->convert_json_to_object());
	}


	public function run_through_json($decoded) {
		if($decoded) foreach($decoded as $match) {
			if($match->sport != 'Futebol' || !property_exists($match, 'homeTeam')) continue;

			$identifier_home_team = $match->homeTeam;
			$identifier_away_team = $match->awayTeam;

			$match_date = new DateTime($match->startDate);
			$match_date = $match_date->format('Y-m-d H:i:s');

			$home_team_id = $this->get_team_id_by_field_type__identifier($this->get_field_type(), $identifier_home_team);
			$away_team_id = $this->get_team_id_by_field_type__identifier($this->get_field_type(), $identifier_away_team);

			$fixtures_id = $this->get_fixture_id_by_home_team__away_team__datetime($home_team_id, $away_team_id, $match_date);

			if(!$home_team_id || !$away_team_id || !$fixtures_id) continue;
			else {	
				if($match->markets) foreach($match->markets as $market_name => $market_selections) {	

					if($market_selections) foreach($market_selections as $market_selection => $odd) {
						$market_identifier = $market_name . $market_selection;

						$market_identifier = str_replace($identifier_home_team, 'homeTeam', $market_identifier);
						$market_identifier = str_replace($identifier_away_team, 'awayTeam', $market_identifier);

						$this->populate_fixtures_markets__fixtures_markets_odds($this->get_field_type(), $market_identifier, $odd, $fixtures_id);
					}

				}
			}
		}
	}
}
