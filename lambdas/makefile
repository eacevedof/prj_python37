# lambdas launcher
start-api:
	sam local start-api

hw:
	cd hello-world; sam local invoke "HelloWorldFunction" -e events/event.json

fn-b-start:
	cd lambda-b; sam local start-lambda -p 3050 --debug

fn-a:
	cd lambda-a; sam local invoke "AFunction" --debug

fn-b:
	cd lambda-b; sam local invoke "BpFunction" --debug
