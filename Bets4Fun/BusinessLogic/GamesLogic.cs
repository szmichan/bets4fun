using System;
using System.ComponentModel;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class GamesLogic
    {
        private static GamesTableAdapter _adapter;
        protected static GamesTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new GamesTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public DB.GamesDataTable GetGames() 
            => Adapter.GetGames();

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public DB.GamesDataTable GetGamesDesc() 
            => Adapter.GetGamesDesc();

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static DB.GamesDataTable GetGamesWithUserBet(string login)
        {
            var user = UsersLogic.GetUserByLogin(login);
            return user != null ? Adapter.GetGamesWithUserBet(user.Id) : null; 
        }

        [DataObjectMethod(DataObjectMethodType.Insert,true)]
        public bool AddGame(int contestId, int? team1Id, int? team2Id, DateTimeOffset? gameDate, int? team1Score, int? team2Score, string description, decimal? team1Points, decimal? team2Points, decimal? drawPoints, decimal? multiplyValue, string team1Alternate, string team2Alternate)
            => Adapter.Insert(contestId, team1Id, team2Id, gameDate, team1Score, team2Score, description, team1Points, team2Points, drawPoints, multiplyValue, team1Alternate, team2Alternate, null, null) == 1;

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public bool UpdateGame(int contestId, int? team1Id, int? team2Id, DateTimeOffset? gameDate, int? team1Score, int? team2Score, string description, decimal? team1Points, decimal? team2Points, decimal? drawPoints, decimal? multiplyValue, string team1Alternate, string team2Alternate,  int id) 
            => Adapter.Update(contestId, team1Id, team2Id, gameDate, team1Score, team2Score, description, team1Points, team2Points, drawPoints, multiplyValue, team1Alternate, team2Alternate, null, id) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool DeleteGame(int id)
            =>  Adapter.Delete(id) == 1;

        public static DB.GamesRow GetGameById(int id)
        {
            var games = Adapter.GetGameById(id);

            switch (games.Count)
            {
                case 0:
                    return null;
                case 1:
                    return games[0];
                default:
                    throw new ZpException("There is more than one Game with the same Id");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public DB.GamesDataTable GetGamesByFilter(int? contestId, int? teamId, DateTimeOffset? dateFrom,
            DateTimeOffset? dateTo, int? gameStatus, DateTimeOffset? date, int? betStatus, string login)
        {
            var result =
                Adapter.GetGamesByFilter(contestId, teamId, dateFrom, dateTo, gameStatus, date, betStatus, login);
            return result;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public DB.GamesDataTable GetGamesByBetStatus(bool? betStatus, string login)
        {
            switch (betStatus)
            {
                case null:
                    return Adapter.GetGames();
                case true:
                    return Adapter.GetGamesBetByUser(login);
                default:
                    return Adapter.GetGamesNotBetByUser(login);
            }
        }
    }
}
