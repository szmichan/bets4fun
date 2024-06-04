<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucGameBets.ascx.cs"
    Inherits="Bets4Fun.UserControls.UcGameBets" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<link href="../App_Themes/Default/ModalPopupMakeBet.css" rel="stylesheet" type="text/css" />

<asp:Button ID="Button2" runat="server" Text="Button" Style="display: none" />
<act:ModalPopupExtender runat="server" ID="GameBetsPopup" TargetControlID="Button2"
    PopupControlID="ucGBPopupMain" DropShadow="false" BehaviorID="mpGameBets1" RepositionMode="RepositionOnWindowScroll"
    PopupDragHandleControlID="PopupHeader1" BackgroundCssClass="modalBackground" CancelControlID="Button2">
</act:ModalPopupExtender>

<div id="ucGBPopupMain" style="width: 520px; background-color: #F1FEED; display: none;">
    <div id="PopupHeader1" style="background-color: Black; height: 20px; cursor: move;">
        <div class="TitlebarLeft">
            <asp:Label ID="lCaption1" runat="server" Text="Zakłady dla wybranego meczu"></asp:Label>
        </div>
        <div onclick="$get('<%=OkButton1.ClientID %>').click();" class="TitlebarRight" id="cancelDiv">
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="PopupBody1" style="clear: both;">
                <br />
                <div style="text-align: center;">
                    <asp:Label ID="ContestLabel1" runat="server" Font-Bold="True" Font-Size="Large" />
                    <br />
                    <asp:Label ID="GameDateLabel1" runat="server" Font-Size="Medium" />
                </div>
                <table style="width: 100%">
                    <tr>
                        <td style="text-align: right; width: 45%;">
                            <asp:Label ID="lbTeam1Points" runat="server" Font-Size="X-Small"></asp:Label>
                        </td>
                        <td style="text-align: center; width: 10%;">
                            <asp:Label ID="lbDrawPoints" runat="server" Font-Size="X-Small"></asp:Label>
                        </td>
                        <td style="text-align: left; width: 45%;">
                            <asp:Label ID="lbTeam2Points" runat="server" Font-Size="X-Small"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            <asp:Label ID="Team1Label1" runat="server" Font-Bold="True"></asp:Label>
                            <asp:Image ID="imgTeam1" runat="server" ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                        </td>
                        <td style="text-align: center;">
                            <asp:Label ID="lbMultiplyValue" runat="server" Font-Size="X-Small"></asp:Label>
                        </td>
                        <td style="text-align: left;">
                            <asp:Image ID="imgTeam2" runat="server" ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                            <asp:Label ID="Team2Label1" runat="server" Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">
                            <asp:Label ID="Team1ScoreLabel1" runat="server" Font-Bold="True" Font-Size="Large" ></asp:Label>
                        </td>
                        <td style="text-align: center;">
                            :
                        </td>
                        <td style="text-align: left;">
                            <asp:Label ID="Team2ScoreLabel1" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div style="margin-left: 10px;">
                    <asp:Label ID="DescriptionLabel1" runat="server" Font-Italic="True"></asp:Label>
                </div>
                <br />
                <asp:GridView ID="BetsGV" runat="server" Width="100%" AllowPaging="True"
                    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id"
                    DataSourceID="BetsDS" OnRowDataBound="BetsGV_RowDataBound" PageSize="12">
                    <RowStyle BackColor="#FFFFF4" />
                    <Columns>
                        <asp:BoundField DataField="User_Login" HeaderText="Login" SortExpression="User_Login">
                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BetDate" DataFormatString="{0:d}, {0:t}" HeaderText="Data obstawienia" SortExpression="BetDate">
                            <ItemStyle HorizontalAlign="Center" Width="40%" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Team1Score" SortExpression="Team1Score">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Team1Score") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Team1Score") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderTemplate>
                                <asp:Label ID="HeaderTeam1Label" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Team2Score" SortExpression="Team2Score">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Team2Score") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Team2Score") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderTemplate>
                                <asp:Label ID="HeaderTeam2Label" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Pkt." SortExpression="Points" DataField="Points" NullDisplayText="-">
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:BoundField>
                    </Columns>
                    <PagerSettings FirstPageText="<<" LastPageText=">>" Mode="Numeric" />
                    <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader" />
                    <HeaderStyle BackColor="#4F9D9D" ForeColor="White" />
                    <AlternatingRowStyle BackColor="#EAF4FF" />
                    <EmptyDataRowStyle VerticalAlign="Top" HorizontalAlign="Center" BackColor="#FF6666" />
                    <EmptyDataTemplate>
                        <asp:Label ID="Empty" runat="server" Text="Brak Zakładów"></asp:Label>
                    </EmptyDataTemplate>
                </asp:GridView>
                <br />
                <div style="text-align: right">
                    <asp:Button ID="OkButton1" runat="server" Text="OK" CssClass="default_button" OnClientClick="$find('mpGameBets1').hide()" />
                </div>
                <asp:ObjectDataSource ID="BetsDS" runat="server" DeleteMethod="DeleteBet"
                    InsertMethod="InsertBet" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetBetsByGameId"
                    TypeName="Bets4Fun.BusinessLogic.BetsLogic" UpdateMethod="UpdateBet">
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="gameId" Type="Int32" />
                        <asp:Parameter Name="userId" Type="Int32" />
                        <asp:Parameter Name="team1Score" Type="Int32" />
                        <asp:Parameter Name="team2Score" Type="Int32" />
                        <asp:Parameter Name="id" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="-1" Name="gameId" Type="Int32" />
                        <asp:Parameter DefaultValue="-1" Name="User_Id" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="gameId" Type="Int32" />
                        <asp:Parameter Name="userId" Type="Int32" />
                        <asp:Parameter Name="team1Score" Type="Int32" />
                        <asp:Parameter Name="team2Score" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:HiddenField ID="GameIdHF" runat="server" />
                <asp:HiddenField ID="UserIdHF" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
