using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bets4Fun.BusinessLogic;
using Bets4Fun.Common;
using Bets4Fun.DBTableAdapters;

namespace Bets4Fun.Admin
{
    public partial class AdminUsers : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            komunikatLabel.Text = string.Empty;
        }

        #region Users Grid View Events

        protected void UsersGV_PageIndexChanged(object sender, EventArgs e)
        {
            UsersGV.SelectedIndex = -1;
            UsersDV.ChangeMode(DetailsViewMode.Insert);
        }

        protected void UsersGV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex == UsersGV.SelectedIndex)
            {
                UsersGV.SelectedIndex = -1;
                UsersDV.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void UsersGV_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (UsersDV.CurrentMode != DetailsViewMode.Edit)
            {
                UsersDV.ChangeMode(DetailsViewMode.Edit);
            }
        }

        #endregion

        #region Users Details View Events

        protected void UsersDV_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                UsersGV.DataBind();
            }
        }

        protected void UsersDV_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                UsersGV.DataBind();
            }
        }

        protected void UsersDV_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel" || e.CommandName == "Update")
            {
                UsersGV.SelectedIndex = -1;
            }
        }

        #endregion

        #region Users Password Changing Events

        protected void ChangePasswordCheckBox_CheckedChanged1(object sender, EventArgs e)
        {
            CheckBox check = (CheckBox)UsersDV.FindControl("ChangePasswordCheckBox");
            if (check != null)
            {
                Panel panel = ((Panel)UsersDV.FindControl("PasswordsPanel"));
                if (panel != null)
                {
                    panel.Enabled = check.Checked;
                }

                RequiredFieldValidator validator = (RequiredFieldValidator)UsersDV.FindControl("PasswordRequiredValidatorEdit");


                if (validator != null)
                {
                    validator.Enabled = check.Checked;
                }

                validator = (RequiredFieldValidator)UsersDV.FindControl("PasswordRetypeRequiredValidatorEdit");

                if (validator != null)
                {
                    validator.Enabled = check.Checked;
                }
            }
        }

        #endregion

        #region Users Data Source Events

        protected void UsersDSMod_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
        {
            TextBox tb = ((TextBox)UsersDV.FindControl("PasswordTextBoxInsert"));
            if (tb != null)
            {
                string login = e.InputParameters["Login"].ToString();
                if (login != null)
                {
                    if (UsersLogic.LoginExists(login))
                    {
                        e.Cancel = true;
                        komunikatLabel.Text = "* Login '" + login + "' already exists.";
                    }
                    else
                    {
                        e.InputParameters["Password"] = PasswordEncoder.EncodePasswordMd5(tb.Text);
                    }
                }
                else
                {
                    throw new ZpException("Where is Login parameter??");
                }
            }
            else
            {
                throw new ZpException("Control 'PasswordTextBoxInsert' does not exists.");
            }
        }

        protected void UsersDSMod_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            TextBox tb = ((TextBox)UsersDV.FindControl("PasswordTextBoxEdit"));
            if (tb != null)
            {
                string login = e.InputParameters["Login"].ToString();
                if (login != null)
                {
                    CheckBox cb = ((CheckBox)UsersDV.FindControl("ChangePasswordCheckBox"));
                    if (cb != null)
                    {
                        if (cb.Checked)
                        {
                            e.InputParameters["Password"] = PasswordEncoder.EncodePasswordMd5(tb.Text);
                        }
                        else
                        {
                            e.InputParameters["Password"] = null;
                        }
                    }
                    else
                    {
                        throw new ZpException("Control 'ChangePasswordCheckBox' does not exists.");
                    }
                }
                else
                {
                    throw new ZpException("Where is Login parameter??");
                }
            }
            else
            {
                throw new ZpException("Control 'PasswordTextBoxEdit' does not exists.");
            }
        }

        #endregion

        #region Assigning to Roles and Leagues

        protected void AssignRolesButton_Click(object sender, EventArgs e)
        {
            if (UsersGV.SelectedIndex >= 0)
            {
                foreach (ListItem item in AvailableRolesListBox.Items)
                {
                    if (item.Selected)
                    {
                        UsersLogic.AssignUserToRole(Convert.ToInt32(UsersGV.SelectedValue), Convert.ToInt32(item.Value));
                    }
                }

                AssignedRolesListBox.DataBind();
                AvailableRolesListBox.DataBind();
            }
        }

        protected void RevokeRolesButton_Click(object sender, EventArgs e)
        {
            if (UsersGV.SelectedIndex >= 0)
            {
                foreach (ListItem item in AssignedRolesListBox.Items)
                {
                    if (item.Selected)
                    {
                        UsersLogic.RevokeUserFromRole(Convert.ToInt32(UsersGV.SelectedValue), Convert.ToInt32(item.Value));
                    }
                }
                AssignedRolesListBox.DataBind();
                AvailableRolesListBox.DataBind();
            }
        }

        protected void btnRevokeLeagues_Click(object sender, EventArgs e)
        {
            if (UsersGV.SelectedIndex >= 0)
            {
                foreach (RepeaterItem item in this.repAssigned.Items)
                {
                    CheckBox cbLeagueName = (CheckBox)item.FindControl("cbLeagueName");
                    if (cbLeagueName.Checked)
                    {
                        HiddenField hfLeagueId = (HiddenField)item.FindControl("hfLeagueID");

                        UsersLogic.RevokeUserFromLeague(Convert.ToInt32(UsersGV.SelectedValue), Convert.ToInt32(hfLeagueId.Value));
                    }
                }
                this.repAssigned.DataBind();
                this.repAvailable.DataBind();
            }
        }

        protected void btnAssignLeagues_Click(object sender, EventArgs e)
        {
            if (UsersGV.SelectedIndex >= 0)
            {
                foreach (RepeaterItem item in repAvailable.Items)
                {
                    CheckBox cbLeagueName = (CheckBox)item.FindControl("cbLeagueName");
                    if (cbLeagueName.Checked)
                    {
                        HiddenField hfLeagueId = (HiddenField)item.FindControl("hfLeagueID");

                        UsersLogic.AssignUserToLeague(Convert.ToInt32(UsersGV.SelectedValue), Convert.ToInt32(hfLeagueId.Value));
                    }

                }

                this.repAssigned.DataBind();
                this.repAvailable.DataBind();
            }
        }

        #endregion
    }
}
