<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"
    CodeBehind="ContestInfo.aspx.cs" Inherits="Bets4Fun.User.ContestInfo" %>

<%@ Register Src="~/UserControls/ucMakeContestInfoBet.ascx" TagName="ucMakeContestInfoBet" TagPrefix="uc" %>
<%--<%@ Register Src="~/UserControls/ucGameBets.ascx" TagName="ucGameBets" TagPrefix="uc" %>--%>

<asp:Content ID="SubtitleContent" ContentPlaceHolderID="MainHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainSubtitleCPH" runat="server">
<%--    <div style="text-align: center; width: 100%; background-color: #66CCFF">--%>
        <asp:Label ID="lblContest" runat="server" Text="Zakłady turniejowe" Font-Size="X-Large"></asp:Label>
<%--    </div>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainMainCPH" runat="server">
    <div style="width: 100%; vertical-align: top;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Block">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="TitleLabel" runat="server" Text="Wyszukiwanie turniejów:" Font-Bold="True"></asp:Label>
                            <table style="border: solid 2px #000000;">
                                <tr>
                                    <td>
                                        <asp:Label ID="ContestLabel" runat="server" Text="Turniej:"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ContestDDL" runat="server" AutoPostBack="False" DataSourceID="ContestsDS"
                                            DataTextField="Name" DataValueField="Id" OnDataBound="ContestDDL_DataBound">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align: bottom">
                            <%--<asp:Button ID="ClearFilterButton" runat="server" Text="Czyść" Width="60px" 
                                onclick="ClearFilterButton_Click" ValidationGroup="ClearGroup" OnClientClick="return ClearFilter();"/>
                            <br/>--%>
                            <asp:Button ID="FilterButton" runat="server" Text="Szukaj" Width="60px" ValidationGroup="SearchGroup" />
                        </td>
                    </tr>
                </table>
                <div>
                    <asp:GridView ID="ContestsInfoGV" runat="server" AutoGenerateColumns="False" DataSourceID="ContestsInfoDS" DataKeyNames="Id"
                        Width="100%" AllowPaging="True" AllowSorting="True" OnRowDataBound="ContestsInfoGV_RowDataBound" OnRowCommand="ContestsInfoGV_RowCommand">
                        <RowStyle BackColor="#FFFFF4" />
                        <EmptyDataRowStyle VerticalAlign="Top" />
                        <Columns>
                            <asp:BoundField DataField="Contest_Name" HeaderText="Turniej" SortExpression="Contest_Name">
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Name" HeaderText="Nazwa zakładu" SortExpression="Name">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OptionName" HeaderText="Wynik zakładu" SortExpression="OptionName" NullDisplayText="-">
                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BettingDeadline" HeaderText="Ostateczny termin obstawienia" DataFormatString="{0:d} {0:t}" SortExpression="BettingDeadline">
                                <ItemStyle HorizontalAlign="Center" Width="15%"/>
                            </asp:BoundField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="BetLinkButton" runat="server" CausesValidation="False" Text='<%# Convert.ToBoolean(Eval("IsBet")) ? "zmień" : "obstaw" %>'
                                        CommandArgument='<%# Eval("Id") %>' CommandName="MakeContestInfoBet">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="AllBetsLink" runat="server" CausesValidation="False" Text="wszystkie<br/>zakłady"
                                        CommandArgument='<%#Eval("Id") %>' CommandName="ContestInfoBets">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Data meczu" SortExpression="GameDate">
                                <ItemTemplate>
                                    <asp:Label ID="DateLabel" runat="server" Text='<%#Eval("GameDate","{0:d}") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="TimeLabel" runat="server" Text='<%#Eval("GameDate","{0:t}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Wynik">
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="text-align: right; width: 45%">
                                                <asp:Label ID="lbTeam1Points" runat="server" Text='<%# "(" + ((Eval("Team1Points") != DBNull.Value) ? Eval("Team1Points") : "-") + ")" %>'
                                                    Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td style="text-align: center; width: 10%">
                                                <asp:Label ID="lbDrawPoints" runat="server" Text='<%# "(" + ((Eval("DrawPoints") != DBNull.Value) ? Eval("DrawPoints") : "-") + ")" %>'
                                                    Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td style="width: 45%;">
                                                <asp:Label ID="lbTeam2Points" runat="server" Text='<%# "(" + ((Eval("Team2Points") != DBNull.Value) ? Eval("Team2Points") : "-") + ")" %>'
                                                    Font-Size="X-Small"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:Label ID="lbTeam1Name" runat="server" Text='<%# Eval("Team1_Name") %>'></asp:Label>
                                                <asp:Image ID="imgTeam1" runat="server" Visible='<%# Eval("Team1_BannerImage") != DBNull.Value %>'
                                                    ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team1_BannerImage") %>' ImageAlign="AbsBottom"
                                                    Width="20px" Height="20px" />
                                            </td>
                                            <td style="text-align: center">
                                                :
                                            </td>
                                            <td>
                                                <asp:Image ID="imgTeam2" runat="server" Visible='<%# Eval("Team2_BannerImage") != DBNull.Value %>'
                                                    ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team2_BannerImage") %>' ImageAlign="AbsBottom"
                                                    Width="20px" Height="20px" />
                                                <asp:Label ID="Team2Label" runat="server" Text='<%# Eval("Team2_Name") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <asp:Label ID="Team1ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Team1Score")) != "")?Eval("Team1Score"):"-" %>'
                                                    Font-Size="Small"></asp:Label>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:Label ID="lbSign" runat="server" Text=":" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Team2ScoreLabel" runat="server" Text='<%# (Convert.ToString(Eval("Team2Score")) != "")?Eval("Team2Score"):"-" %>'
                                                    Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle Width="35%" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Label ID="InfoLabel" runat="server" Text="INFO" Style="cursor: help;" BackColor="#C7E2E2"
                                        BorderColor="#FF0066" Font-Bold="True" BorderWidth="2px" Font-Size="10px" ToolTip='<%# Eval("Description") %>'
                                        Visible='<%# Convert.ToString(Eval("Description")).Trim() != "" %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="BetLinkButton" runat="server" CausesValidation="False" Text='<%# Convert.ToBoolean(Eval("IsBet"))?"zmień":"obstaw" %>'
                                        CommandArgument='<%# Eval("Id") %>' CommandName="MakeBet">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="AllBetsLink" runat="server" CausesValidation="False" Text="wszystkie<br/>zakłady"
                                        CommandArgument='<%#Eval("Id") %>' CommandName="GameBets">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>--%>
                        </Columns>
                        <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" />
                        <EmptyDataTemplate>
                            Brak Danych
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#FFFFCC" />
                        <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="#EAF4FF" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ContestsDS" runat="server" OldValuesParameterFormatString="{0}"
                        SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic">
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ContestsInfoDS" runat="server" SelectMethod="GetContestsInfo"
                        TypeName="Bets4Fun.BusinessLogic.ContestsInfoLogic" FilterExpression="(({0} = -1) OR (Contest_Id = {0}))"
                        OnSelecting="ContestsInfoDS_Selecting">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="" Name="login" Type="String" />
                        </SelectParameters>
                        <FilterParameters>
                            <asp:ControlParameter ControlID="ContestDDL" Name="ContestId" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="-1" />
                            <%--                        <asp:ControlParameter ControlID="TeamDDL" Name="TeamId" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="-1" />
                            <asp:ControlParameter ControlID="DateFromCalendar" Name="DateFrom" PropertyName="SelectedDate"
                                Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
                            <asp:ControlParameter ControlID="DateToCalendar" Name="DateTo" PropertyName="SelectedDate"
                                Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
                            <asp:ControlParameter ControlID="GameStatusDDL" Name="GameStatus" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="-1" />
                            <asp:Parameter Name="Date" DefaultValue="" ConvertEmptyStringToNull="False" />
                            <asp:ControlParameter ControlID="BetStatusDDL" Name="BetStatus" PropertyName="SelectedValue"
                                Type="Int32" DefaultValue="-1" />--%>
                        </FilterParameters>
                    </asp:ObjectDataSource>
                </div>
<%--                <uc:ucGameBets runat="server" ID="GameBetsPopup" Visible="False"/>--%>
                <uc:ucMakeContestInfoBet runat="server" ID="MakeContestInfoBetPopup" OnEndSaving="MakeBetEndSaving" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
