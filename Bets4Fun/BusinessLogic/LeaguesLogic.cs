using System.ComponentModel;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class LeaguesLogic
    {
        private static LeaguesTableAdapter _adapter;

        public static LeaguesTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new LeaguesTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static DB.LeaguesDataTable GetLeagues() 
            => Adapter.GetLagues();

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.LeaguesDataTable GetUserLeagues(int userId, int contestId) 
            => Adapter.GetUserLeagues(userId, contestId);

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.LeaguesDataTable GetNotUserLeagues(int userId, int contestId) 
            => Adapter.GetNotUserLeagues(userId, contestId);

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static int GetUsersCountInLeague(int leagueId) 
            => (int)Adapter.GetUsersCountInLeague(leagueId);

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.LeaguesRow GetLeagueById(int id)
        {
            var table = Adapter.GetByID(id);

            switch (table.Rows.Count)
            {
                case 1:
                    return table[0];
                case 0:
                    return null;
                default:
                    throw new ZpException($"There is more than one League with the same Id = {id}");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public bool AddLeague(int contestId, string name, bool bettingForMoney, decimal? entryFee) 
            => Adapter.Insert(contestId, name, bettingForMoney, entryFee) == 1;

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public bool UpdateLeague(int contestId, string name, bool bettingForMoney, decimal? entryFee, int id) 
            => Adapter.Update(contestId, name, bettingForMoney, entryFee, id) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool DeleteLeague(int id) 
            => Adapter.Delete(id) == 1;
    }
}