using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.Admin
{
    public partial class AdminDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label3.Text = DateConverter.ConvertToCest(DateTime.Now).ToString();
        }
    }
}
