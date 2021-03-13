# lambdas launcher
start-api:
	sam local start-api

hw:
	cd hello-world; sam local invoke HelloWorldFunction -e events/event.json

a-build:
	sam build MyFunctionA --template $(HOME)/projects/prj_python37/lambdas/lambda-a/template.yaml --build-dir $(HOME)/projects/lambda-builds/prj-python/l-a --use-container --debug

a-invoke:
	sam local invoke MyFunctionA --template $(HOME)/projects/lambda-builds/prj-python/l-a/template.yaml --event $(HOME)/projects/prj_python37/lambdas/lambda-a/input.json  --debug

a-start:
	sam local start-lambda -p 3050 --template $(HOME)/projects/lambda-builds/prj-python/l-a/template.yaml  --debug

b-build:
	sam build MyFunctionB --template $(HOME)/projects/prj_python37/lambdas/lambda-b/template.yaml --build-dir $(HOME)/projects/lambda-builds/prj-python/l-b --use-container --debug

b-invoke:
	sam local invoke MyFunctionB --template $(HOME)/projects/lambda-builds/prj-python/l-b/template.yaml --event $(HOME)/projects/prj_python37/lambdas/lambda-b/input.json  --debug

b-start:
	sam local start-lambda -p 3050 --template $(HOME)/projects/lambda-builds/prj-python/l-b/template.yaml  --debug
