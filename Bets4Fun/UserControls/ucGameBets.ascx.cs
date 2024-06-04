using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bets4Fun.BusinessLogic;
using System.Data;
using System.Drawing;

namespace Bets4Fun.UserControls
{
    public partial class UcGameBets : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /*
        public void BindData()
        {
            BetsGV.DataBind();
        }
        */

        public void ShowGameBets(int gameId, int userId)
        {
            this.Visible = true;

            DB.GamesRow game = GamesLogic.GetGameById(gameId);

            if (game != null)
            {
                ContestLabel1.Text = Convert.ToString(game.Contest_Name);
                
                if (!game.IsGameDateNull())
                    GameDateLabel1.Text = string.Format("{0:yyyy-MM-dd, HH:mm}", game.GameDate);
                else
                    GameDateLabel1.Text = string.Empty;

                Team1Label1.Text = game.Team1_Name;
                Team2Label1.Text = game.Team2_Name;

                if (!game.IsTeam1ScoreNull())
                    Team1ScoreLabel1.Text = game.Team1Score.ToString();
                else
                    Team1ScoreLabel1.Text = "-";

                if (!game.IsTeam2ScoreNull())
                    Team2ScoreLabel1.Text = game.Team2Score.ToString();
                else
                    Team2ScoreLabel1.Text = "-";

                if (!game.IsDescriptionNull())
                    DescriptionLabel1.Text = game.Description.Replace(Environment.NewLine, "<br/>").Replace("\n", "<br/>");
                else
                    DescriptionLabel1.Text = string.Empty;

                lbMultiplyValue.Text = "(" + game.MultiplyValue + ")";

                if (!game.IsTeam1PointsNull())
                    lbTeam1Points.Text = "(" + game.Team1Points + ")";
                else
                    lbTeam1Points.Text = "-";

                if (!game.IsTeam2PointsNull())
                    lbTeam2Points.Text = "(" + game.Team2Points + @")";
                else
                    lbTeam2Points.Text = "-";

                if (!game.IsDrawPointsNull())
                    lbDrawPoints.Text = "(" + game.DrawPoints + ")";
                else
                    lbDrawPoints.Text = "-";

                if (!game.IsTeam1_BannerImageNull())
                    imgTeam1.ImageUrl = "~/App_Themes/Default/Images/banners/" + game.Team1_BannerImage;
                else
                    imgTeam1.Visible = false;

                if (!game.IsTeam2_BannerImageNull())
                    imgTeam2.ImageUrl = "~/App_Themes/Default/Images/banners/" + game.Team2_BannerImage;
                else
                    imgTeam2.Visible = false;

                GameIdHF.Value = gameId.ToString();
                UserIdHF.Value = userId.ToString();

                //DB.BetsDataTable bets = BetsLogic.GetBetsByGameId(Game_Id, User_Id);

                BetsDS.SelectParameters["Game_Id"].DefaultValue = gameId.ToString();
                BetsDS.SelectParameters["User_Id"].DefaultValue = userId.ToString();

                BetsGV.PageIndex = 0;

                BetsGV.DataBind();
                BetsGV.Sort("", SortDirection.Ascending);
                //BetsGV.SortExpression = string.Empty;
                //BetsGV.SortDirection = SortDirection.Ascending;

                GameBetsPopup.Show();
            }
        }

        protected void BetsGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DB.BetsRow bet = (DB.BetsRow)((DataRowView)e.Row.DataItem).Row;
                if (Convert.ToInt32(UserIdHF.Value) == bet.User_Id)
                {
                    //e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF6666");
                    e.Row.Font.Bold = true;
                }

                if (!bet.IsPointsNull())
                {
                    if (bet.Points == 0)
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#FFD2CC");
                    }
                    else if (bet.Game_Team1Score == bet.Team1Score && bet.Game_Team2Score == bet.Team2Score)
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#BFFFFA");
                        //e.Row.BorderColor = ColorTranslator.FromHtml("#22781E");
                        //e.Row.BorderWidth = new Unit(2);
                    }
                    else
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#E2FFCC");
                    }
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {

                ((Label)e.Row.FindControl("HeaderTeam1Label")).Text = Team1Label1.Text; 
                ((Label)e.Row.FindControl("HeaderTeam2Label")).Text = Team2Label1.Text;
            }
        }

        /*
        protected void BetsGV_PageIndexChanged(object sender, EventArgs e)
        {
            GameBetsPopup.Show();
        }

        protected void BetsGV_Sorted(object sender, EventArgs e)
        {
            GameBetsPopup.Show();
        }
         */ 
    }
}