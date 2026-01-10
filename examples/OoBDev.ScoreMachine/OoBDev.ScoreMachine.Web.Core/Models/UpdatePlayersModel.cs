namespace OoBDev.ScoreMachine.Web.Core.Models
{
    public class UpdatePlayersModel
    {
        public PlayerModel Left { get; set; }
        public PlayerModel Right { get; set; }
        public string Match { get; set; }
        public string Weapon { get; set; }
    }
}
