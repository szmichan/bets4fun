using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using Bets4Fun.BusinessLogic;
using Bets4Fun.Common;

namespace Bets4Fun.User
{
    public partial class ContestInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ContestDDL_DataBound(object sender, EventArgs e)
        {
            ContestDDL.Items.Insert(0, new ListItem("[all]", "-1"));
        }

        protected void ContestsInfoGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var contestInfo = (DB.ContestsInfoRow)((DataRowView)e.Row.DataItem).Row;
                var link = (LinkButton)e.Row.FindControl("BetLinkButton");
                if (link != null)
                {
                    link.Enabled = (contestInfo.BettingDeadline >= DateConverter.ConvertToCest(DateTime.Now));
                    if (!link.Enabled)
                    {
                        link.ForeColor = Color.LightGray;
                    }

                }

                link = (LinkButton)e.Row.FindControl("AllBetsLink");
                if (link != null)
                {
                    link.Enabled = contestInfo.BettingDeadline >= DateConverter.ConvertToCest(DateTime.Now.AddHours(1)) || contestInfo.BettingDeadline < DateConverter.ConvertToCest(DateTime.Now);
                    if (!link.Enabled)
                    {
                        link.ForeColor = Color.LightGray;
                    }
                }
            }
        }

        protected void ContestsInfoDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["Login"] = User.Identity.Name;
        }

        protected void ContestsInfoGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("MakeContestInfoBet"))
            {
                //Session["Game_Id"] = e.CommandArgument;
                var user = UsersLogic.GetUserByLogin(User.Identity.Name);
                if (user != null)
                {
                    MakeContestInfoBetPopup.Show(Convert.ToInt32(e.CommandArgument), user.Id);
                }
            }
            else if (e.CommandName.Equals("ContestInfoBets"))
            {
                /*
                DB.UsersRow user = UsersLogic.GetUserByLogin(User.Identity.Name);
                if (user != null)
                    GameBetsPopup.ShowGameBets(Convert.ToInt32(e.CommandArgument), user.Id);
                 */
            }
        }


        protected void MakeBetEndSaving()
        {
            ContestsInfoGV.DataBind();
            //GameBetsPopup.BindData();
        }
    }
}