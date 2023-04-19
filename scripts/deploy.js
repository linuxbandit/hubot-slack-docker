const validServices = ['api','app'];
const validEnvironments = ['production'];
robot.hear (`@${process.env.BOT_ID}`,async (bot) => {
    // Bot is only interested in listening message 
    // like @deploy api featurex to production 
    // Setting up reusable variable
	  const payload = bot.message.text.split(" ")
    const service = payload[2];
    const branch = payload[3];
    const environment = payload[5];
    const username = bot.message.user.name;
    //Inform user that we processing
    bot.send(`Roger that! Please wait.`);
// Validate if the command that has been used is valid or not 
// because user can use invalid commands too 
if(!validateCommand(bot,username,service,branch,environment)) {
      return;
    }
    // If command seems valid, then trigger a workflow
    await triggerWorkflow(bot,username,service,environment,branch)
    
    // Inform user that workflow has been triggered successfully
    bot.send(`Github Action has been triggered successfully`);
  })
  const validateCommand = (bot,username,service,branch,environment) => {
    // Limit the services as users can use services that are not listed 
    // which will try to trigger workflow and gets error
    if(!validServices.includes(service)) {
       bot.send(`${service} is not available, Only ${validServices.join(', ')} are available`);
      return false;
      }
      // Limit the environment as users can use invalid list of environment too
      if(!validEnvironments.includes(environment)) {
        bot.send(`${environment} is not available. Only ${validEnvironments.join(', ')} are available`);
        return false;
      }
      return true;
  }

  const triggerWorkflow = (bot,username,service,environment,branch) => {
    try {
      // This is the same manual workflow triggering code converted 
      // from curl to actual javascript post request
      const data = await axios.post(`https://api.github.com/repos/JosiahSiegel/hubot-slack-docker/dispatches`,{
        'event_type': 'chatops-service',
        'client_payload': {'validate': true, 'message': "Hello!", 'environment': environment, 'ref': branch}
      },{headers:{
      Authorization: `token ${token}`,
      }})
    }
      catch(e) {
        bot.send(`Sorry @${username} could not trigger github action. Please check my logs ${e.message}`);
      }
  }