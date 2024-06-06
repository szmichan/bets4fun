using System;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.User
{
    public partial class Games : BasePage
    {
        [WebMethod]
        [ScriptMethod]
        public static void SaveCollapsedState(string val)
        {
            HttpContext.Current.Session["collapsed-games"] = val;
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext.Current.Session["collapsed-games"] = "collapse show";

                DateFromCalendar.SelectedDate = DateTimeOffset.Now.AddDays(-1).ToString("yyyy-MM-dd");
                //DateToCalendar.SelectedDate = DateTimeOffset.Now.AddDays(7).ToString("yyyy-MM-dd");
            }
        }

        protected void ContestDDL_DataBound(object sender, EventArgs e)
        {
            ContestDDL.Items.Insert(0, new ListItem("[all]", ""));
        }

        protected void TeamDDL_DataBound(object sender, EventArgs e)
        {
            TeamDDL.Items.Insert(0, new ListItem("[all]", ""));
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
        }

        protected void GamesDS_Filtering1(object sender, ObjectDataSourceFilteringEventArgs e)
        {
           
        }

        protected void GamesGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }

        protected void GamesGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }

        protected void GamesDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["Date"] = DateTimeOffset.UtcNow;
            e.InputParameters["Login"] = User.Identity.Name;
            if (e.InputParameters["DateTo"] != null)
            {
                e.InputParameters["DateTo"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1));;
            }

            if (e.InputParameters["DateFrom"] != null)
            {
                e.InputParameters["DateFrom"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["DateFrom"].ToString())); 
            }
        }

        protected void ClearFilterButton_Click(object sender, EventArgs e)
        {
            if (ContestDDL.Items.Count > 0)
                ContestDDL.SelectedIndex = 0;
            if (TeamDDL.Items.Count > 0)
                TeamDDL.SelectedIndex = 0;
            if (GameStatusDDL.Items.Count > 0)
                GameStatusDDL.SelectedIndex = 0;
            if (BetStatusDDL.Items.Count > 0)
                BetStatusDDL.SelectedIndex = 0;
            DateFromCalendar.SelectedDate = "";
            DateToCalendar.SelectedDate = "";
        }

        protected void MakeBetEndSaving()
        {
            GamesGV.DataBind();
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            GamesGV.DataBind();
        }
    }
}
