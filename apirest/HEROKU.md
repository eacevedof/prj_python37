## [Youtube Python Django Tutorial: Deploying Your Application (Option #2) - Deploy using Heroku](https://youtu.be/6DI_7Zja8Zc?t=744)
> By Corey Schafer - Publicado el 19 feb. 2019

#### commands:
- `heroku create prj-apirest --buildpack heroku/python`
    - `heroku apps:delete --app tfw-firstapp`
- `heroku open -a <appname>`
    - [https://prj-apirest.herokuapp.com/](https://prj-apirest.herokuapp.com/)

- `git subtree push --prefix apirest heroku master`
    - Define un subdirectorio como un subrepo
    - No lo he dejado terminar porque no se que consecuencias puede traer
    - `https://git.heroku.com/prj-apirest.git`

- `heroku git:remote -a prj-apirest`
- `git push heroku master` 
    - **error:**
    ```sh
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> App not compatible with buildpack: https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/python.tgz
    remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
    remote:
    remote:  !     Push failed
    remote: Verifying deploy...
    remote:
    remote: !       Push rejected to prj-apirest.
    remote:
    To https://git.heroku.com/prj-apirest.git
    ! [remote rejected] master -> master (pre-receive hook declined)
    error: failed to push some refs to 'https://git.heroku.com/prj-apirest.git'    
    ```

## Errores:


