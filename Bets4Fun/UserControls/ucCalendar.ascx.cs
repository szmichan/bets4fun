using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bets4Fun.UserControls
{
    [ControlValueProperty("SelectedDate")]
    [ValidationPropertyAttribute("SelectedDate")]
    public partial class UcCalendar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public TextBox TextBoxDate
        {
            get => tbDateEdit;
            set => tbDateEdit = value;
        }

        public CustomValidator DateValidator => cvDateEdit;

        //public string TextBoxID
        //{
        //    get { return this.ID + "_" + TextBoxDate.ID; }
        //}

        [Bindable(true, BindingDirection.TwoWay)]
        public string SelectedDate
        {
            get => tbDateEdit.Text;
            set => tbDateEdit.Text = value;
        }

        //public bool AutoPostBack
        //{
        //    get { return tbDateEdit.AutoPostBack; }
        //    set { tbDateEdit.AutoPostBack = value; }
        //}

        //public string abc
        //{
        //    get { return "";}
        //    set { ;}
        //}

        //public Unit Width
        //{
        //    set { this.tbDateEdit.Width = value; }
        //    get { return this.tbDateEdit.Width; }
        //}

        public string ValidationGroup
        {
            get => tbDateEdit.ValidationGroup;
            set
            {
                tbDateEdit.ValidationGroup = value;
                cvDateEdit.ValidationGroup = value;
            }
        }

        public bool Required
        {
            get;
            set;
        }
    }
}