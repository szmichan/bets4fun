using Bets4Fun.BusinessLogic;
using System;
using System.IO;
using System.Net.Mail;
using System.Text;
using Bets4Fun.Common;

namespace Bets4Fun.Anonymous
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.lbError.Visible = false;
            this.lbError.Text = string.Empty;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("~/Login.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            var user =  UsersLogic.GetUserByLogin(this.UserName.Text);

            if (user == null || user.Email != this.Email.Text)
            {
                this.lbError.Visible = true;
                this.lbError.Text = "values entered are invalid";
            }
            else
            {
                // OK

                var path = Server.MapPath("~/mail_formats/reset_password.txt");
                var body = File.ReadAllText(path, Encoding.Default);
                var newPass = Guid.NewGuid().ToString().Substring(0, 8);

                if (UsersLogic.ResetPass(user.Login, PasswordEncoder.EncodePasswordMd5(newPass)))
                {
                    var client = new SmtpClient();

                    var message = new MailMessage
                    {
                        Body = body.Replace("<%FirstName%>", user.FirstName).Replace("<%LastName%>", user.LastName).Replace("<%UserName%>", user.Login).Replace("<%NewPassword%>", newPass),
                        Subject = "password has been reset",
                        IsBodyHtml = true,
                        BodyEncoding = Encoding.UTF8
                };

                    message.To.Add(user.Email);
                    message.Bcc.Add(message.From);

                    client.Send(message);

                    this.MultiView1.ActiveViewIndex = 1;
                }
                else
                {
                    this.lbError.Visible = true;
                    this.lbError.Text = "error when resetting password";
                }
            }
        }
    }
}