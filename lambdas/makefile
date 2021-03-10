# lambdas launcher
start-api:
	sam local start-api

hw:
	cd hello-world; sam local invoke "HelloWorldFunction" -e events/event.json

fn-a:
	cd lambda-a; sam local invoke "AFunction"
fn-b:
	cd lambda-b; sam local invoke "BpFunction"
