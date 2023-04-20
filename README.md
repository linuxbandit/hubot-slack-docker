## Hubot with slack adapter in Docker

### Usage

- Add your own scripts to the `scripts` folder
- Set `.env` file accordingly
- `make build`
- `make`

### Heroku deployment

```bash
appname=devopsbot
container=hubot

heroku access --app $appname
heroku container:login
heroku container:push $container --app $appname
heroku container:release $container --app $appname
cat .env | xargs heroku config:set --app $appname &> /dev/null
heroku logs --app $appname
```
