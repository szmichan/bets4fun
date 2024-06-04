using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bets4Fun.BusinessLogic;
using System.Drawing;
using System.Threading;
using System.Globalization;
using System.Web.Security;
using Bets4Fun.Common;

namespace Bets4Fun.User
{
    public partial class ChangePassword : BasePage
    {
        protected override void InitializeCulture()
        {
            /*
            string key = Request.Form.AllKeys.FirstOrDefault(el => el.Contains("ddlLanguage"));

            if (!string.IsNullOrEmpty(key))
            {
                string selectedLanguage = Request.Form[key];

                if (!string.IsNullOrEmpty(selectedLanguage) && !selectedLanguage.Equals(this.Session[SessionKeys.LANGUAGE_ID].ToString()))
                {
                    UsersLogic.UpdateLanguage((int)this.Session[SessionKeys.USER_ID], int.Parse(selectedLanguage));
                    DB.UsersRow user = UsersLogic.GetUserById((int)this.Session[SessionKeys.USER_ID]);

                    this.Session[SessionKeys.LANGUAGE_ID] = user.Language_Id;
                    this.Session[SessionKeys.CULTURE_INFO_NAME] = user.CultureInfoName;

                    //this.Session["Lang"] = selectedLanguage;
                    //CultureInfo culture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                    //Thread.CurrentThread.CurrentCulture = culture;
                    //Thread.CurrentThread.CurrentUICulture = culture;
                }
            }*/
            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var okLabel = (Label)ChangePassword1.ChangePasswordTemplateContainer.FindControl("FailureText");


            okLabel.Text = string.Empty;
            okLabel.CssClass = "text-danger bg-white";
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                //this.ddlLanguage.SelectedValue = this.Session[SessionKeys.LANGUAGE_ID].ToString();
            }
        }

        protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
        {
            var okLabel = (Label)ChangePassword1.ChangePasswordTemplateContainer.FindControl("FailureText");

            var usersLogic = new UsersLogic();
            if (usersLogic.ChangePassword(User.Identity.Name, PasswordEncoder.EncodePasswordMd5(ChangePassword1.CurrentPassword), PasswordEncoder.EncodePasswordMd5(ChangePassword1.NewPassword)))
            {
                okLabel.CssClass = "text-success bg-white";
                okLabel.Text = "Password has been changed!";
            }
            else
            {
                okLabel.Text = "Password has not been changed!";
            }
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ddlLanguage_DataBound(object sender, EventArgs e)
        {
        }
    }
}
