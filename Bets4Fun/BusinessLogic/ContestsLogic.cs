using System.ComponentModel;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class ContestsLogic
    {
        private ContestsTableAdapter _adapter;

        public ContestsTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new ContestsTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public DB.ContestsDataTable GetContests()
            => Adapter.GetContests();

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public bool AddContest(string name, string description)
            => Adapter.Insert(name, description) == 1;

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public bool UpdateContest(string name, string description, int id)
            => Adapter.Update(name, description, id) == 1;

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool DeleteContest(int id)
            => Adapter.Delete(id) == 1;
    }
}
