using System.ComponentModel;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.BusinessLogic
{
    [DataObject]
    public class LanguagesLogic
    {
        private LanguagesTableAdapter _adapter;
        public LanguagesTableAdapter Adapter
        {
            set => _adapter = value;
            get => _adapter ?? new LanguagesTableAdapter();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public DB.LanguagesDataTable GetLanguages() 
            => Adapter.GetLanguages();
    }
}
