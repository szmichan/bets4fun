using System;
using System.Web.UI.WebControls;

namespace Bets4Fun.Admin
{
    public partial class AdminTeams: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (!IsPostBack)
            {
                Menu m = (Menu)this.Master.FindControl("Menu1");
                if (m != null)
                {
                    m.Items[1].Selected = true;
                }

            }
        */
            
            //Label3.Text = FormsAuthentication.HashPasswordForStoringInConfigFile("abc", "sha1");
   
            //Label3.Text = PasswordEncoder.EncodePasswordMD5("abc");
            //UsersTableAdapter adapter = new UsersTableAdapter();
            //int i = adapter.Insert("smichan", null, null, PasswordEncoder.EncodePassword("abc"));

        }

        protected void TeamsGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            TeamsDV.ChangeMode(DetailsViewMode.Edit);
        }

        protected void TeamsDV_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                TeamsGV.DataBind();
            }
        }

        protected void TeamsDV_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                TeamsGV.DataBind();
            }
        }

        protected void TeamsGV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == TeamsGV.SelectedIndex)
            {
                TeamsGV.SelectedIndex = -1;
                TeamsDV.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void TeamsDV_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                TeamsGV.SelectedIndex = -1;
            }
        }

        protected void TeamsGV_PageIndexChanged(object sender, EventArgs e)
        {
            TeamsGV.SelectedIndex = -1;
            TeamsDV.ChangeMode(DetailsViewMode.Insert);
        }
    }
}
