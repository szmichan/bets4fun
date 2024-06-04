<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminLeagues.aspx.cs" Inherits="Bets4Fun.Admin.AdminLeagues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Leagues management
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminMainCPH" runat="server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Block">
        <ContentTemplate>
            <div>
                    <asp:Label ID="lLeauges" runat="server" Text="Legaues:" Font-Bold="True"></asp:Label>
                    <asp:GridView ID="gvLeagues" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                        DataSourceID="LeaguesDSList" OnSelectedIndexChanged="gvLeagues_SelectedIndexChanged" Width="100%"
                        AllowPaging="True" AllowSorting="True" OnRowDeleting="gvLeagues_RowDeleting"
                        OnPageIndexChanged="gvLeagues_PageIndexChanged" PageSize="15">
                        <RowStyle BackColor="#FFFFF4" />
                        <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="Contest_Name" HeaderText="Contest" SortExpression="Contest_Name">
                                <ItemStyle Width="30%" HorizontalAlign="Center" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                <ItemStyle Width="20%" HorizontalAlign="Center" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="BettingForMoney" HeaderText="For money" SortExpression="BettingForMoney">
                                <ItemStyle Width="10%" HorizontalAlign="Center" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="EntryFee" SortExpression="EntryFee" HeaderText="Entry fee">
                                <ItemStyle HorizontalAlign="Right" Width="20%" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:BoundField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="SelectLinkButton" runat="server" CausesValidation="False" Text="select" CommandName="Select" Font-Bold="true">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="DeleteBetButton" runat="server" CausesValidation="False"
                                        CommandName="Delete" Text="delete" Font-Bold="true"
                                        OnClientClick="return Confirm('Are you sure you want to delete this league?');"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader"/>
                        <EmptyDataTemplate>
                            No Leagues
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#FFFFCC" />
                        <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" />
                        <AlternatingRowStyle BackColor="#EAF4FF" />
                    </asp:GridView>

                    <asp:ObjectDataSource ID="LeaguesDSList" runat="server" SelectMethod="GetLeagues"
                        TypeName="Bets4Fun.BusinessLogic.LeaguesLogic" DeleteMethod="DeleteLeague" OldValuesParameterFormatString="{0}">
                        <DeleteParameters>
                            <asp:Parameter Name="id" Type="Int32" />
                        </DeleteParameters>
                    </asp:ObjectDataSource>

                </div>
                <div style="margin-top: 50px;">
                    <asp:Label ID="lDetails" runat="server" Text="Dodawanie/edytowanie lig:" Font-Bold="True"></asp:Label>
                    <asp:DetailsView ID="dvLeagues" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
                        DataKeyNames="Id" DataSourceID="LeaguesDSMod" OnItemInserted="dvLeagues_ItemInserted" OnItemUpdated="dvLeagues_ItemUpdated"
                        DefaultMode="Insert" OnItemCommand="dvLeagues_ItemCommand" >
                        <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
                        <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
                        <Fields>
                            <asp:TemplateField HeaderText="Contest">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlContests" runat="server" DataSourceID="ContestsDS" DataTextField="Name"
                                        DataValueField="Id" SelectedValue='<%# Bind("Contest_Id") %>' Width="250px" ValidationGroup="Insert_Update">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="League name">
                               <EditItemTemplate>
                                    <asp:TextBox ID="tbName" runat="server" Text='<%# Bind("Name") %>' Width="50%" ValidationGroup="Insert_Update" />
                                    <asp:RequiredFieldValidator ID="NamerequiredValidator" runat="server" ErrorMessage="*"
                                        ControlToValidate="tbName" Display="Dynamic" ValidationGroup="Insert_Update" />
                                </EditItemTemplate>
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Betting for money">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="cbBettingForMoney" runat="server" Checked='<%# Bind("BettingForMoney") %>' />
                                </EditItemTemplate>
                               <ItemStyle CssClass="p-1" />
                               <HeaderStyle CssClass="p-1" />
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="Entry fee">
                               <EditItemTemplate>
                                    <asp:TextBox ID="tbEntryFee" runat="server" Text='<%#Bind("EntryFee")%>' Width="50px" ValidationGroup="Insert_Update" />
                                    <asp:RegularExpressionValidator ID="EntryFeedecimalValidator" runat="server" ErrorMessage="*"
                                        ControlToValidate="tbEntryFee" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic" ValidationGroup="Insert_Update" />
                                    <asp:RequiredFieldValidator ID="EntryFeerequiredValidator" runat="server" ErrorMessage="*"
                                        ControlToValidate="tbEntryFee" Display="Dynamic" ValidationGroup="Insert_Update" />
                                </EditItemTemplate>
                               <ItemStyle CssClass="p-1" />
                               <HeaderStyle CssClass="p-1" />
                           </asp:TemplateField>
                            <asp:CommandField ShowInsertButton="True" ShowEditButton="True" ButtonType="Button" 
                                              CancelText="cancel" DeleteText="delete" EditText="edit" InsertText="add" 
                                              NewText="new" SelectText="select" UpdateText="update" >
                                <ControlStyle CssClass="btn btn-primary" />
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:CommandField>
                        </Fields>
                        <InsertRowStyle BackColor="#EAF4FF" />
                        <EditRowStyle BackColor="#EAF4FF" />
                    </asp:DetailsView>
                  
                    <asp:ObjectDataSource ID="ContestsDS" runat="server"  SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic"  />
                    
                    <asp:ObjectDataSource ID="LeaguesDSMod" runat="server" InsertMethod="AddLeague"
                        SelectMethod="GetLeagueById" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic"
                        UpdateMethod="UpdateLeague" OnInserting="LeaguesDSMod_Inserting"
                        OnUpdating="LeaguesDSMod_Updating">
                         <SelectParameters>
                            <asp:ControlParameter ControlID="gvLeagues" DefaultValue="-1" Name="id" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                         <UpdateParameters>
                            <asp:Parameter Name="contestId" Type="Int32" />
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="bettingForMoney" Type="Boolean" />
                            <asp:Parameter Name="entryFee" Type="Decimal" />
                            <asp:Parameter Name="id" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="contestId" Type="Int32" />
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="bettingForMoney" Type="Boolean" />
                            <asp:Parameter Name="entryFee" Type="Decimal" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
