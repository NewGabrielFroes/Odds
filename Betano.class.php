<?php
include("Platform.class.php");
class Betano extends Platform {
	private $field_type = "Betano";
	private $url = "https://br.betano.com/adserve?type=OddsComparisonFeed&lang=pt&sport=FOOT";

	public function __construct($pdo) {
		parent::__construct($pdo);
		$this->set_field_type($this->field_type);
		$this->set_url($this->url);
		$this->set_json_decoded($this->convert_json_to_object());
	} 

	public function run_through_json($decoded) {
		if($decoded) foreach ($decoded as $match) {
			$identifier_home_team = $match->teams[0]->id;
			$identifier_away_team = $match->teams[1]->id;

			$match_date = new DateTime($match->date);
			$match_date = $match_date->format('Y-m-d H:i:s');

			$home_team_id = $this->get_team_id_by_field_type__identifier($this->get_pdo(), $this->get_field_type(), $identifier_home_team);
			$away_team_id = $this->get_team_id_by_field_type__identifier($this->get_pdo(), $this->get_field_type(), $identifier_away_team);

			$fixtures_id = $this->get_fixture_id_by_home_team__away_team__datetime($this->get_pdo(), $home_team_id, $away_team_id, $match_date);

			$identifiers = [];
			$odds = [];

			if(!$home_team_id || !$away_team_id || !$fixtures_id) continue;
			else {
				if($match->market) foreach($match->market as $market) {	
					if($market->selections) foreach ($market->selections as $selection) {
						$identifier = $market->type . $selection->name;
						$odd = $selection->price;
						
						$this->populate_fixtures_markets__fixtures_markets_odds($this->get_pdo(), $this->get_field_type(), $identifier, $odd, $fixtures_id);
					}

				}
			}
		}
	}
}