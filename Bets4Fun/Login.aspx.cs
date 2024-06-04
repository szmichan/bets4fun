using System;
using System.Web.Security;

namespace Bets4Fun
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbError.Visible = false;
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
        }

        protected void bLogin_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(UserName.Value, Password.Value))
            {
                //TODO
                //Session["Lang"] = "pl-PL";

                FormsAuthentication.RedirectFromLoginPage(UserName.Value, false);
            }
            else
            {
                lbError.Visible = true;
            }
        }
    }
}
