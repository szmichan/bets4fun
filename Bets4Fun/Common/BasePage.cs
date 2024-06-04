using System.Globalization;
using System.Threading;
using System.Web.UI;

namespace Bets4Fun.Common
{
    public class BasePage : Page
    {
        protected override void InitializeCulture()
        {
            base.InitializeCulture();

            var culture = CultureInfo.CreateSpecificCulture("en-Gb");

            culture.NumberFormat.NumberDecimalSeparator = ".";
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;
        }


        //protected override void InitializeCulture()
        //{
        //    if (this.Session[SessionKeys.CULTURE_INFO_NAME] != null)
        //    {
        //        var selectedLanguage = (string)this.Session[SessionKeys.CULTURE_INFO_NAME];

        //        var culture = CultureInfo.CreateSpecificCulture(selectedLanguage);
        //        culture.NumberFormat.NumberDecimalSeparator = ".";

        //        Thread.CurrentThread.CurrentCulture = culture;
        //        Thread.CurrentThread.CurrentUICulture = culture;
        //    }
        //    base.InitializeCulture();
        //}
    }
}