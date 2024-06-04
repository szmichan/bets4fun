using System;

namespace Bets4Fun
{
    public partial class ZpLogin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Label2.Text = string.Format("Copyright© {0} smichan", DateTime.Now.Year);
            }
        }
    }
}