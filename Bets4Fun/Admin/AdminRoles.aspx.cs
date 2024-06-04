using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bets4Fun.Admin
{
    public partial class AdminRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Roles Grid View Events

        protected void RolesGV_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (RolesDV.CurrentMode != DetailsViewMode.Edit)
            {
                RolesDV.ChangeMode(DetailsViewMode.Edit);
            }

        }

        protected void RolesGV_PageIndexChanged(object sender, EventArgs e)
        {
            RolesGV.SelectedIndex = -1;
            RolesDV.ChangeMode(DetailsViewMode.Insert);
        }

        protected void RolesGV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == RolesGV.SelectedIndex)
            {
                RolesGV.SelectedIndex = -1;
                RolesDV.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion

        #region Roles Details View Events

        protected void RolesDV_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                RolesGV.SelectedIndex = -1;
            }
        }

        protected void RolesDV_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                RolesGV.DataBind();
            }
        }

        protected void RolesDV_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                RolesGV.DataBind();
            }
        }

        #endregion
    }
}
