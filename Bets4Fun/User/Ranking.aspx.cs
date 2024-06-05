using Bets4Fun.BusinessLogic;
using System;
using System.Data;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.User
{
    public partial class Ranking : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {

        }

        protected void RankingGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DB.RankingRow rRow = (DB.RankingRow)((DataRowView)e.Row.DataItem).Row;
                if (User.Identity.Name == rRow.Login)
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF6666");
                }
            }
        }

        protected void dllLeagues_DataBound(object sender, EventArgs e)
        {
            this.dllLeagues.Items.Insert(0, new ListItem() { Text = "[all]", Value = "-1" });
            this.dllLeagues.Enabled = (this.dllLeagues.Items.Count > 1);
        }

        protected void ddlContests_DataBound(object sender, EventArgs e)
        {
            this.ddlContests.Items.Add(new ListItem() { Text = "[all]", Value = "-1" });
        }

        protected void RankingGV_DataBound(object sender, EventArgs e)
        {
            int leagueId = int.Parse(this.dllLeagues.SelectedValue);

            if (leagueId > 0)
            {
                DB.LeaguesRow league = LeaguesLogic.GetLeagueById(leagueId);

                if (league != null && league.BettingForMoney)
                {
                    decimal pot = LeaguesLogic.GetUsersCountInLeague(leagueId) * league.EntryFee;

                    this.lCount.Text = string.Format(
                        "<table style=\"text-align:right;margin-top: 30px;\"><tr><td>Currently in pot:</td><td><b>{0:#.00} PLN</b></td></tr><tr><td>I place:</td><td>{1:#.00} PLN</td></tr><tr><td>II place:</td><td>{2:#.00} PLN</td></tr><tr><td>III place:</td><td>{3:#.00} PLN</td></tr></table>",
                        pot,
                        Math.Ceiling(pot * league.Prize1),
                        Math.Floor(pot * league.Prize2),
                        Math.Floor(pot * league.Prize3)
                    );
                    this.lCount.Visible = true;
                }
                else
                {
                    this.lCount.Visible = false;
                }
            }
            else
            {
                this.lCount.Visible = false;
            }
        }
    }
}
