using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.Admin
{
    public partial class AdminLeagues : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["update"] = DateTime.Now.Ticks;
            }
        }

        protected void Page_Prerender(object sender, EventArgs e)
        {
            ViewState["update"] = Session["update"];
        }

        protected void gvLeagues_SelectedIndexChanged(object sender, EventArgs e)
        {
            //dvLeagues.DataBind(); 
            dvLeagues.ChangeMode(DetailsViewMode.Edit);
        }

        protected void gvLeagues_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == gvLeagues.SelectedIndex)
            {
                gvLeagues.SelectedIndex = -1;
                dvLeagues.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void gvLeagues_PageIndexChanged(object sender, EventArgs e)
        {
            if (gvLeagues.SelectedIndex >= 0)
            {
                gvLeagues.SelectedIndex = -1;
                dvLeagues.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void LeaguesDSMod_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            if ((long)Session["update"] == (long)ViewState["update"])
            {
                Session["update"] = DateTime.Now.Ticks;
            }
            else
            {
                e.Cancel = true;
            }
        }

        protected void LeaguesDSMod_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            if ((long)Session["update"] == (long)ViewState["update"])
            {
                Session["update"] = DateTime.Now.Ticks;
            }
            else
            {
                e.Cancel = true;
            }
        }

        protected void dvLeagues_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                gvLeagues.SelectedIndex = -1;
            }
        }

        protected void dvLeagues_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                gvLeagues.DataBind();
            }
        }

        protected void dvLeagues_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                gvLeagues.DataBind();
            }
        }
    }
}