using System.ComponentModel;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class ContestsInfoLogic
    {
        private static ContestsInfoTableAdapter _adapter;
        public static ContestsInfoTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new ContestsInfoTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public DB.ContestsInfoDataTable GetContestsInfo(string login)
            => Adapter.GetContestsInfo(login);

        public static DB.ContestsInfoRow GetContestsInfoById(int id)
        {
            var contestsInfos = Adapter.GetContestsInfoById(id);

            switch (contestsInfos.Count)
            {
                case 0:
                    return null;
                case 1:
                    return contestsInfos[0];
                default:
                    throw new ZpException("There are more than one contests with the same Id");
            }
        }
    }
}