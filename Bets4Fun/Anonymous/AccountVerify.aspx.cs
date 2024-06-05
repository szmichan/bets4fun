using System;
using Bets4Fun.BusinessLogic;
using Bets4Fun.Common;

namespace Bets4Fun.Anonymous
{
    public partial class AccountVerify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var userId = 0;

            var userIdDecrypted = PasswordEncoder.DecryptStringRijndael(Request.QueryString["UserID"]);

            if (!string.IsNullOrEmpty(Request.QueryString["UserID"]) && !string.IsNullOrEmpty(Request.QueryString["Code"]) && int.TryParse(userIdDecrypted, out userId))
            {
                var user = UsersLogic.GetUserById(userId);
               
                if (!user.IsActivated)
                {
                    if (PasswordEncoder.EncodePasswordMd5(user.Login) == Request.QueryString["Code"])
                    {
                        UsersLogic.ActivateUser(user.Id, true);

                        Label1.Text = "Your account has been activated";
                    }
                    else
                    {
                        Label1.Text = "Couldn't activate your account";
                    }
                }
                else
                {
                    Label1.Text = "Account already activated";
                }

            }
            else
            {
                Label1.Text = "Couldn't activate your account";
            }
        }
    }
}