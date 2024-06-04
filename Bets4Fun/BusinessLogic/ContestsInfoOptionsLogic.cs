using System.ComponentModel;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    public class ContestsInfoOptionsLogic
    {
        private ContestsInfoOptionsTableAdapter _adapter;

        public ContestsInfoOptionsTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new ContestsInfoOptionsTableAdapter();
        }


        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public DB.ContestsInfoOptionsDataTable GetContestsInfoOptions(int contestInfoId, int userId)
            => Adapter.GetContestsInfoOptions(contestInfoId, userId);
    }
}