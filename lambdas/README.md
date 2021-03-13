- Comandos
```
sam build FunctionB --template "$HOME/projects/prj_python37/lambdas/lambda-b\template-roles.yaml" --build-dir "$HOME/lambda-builds/prj-python" --use-container --debug
sam local invoke FunctionB --template "$HOME\lambda-builds\prj-python\template.yaml" --event "$HOME/projects/prj_python37/lambdas/lambda-b/input.json"  --debug 
sam local start-lambda -p 3050 --template "$HOME/lambda-builds\prj-python\template.yaml"  --debug
```
