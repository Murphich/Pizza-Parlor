<?php

	$DB_USERNAME = "a1246208_murph";
	$DB_PASSWORD = "mypizza12";
	$DB_NAME = "a1246208_pizza";
	
	// get username and password
	$u = $_POST['u'];
	$p = $_POST['p'];
	
	// see if request comes from a valid person
	// probably look in a user database, but for now just hard-code the check

	if ($u == "jdoe" && $p == "pword")
		{
		$qry = "select * from pizzaDb";
		
		mysql_connect("localhost", $DB_USERNAME, $DB_PASSWORD) OR DIE ("Unable to connect to database! Please try again later.");
		mysql_select_db($DB_NAME);
	
		$result = mysql_query($qry);
		
		if (numRows)
			{
			$rows = array();
			while($r = mysql_fetch_assoc($result)) {
				$rows[] = $r;
				}
		    print json_encode($rows);				
			}
		else
			print "Error: No records returned.";
		}
	else
		print "Error: Incorrect username/password.";

?>