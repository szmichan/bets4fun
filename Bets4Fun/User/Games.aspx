<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" UICulture="auto"
    CodeBehind="Games.aspx.cs" Inherits="Bets4Fun.User.Games" %>
<%@ Import Namespace="Bets4Fun.Common" %>

<%@ Register Src="~/UserControls/ucCalendar.ascx" TagName="ucCalendar" TagPrefix="uc" %>
<%@ Register Src="~/UserControls/ucMakeBet.ascx" TagName="ucMakeBet" TagPrefix="uc" %>
<%@ Register Src="~/UserControls/ucGameBets.ascx" TagName="ucGameBets" TagPrefix="uc" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="MainHeadCPH" runat="server">

    <script type="text/javascript">
    
    function ClearFilter() {
        $get('<%=DateFromCalendar.TextBoxDate.ClientID %>').value = '';
        $get('<%=DateToCalendar.TextBoxDate.ClientID %>').value = '';
        
        $get('<%=DateFromCalendar.DateValidator.ClientID %>').style.display = 'none';
        $get('<%=DateToCalendar.DateValidator.ClientID %>').style.display = 'none';

        $get('<%=ContestDDL.ClientID %>').value = '';
        $get('<%=TeamDDL.ClientID %>').value = '';
        $get('<%=GameStatusDDL.ClientID %>').value = '';
        $get('<%=BetStatusDDL.ClientID %>').value = '';
        
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
                <button type="button" class="btn btn-info btn-block" data-target="#filters" data-toggle="collapse" aria-expanded="false" aria-controls="filters" onclick="checkToggle($(this),'Games.aspx/SaveCollapsedState')">Toggle Filters</button>
                <div id="filters" class="px-4 <%= HttpContext.Current.Session["collapsed-games"].ToString() %>" style="background-color:#7abcc7">
                    <div class="pt-4 form-group row" >
                        <label for="ContestDDL" class="col-sm-2 col-form-label"><b>Competition:</b></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ContestDDL" runat="server" AutoPostBack="False" DataSourceID="ContestsDS"
                                DataTextField="Name" DataValueField="Id" OnDataBound="ContestDDL_DataBound" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="TeamDDL" class="col-sm-2 col-form-label"><b>Team:</b></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="TeamDDL" runat="server" DataSourceID="TeamsDS" OnDataBound="TeamDDL_DataBound"
                                DataTextField="Name" DataValueField="Id" CssClass="form-control">
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
                      <div class="form-group row">
                        <label for="BetStatusDDL" class="col-sm-2 col-form-label"><b>Bet state:</b></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="BetStatusDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">[all]</asp:ListItem>
                                <asp:ListItem Value="1">bet</asp:ListItem>
                                <asp:ListItem Value="0">not bet</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="DateFromCalendar" class="col-sm-2 col-form-label"><b>Game date:</b></label>
                          <div class="col-sm-3">
                                <span>from</span>
                                <uc:ucCalendar ID="DateFromCalendar" runat="server" 
                                    ValidationGroup="SearchGroup" />
                            </div>
                            <div class="col-sm-3">
                                <span>to</span>
                                <uc:ucCalendar ID="DateToCalendar" runat="server" 
                                               ValidationGroup="SearchGroup" />
                            </div>
         

                      </div>
                      <button type="button" class="btn btn-primary mb-4" onclick="return ClearFilter();">Clear</button>
                    <asp:Button ID="FilterButton" runat="server" Text="Search" ValidationGroup="SearchGroup" CssClass="btn btn-primary make-bet--refresh-grid  mb-4" OnClick="FilterButton_Click"/>
                </div>
                <br />
                <div>
                    <asp:GridView ID="GamesGV" runat="server" AutoGenerateColumns="False" DataSourceID="GamesDS"
                        Width="100%" AllowPaging="True" AllowSorting="True" OnRowCommand="GamesGV_RowCommand" DataKeyNames="Id"
                        OnRowDataBound="GamesGV_RowDataBound" PageSize="100">
                        <RowStyle BackColor="#FFFFF4" />
                        <EmptyDataRowStyle VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField HeaderText="Result">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="text-align: center;" colspan="3">
                                                <asp:Label ID="lbContestName" runat="server" Text='<%# Eval("Contest_Name") %>' Font-Size="Large" Font-Bold="True"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;" colspan="3">
                                                <asp:Label ID="DateLabel" runat="server" Text='<%#DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("yyyy-MM-dd, HH:mm") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; width: 45%">
                                                <asp:Label ID="lbTeam1Points" runat="server" Text='<%# "(" + (Eval("Team1Points") != DBNull.Value ? Eval("Team1Points") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td style="text-align: center; width: 10%">
                                                <asp:Label ID="lbDrawPoints" runat="server" Text='<%# "(" + (Eval("DrawPoints") != DBNull.Value ? Eval("DrawPoints") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td style="width: 45%;">
                                                <asp:Label ID="lbTeam2Points" runat="server" Text='<%# "(" + (Eval("Team2Points") != DBNull.Value ? Eval("Team2Points") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:Label ID="lbTeam1Name" runat="server" Text='<%# Eval("Team1_Name") %>'></asp:Label>
                                                <asp:Image ID="imgTeam1" runat="server" Visible='<%# Eval("Team1_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team1_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px"/>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:Label ID="Label2" runat="server" Text='<%# "(" + ((Eval("MultiplyValue") != DBNull.Value) ? Eval("MultiplyValue") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Image ID="imgTeam2" runat="server" Visible='<%# Eval("Team2_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team2_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px"/>
                                                <asp:Label ID="Team2Label" runat="server" Text='<%# Eval("Team2_Name") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:Label ID="Team1ScoreLabel" runat="server" Text='<%# Eval("Team1Score") != DBNull.Value ? Eval("Team1Score") : "-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:Label ID="lbSign" runat="server" Text=":" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Team2ScoreLabel" runat="server" Text='<%# Eval("Team2Score") != DBNull.Value ? Eval("Team2Score") : "-" %>' Font-Size="Large" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle Width="80%" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:PlaceHolder ID="changeBtnPlaceholder" runat="server" Visible='<%#(DateTimeOffset)Eval("GameDate") > DateTimeOffset.UtcNow.AddMinutes(5) %>'>
                                        <button type="button" class="btn btn-secondary bg-light" data-toggle="modal" data-target="#betModal" <%#(DateTimeOffset)Eval("GameDate") > DateTimeOffset.UtcNow.AddMinutes(5) ? "" : "disabled" %> onclick="MakeBet_Load(event,$(this),<%# Eval("Id") %>,<%# HttpContext.Current.Session["USER_ID"] %>)">
                                            <img alt="change" src="../App_Themes/Default/Images/edit.svg"  />
                                        </button>
                                    </asp:PlaceHolder>
                                    <asp:PlaceHolder ID="betsBtnPlaceholder" runat="server" Visible='<%# (DateTimeOffset)Eval("GameDate") < DateTimeOffset.UtcNow.AddMinutes(-5) || Roles.IsUserInRole(User.Identity.Name, "Admin") %>'>
                                        <button type="button" class="btn btn-secondary bg-light" data-toggle="modal" data-target="#allBetsModal" onclick="ShowAllBets_Load(event,$(this),<%# Eval("Id") %>,<%# HttpContext.Current.Session["USER_ID"] %>)">
                                            <img alt="all bets" src="../App_Themes/Default/Images/list.svg"  />
                                        </button>
                                    </asp:PlaceHolder>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader"/>
                        <EmptyDataTemplate>
                            No results found for specified filters
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#FFFFCC" />
                        <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" HorizontalAlign="Center" CssClass="pagerHeader"/>
                        <AlternatingRowStyle BackColor="#EAF4FF" />
                    </asp:GridView>
                    <%-- w zależności od opcji filtrowania zmienić FilterExpression i uzyć innej funkcji w SelectMethod--%>
                    <asp:ObjectDataSource ID="GamesDS" runat="server" SelectMethod="GetGamesByFilter"
                        TypeName="Bets4Fun.BusinessLogic.GamesLogic"
                        OnSelecting="GamesDS_Selecting">
                        <SelectParameters>
                            <%-- 2-ga opcja filtrowania po statusie zakładu
                            <asp:ControlParameter ControlID="BetStatusDDL" Name="BetStatus" PropertyName="SelectedValue"
                            Type="Boolean" DefaultValue="" />  
                         --%>
                            <asp:ControlParameter ControlID="ContestDDL" Name="contestId" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                            <asp:ControlParameter ControlID="TeamDDL" Name="teamId" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                            <asp:ControlParameter ControlID="DateFromCalendar" Name="dateFrom" PropertyName="SelectedDate"
                                DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue=""  />
                            <asp:ControlParameter ControlID="DateToCalendar" Name="dateTo" PropertyName="SelectedDate"
                                DbType="DateTimeOffset" ConvertEmptyStringToNull="true" DefaultValue=""  />
                            <asp:ControlParameter ControlID="GameStatusDDL" Name="gameStatus" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true"/>
                            <asp:Parameter Name="date" ConvertEmptyStringToNull="true" DbType="DateTimeOffset" />
                            <asp:ControlParameter ControlID="BetStatusDDL" Name="betStatus" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="" ConvertEmptyStringToNull="true" />
                            <asp:Parameter DefaultValue="" Name="login" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ContestsDS" runat="server" OldValuesParameterFormatString="{0}"
                        SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic">
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="TeamsDS" runat="server" SelectMethod="GetTeams" TypeName="Bets4Fun.BusinessLogic.TeamsLogic">
                    </asp:ObjectDataSource>
                    <br />
                </div>
                
                <uc:ucGameBets runat="server" ID="GameBetsPopup" Visible="False"/>
                <uc:ucMakeBet runat="server" ID="MakeBetPopup" OnEndSaving="MakeBetEndSaving" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>