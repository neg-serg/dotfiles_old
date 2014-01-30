-- ion3 configuration for my jackd utility workspace.

-- Title	Class	Instance
--
-- QJackConnect	Qjackconnect	qjackconnect

defwinprop{
	class = "Qjackconnect",
	instance = "qjackconnect",
	target = "jackutil"
}

defwinprop{
	class = "Qjackctl",
	instance = "qjackctl",
	target = "jackutil"
}
