namespace Bets4Fun.UserControls
{
    using System;
    using System.Globalization;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    [ToolboxData(@"<{0}:GridPager runat=""server"" PersistentDataSource=true></{0}:GridPager>")]
    public class GridPager : UserControl
    {
        #region Properties

        /// <summary>
        ///     Gets or sets the number of results.
        /// </summary>
        /// <value> The number of results. </value>
        public int NumberOfResults { get; set; }

        /// <summary>
        ///     Gets or sets the results to show per page.
        /// </summary>
        /// <value> The results to show per page. </value>
        public int ResultsToShowPerPage { get; set; }

        /// <summary>
        ///     Gets or sets the page links to show for pagination links.
        /// </summary>
        /// <value> The page links to show. </value>
        public int PageLinksToShow { get; set; }

        /// <summary>
        ///     Gets or sets a value indicating whether [show first and last].
        /// </summary>
        /// <value>
        ///     <c>true</c> if [show first and last]; otherwise, <c>false</c> .
        /// </value>
        public bool ShowFirstAndLast { get; set; }

        /// <summary>
        ///     Gets or sets a value indicating whether [show next and previous].
        /// </summary>
        /// <value>
        ///     <c>true</c> if [show next and previous]; otherwise, <c>false</c> .
        /// </value>
        public bool ShowNextAndPrevious { get; set; }

        /// <summary>
        ///     Gets or sets the next text.
        /// </summary>
        /// <value> The next text. </value>
        public string NextText { get; set; }

        /// <summary>
        ///     Gets or sets the previous text.
        /// </summary>
        /// <value> The previous text. </value>
        public string PreviousText { get; set; }

        /// <summary>
        ///     Gets or sets the first text.
        /// </summary>
        /// <value> The first text. </value>
        public string FirstText { get; set; }

        /// <summary>
        ///     Gets or sets the last text.
        /// </summary>
        /// <value> The last text. </value>
        public string LastText { get; set; }

        public GridView TheGrid { get; private set; }

        #endregion

        /// <summary>
        ///     Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender"> The source of the event. </param>
        /// <param name="e">
        ///     The <see cref="System.EventArgs" /> instance containing the event data.
        /// </param>
        protected void Page_Load(object sender, EventArgs e)
        {
            ResultsToShowPerPage = 5;

            var control = Parent;
            while (control != null)
            {
                if (control is GridView)
                {
                    TheGrid = (GridView) control;
                    break;
                }
                control = control.Parent;
            }
        }

        /// <summary>
        ///     Called by the ASP.NET page framework to notify server controls that use composition-based implementation to create any child controls they contain in preparation for posting back or rendering.
        /// </summary>
        protected override void CreateChildControls()
        {
            
            Controls.Add(new Literal { Text = "<div class=\"pagination text-center\"><ul>" });

            var min = Math.Min(Math.Max(0, TheGrid.PageIndex - ( PageLinksToShow/2 )),
                               Math.Max(0, TheGrid.PageCount - PageLinksToShow + 1));
            var max = Math.Min(TheGrid.PageCount, min + PageLinksToShow);

            if (ShowFirstAndLast)
            {
                AddLink(FirstText ?? "First", "firstPage", TheGrid.PageIndex > 0, "First");
            }

            if (ShowNextAndPrevious)
            {
                AddLink(PreviousText ?? "Previous", "previousPage", TheGrid.PageIndex > 0, "Prev");
            }

            for (var i = min; i < max; i++)
            {
                AddLink((i + 1).ToString(CultureInfo.InvariantCulture), "selected", TheGrid.PageIndex != i, (i + 1).ToString(CultureInfo.InvariantCulture));
            }

            if (ShowNextAndPrevious)
            {
                AddLink(NextText ?? "Next", "nextPage", TheGrid.PageIndex < TheGrid.PageCount - 1, "Next");
            }
            if (ShowFirstAndLast)
            {
                AddLink(LastText ?? "Last", "lastPage", TheGrid.PageIndex < TheGrid.PageCount - 1, "Last");
            }
            Controls.Add(new Literal {Text = "</ul></div>"});
            
        }


        /// <summary>
        /// Adds the link for the page (and next/last etc) or a label if its a deactivated link
        /// </summary>
        /// <param name="text">The text.</param>
        /// <param name="cssClass">The CSS class.</param>
        /// <param name="addAsLink">if set to <c>true</c> [add as link].</param>
        /// <param name="commandArgument">The command argument.</param>
        private void AddLink(String text, String cssClass, bool addAsLink, string commandArgument)
        {
            Controls.Add(new Literal {Text = "<li>"});
            if (addAsLink)
            {
                var button = new LinkButton
                    {
                        ID = "Page" + text,
                        CommandName = "Page",
                        CommandArgument = commandArgument,
                        Text = text
                    };

                Controls.Add(button);
            }
            else
            {
                Controls.Add(new Label {Text = text, CssClass = cssClass});
            }
            Controls.Add(new Literal {Text = "</li>"});
        }
    }
}