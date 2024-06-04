﻿using Bets4Fun.BusinessLogic;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using Bets4Fun.Common;

namespace Bets4Fun.User
{
    public partial class Bets : BasePage
    {
        [WebMethod]
        [ScriptMethod]
        public static void SaveCollapsedState(string val)
        {
            HttpContext.Current.Session["collapsed-bets"] = val;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext.Current.Session["collapsed-bets"] = "collapse show";

                GameDateFromCalendar.SelectedDate = DateTimeOffset.Now.AddDays(-1).ToString("yyyy-MM-dd"); //DateConverter.ConvertToLocal(DateTime.Now).AddDays(-1).ToString("yyyy-MM-dd");
                GameDateToCalendar.SelectedDate = DateTimeOffset.Now.AddDays(7).ToString("yyyy-MM-dd");//DateConverter.ConvertToLocal(DateTime.Now).AddDays(7).ToString("yyyy-MM-dd");
            }
            //else
            //{
            //    BetsGV.DataBind();
            //}
        }

        protected void BetsDS_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["Date"] = DateTimeOffset.UtcNow;
            e.InputParameters["Login"] = User.Identity.Name;

            if (e.InputParameters["BetDateTo"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["BetDateTo"].ToString()).AddDays(1).AddMilliseconds(-1), DateTimeKind.Local);
                //e.InputParameters["BetDateTo"] = localTime2;
                e.InputParameters["BetDateTo"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["BetDateTo"].ToString()).AddDays(1).AddMilliseconds(-1)); //DateTimeOffset.Parse(e.InputParameters["BetDateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToUniversalTime();
            }

            if (e.InputParameters["BetDateFrom"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["BetDateFrom"].ToString()), DateTimeKind.Local);
                //e.InputParameters["BetDateFrom"] = localTime2;
                e.InputParameters["BetDateFrom"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["BetDateFrom"].ToString())); //DateTimeOffset.Parse(e.InputParameters["BetDateFrom"].ToString()).ToUniversalTime();
            }

            if (e.InputParameters["GameDateTo"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["GameDateTo"].ToString()).AddDays(1).AddMilliseconds(-1), DateTimeKind.Local);
                //e.InputParameters["GameDateTo"] = localTime2
                e.InputParameters["GameDateTo"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["GameDateTo"].ToString()).AddDays(1).AddMilliseconds(-1)); //DateTimeOffset.Parse(e.InputParameters["GameDateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToUniversalTime();
            }

            if (e.InputParameters["GameDateFrom"] != null)
            {
                //DateTimeOffset localTime2 = DateTime.SpecifyKind(DateTime.Parse(e.InputParameters["GameDateFrom"].ToString()), DateTimeKind.Local);
                //e.InputParameters["GameDateFrom"] = localTime2;
                e.InputParameters["GameDateFrom"] = DateConverter.ConvertToUtcFromCest(DateTime.Parse(e.InputParameters["GameDateFrom"].ToString())); //DateTimeOffset.Parse(e.InputParameters["GameDateFrom"].ToString()).ToUniversalTime();
            }
        }

        protected void BetsDS_Filtering(object sender, ObjectDataSourceFilteringEventArgs e)
        {
            //e.ParameterValues["Date"] = DateConverter.ConvertToLocal(DateTime.Now).ToString("yyyy-MM-dd");

            //if (!string.IsNullOrEmpty(e.ParameterValues["GameDateTo"].ToString()))
            //{
            //    e.ParameterValues["GameDateTo"] = DateTime.Parse(e.ParameterValues["GameDateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToString("yyyy-MM-dd");
            //}

            //if (!string.IsNullOrEmpty(e.ParameterValues["BetDateTo"].ToString()))
            //{
            //    e.ParameterValues["BetDateTo"] = DateTime.Parse(e.ParameterValues["BetDateTo"].ToString()).AddDays(1).AddMilliseconds(-1).ToString("yyyy-MM-dd");
            //}
        }

        protected void ContestDDL_DataBound(object sender, EventArgs e)
        {
            ContestDDL.Items.Insert(0, new ListItem("[all]", ""));
        }

        protected void ClearFilterButton_Click(object sender, EventArgs e)
        {
            if (ContestDDL.Items.Count > 0)
                ContestDDL.SelectedIndex = 0;
            if (GameStatusDDL.Items.Count > 0)
                GameStatusDDL.SelectedIndex = 0;

            BetDateFromCalendar.SelectedDate = "";
            BetDateToCalendar.SelectedDate = "";
            GameDateFromCalendar.SelectedDate = "";
            GameDateToCalendar.SelectedDate = "";
        }

        protected void BetsGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DB.BetsRow bet = (DB.BetsRow)((DataRowView)e.Row.DataItem).Row;
                //LinkButton link = (LinkButton)e.Row.FindControl("BetLinkButton");
                //if (link != null)
                //{
                //    link.Enabled = (!bet.IsGame_DateNull() && bet.Game_Date >= DateConverter.ConvertToLocal(DateTime.Now.AddMinutes(5)));
                //    if (!link.Enabled)
                //    {
                //        link.ForeColor = Color.LightGray;
                //    }
                //}
                //link = (LinkButton)e.Row.FindControl("DeleteBetButton");
                //if (link != null)
                //{
                //    link.Enabled = (!bet.IsGame_DateNull() && bet.Game_Date >= DateConverter.ConvertToLocal(DateTime.Now.AddMinutes(5)));
                //    if (!link.Enabled)
                //    {
                //        link.ForeColor = Color.LightGray;
                //    }
                //    else
                //    {
                //        link.Attributes.Add("onclick", "return Confirm('Czy na pewno chcesz zrezygnować z tego zakładu?');");
                //    }
                //}

                if (!bet.IsPointsNull())
                {
                    if (bet.Points == 0)
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#FFD2CC");
                    }
                    else if (bet.Game_Team1Score == bet.Team1Score && bet.Game_Team2Score == bet.Team2Score)
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#BFFFFA");
                    }
                    else
                    {
                        e.Row.BackColor = ColorTranslator.FromHtml("#E2FFCC");
                    }
                }
            }
        }

        protected void BetsGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MakeBet")
            {
                DB.UsersRow user = UsersLogic.GetUserByLogin(User.Identity.Name);
                if (user != null)
                    MakeBetPopup.Show(Convert.ToInt32(e.CommandArgument), user.Id);
            }
        }

        public void MakeBetEndSaving()
        {
            BetsGV.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            BetsGV.DataBind();
        }
    }
}
