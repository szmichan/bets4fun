using Bets4Fun.Domain.Objects;
using System.Collections.Generic;

namespace Bets4Fun.Domain.Entities
{
    public class User : BaseEntity<int>
    {
        public string Login { get; set; }
        public string Email { get; set; }
        public ICollection<Bet> Bets { get; set; }

        public Bet MakeBet(Game game, ScoreDetails result)
        {
            var bet = Bet.Create(this, game, result);
            this.Bets.Add(bet);
            return bet;
        }
    }
}
