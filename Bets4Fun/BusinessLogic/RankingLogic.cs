using Bets4Fun.DBTableAdapters;
using System.ComponentModel;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class RankingLogic
    {
        private static RankingAdapter _adapter;
        public static RankingAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new RankingAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static DB.RankingDataTable GetRanking(int leagueId, int contestId) 
            => Adapter.GetRanking(leagueId, contestId);
    }
}
