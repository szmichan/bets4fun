<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeBehind="AdminUsers.aspx.cs" Inherits="Bets4Fun.Admin.AdminUsers" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Users management
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <div>
        <asp:Label ID="Label3" runat="server" Text="Users:" Font-Bold="True"></asp:Label>
        <asp:GridView ID="UsersGV" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            DataSourceID="UsersDSList" OnSelectedIndexChanged="UsersGV_SelectedIndexChanged"
            Width="100%" AllowPaging="True" AllowSorting="True" OnRowDeleting="UsersGV_RowDeleting"
            OnPageIndexChanged="UsersGV_PageIndexChanged" PageSize="15">
            <RowStyle BackColor="#FFFFF4" />
            <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
            <Columns>
                <asp:BoundField DataField="Login" HeaderText="Login" SortExpression="Login">
                    <ItemStyle HorizontalAlign="Center" Width="20%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive">
                    <ItemStyle HorizontalAlign="Center" Width="5%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:CheckBoxField>
                <asp:CheckBoxField DataField="IsActivated" HeaderText="Activated" SortExpression="IsActivated">
                    <ItemStyle HorizontalAlign="Center" Width="5%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                    <ItemStyle HorizontalAlign="Center" Width="20%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:BoundField DataField="FirstName" HeaderText="Name" SortExpression="FirstName">
                    <ItemStyle HorizontalAlign="Center" Width="10%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:BoundField DataField="LastName" HeaderText="Surname" SortExpression="LastName">
                    <ItemStyle HorizontalAlign="Center" Width="10%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:CommandField ShowSelectButton="True" SelectText="select">
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="15%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:CommandField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lbDelete" runat="server" CommandName="Delete" Text="delete" OnClientClick="return confirm('Are you sure you want to delete user');"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="15%" CssClass="p-1"/>
                    <HeaderStyle CssClass="p-1" />
                </asp:TemplateField>
            </Columns>
            <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader" />
            <EmptyDataTemplate>
                No Users
            </EmptyDataTemplate>
            <SelectedRowStyle BackColor="#FFFFCC" />
            <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" />
            <AlternatingRowStyle BackColor="#EAF4FF" />
        </asp:GridView>
        <asp:ObjectDataSource ID="UsersDSList" runat="server" SelectMethod="GetUsers" TypeName="Bets4Fun.BusinessLogic.UsersLogic"
            DeleteMethod="DeleteUser" OldValuesParameterFormatString="{0}">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
        </asp:ObjectDataSource>
    </div>
    <div class="mt-5">
        <asp:Label ID="Label4" runat="server" Text="Add/modify users:" Font-Bold="True"></asp:Label>
        <asp:DetailsView ID="UsersDV" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
            DataKeyNames="Id" DataSourceID="UsersDSMod" OnItemInserted="UsersDV_ItemInserted"
            OnItemUpdated="UsersDV_ItemUpdated" DefaultMode="Insert" OnItemCommand="UsersDV_ItemCommand">
            <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
            <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
            <Fields>
                <asp:TemplateField HeaderText="Login" SortExpression="Login">
                    <EditItemTemplate>
                        <asp:TextBox ID="LoginTextBox" runat="server" Text='<%# Bind("Login") %>' ValidationGroup="EditUser"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="LoginRequiredValidator" runat="server" ControlToValidate="LoginTextBox"
                            ErrorMessage="* required" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="LoginTextBox" runat="server" Text='<%# Bind("Login") %>' ValidationGroup="InsertUser"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="LoginRequiredValidator" runat="server" ControlToValidate="LoginTextBox"
                            ErrorMessage="* required" ValidationGroup="InsertUser"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Login") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                </asp:TemplateField>
                <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive" >
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="FirstName" HeaderText="Name" SortExpression="FirstName">
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:BoundField DataField="LastName" HeaderText="Surname" SortExpression="LastName">
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Email">
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                    <EditItemTemplate>
                        <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("Email") %>' autocomplete="off"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="EmailExprValidator" runat="server" ControlToValidate="tbEmail" Display="Dynamic" ValidationGroup="EditUser"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="* invalid email">
                        </asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("Email") %>' autocomplete="off"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="EmailExprValidator" runat="server" ControlToValidate="tbEmail" Display="Dynamic" ValidationGroup="InsertUser"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="* invalid email">
                        </asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Login") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Password">
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                    <EditItemTemplate>
                        <asp:CheckBox ID="ChangePasswordCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="ChangePasswordCheckBox_CheckedChanged1"
                            Text="Zmień hasło" />
                        <br />
                        <asp:Panel ID="PasswordsPanel" runat="server" Enabled="False">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 20%;">
                                        <asp:Label ID="Label6" runat="server" Text="password:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PasswordTextBoxEdit" runat="server" TextMode="Password" autocomplete="off" ValidationGroup="EditUser"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequiredValidatorEdit" runat="server" ControlToValidate="PasswordTextBoxEdit"
                                            ErrorMessage="* required" Enabled="False" ValidationGroup="EditUser"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="repeat password:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PasswordRetypeTextBoxEdit" runat="server" TextMode="Password" autocomplete="off" ValidationGroup="EditUser"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRetypeRequiredValidatorEdit" runat="server" ValidationGroup="EditUser"
                                            ControlToValidate="PasswordRetypeTextBoxEdit" Display="Dynamic" ErrorMessage="* required"
                                            Enabled="False"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="PasswordCompareValidatorEdit" runat="server" ControlToCompare="PasswordTextBoxEdit" ValidationGroup="EditUser"
                                            ControlToValidate="PasswordRetypeTextBoxEdit" Display="Dynamic" ErrorMessage="* passwords do not match"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                        </asp:Panel>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Panel ID="PasswordsPanel" runat="server">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 20%;">
                                        <asp:Label ID="Label6" runat="server" Text="password:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PasswordTextBoxInsert" runat="server" TextMode="Password" Wrap="False" autocomplete="off" ValidationGroup="InsertUser"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequiredValidatorInsert" runat="server" ControlToValidate="PasswordTextBoxInsert"
                                            ErrorMessage="* pole wymagane" Display="Dynamic" ValidationGroup="InsertUser"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="repeat password:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="PasswordRetypeTextBoxInsert" runat="server" TextMode="Password" autocomplete="off" ValidationGroup="InsertUser"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRetypeRequiredValidatorInsert" runat="server" ValidationGroup="InsertUser"
                                            ControlToValidate="PasswordRetypeTextBoxInsert" Display="Dynamic" ErrorMessage="* required"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="PasswordCompareValidatorInsert" runat="server" ControlToCompare="PasswordTextBoxInsert" ValidationGroup="InsertUser"
                                            ControlToValidate="PasswordRetypeTextBoxInsert" Display="Dynamic" ErrorMessage="* passwords do not match"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                        </asp:Panel>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ControlStyle CssClass="btn btn-primary " />
                    <ItemStyle CssClass="p-1" />
                    <HeaderStyle CssClass="p-1" />
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                            Text="uaktualnij" Font-Bold="True" ValidationGroup="EditUser"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="anuluj" Font-Bold="True"></asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Insert" Text="dodaj"
                            Font-Bold="True" ValidationGroup="InsertUser" />
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="anuluj" Font-Bold="True"></asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="edytuj" Font-Bold="True"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="New"
                            Text="nowy" Font-Bold="True"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <InsertRowStyle BackColor="#EAF4FF" />
            <EditRowStyle BackColor="#EAF4FF" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="UsersDSMod" runat="server" FilterExpression="Id={0}" InsertMethod="AddUser"
            SelectMethod="GetUsers" TypeName="Bets4Fun.BusinessLogic.UsersLogic"
            DeleteMethod="DeleteUser" UpdateMethod="UpdateUser" OldValuesParameterFormatString="{0}"
            OnInserting="UsersDSMod_Inserting" OnUpdating="UsersDSMod_Updating">
            <FilterParameters>
                <asp:ControlParameter ControlID="UsersGV" DefaultValue="" Name="@Id" PropertyName="SelectedValue" />
            </FilterParameters>
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="login" Type="String" />
                <asp:Parameter Name="firstName" Type="String" />
                <asp:Parameter Name="lastName" Type="String" />
                <asp:Parameter Name="password" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="isActive" Type="Boolean" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="login" Type="String" />
                <asp:Parameter Name="firstName" Type="String" />
                <asp:Parameter Name="lastName" Type="String" />
                <asp:Parameter Name="password" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="isActive" Type="Boolean" />
            </InsertParameters>
        </asp:ObjectDataSource>
        <asp:Label ID="komunikatLabel" runat="server" ForeColor="Red"></asp:Label>
    </div>
    <div class="mt-5">
        <table style="width: 100%;">
            <tr>
                <td style="width: 45%;">
                    <asp:Label ID="AvailableRolesLabel" runat="server" Text="Available roles:" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:ListBox ID="AvailableRolesListBox" runat="server" Width="100%" SelectionMode="Multiple"
                        DataSourceID="RolesAvailableDS" DataTextField="Name" DataValueField="Id"></asp:ListBox>
                </td>
                <td style="padding-top: 20px; width: 10%; text-align: center;">
                    <div>
                        <asp:Button ID="AssignRolesButton" runat="server" Text=">" OnClick="AssignRolesButton_Click" CssClass="button_def" Width="50px" />
                    </div>
                    <div>
                        <asp:Button ID="RevokeRolesButton" runat="server" Text="<" OnClick="RevokeRolesButton_Click" CssClass="button_def" Width="50px" />
                    </div>
                </td>
                <td style="width: 45%;">
                    <asp:Label ID="AssignedRolesLabel" runat="server" Text="Assigned roles:" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:ListBox ID="AssignedRolesListBox" runat="server" Width="100%" SelectionMode="Multiple"
                        DataSourceID="RolesUserDS" DataTextField="Name" DataValueField="Id"></asp:ListBox>
                </td>
            </tr>
        </table>
    </div>
    <div class="mt-5">
        <asp:Label ID="lContest" runat="server" Text="Contest:"></asp:Label>
        <asp:DropDownList ID="ddlContests" runat="server" DataSourceID="ContestsDS" DataTextField="Name" DataValueField="Id" Width="30%" AutoPostBack="True">
        </asp:DropDownList>

        <table style="width: 100%;" class="mt-2">
            <tr>
                <td style="width: 45%;">
                    <asp:Label ID="lbNotAssignedLeagues" runat="server" Text="Available leagues:" Font-Bold="True"></asp:Label>
                    <br />
                    <div style="border: thin solid; overflow: auto; height: 200px; background-color: white;">
                        <asp:Repeater ID="repAvailable" runat="server" DataSourceID="dsNotAssignedLeagues">
                            <HeaderTemplate>
                                <table border="0">
                                    <thead>
                                        <tr style="background-color: gray;">
                                            <th></th>
                                            <th>
                                                <asp:Label ID="lNameHeader" runat="server" Text="Name"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lBettingForMoneyHeader" runat="server" Text="For money"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lEntryFeeHeader" runat="server" Text="Entry fee"></asp:Label></th>
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
                                        <asp:CheckBox ID="cbBettingForMoney" runat="server" Checked='<%# Eval("BettingForMoney")%>' Enabled="false" />
                                    </td>
                                    <td style="text-align:right">
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
                    <div>
                        <asp:Button ID="btnAssignLeagues" runat="server" Text=">" OnClick="btnAssignLeagues_Click" CssClass="button_def" Width="50px" />
                    </div>
                    <div>
                        <asp:Button ID="btnRevokeLeagues" runat="server" Text="<" OnClick="btnRevokeLeagues_Click" CssClass="button_def" Width="50px" />
                    </div>
                </td>
                <td style="width: 45%;">
                    <asp:Label ID="lbAssignedLeagues" runat="server" Text="Assigned leagues:" Font-Bold="True"></asp:Label>
                    <br />
                    <div style="border: thin solid; overflow: auto; height: 200px; background-color: white;">
                        <asp:Repeater ID="repAssigned" runat="server" DataSourceID="dsAssignedLeagues">
                            <HeaderTemplate>
                                <table border="0">
                                    <thead>
                                        <tr style="background-color: gray;">
                                            <th></th>
                                            <th>
                                                <asp:Label ID="lNameHeader" runat="server" Text="Name"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lBettingForMoneyHeader" runat="server" Text="For money"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lEntryFeeHeader" runat="server" Text="entry fee"></asp:Label></th>
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
                                        <asp:CheckBox ID="cbBettingForMoney" runat="server" Checked='<%# Eval("BettingForMoney")%>' Enabled="false" />
                                    </td>
                                    <td style="text-align:right">
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
            </tr>
        </table>

        <asp:ObjectDataSource ID="ContestsDS" runat="server" SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic" />
        <asp:ObjectDataSource ID="UsersAssignDS" runat="server" SelectMethod="GetUsers" TypeName="Bets4Fun.BusinessLogic.UsersLogic" />
        <asp:ObjectDataSource ID="RolesUserDS" runat="server" SelectMethod="GetUserRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic">
            <SelectParameters>
                <asp:ControlParameter ControlID="UsersGV" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="RolesAvailableDS" runat="server" SelectMethod="GetNotUserRoles" TypeName="Bets4Fun.BusinessLogic.RolesLogic">
            <SelectParameters>
                <asp:ControlParameter ControlID="UsersGV" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsAssignedLeagues" runat="server" SelectMethod="GetUserLeagues" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic">
            <SelectParameters>
                <asp:ControlParameter ControlID="UsersGV" Name="userId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsNotAssignedLeagues" runat="server" SelectMethod="GetNotUserLeagues" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic">
            <SelectParameters>
                <asp:ControlParameter ControlID="UsersGV" Name="userId" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
