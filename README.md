## Hubot with slack adapter in Docker

Simple implementation, would recommend [https://github.com/minddocdev/hubot](https://github.com/minddocdev/hubot) for prod. 

I wanted one solution where I could commit the scripts instead of publishing them to NPM (and to play around it, and do it myself).

### Usage

- Add your own scripts to the `scripts` folder
- Set your wanted external *hubot* scripts in `external-scripts.json`
- Set your needed node libraries in the `EXTRA_PACKAGES` variable on `docker-compose.yml`
- Set `.env` file accordingly
- `make`
- ???
- PROFIT!!!