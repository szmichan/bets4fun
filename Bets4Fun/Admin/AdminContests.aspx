<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="AdminContests.aspx.cs" Inherits="Bets4Fun.Admin.AdminContests"%>

<asp:Content ID="HeadCPH" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Contests management
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <div>
        <asp:Label ID="ListLabel" runat="server" Text="Contests:" Font-Bold="True"></asp:Label>
        <asp:GridView ID="ContestsGV" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            DataSourceID="ContestsListDS" 
            OnSelectedIndexChanged="ContestsGV_SelectedIndexChanged" Width="100%" 
            AllowPaging="True" AllowSorting="True"
            OnRowDeleting="ContestsGV_RowDeleting" OnPageIndexChanged="ContestsGV_PageIndexChanged"
            PageSize="15"
            OnRowDataBound="ContestsGV_RowDataBound"
            OnRowCommand="ContestsGV_RowCommand">
            <RowStyle BackColor="#FFFFF4" />
            <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" 
                    SortExpression="Name">
                    <ItemStyle Width="70%" HorizontalAlign="Center" CssClass="p-1" />
                </asp:BoundField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="SelectLinkButton" runat="server" CausesValidation="False" Text="select" CommandName="Select" Font-Bold="true">
                        </asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="7.5%" CssClass="p-1"/>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="DeleteBetButton" runat="server" CausesValidation="False"
                                        CommandName="Delete" Text="delete" Font-Bold="true"
                                        OnClientClick="return Confirm('Do you really want to remove this contest?');"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="7.5%" CssClass="p-1"/>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemStyle Width="10%" Font-Bold="True" HorizontalAlign="Center" CssClass="p-1" />
                    <ItemTemplate>
                        <asp:LinkButton ID="SeedDataLink" runat="server" Text="seed"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader"/>
            <EmptyDataTemplate>
                No Contests
            </EmptyDataTemplate>
            <SelectedRowStyle BackColor="#FFFFCC" />
            <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" 
                HorizontalAlign="Center" />
            <AlternatingRowStyle BackColor="#EAF4FF" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ContestsListDS" runat="server" SelectMethod="GetContests"
            TypeName="Bets4Fun.BusinessLogic.ContestsLogic" InsertMethod="AddContest"
            DeleteMethod="DeleteContest" UpdateMethod="UpdateContest">
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div class="mt-5">
        <asp:Label ID="AddModifyLabel" runat="server" Text="Add/modify contest:" Font-Bold="True" ></asp:Label>
        <asp:DetailsView ID="ContestsDV" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
            DataKeyNames="Id" DataSourceID="ContestsDetailsDS" OnItemInserted="ContestsDV_ItemInserted"
            OnItemUpdated="ContestsDV_ItemUpdated"
            DefaultMode="Insert" OnItemCommand="ContestsDV_ItemCommand" >
            <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
            <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
            <Fields>
                <asp:TemplateField HeaderText="Contest name" SortExpression="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>' 
                            Width="50%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>' 
                            Width="50%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>' Width="50%" 
                            ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' Height="100px"
                            TextMode="MultiLine" Width="99%"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' Height="100px"
                            TextMode="MultiLine" Width="99%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Description") %>' Width="99%"
                            Height="100px" ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle VerticalAlign="Middle" />
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
        <asp:ObjectDataSource ID="ContestsDetailsDS" runat="server" FilterExpression="Id={0}"
            InsertMethod="AddContest" SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic"
            DeleteMethod="DeleteContest" UpdateMethod="UpdateContest" 
            oninserted="ContestsDetailsDS_Inserted">
            <FilterParameters>
                <asp:ControlParameter ControlID="ContestsGV" DefaultValue="" Name="@Id" PropertyName="SelectedValue" />
            </FilterParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
