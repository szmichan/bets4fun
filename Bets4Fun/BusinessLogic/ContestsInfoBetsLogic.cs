using Bets4Fun.DBTableAdapters;
using System.ComponentModel;

namespace Bets4Fun.BusinessLogic
{
    public class ContestsInfoBetsLogic
    {
        private static ContestsInfoBetsTableAdapter _adapter;
        public static ContestsInfoBetsTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new ContestsInfoBetsTableAdapter();
        }


        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static bool InsertContestInfoBet(int contestInfoId, int userId, int contestInfoOptionId)
            => Adapter.Insert(contestInfoId, userId, contestInfoOptionId) == 1;
    }
}