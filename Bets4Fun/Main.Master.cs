using System;
using System.Web.Security;
using Bets4Fun.Common;

namespace Bets4Fun
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label3.Text = DateConverter.ConvertToCest(DateTime.Now).ToString();
            Response.TrySkipIisCustomErrors = true;

            if (!this.IsPostBack)
            {
                this.Label2.Text = string.Format("Copyright© {0} smichan", DateTime.Now.Year);
            }

        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Roles.DeleteCookie();
            Response.Redirect(FormsAuthentication.LoginUrl);
        }
    }
}
