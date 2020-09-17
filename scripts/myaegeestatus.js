// Description:
//   Query services status - simple reading of my.aegee.eu/status
//
//   Examples:
//   - `hubot what is the status of frontend` - Get status of frontend
//   - `hubot what is the status of core` - Get status of core
//   - `hubot what is the status of events` - Get status of events
//   - `hubot what is the status of statutory` - Get status of statutory
//   - `hubot what is the status of discounts` - Get status of discounts
//   - `hubot what is the status of mailer` - Get status of mailer
//
// Commands:
//   hubot what is the status of (frontend|core|events|statutory|discounts|mailer)
//
// Author:
//   https://github.com/linuxbandit

module.exports = (robot) => {
  robot.hear(/what is the status of (frontend|core|events|statutory|discounts|mailer)/i, (res) => {
      
      const service = res.match[1]
      const base_url = "https://my.aegee.eu"
      const path = (service === "frontend" ? "/healthcheck" : `/api/${service}/healthcheck`)

      robot.http(base_url + path)
        .header('Accept', 'application/json')
        .get() ( (err, response, body) => {

        // err & response status checking code here
        if (err != null || response.headers['content-type'].indexOf('application/json') === -1) {
          robot.logger.error(err)
          return res.send("An error occurred, or the answer was not JSON :(")
        }

        try {
          const data = JSON.parse(body)
          let health = data.success ? 'HEALTHY :ok:' : ':warning: UNHEALTHY :warning:'
          return res.send(`Service ${service} is ${health}`)
        } catch (error) {
            robot.logger.error(error)
            return res.send("Ran into an error parsing JSON :(")
        }
      })
  })

}
