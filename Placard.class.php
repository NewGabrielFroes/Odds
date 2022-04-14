<?php
class Placard extends Platform {
	private $field_type = "Placard";
	private $url = "http://localhost/odds/dados.json";

	public function __construct($pdo) {
		parent::__construct($pdo);
		$this->set_field_type($this->field_type);
		$this->set_url($this->url);
		$this->set_json_decoded($this->convert_json_to_object());
	}

	public function run_through_json($decoded) {
		if($decoded) foreach($decoded as $match) {
			if($match->sport != "Futebol") continue;

			$identifier_home_team = $match->homeTeam;
			$identifier_away_team = $match->awayTeam;

			$match_date = new DateTime($match->startDate);
			$match_date = $match_date->format('Y-m-d H:i:s');

			$home_team_id = $this->get_team_id_by_field_type__identifier($this->get_pdo(), $this->get_field_type(), $identifier_home_team);
			$away_team_id = $this->get_team_id_by_field_type__identifier($this->get_pdo(), $this->get_field_type(), $identifier_away_team);

			$fixtures_id = $this->get_fixture_id_by_home_team__away_team__datetime($this->get_pdo(), $home_team_id, $away_team_id, $match_date);

			$identifiers = ["1x2homeTeam", "1x2awayTeam", "1x2draw"];

			if(!$home_team_id || !$away_team_id || !$fixtures_id) continue;
			else {	
				if($match->markets) foreach($match->markets as $market) {	
					$market_prices = array_values((array) $market);
					
					$count = 0;
					if($market_prices) foreach($market_prices as $market_price) {
						$odd = $market_price;
						$identifier = $identifiers[$count];

						$this->populate_fixtures_markets__fixtures_markets_odds($this->get_pdo(), $this->get_field_type(), $identifier, $odd, $fixtures_id);
						
						$count++;
					}
				}
			}
		}
	}
}
