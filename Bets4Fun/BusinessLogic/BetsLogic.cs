using System;
using System.ComponentModel;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class BetsLogic
    {
        private static BetsTableAdapter _adapter;
        public static BetsTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new BetsTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static DB.BetsDataTable GetBetsByUserLogin(string login)
        {
            return Adapter.GetBetsByUserLogin(login);
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.BetsDataTable GetBetsByGameId(int gameId)
        {
            return Adapter.GetBetsByGameId(gameId);
        }

        public static bool IsGameBetByUser(int gameId, int userId)
        {
            var betsCount = Adapter.CountBetsForUserInGame(gameId, userId);

            switch (betsCount)
            {
                case null:
                case 0:
                    return false;
                case 1:
                    return true;
                default:
                    throw new ZpException($"User with Id = '{userId}' bet Game with Id = '{gameId}' more than once.");
            }
        }

        /// <summary>
        /// if user did not bet game then null, throws ZPException if user bets game more than once
        /// </summary>
        /// <param name="gameId"></param>
        /// <param name="Login"></param>
        /// <returns></returns>
        public static DB.BetsRow GetBetByUserInGame(int gameId, int userId)
        {
            var bets = Adapter.GetBetsByUserInGame(gameId, userId);
            switch (bets.Count)
            {
                case 0:
                    return null;
                case 1:
                    return bets[0];
                default:
                    throw new ZpException(
                        $"User identified by Id = '{userId}' bet Game identified by Id = '{gameId}' more than once");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public static bool DeleteBet(int id)
        {
            return Adapter.Delete(id) == 1;
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static bool InsertBet(int gameId, int userId, int team1Score, int team2Score)
        {
            if (GetBetByUserInGame(gameId, userId) == null)
                return Adapter.Insert(gameId, userId, team1Score, team2Score, DateTimeOffset.Now) == 1;
            
            return false;
        }

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public static bool UpdateBet(int gameId, int userId, int team1Score, int team2Score, int id)
        {
            return Adapter.Update(gameId, userId, team1Score, team2Score, DateTimeOffset.Now, id) == 1;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public DB.BetsDataTable GetBetsByFilter(int? contestId, DateTimeOffset? betDateFrom,
            DateTimeOffset? betDateTo, DateTimeOffset? gameDateFrom, DateTimeOffset? gameDateTo, int? gameStatus, DateTimeOffset? date, string login)
        {
            return Adapter.GetBetsByFilter(contestId, betDateFrom, betDateTo, gameDateFrom, gameDateTo, gameStatus, date, login);
        }
    }
}
