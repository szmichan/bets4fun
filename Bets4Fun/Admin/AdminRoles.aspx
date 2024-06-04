<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminRoles.aspx.cs" Inherits="Bets4Fun.Admin.AdminRoles" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Roles management
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
<div>
                    <asp:Label ID="Label2" runat="server" Text="Roles:" Font-Bold="True"></asp:Label>
                    <asp:GridView ID="RolesGV" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                        DataSourceID="RolesDSList" OnSelectedIndexChanged="RolesGV_SelectedIndexChanged"
                        Width="100%" AllowPaging="True" AllowSorting="True" OnRowDeleting="RolesGV_RowDeleting"
                        OnPageIndexChanged="RolesGV_PageIndexChanged" PageSize="5">
                        <RowStyle BackColor="#FFFFF4" />
                        <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                <ItemStyle Width="70%" HorizontalAlign="Center" CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:BoundField>
                            <asp:CommandField ShowDeleteButton="True" DeleteText="usuń">
                                <HeaderStyle HorizontalAlign="Center" CssClass="p-1"/>
                                <ItemStyle Font-Bold="True" Width="15%" HorizontalAlign="Center" CssClass="p-1" />
                            </asp:CommandField>
                            <asp:CommandField ShowSelectButton="True" SelectText="wybierz">
                                <HeaderStyle HorizontalAlign="Center" CssClass="p-1" />
                                <ItemStyle Font-Bold="True" Width="15%" HorizontalAlign="Center" CssClass="p-1" />
                            </asp:CommandField>
                        </Columns>
                        <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader" />
                        <EmptyDataTemplate>
                            No Roles
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#FFFFCC" />
                        <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" />
                        <AlternatingRowStyle BackColor="#EAF4FF" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="RolesDSList" runat="server" SelectMethod="GetRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic"
                        InsertMethod="AddRole" DeleteMethod="DeleteRole" UpdateMethod="UpdateRole">
                        <DeleteParameters>
                            <asp:Parameter Name="id" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="description" Type="String" />
                            <asp:Parameter Name="id" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="description" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                </div>
                <div style="margin-top: 50px;">
                    <asp:Label ID="Label5" runat="server" Text="Add/modify roles:" 
                        Font-Bold="True"></asp:Label>
                    <asp:DetailsView ID="RolesDV" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
                        DataKeyNames="Id" DataSourceID="RolesDSMod" OnItemUpdated="RolesDV_ItemUpdated"
                        DefaultMode="Insert" OnItemCommand="RolesDV_ItemCommand" OnItemInserted="RolesDV_ItemInserted">
                        <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
                        <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
                        <Fields>
                            <asp:BoundField DataField="Name" HeaderText="Role name" SortExpression="Name">
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                                        TextMode="MultiLine" Width="99%"></asp:TextBox>
                       
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                                        TextMode="MultiLine" Width="99%"></asp:TextBox>
               
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                                        Width="99%"></asp:Label>
           
                                </ItemTemplate>
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:TemplateField>
                            <asp:CommandField ShowInsertButton="True" ShowEditButton="True" ButtonType="Button" 
                                              CancelText="cancel" DeleteText="delete" EditText="edit" InsertText="add" 
                                              NewText="new" SelectText="select" UpdateText="update" >
                                <ControlStyle CssClass="btn btn-primary " />
                                <ItemStyle CssClass="p-1" />
                                <HeaderStyle CssClass="p-1" />
                            </asp:CommandField>
                        </Fields>
                        <InsertRowStyle BackColor="#EAF4FF" />
                        <EditRowStyle BackColor="#EAF4FF" />
                    </asp:DetailsView>
                    <asp:ObjectDataSource ID="RolesDSMod" runat="server" FilterExpression="Id={0}" InsertMethod="AddRole"
                        SelectMethod="GetRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic"
                        DeleteMethod="DeleteRole" UpdateMethod="UpdateRole">
                        <FilterParameters>
                            <asp:ControlParameter ControlID="RolesGV" DefaultValue="" Name="@Id" PropertyName="SelectedValue" />
                        </FilterParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="id" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="description" Type="String" />
                            <asp:Parameter Name="id" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="name" Type="String" />
                            <asp:Parameter Name="description" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:Label ID="komunikatLabel" runat="server" ForeColor="Red"></asp:Label>
                </div>
</asp:Content>
