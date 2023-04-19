// Description:
//   holiday detector script

module.exports = function(robot) {
  robot.respond(/hi/i, function(msg){
      var today = new Date();

      msg.reply("hey");
  });
}