using Bets4Fun.Domain.Objects;
using System;

namespace Bets4Fun.Domain.Entities
{
    public class Bet : BaseEntity<int>
    {
        public DateTime BetDate { get; set; }
        public User User { get; set; }
        public Game Game { get; set; }
        public ScoreDetails BetResult { get; set; }

        public void ChangeBetResult(ScoreDetails result)
        {
            this.BetResult = result;
        }

        public static Bet Create(User user, Game game, ScoreDetails result)
        {
            return new Bet()
            {
                BetDate = DateTime.UtcNow,
                User = user,
                Game = game,
                BetResult = result
            };
        }
    }
}
