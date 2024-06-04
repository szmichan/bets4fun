using System;
using System.Data;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bets4Fun.Admin
{
    public partial class AdminContests : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void ContestsGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            ContestsDV.ChangeMode(DetailsViewMode.Edit);
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
        }

        protected void ContestsDV_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ContestsGV.DataBind();
            }
        }

        protected void ContestsDV_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                ContestsGV.DataBind();
            }
        }

        protected void ContestsGV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == ContestsGV.SelectedIndex)
            {
                ContestsGV.SelectedIndex = -1;
                ContestsDV.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void ContestsDV_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                ContestsGV.SelectedIndex = -1;
            }
        }

        protected void ContestsGV_PageIndexChanged(object sender, EventArgs e)
        {
            ContestsGV.SelectedIndex = -1;
            ContestsDV.ChangeMode(DetailsViewMode.Insert);
        }

        protected void ContestsDetailsDS_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            int retVal = Convert.ToInt32(e.ReturnValue);
        }

        protected void ContestsGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var control = e.Row.FindControl("SeedDataLink") as LinkButton;

                if (control != null)
                {
                    var dataItem = ((DataRowView)e.Row.DataItem).Row as DB.ContestsRow;
                    //int? ExternalId = DataBinderExtensions.Eval<int?>(e.Row.DataItem, "ExternalId");
                    if (!dataItem.IsExternalIdNull())
                    {
                        control.Attributes.Add("onclick", string.Format("SeedData({0}); return false;", dataItem.Id));
                    }
                    else
                    {
                        control.Visible = false;
                    }
                }
            }
        }

        protected void ContestsGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seed")
            {

            }
        }

        protected void ContestsGV_DataBinding(object sender, EventArgs e)
        {
            
        }
    }
}
