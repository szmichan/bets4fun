<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"
    CodeBehind="Bets.aspx.cs" Inherits="Bets4Fun.User.Bets" %>
<%@ Import Namespace="Bets4Fun.Common" %>

<%@ Register Src="~/UserControls/ucCalendar.ascx" TagName="ucCalendar" TagPrefix="uc" %>
<%@ Register Src="~/UserControls/ucMakeBet.ascx" TagName="ucMakeBet" TagPrefix="uc" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="MainHeadCPH" runat="server">

    <script type="text/javascript">
        function ClearFilter()
        {
            $get('<%=BetDateFromCalendar.TextBoxDate.ClientID %>').value = '';
            $get('<%=BetDateToCalendar.TextBoxDate.ClientID %>').value = '';
            $get('<%=GameDateFromCalendar.TextBoxDate.ClientID %>').value = '';
            $get('<%=GameDateToCalendar.TextBoxDate.ClientID %>').value = '';

            $get('<%=BetDateFromCalendar.DateValidator.ClientID %>').style.display = 'none';
            $get('<%=BetDateToCalendar.DateValidator.ClientID %>').style.display = 'none';
            $get('<%=GameDateFromCalendar.DateValidator.ClientID %>').style.display = 'none';
            $get('<%=GameDateToCalendar.DateValidator.ClientID %>').style.display = 'none';

            $get('<%=ContestDDL.ClientID %>').value = '';
            $get('<%=GameStatusDDL.ClientID %>').value = '';

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="MainSubtitleCPH" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainMainCPH" runat="server">
    <div style="width: 100%; vertical-align: top;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Block">
            <ContentTemplate>
                <button type="button" class="btn btn-info btn-block" data-target="#filters" data-toggle="collapse" aria-expanded="false" aria-controls="filters" onclick="checkToggle($(this),'Bets.aspx/SaveCollapsedState')">Toggle Filters</button>
                <div id="filters" class="px-4 <%= HttpContext.Current.Session["collapsed-bets"].ToString() %>" style="background-color:#7abcc7">
                     <div class="pt-4 form-group row">
                        <label for="BetDateFromCalendar" class="col-sm-2 col-form-label"><b>Bet date:</b></label>
                        <div class="col-sm-3">
                            <span>from</span>
                            <uc:ucCalendar ID="BetDateFromCalendar" runat="server" 
                                ValidationGroup="SearchGroup" />

                        </div>
                        <div class="col-sm-3">
                            <span>to</span>
                            <uc:ucCalendar ID="BetDateToCalendar" runat="server" 
                                           ValidationGroup="SearchGroup" />
                         </div>
                      </div>
                      <div class="form-group row">
                        <label for="GameDateFromCalendar" class="col-sm-2 col-form-label"><b>Game date:</b></label>
                        <div class="col-sm-3">
                            <span>from</span>
                            <uc:ucCalendar ID="GameDateFromCalendar" runat="server" 
                                ValidationGroup="SearchGroup" />
                        </div>
                        <div class="col-sm-3">
                          <span>to</span>
                          <uc:ucCalendar ID="GameDateToCalendar" runat="server" 
                                         ValidationGroup="SearchGroup" />
                        </div>
                      </div>
                    <div class="form-group row" >
                        <label for="ContestDDL" class="col-sm-2 col-form-label"><b>Competition:</b></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ContestDDL" runat="server" AutoPostBack="False" DataSourceID="ContestsDS"
                                DataTextField="Name" DataValueField="Id" OnDataBound="ContestDDL_DataBound" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                      </div>
                     <div class="form-group row">
                        <label for="GameStatusDDL" class="col-sm-2 col-form-label"><b>Game state:</b></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="GameStatusDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">[all]</asp:ListItem>
                                <asp:ListItem Value="0">finished/ongoing</asp:ListItem>
                                <asp:ListItem Value="1">to be played</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                      </div>
                      <button type="button" class="btn btn-primary mb-4" onclick="return ClearFilter();">Clear</button>
                      <asp:Button ID="Button1" runat="server" Text="Search" ValidationGroup="SearchGroup" CssClass="btn btn-primary make-bet--refresh-grid mb-4" OnClick="Button1_Click"/>
                </div>
                <br />
                <asp:GridView ID="BetsGV" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                    DataSourceID="BetsDS" AllowSorting="True" AllowPaging="True" Width="100%"
                    OnRowDataBound="BetsGV_RowDataBound" OnRowCommand="BetsGV_RowCommand"
                    PageSize="100">
                    <Columns>
                        <asp:TemplateField HeaderText="Result">
                            <ItemTemplate>
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="text-align: center;" colspan="3">
                                            <asp:Label ID="lbContestName" runat="server" Text='<%# Eval("Contest_Name") %>' Font-Size="Large" Font-Bold="True"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="3">
                                            <asp:Label ID="lbDate" runat="server" Text='<%# DateConverter.ConvertToCest((DateTimeOffset)Eval("Game_Date")).ToString("yyyy-MM-dd, HH:mm") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right; width: 45%">
                                            <asp:Label ID="lbTeam1Points" runat="server" Text='<%# "(" + ((Eval("Game_Team1Points") != DBNull.Value) ? Eval("Game_Team1Points") : "-") + ")" %>'
                                                Font-Size="X-Small"></asp:Label>
                                        </td>
                                        <td style="text-align: center; width: 10%">
                                            <asp:Label ID="lbDrawPoints" runat="server" Text='<%# "(" + ((Eval("Game_DrawPoints") != DBNull.Value) ? Eval("Game_DrawPoints") : "-") + ")" %>'
                                                Font-Size="X-Small"></asp:Label>
                                        </td>
                                        <td style="text-align: left; width: 45%;">
                                            <asp:Label ID="lbTeam2Points" runat="server" Text='<%# "(" + ((Eval("Game_Team2Points") != DBNull.Value) ? Eval("Game_Team2Points") : "-") + ")" %>'
                                                Font-Size="X-Small"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            <asp:Label ID="Team1Label" runat="server" Text='<%# Eval("Team1_Name") %>'></asp:Label>
                                            <asp:Image ID="imgTeam1" runat="server" Visible='<%# Eval("Team1_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team1_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                                        </td>
                                        <td style="text-align: center;">
                                             <asp:Label ID="lbMultiplyValue" runat="server" Text='<%# "(" + ((Eval("MultiplyValue") != DBNull.Value) ? Eval("MultiplyValue") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                        </td>
                                        <td style="text-align: left;">
                                            <asp:Image ID="imgTeam2" runat="server" Visible='<%# Eval("Team2_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team2_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                                            <asp:Label ID="Team2Label" runat="server" Text='<%# Eval("Team2_Name") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            <asp:Label ID="GameTeam1ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Game_Team1Score")) != "") ? Eval("Game_Team1Score") : "-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td style="text-align: center;">
                                            :
                                        </td>
                                        <td style="text-align: left;">
                                            <asp:Label ID="GameTeam2ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Game_Team2Score")) != "") ? Eval("Game_Team2Score") : "-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>                                   
                                </table>
                            </ItemTemplate>
                            <ItemStyle Width="70%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bet">
                            <ItemTemplate>
                                <table style="width: 100%">
                                    <tr>
                                        <td style="text-align: right; width: 45%">
                                            <asp:Label ID="Team1ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Team1Score")) != "")?Eval("Team1Score"):"-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td style="text-align: center; width: 10%">
                                            :
                                        </td>
                                        <td style="text-align: left; width: 45%">
                                            <asp:Label ID="Team2ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Team2Score")) != "")?Eval("Team2Score"):"-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <asp:PlaceHolder ID="btnsPlaceholder" runat="server" Visible='<%#(DateTimeOffset)Eval("Game_Date") > DateTimeOffset.UtcNow.AddMinutes(5) %>'>
                                    <button type="button" class="btn btn-secondary bg-light" data-toggle="modal" data-target="#betModal" onclick="MakeBet_Load(event,$(this),<%# Eval("Game_Id") %>,<%# HttpContext.Current.Session["USER_ID"] %>)">
                                        <img alt="change" src="../App_Themes/Default/Images/edit.svg"/>
                                    </button>
                                </asp:PlaceHolder>
                            </ItemTemplate>
                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Pts" DataField="Points" SortExpression="Points" NullDisplayText="-">
                            <ItemStyle Width="15%" HorizontalAlign="Center" Font-Bold="True" Font-Size="Large"/>
                        </asp:BoundField>
                    </Columns>
                    <PagerSettings FirstPageText="<<" LastPageText=">>" Mode="Numeric" />
                    <RowStyle BackColor="#FFFFF4" />
                    <EmptyDataRowStyle VerticalAlign="Top" />
                    <EmptyDataTemplate>
                        No results found for specified filters
                    </EmptyDataTemplate>
                    <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader" />
                    <HeaderStyle BackColor="#4F9D9D" ForeColor="White" HorizontalAlign="Center" CssClass="pagerHeader" />
                    <AlternatingRowStyle BackColor="#EAF4FF" />
                </asp:GridView>
                <asp:ObjectDataSource ID="BetsDS" runat="server" OldValuesParameterFormatString="{0}"
                    SelectMethod="GetBetsByFilter" TypeName="Bets4Fun.BusinessLogic.BetsLogic"
                    OnSelecting="BetsDS_Selecting" 
                    DeleteMethod="DeleteBet" InsertMethod="InsertBet" UpdateMethod="UpdateBet">
                    <UpdateParameters>
                        <asp:Parameter Name="gameId" Type="Int32" />
                        <asp:Parameter Name="userId" Type="Int32" />
                        <asp:Parameter Name="team1Score" Type="Int32" />
                        <asp:Parameter Name="team2Score" Type="Int32" />
                        <asp:Parameter Name="id" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ContestDDL" Name="contestId" PropertyName="SelectedValue"
                            Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                        <asp:ControlParameter ControlID="BetDateFromCalendar" Name="betDateFrom" PropertyName="SelectedDate"
                            DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue="" />
                        <asp:ControlParameter ControlID="BetDateToCalendar" Name="betDateTo" PropertyName="SelectedDate"
                            DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue="" />
                        <asp:ControlParameter ControlID="GameDateFromCalendar" Name="gameDateFrom" PropertyName="SelectedDate"
                            DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue="" />
                        <asp:ControlParameter ControlID="GameDateToCalendar" Name="gameDateTo" PropertyName="SelectedDate"
                            DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue="" />
                        <asp:ControlParameter ControlID="GameStatusDDL" Name="gameStatus" PropertyName="SelectedValue"
                            Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                        <asp:Parameter Name="date" ConvertEmptyStringToNull="true" DbType="DateTimeOffset"/>
                        <asp:Parameter Name="login" Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="gameId" Type="Int32" />
                        <asp:Parameter Name="userId" Type="Int32" />
                        <asp:Parameter Name="team1Score" Type="Int32" />
                        <asp:Parameter Name="team2Score" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:DropDownList ID="GamesDDL" runat="server" DataSourceID="GamesDS" DataTextField="GameFullName"
                    DataValueField="Id" Visible="False">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="GamesDS" runat="server" OldValuesParameterFormatString="{0}"
                    SelectMethod="GetGames" TypeName="Bets4Fun.BusinessLogic.GamesLogic"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ContestsDS" runat="server" OldValuesParameterFormatString="{0}"
                    SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic"></asp:ObjectDataSource>
                <uc:ucMakeBet runat="server" ID="MakeBetPopup" OnEndSaving="MakeBetEndSaving" />

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>