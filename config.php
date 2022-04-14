<?php
function connect() {
	$host = 'localhost';
	$user = 'oddsuser';
	$password = 'Bk4Ax-TMG5NtR*-7';
	$db = 'odds'; 
	

	try {
		return new PDO("mysql:host=$host;dbname=$db", $user, $password);
	}
	catch(PDOException $i) {
		die('Erro: <code>' . $i->getMessage() . '</code>');
	}
	catch(Exception $i) {
		die('Erro: <code>' . $i->getMessage() . '</code>');
	}
}
