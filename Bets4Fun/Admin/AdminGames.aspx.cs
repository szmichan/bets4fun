using Bets4Fun.UserControls;
using System;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.Admin
{
    public partial class AdminGames : BasePage
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DetailsView1.ChangeMode(DetailsViewMode.Edit);
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                GridView1.DataBind();
            }
        }

        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                GridView1.DataBind();
            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            //var d = DateTimeOffset.Now;
            //TimeZoneInfo tzi = 
            //DateTime localTime = TimeZoneInfo.ConvertTime(DateTime.UtcNow, myTimeZoneInfo);
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.CurrentMode == DetailsViewMode.Edit)
            {
                var ddlTeam1 = (DropDownList)DetailsView1.FindControl("ddlTeam1");
                var ddlTeam2 = (DropDownList)DetailsView1.FindControl("ddlTeam2");

                if (!((DB.GamesRow)((System.Data.DataRowView)DetailsView1.DataItem).Row).IsTeam1_IdNull())
                {
                    ddlTeam1.SelectedValue = ((DB.GamesRow)((System.Data.DataRowView)DetailsView1.DataItem).Row).Team1_Id.ToString();
                }

                if (!((DB.GamesRow)((System.Data.DataRowView)DetailsView1.DataItem).Row).IsTeam2_IdNull())
                {
                    ddlTeam2.SelectedValue = ((DB.GamesRow)((System.Data.DataRowView)DetailsView1.DataItem).Row).Team2_Id.ToString();
                }
            }
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == GridView1.SelectedIndex)
            {
                GridView1.SelectedIndex = -1;
                DetailsView1.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                GridView1.SelectedIndex = -1;
            }
        }

        protected void GridView1_PageIndexChanged(object sender, EventArgs e)
        {
            GridView1.SelectedIndex = -1;
            DetailsView1.ChangeMode(DetailsViewMode.Insert);
        }

        protected void GamesDSMod_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            if ((long)Session["update"] == (long)ViewState["update"])
            {
                Session["update"] = DateTime.Now.Ticks;

                var tb = (TextBox)DetailsView1.FindControl("EditTimeTB");
                var uc = (UcCalendar)DetailsView1.FindControl("ucCalendar1");

                if (tb != null && uc != null)
                {
                    if (tb.Text != string.Empty)
                    {
                        //DateTimeOffset dtoff = DateTime.SpecifyKind(DateTime.Parse($"{uc.SelectedDate} { tb.Text}"), DateTimeKind.Local);
                        e.InputParameters["GameDate"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse($"{uc.SelectedDate} { tb.Text}")); //DateTimeOffset.Parse($"{uc.SelectedDate} { tb.Text}").ToUniversalTime();
                    }
                }
                else
                {
                    throw new ZpException("Required controls not found.");
                }

                var ddlTeam1 = (DropDownList)DetailsView1.FindControl("ddlTeam1");
                if (ddlTeam1 != null && ddlTeam1.SelectedIndex > 0)
                {
                    e.InputParameters["Team1Id"] = int.Parse(ddlTeam1.SelectedValue);
                }

                var ddlTeam2 = (DropDownList)DetailsView1.FindControl("ddlTeam2");
                if (ddlTeam2 != null && ddlTeam2.SelectedIndex > 0)
                {
                    e.InputParameters["Team2Id"] = int.Parse(ddlTeam2.SelectedValue);
                }
            }
            else
            {
                e.Cancel = true;
            }
        }

        protected void GamesDSMod_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            if ((long)Session["update"] == (long)ViewState["update"])
            {
                Session["update"] = DateTime.Now.Ticks;

                var tb = (TextBox)DetailsView1.FindControl("InsertTimeTB");
                var uc = (UcCalendar)DetailsView1.FindControl("ucCalendar1");

                if (tb != null && uc != null)
                {
                    if (tb.Text != string.Empty)
                    {
                        e.InputParameters["GameDate"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse($"{uc.SelectedDate} { tb.Text}"));//DateTimeOffset.Parse($"{uc.SelectedDate} { tb.Text}").ToUniversalTime();
                    }
                }
                else
                {
                    throw new ZpException("Required controls not found."); ;
                }
            }
            else
            {
                e.Cancel = true;
            }
        }

        protected void ddlTeam1_DataBound(object sender, EventArgs e)
        {
            var s = sender as DropDownList;

            s?.Items.Insert(0, new ListItem("[unknown]", ""));
        }

        protected void ddlTeam2_DataBound(object sender, EventArgs e)
        {
            var s = sender as DropDownList;

            s?.Items.Insert(0, new ListItem("[unknown]", ""));
        }
    }
}
