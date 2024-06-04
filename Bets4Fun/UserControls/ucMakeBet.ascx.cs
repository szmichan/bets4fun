using System;
using Bets4Fun.BusinessLogic;

namespace Bets4Fun.UserControls
{
    public partial class UcMakeBet : System.Web.UI.UserControl
    {

        //private int? _betId = null;
        //private int _userId = -1;
        //private int _gameId = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            OkButton.Enabled = true;
        }

        public void Show(int gameId, int userId)
        {
            this.Visible = true;

            DB.GamesRow game = GamesLogic.GetGameById(gameId);

            if (game != null)
            {
                ContestLabel.Text = Convert.ToString(game.Contest_Name);
                if (!game.IsGameDateNull())
                {
                    GameDateLabel.Text = $"{game.GameDate:yyyy-MM-dd, HH:mm}";
                }
                else
                {
                    GameDateLabel.Text = string.Empty;
                }

                Team1Label.Text = Convert.ToString(game.Team1_Name);
                Team2Label.Text = Convert.ToString(game.Team2_Name);
                
                if (!game.IsDescriptionNull())
                {
                    DescriptionLabel.Text = game.Description.Replace(Environment.NewLine, "<br/>").Replace("\n", "<br/>");
                }
                else
                {
                    DescriptionLabel.Text = string.Empty;
                }

                lbMultiplyValue.Text = @"(" + game.MultiplyValue + @")";

                if (!game.IsTeam1PointsNull())
                {
                    lbTeam1Points.Text = @"(" + game.Team1Points + @")";
                }
                else
                {
                    lbTeam1Points.Text = @"-";
                }

                if (!game.IsTeam2PointsNull())
                {
                    lbTeam2Points.Text = @"(" + game.Team2Points + @")";
                }
                else
                {
                    lbTeam2Points.Text = @"-";
                }

                if (!game.IsDrawPointsNull())
                {
                    lbDrawPoints.Text = @"(" + game.DrawPoints + @")";
                }
                else
                {
                    lbDrawPoints.Text = @"-";
                }
                
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

                DB.BetsRow bet = BetsLogic.GetBetByUserInGame(gameId, userId);

                if (bet != null)
                {
                    Team1ScoreTB.Text = bet.Team1Score.ToString();
                    Team2ScoreTB.Text = bet.Team2Score.ToString();
                    BetIdHF.Value = bet.Id.ToString();
                    
                }
                else
                {
                    Team1ScoreTB.Text = string.Empty;
                    Team2ScoreTB.Text = string.Empty;
                    BetIdHF.Value = "";
                }

                MakeBetPopup.Show();
            }
        }

        protected void OkButton_Click(object sender, EventArgs e)
        {
            OkButton.Enabled = false;
            
            if (BetIdHF.Value == "")
            {
                if (!BetsLogic.IsGameBetByUser(Convert.ToInt32(GameIdHF.Value), Convert.ToInt32(UserIdHF.Value)))
                {
                    BetsLogic.InsertBet(Convert.ToInt32(GameIdHF.Value), Convert.ToInt32(UserIdHF.Value), Convert.ToInt32(Team1ScoreTB.Text), Convert.ToInt32(Team2ScoreTB.Text));
                }
            }
            else
            {
                BetsLogic.UpdateBet(Convert.ToInt32(GameIdHF.Value), Convert.ToInt32(UserIdHF.Value), Convert.ToInt32(Team1ScoreTB.Text), Convert.ToInt32(Team2ScoreTB.Text), Convert.ToInt32(BetIdHF.Value));
            }

            EndSaving?.Invoke();
        }

        public delegate void Onendsaving();
        public event Onendsaving EndSaving;
    }
}