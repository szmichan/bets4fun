using System;

namespace Bets4Fun.Anonymous
{
    public partial class GameRules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("~/Login.aspx");
        }
    }
}