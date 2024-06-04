<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="AdminTeams.aspx.cs" Inherits="Bets4Fun.Admin.AdminTeams" %>
<%@ Register Src="../UserControls/ucCalendar.ascx" TagName="ucCalendar" TagPrefix="uc1" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Teams management
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <div>
        <asp:Label ID="TeamsListLabel" runat="server" Text="Teams:" Font-Bold="True"></asp:Label>
        <asp:GridView ID="TeamsGV" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            DataSourceID="TeamsListDS" 
            OnSelectedIndexChanged="TeamsGV_SelectedIndexChanged" Width="100%"
            AllowPaging="True" AllowSorting="True" OnRowDeleting="TeamsGV_RowDeleting"
            OnPageIndexChanged="TeamsGV_PageIndexChanged" PageSize="15">
            <RowStyle BackColor="#FFFFF4" />
            <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="imgTeam1" runat="server" Visible='<%# Eval("BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px"/>
                    </ItemTemplate>
                    <ItemStyle Width="10%" HorizontalAlign="Center" CssClass="p-1" />
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" 
                    SortExpression="Name">
                    <ItemStyle Width="60%" HorizontalAlign="Center" CssClass="p-1"/>
                </asp:BoundField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="SelectLinkButton" runat="server" CausesValidation="False" Text="select" CommandName="Select" Font-Bold="true">
                        </asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="7.5%" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="DeleteBetButton" runat="server" CausesValidation="False"
                                        CommandName="Delete" Text="delete" Font-Bold="true"
                                        OnClientClick="return Confirm('Do you really want to remove this team?');"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="7.5%" />
                </asp:TemplateField>

            </Columns>
            <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader"/>
            <EmptyDataTemplate>
                No Teams
            </EmptyDataTemplate>
            <SelectedRowStyle BackColor="#FFFFCC" />
            <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" />
            <AlternatingRowStyle BackColor="#EAF4FF" />
        </asp:GridView>
        <asp:ObjectDataSource ID="TeamsListDS" runat="server" SelectMethod="GetTeams"
            TypeName="Bets4Fun.BusinessLogic.TeamsLogic" InsertMethod="AddTeam"
            DeleteMethod="DeleteTeam" UpdateMethod="UpdateTeam" 
            OldValuesParameterFormatString="{0}">
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="setUpDate" Type="DateTime" />
                <asp:Parameter Name="isNational" Type="Boolean" />
                <asp:Parameter Name="description" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="setUpDate" Type="DateTime" />
                <asp:Parameter Name="isNational" Type="Boolean" />
                <asp:Parameter Name="description" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div class="mt-5">
        <asp:Label ID="TeamsAddModLabel" runat="server" Text="Add/modify team:" Font-Bold="True"></asp:Label>
        <asp:DetailsView ID="TeamsDV" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
            DataKeyNames="Id" DataSourceID="TeamsModDS" OnItemInserted="TeamsDV_ItemInserted"
            OnItemUpdated="TeamsDV_ItemUpdated"
            DefaultMode="Insert" OnItemCommand="TeamsDV_ItemCommand">
            <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
            <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
            <Fields>
                <asp:TemplateField HeaderText="Team name" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbName" runat="server" Text='<%# Bind("Name") %>' Width="50%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbName" runat="server" Text='<%# Bind("Name") %>' Width="50%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbName" runat="server" Text='<%# Bind("Name") %>' Width="50%"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Setup date" SortExpression="SetUpDate">
                    <EditItemTemplate>
                        <uc1:ucCalendar ID="ucCalendar1" runat="server" SelectedDate='<%# Bind("SetUpDate", "{0:d}") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <uc1:ucCalendar ID="ucCalendar2" runat="server" SelectedDate='<%# Bind("SetUpDate", "{0:d}") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbSetUpDate" runat="server" Text='<%# Bind("SetUpDate", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Is national" SortExpression="IsNational">
                    <EditItemTemplate>
                        <asp:CheckBox ID="cbIsNational" runat="server" Checked='<%# Bind("IsNational") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="cbIsNational" runat="server" Checked='<%# Bind("IsNational") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbIsNational" runat="server" Checked='<%# Bind("IsNational") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbDesc" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            TextMode="MultiLine" Width="99%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbDesc" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            TextMode="MultiLine" Width="99%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbDesc" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            Width="99%"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Badge name" SortExpression="BannerImage">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbBannerImage" runat="server" Text='<%# Bind("BannerImage") %>' Width="50%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbBannerImage" runat="server" Text='<%# Bind("BannerImage") %>' Width="50%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbBannerImage" runat="server" Text='<%# Bind("BannerImage") %>' Width="50%"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100%" />
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" ShowEditButton="True" ButtonType="Button" 
                                  CancelText="cancel" DeleteText="delete" EditText="edit" InsertText="add" 
                                  NewText="new" SelectText="select" UpdateText="update" >
                    <ControlStyle CssClass="btn btn-primary " />
                </asp:CommandField>
            </Fields>
            <InsertRowStyle BackColor="#EAF4FF" />
            <EditRowStyle BackColor="#EAF4FF" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="TeamsModDS" runat="server" FilterExpression="Id={0}"
            InsertMethod="AddTeam" SelectMethod="GetTeams" TypeName="Bets4Fun.BusinessLogic.TeamsLogic"
            DeleteMethod="DeleteTeam" UpdateMethod="UpdateTeam" 
            OldValuesParameterFormatString="{0}">
            <FilterParameters>
                <asp:ControlParameter ControlID="TeamsGV" DefaultValue="" Name="@Id" PropertyName="SelectedValue" />
            </FilterParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="setUpDate" Type="DateTime" />
                <asp:Parameter Name="isNational" Type="Boolean" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="bannerImage" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="setUpDate" Type="DateTime" />
                <asp:Parameter Name="isNational" Type="Boolean" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="bannerImage" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
