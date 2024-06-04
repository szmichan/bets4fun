using System;
using System.Web.UI.WebControls;
using Bets4Fun.BusinessLogic;
using Bets4Fun.Common;

namespace Bets4Fun.Admin
{
    public partial class AdminAssigningUr : BasePage
    {
        protected void AssignRolesButton_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in AvailableRolesListBox.Items)
            {
                if (item.Selected)
                {
                    UsersLogic.AssignUserToRole(Convert.ToInt32(UsersDDL.SelectedValue), Convert.ToInt32(item.Value));
                }
            }

            AssignedRolesListBox.DataBind();
            AvailableRolesListBox.DataBind();
        }

        protected void RevokeRolesButton_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in AssignedRolesListBox.Items)
            {
                if (item.Selected)
                {
                    UsersLogic.RevokeUserFromRole(Convert.ToInt32(UsersDDL.SelectedValue), Convert.ToInt32(item.Value));
                }
            }
            AssignedRolesListBox.DataBind();
            AvailableRolesListBox.DataBind();
        }

        protected void BtnRevokeLeagues_Click(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in this.repAssigned.Items)
            {
                var cbLeagueName = (CheckBox)item.FindControl("cbLeagueName");
                if (cbLeagueName.Checked)
                {
                    var hfLeagueId = (HiddenField)item.FindControl("hfLeagueID");

                    UsersLogic.RevokeUserFromLeague(Convert.ToInt32(UsersDDL.SelectedValue), Convert.ToInt32(hfLeagueId.Value));
                }
            }
            this.repAssigned.DataBind();
            this.repAvailable.DataBind();
        }

        protected void BtnAssignLeagues_Click(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in repAvailable.Items)
            {
                var cbLeagueName = (CheckBox)item.FindControl("cbLeagueName");
                if (cbLeagueName.Checked)
                {
                    var hfLeagueId = (HiddenField)item.FindControl("hfLeagueID");

                    UsersLogic.AssignUserToLeague(Convert.ToInt32(UsersDDL.SelectedValue), Convert.ToInt32(hfLeagueId.Value));
                }

            }

            this.repAssigned.DataBind();
            this.repAvailable.DataBind();
        }
    }
}
