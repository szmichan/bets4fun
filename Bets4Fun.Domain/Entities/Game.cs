using Bets4Fun.Domain.Objects;
using System;

namespace Bets4Fun.Domain.Entities
{
    public class Game : BaseEntity<int>
    {
        public DateTime StartDate { get; set; }
        public Competition Competition { get; set; }
        public Team HostTeam { get; set; }
        public Team GuestTeam { get; set; }
        public ScoreDetails ScoreDetails { get; set; }
        public BettingDetails BettingDetails { get; set; }
    }
}
