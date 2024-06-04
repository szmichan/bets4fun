using System;
using System.ComponentModel;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class TeamsLogic : IDisposable
    {
        private TeamsTableAdapter _adapter;
        public TeamsTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new TeamsTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public DB.TeamsDataTable GetTeams() 
            => Adapter.GetTeams();

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public bool AddTeam(string name, DateTime? setUpDate, bool isNational, string description, string bannerImage) 
            => Adapter.Insert(name, setUpDate, isNational, description, bannerImage) == 1;

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public bool UpdateTeam(string name, DateTime? setUpDate, bool isNational, string description, string bannerImage, int id) 
            => Adapter.Update(name, setUpDate, isNational, description, bannerImage, id) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool DeleteTeam(int id) 
            => Adapter.Delete(id) == 1;

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public DB.TeamsRow GetTeamByExternalId(int externalId)
        {
            var teams = Adapter.GetTeamByExternalId(externalId);

            switch (teams.Count)
            {
                case 0:
                    return null;
                case 1:
                    return teams[0];
                default:
                    throw new ZpException($"There is more than 1 team with the same Id = {externalId}");
            }
        }

        public void Dispose() => _adapter?.Dispose();
    }
}
