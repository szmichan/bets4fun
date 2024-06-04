using System;

namespace Bets4Fun.Errors
{
    public partial class Unauthorized : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ReturnUrl"] != null)
                Label1.Text = Request.QueryString["ReturnUrl"];
            else
            {
                int lastIndex = Request.RawUrl.IndexOf("401");

                if (lastIndex > 0)
                {
                    Uri uri = new Uri(Request.RawUrl.Substring(Request.RawUrl.IndexOf("401") + 3).Trim(new char[] { ';' }));
                    Label1.Text = uri.PathAndQuery;
                }
            }
        }
    }
}
