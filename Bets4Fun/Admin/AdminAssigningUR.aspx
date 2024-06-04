<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminAssigningUR.aspx.cs" Inherits="Bets4Fun.Admin.AdminAssigningUr" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    <asp:Label ID="AssigningLabel" runat="server" Text="Przypisywanie Użytkowników do Ról" Font-Size="Medium"></asp:Label>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Block">
        <ContentTemplate>
            <div style="width: 100%;">
                <asp:Label ID="UserLabel" runat="server" Text="Użytkownik:"></asp:Label>
                <asp:DropDownList ID="UsersDDL" runat="server" DataSourceID="UsersAssignDS" DataTextField="Login"
                    DataValueField="Id" Width="30%" AutoPostBack="True">
                </asp:DropDownList>
                <br />
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 45%;">
                            <asp:Label ID="AvailableRolesLabel" runat="server" Text="Dostępne Role:"></asp:Label>
                            <br />
                            <asp:ListBox ID="AvailableRolesListBox" runat="server" Width="100%" SelectionMode="Multiple"
                                DataSourceID="RolesAvailableDS" DataTextField="Name" DataValueField="Id"></asp:ListBox>
                        </td>
                        <td style="padding-top: 20px; width: 10%; text-align: center;">
                            <asp:Button ID="AssignRolesButton" runat="server" Text=">" OnClick="AssignRolesButton_Click" CssClass="button_def" Width="50px" />
                            <br />
                            <asp:Button ID="RevokeRolesButton" runat="server" Text="<" OnClick="RevokeRolesButton_Click" CssClass="button_def" Width="50px" />
                        </td>
                        <td style="width: 45%;">
                            <asp:Label ID="AssignedRolesLabel" runat="server" Text="Przypisane Role:"></asp:Label>
                            <br />
                            <asp:ListBox ID="AssignedRolesListBox" runat="server" Width="100%" SelectionMode="Multiple"
                                DataSourceID="RolesUserDS" DataTextField="Name" DataValueField="Id"></asp:ListBox>
                        </td>
                    </tr>
                </table>
                <hr />
                <br />
                <asp:Label ID="lContest" runat="server" Text="Turniej:"></asp:Label>
                <asp:DropDownList ID="ddlContests" runat="server" DataSourceID="ContestsDS" DataTextField="Name"
                    DataValueField="Id" Width="30%" AutoPostBack="True">
                </asp:DropDownList>
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 45%;">
                            <asp:Label ID="lbNotAssignedLeagues" runat="server" Text="Dostępne Ligi:"></asp:Label>
                            <br />
                            <div style="border: thin solid; overflow: auto; height: 200px; background-color: white;">
                                 <asp:Repeater ID="repAvailable" runat="server" DataSourceID="dsNotAssignedLeagues">
                                    <HeaderTemplate>
                                        <table border="0">
                                            <thead>
                                                <tr style="background-color: gray;">
                                                    <th></th>
                                                    <th><asp:Label ID="lNameHeader" runat="server" Text="Nazwa"></asp:Label></th>
                                                    <th><asp:Label ID="lBettingForMoneyHeader" runat="server" Text="$"></asp:Label></th>
                                                    <th><asp:Label ID="lEntryFeeHeader" runat="server" Text="Wpisowe"></asp:Label></th>
                                                </tr>
                                            </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="hfLeagueID" runat="server" Value='<%# Eval("Id")%>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbLeagueName" runat="server" Text='<%# Eval("Name")%>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbBettingForMoney" runat="server" Checked='<%# Eval("BettingForMoney")%>'/>
                                            </td>
                                            <td>
                                                <asp:Label ID="lEntryFee" runat="server" Text='<%# Eval("EntryFee")%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                        <td style="padding-top: 20px; width: 10%; text-align: center;">
                            <asp:Button ID="btnAssignLeagues" runat="server" Text=">" OnClick="BtnAssignLeagues_Click" CssClass="button_def" Width="50px" />
                            <br />
                            <asp:Button ID="btnRevokeLeagues" runat="server" Text="<" OnClick="BtnRevokeLeagues_Click" CssClass="button_def" Width="50px" />
                        </td>
                        <td style="width: 45%;">
                            <asp:Label ID="lbAssignedLeagues" runat="server" Text="Przypisane Ligi:"></asp:Label>
                            <br />
                            <div style="border: thin solid; overflow: auto; height: 200px; background-color: white;">
                                <asp:Repeater ID="repAssigned" runat="server" DataSourceID="dsAssignedLeagues">
                                    <HeaderTemplate>
                                        <table border="0">
                                            <thead>
                                                <tr style="background-color: gray;">
                                                    <th></th>
                                                    <th><asp:Label ID="lNameHeader" runat="server" Text="Nazwa"></asp:Label></th>
                                                    <th><asp:Label ID="lBettingForMoneyHeader" runat="server" Text="$"></asp:Label></th>
                                                    <th><asp:Label ID="lEntryFeeHeader" runat="server" Text="Wpisowe"></asp:Label></th>
                                                </tr>
                                            </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="hfLeagueID" runat="server" Value='<%# Eval("Id")%>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbLeagueName" runat="server" Text='<%# Eval("Name")%>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbBettingForMoney" runat="server" Checked='<%# Eval("BettingForMoney")%>'/>
                                            </td>
                                            <td>
                                                <asp:Label ID="lEntryFee" runat="server" Text='<%# Eval("EntryFee")%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                               <%-- <asp:Repeater ID="repAssignedLeagues" runat="server" DataSourceID="dsAssignedLeagues">
                                    <HeaderTemplate>
                                        <table border="0">
                                            <thead>
                                                <tr style="background-color: gray;">
                                                    <th></th>
                                                    <th style="width: 200px"></th>

                                                </tr>
                                            </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="hfLeagueID" runat="server" Value='<%# Eval("Id")%>' />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbAssignedLeague" runat="server" Text='<%# Eval("Name")%>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>--%>
                            </div>
                        </td>
                    </tr>
                </table>

                <asp:ObjectDataSource ID="ContestsDS" runat="server"  SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic"  />
                    
                <asp:ObjectDataSource ID="UsersAssignDS" runat="server" SelectMethod="GetUsers" TypeName="Bets4Fun.BusinessLogic.UsersLogic" />

                <asp:ObjectDataSource ID="RolesUserDS" runat="server" SelectMethod="GetUserRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="UsersDDL" Name="id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>

                <asp:ObjectDataSource ID="RolesAvailableDS" runat="server" SelectMethod="GetNotUserRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="UsersDDL" Name="id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>

                <asp:ObjectDataSource ID="dsAssignedLeagues" runat="server" SelectMethod="GetUserLeagues" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="UsersDDL" Name="userId" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>

                <asp:ObjectDataSource ID="dsNotAssignedLeagues" runat="server" SelectMethod="GetNotUserLeagues" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="UsersDDL" Name="userId" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
