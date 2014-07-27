npv <- function(years,outflow,inflow,interest) {
	inflow.series <- (inflow)/((1+interest)^(1:years))
	netpresentvalue <- (-(outflow)+sum(inflow.series))
	print(-outflow)
	print(inflow.series)
	print(sum(inflow.series))
	print(netpresentvalue)
	}