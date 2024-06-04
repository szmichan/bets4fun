using Bets4Fun.BusinessLogic;
using System;
using System.Web.UI.WebControls;

namespace Bets4Fun.UserControls
{
    public partial class UcMakeContestInfoBet : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //OkButton.Attributes.Add("onclick", "if (Page_ClientValidate()) {" + OkButton.ClientID + ".disabled = true;}");// + Page.ClientScript.GetPostBackEventReference(OkButton, ""));
        }

        public void Show(int contestInfoId, int userId)
        {
            OkButton.Enabled = true;

            this.Visible = true;

            DB.ContestsInfoRow contestsInfo = ContestsInfoLogic.GetContestsInfoById(contestInfoId);

            if (contestsInfo != null)
            {
                ContestLabel.Text = Convert.ToString(contestsInfo.Contest_Name);
                ContestInfoLabel.Text = Convert.ToString(contestsInfo.Name);

                ContestInfoIdHF.Value = contestInfoId.ToString();
                UserIdHF.Value = userId.ToString();

                ContestInfoOptionsDS.SelectParameters.Clear();
                ContestInfoOptionsDS.SelectParameters.Add("ContestInfoId", contestInfoId.ToString());
                ContestInfoOptionsDS.SelectParameters.Add("UserId", userId.ToString());
                ContestInfoOptionsDS.DataBind();

                MakeContestsInfoBetPopup.Show();
            }
        }

        protected void OkButton_Click(object sender, EventArgs e)
        {

            if (ContestInfoIdHF.Value != "" && UserIdHF.Value != "")
            {
                int optionId = -1;

                foreach (GridViewRow row in ContestInfoOptionsGV.Rows)
                {
                    CheckBox cbOptionChoosen = (CheckBox)row.FindControl("cbOptionChoosen");
                    if (cbOptionChoosen.Checked)
                    {
                        optionId = Convert.ToInt32(ContestInfoOptionsGV.DataKeys[row.RowIndex].Value);
                        break;
                    }
                    
                }

                if (optionId > 0)
                {
                    ContestsInfoBetsLogic.InsertContestInfoBet(Convert.ToInt32(ContestInfoIdHF.Value), Convert.ToInt32(UserIdHF.Value), optionId);

                    //Thread.Sleep(5000);
                    //OkButton.Enabled = false;

                    /*
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
                     */ 
                    if (EndSaving != null)
                    {
                        EndSaving();
                    }
                }
            }
            //MakeContestsInfoBetPopup.Hide();
        }

        public delegate void Onendsaving();
        public event Onendsaving EndSaving;

        protected void ContestInfoOptionsGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
            {
                CheckBox cbOptionChoosen = (CheckBox)e.Row.FindControl("cbOptionChoosen");
                cbOptionChoosen.Attributes["onclick"] = string.Format("javascript:ChildClick(this);");
            }
        }

        protected void ContestInfoOptionsGV_Sorted(object sender, EventArgs e)
        {
            MakeContestsInfoBetPopup.Show();   
        }

        protected void ContestInfoOptionsGV_PageIndexChanged(object sender, EventArgs e)
        {
            MakeContestsInfoBetPopup.Show();
        }
    }
}