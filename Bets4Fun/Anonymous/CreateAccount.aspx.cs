using System;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using Bets4Fun.BusinessLogic;
using Bets4Fun.Common;

namespace Bets4Fun.Anonymous
{
    public partial class CreateAccount : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_SendingMail(object sender, MailMessageEventArgs e)
        {
            var user = UsersLogic.GetUserByLogin(CreateUserWizard1.UserName);
            if (user != null)
            {
                var url = Request.Url.ToString();
                var index = url.LastIndexOf('/');
                url = url.Substring(0, index);


                var activationLink = string.Format("{0}/{1}?UserID={2}&Code={3}", url, "AccountVerify.aspx", 
                    HttpUtility.UrlEncode(PasswordEncoder.EncryptStringRijndael(user.Id.ToString())), 
                    HttpUtility.UrlEncode(PasswordEncoder.EncodePasswordMd5(CreateUserWizard1.UserName.ToString())));
                e.Message.Body = e.Message.Body.Replace("<%ActivationLink%>", activationLink).Replace("<%FirstName%>", user.FirstName).Replace("<%LastName%>", user.LastName);
                e.Message.Bcc.Add(e.Message.From);
                e.Message.IsBodyHtml = true;
                e.Message.BodyEncoding = Encoding.UTF8;
            }
        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            var firstName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("FirstName");
            var lastName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("LastName");
            var userName = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName");

            UsersLogic.UpdateOtherData(firstName.Text, lastName.Text, userName.Text);
        }

        protected void CreateUserButton_Click(object sender, EventArgs e)
        {
            var status = MembershipCreateStatus.UserRejected;

            var user = Membership.CreateUser(
                ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName")).Text,
                ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Password")).Text,
                ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Email")).Text,
                null,
                null,
                false,
                out status);

            if (status == MembershipCreateStatus.Success)
            {
                CreateUserWizard1.MoveTo(CompleteWizardStep1);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("~/Login.aspx");
        }
    }
}