using System;

namespace Bets4Fun.Errors
{
    public partial class NotFound : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["aspxerrorpath"] != null)
                Label1.Text = Request.QueryString["aspxerrorpath"];
            else
            {
                int lastIndex = Request.RawUrl.IndexOf("404");

                if (lastIndex > 0)
                {
                    Uri uri = new Uri(Request.RawUrl.Substring(Request.RawUrl.IndexOf("404") + 3).Trim(new char[] { ';' }));
                    Label1.Text = uri.PathAndQuery;
                }
            }
        }
    }
}
