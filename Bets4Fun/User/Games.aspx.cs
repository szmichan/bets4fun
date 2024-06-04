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

                DateFromCalendar.SelectedDate = DateTimeOffset.Now.AddDays(-1).ToString("yyyy-MM-dd"); //DateConverter.ConvertToLocal(DateTime.Now).AddDays(-1).ToString("yyyy-MM-dd");
                DateToCalendar.SelectedDate = DateTimeOffset.Now.AddDays(7).ToString("yyyy-MM-dd");//DateConverter.ConvertToLocal(DateTime.Now).AddDays(7).ToString("yyyy-MM-dd");
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
            //GamesDS.DataBind();
            //string abc = "";
        }

        protected void GamesDS_Filtering1(object sender, ObjectDataSourceFilteringEventArgs e)
        {
            //e.ParameterValues["Date"] = DateTimeOffset.UtcNow;//.ToString("yyyy-MM-dd");

            //if (!string.IsNullOrEmpty(e.ParameterValues["DateTo"].ToString()))
            //{
            //    DateTime localTime1 = DateTime.SpecifyKind(DateTime.Parse(e.ParameterValues["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1), DateTimeKind.Local);
            //    DateTimeOffset localTime2 = localTime1;
            //    e.ParameterValues["DateTo"] = localTime2;// DateTime.Parse(e.ParameterValues["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToString("yyyy-MM-dd HH:mm:ss");
            //}

            //if (!string.IsNullOrEmpty(e.ParameterValues["DateFrom"].ToString()))
            //{
            //    DateTime localTime1 = DateTime.SpecifyKind(DateTime.Parse(e.ParameterValues["DateFrom"].ToString()), DateTimeKind.Local);
            //    DateTimeOffset localTime2 = localTime1;
            //    e.ParameterValues["DateFrom"] = localTime2;
            //}
        }

        protected void GamesGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (e.CommandName.Equals("MakeBet"))
            //{
            //    DB.UsersRow user = UsersLogic.GetUserByLogin(User.Identity.Name);
            //    if (user != null)
            //        MakeBetPopup.Show(Convert.ToInt32(e.CommandArgument), user.Id);
            //}
            //else if (e.CommandName.Equals("GameBets"))
            //{
            //    DB.UsersRow user = UsersLogic.GetUserByLogin(User.Identity.Name);
            //    if (user != null)
            //        GameBetsPopup.ShowGameBets(Convert.ToInt32(e.CommandArgument), user.Id);
            //}
        }

        protected void GamesGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        DB.GamesRow game = (DB.GamesRow)((DataRowView)e.Row.DataItem).Row;
        //        LinkButton link = (LinkButton)e.Row.FindControl("BetLinkButton");
        //        if (link != null)
        //        {
        //            // 2-ga opcja filtrowania po statusie zakładu
        //            //link.Text = BetsLogic.IsGameBetByUser(game.Id, User.Identity.Name) ? "edit" : "bet";
        //            // 2-ga opcja filtrowania po statusie zakładu

        //            link.Enabled = (!game.IsGameDateNull() && game.GameDate >= DateTimeOffset.UtcNow.AddMinutes(5));
        //            if (!link.Enabled)
        //            {
        //                link.ForeColor = Color.LightGray;
        //            }
                    
        //        }
        //        link = (LinkButton)e.Row.FindControl("AllBetsLink");
        //        if (link != null)
        //        {
        //            link.Enabled = !game.IsGameDateNull() && (game.GameDate >= DateTimeOffset.UtcNow.AddHours(1) || game.GameDate < DateTimeOffset.UtcNow.AddMinutes(-5));
        //            if (!link.Enabled)
        //            {
        //                link.ForeColor = Color.LightGray;
        //            }
        //        }
        //    }
        }

        protected void GamesDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["Date"] = DateTimeOffset.UtcNow;
            e.InputParameters["Login"] = User.Identity.Name;
            if (e.InputParameters["DateTo"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1), DateTimeKind.Local);
                e.InputParameters["DateTo"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1)); //DateTimeOffset.Parse(e.InputParameters["DateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToUniversalTime();
            }

            if (e.InputParameters["DateFrom"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["DateFrom"].ToString()), DateTimeKind.Local);
                e.InputParameters["DateFrom"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["DateFrom"].ToString())); //DateTimeOffset.Parse(e.InputParameters["DateFrom"].ToString()).ToUniversalTime();
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
            //GameBetsPopup.BindData();
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            GamesGV.DataBind();
        }
    }
}
