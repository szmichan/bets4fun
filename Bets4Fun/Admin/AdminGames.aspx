<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="AdminGames.aspx.cs" Inherits="Bets4Fun.Admin.AdminGames" %>

<%@ Import Namespace="Bets4Fun.Common" %>

<%@ Register Src="../UserControls/ucCalendar.ascx" TagName="ucCalendar" TagPrefix="uc1" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
    Games management
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <div>
        <asp:Label ID="Label3" runat="server" Text="Games:" Font-Bold="True"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            DataSourceID="GamesDSList" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
            OnDataBound="GridView1_DataBound" OnRowDeleted="GridView1_RowDeleted" Width="100%"
            AllowPaging="True" AllowSorting="True" OnRowDeleting="GridView1_RowDeleting"
            OnPageIndexChanged="GridView1_PageIndexChanged" PageSize="15">
            <RowStyle BackColor="#FFFFF4" />
            <EmptyDataRowStyle Width="100%" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Enabled="False" Checked='<%# Convert.ToBoolean(Eval("Team1Score") != DBNull.Value && Eval("Team2Score") != DBNull.Value)%>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Contest_Name" HeaderText="Contest" SortExpression="Contest_Name">
                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Date">
                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%#DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("yyyy-MM-dd") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Time">
                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%#DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("HH:mm") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: right">
                                    <asp:Label ID="lbTeam1Pts" runat="server" Text='<%#"(" + (Eval("Team1Points") != DBNull.Value ? Eval("Team1Points") : "-") + ")"%>'
                                        Font-Size="X-Small"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label runat="server" ID="lbDrawPts" Text='<%#"(" + (Eval("DrawPoints") != DBNull.Value ? Eval("DrawPoints") : "-") + ")"%>'
                                        Font-Size="X-Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbTeam2Pts" runat="server" Text='<%#"(" + (Eval("Team2Points") != DBNull.Value ? Eval("Team2Points") : "-") + ")"%>'
                                        Font-Size="X-Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; width: 45%">
                                    <asp:Label ID="Team1Label" runat="server" Text='<%# Eval("Team1_Name")%>'></asp:Label>
                                    <asp:Image ID="imgTeam1" runat="server" Visible='<%# Eval("Team1_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team1_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                                </td>
                                <td style="text-align: center; width: 10%">
                                    <asp:Label runat="server" ID="Team1Score" Text='<%#Eval("Team1Score") != DBNull.Value ? Eval("Team1Score") : "-" %>' Font-Size="Medium" Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lbMultiplyValue" runat="server" Text='<%# "(" + (Eval("MultiplyValue") != DBNull.Value ? Eval("MultiplyValue") : "-") + ")" %>' Font-Size="X-Small"></asp:Label>
                                    <asp:Label runat="server" ID="Team2Score" Text='<%# Eval("Team2Score") != DBNull.Value ? Eval("Team2Score") : "-" %>' Font-Size="Medium" Font-Bold="True"></asp:Label>
                                </td>
                                <td style="width: 45%;">
                                    <asp:Image ID="imgTeam2" runat="server" Visible='<%# Eval("Team2_BannerImage") != DBNull.Value %>' ImageUrl='<%# "~/App_Themes/Default/Images/banners/" + Eval("Team2_BannerImage") %>' ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px" />
                                    <asp:Label ID="Team2Label" runat="server" Text='<%# Eval("Team2_Name")%>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:TemplateField>
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
                            OnClientClick="return Confirm('Do you really want to remove this game?');"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="7.5%" />
                </asp:TemplateField>
            </Columns>
            <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" CssClass="pagerHeader" />
            <EmptyDataTemplate>
                No Games
            </EmptyDataTemplate>
            <SelectedRowStyle BackColor="#FFFFCC" />
            <HeaderStyle BackColor="#4F9D9D" Font-Bold="False" ForeColor="White" />
            <AlternatingRowStyle BackColor="#EAF4FF" />
        </asp:GridView>
        <asp:ObjectDataSource ID="GamesDSList" runat="server" SelectMethod="GetGamesDesc"
            TypeName="Bets4Fun.BusinessLogic.GamesLogic" InsertMethod="AddGame"
            DeleteMethod="DeleteGame" UpdateMethod="UpdateGame" OldValuesParameterFormatString="{0}">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="contestId" Type="Int32" />
                <asp:Parameter Name="team1Id" Type="Int32" />
                <asp:Parameter Name="team2Id" Type="Int32" />
                <asp:Parameter Name="gameDate" Type="DateTime" />
                <asp:Parameter Name="team1Score" Type="Int32" />
                <asp:Parameter Name="team2Score" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
                <asp:Parameter Name="team1Points" Type="Decimal" />
                <asp:Parameter Name="team2Points" Type="Decimal" />
                <asp:Parameter Name="drawPoints" Type="Decimal" />
                <asp:Parameter Name="multiplyValue" Type="Decimal" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team1Alternate" Type="String" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Alternate" Type="String" ConvertEmptyStringToNull="true" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="contestId" Type="Int32" />
                <asp:Parameter Name="team1Id" Type="Int32" />
                <asp:Parameter Name="team2Id" Type="Int32" />
                <asp:Parameter Name="gameDate" Type="DateTime" />
                <asp:Parameter Name="team1Score" Type="Int32" />
                <asp:Parameter Name="team2Score" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="multiplyValue" Type="Decimal" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team1Points" Type="Decimal" />
                <asp:Parameter Name="team2Points" Type="Decimal" />
                <asp:Parameter Name="multiplyValue" Type="Decimal" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team1Alternate" Type="String" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Alternate" Type="String" ConvertEmptyStringToNull="true" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div style="margin-top: 50px;">
        <asp:Label ID="Label4" runat="server" Text="Add/edit game:" Font-Bold="True"></asp:Label>
        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
            DataKeyNames="Id" DataSourceID="GamesDSMod" OnItemInserted="DetailsView1_ItemInserted"
            OnItemUpdated="DetailsView1_ItemUpdated" OnDataBound="DetailsView1_DataBound"
            DefaultMode="Insert" OnItemCommand="DetailsView1_ItemCommand">
            <CommandRowStyle BackColor="#EAF4FF" Font-Bold="True" />
            <FieldHeaderStyle Font-Bold="True" ForeColor="Black" Width="30%" />
            <Fields>
                <asp:TemplateField HeaderText="Contest" SortExpression="Contest_Name">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ContestsDS" DataTextField="Name"
                            DataValueField="Id" SelectedValue='<%# Bind("ContestId") %>' Width="250px">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ContestsDS" DataTextField="Name"
                            DataValueField="Id" SelectedValue='<%# Bind("ContestId") %>' Width="250px">
                        </asp:DropDownList>
                    </InsertItemTemplate>
<%--                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("ContestName") %>'></asp:Label>
                    </ItemTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date" SortExpression="GameDate">
                    <EditItemTemplate>
                        <uc1:ucCalendar ID="ucCalendar1" runat="server" Required="True" SelectedDate='<%# DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("yyyy-MM-dd") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <uc1:ucCalendar ID="ucCalendar1" runat="server" SelectedDate='' Required="True" />
                    </InsertItemTemplate>
<%--                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("yyyy-MM-dd") %>'></asp:Label>
                    </ItemTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Time" SortExpression="GameDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditTimeTB" runat="server" Text='<%#DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("HH:mm") %>' Width="70px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="EditGameTimeRegRexValidator" runat="server" ErrorMessage="* invalid time"
                            ControlToValidate="EditTimeTB" ValidationExpression="(([0-1]?\d)|([2][0-3]))(:[0-5]+\d)"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertTimeTB" runat="server" Text=''
                            Width="70px"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" ID="InsertGameTimeRequiredValidator" ErrorMessage="* required" ControlToValidate="InsertTimeTB" runat="server"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" ID="InsertGameTimeRegRexValidator" runat="server"
                            ErrorMessage="* invalid time" ControlToValidate="InsertTimeTB" ValidationExpression="(([0-1]?\d)|([2][0-3]))(:[0-5]+\d)"></asp:RegularExpressionValidator>
                    </InsertItemTemplate>
<%--                    <ItemTemplate>
                        <asp:Label ID="GameTimeLabel" runat="server" Text='<%#DateConverter.ConvertToCest((DateTimeOffset)Eval("GameDate")).ToString("HH:mm") %>'></asp:Label>
                    </ItemTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Host team" SortExpression="Team1_Name">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlTeam1" runat="server" DataSourceID="TeamsDS" DataTextField="Name"
                            DataValueField="Id" OnDataBound="ddlTeam1_DataBound" SelectedValue='<%# Bind("Team1Id") %>' />
                        <asp:TextBox ID="tbTeam1Alternate" runat="server" Text='<%# Bind("Team1Alternate") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlTeam1" runat="server" DataSourceID="TeamsDS" DataTextField="Name" OnDataBound="ddlTeam1_DataBound"
                            DataValueField="Id" SelectedValue='<%# Bind("Team1Id") %>' />
                        <asp:TextBox ID="tbTeam1Alternate" runat="server" Text='<%# Bind("Team1Alternate") %>' />
                    </InsertItemTemplate>
   <%--                 <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Team1_Name") %>'></asp:Label>
                    </ItemTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Guest team" SortExpression="Team2_Name">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlTeam2" runat="server" DataSourceID="TeamsDS" DataTextField="Name"
                            DataValueField="Id" OnDataBound="ddlTeam2_DataBound" SelectedValue='<%# Bind("Team1Id") %>'/>
                        <asp:TextBox ID="tbTeam2Alternate" runat="server" Text='<%# Bind("Team2Alternate") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlTeam2" runat="server" DataSourceID="TeamsDS" DataTextField="Name" OnDataBound="ddlTeam2_DataBound"
                            DataValueField="Id" SelectedValue='<%# Bind("Team2Id") %>' />

                        <asp:TextBox ID="tbTeam2Alternate" runat="server" Text='<%# Bind("Team2Alternate") %>' />
                    </InsertItemTemplate>
<%--                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Team2_Name") %>'></asp:Label>
                    </ItemTemplate>--%>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Score">
                    <EditItemTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td style="text-align: right">
                                    <asp:Label ID="lbTeam1Score" runat="server" Text="hosts"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbTeam2Score" runat="server" Text="guests"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:TextBox ID="tbTeam1Score" runat="server" Text='<%#Bind("Team1Score")%>' Width="35px" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbTeam2Score" runat="server" Text='<%#Bind("Team2Score")%>' Width="35px" />
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td style="text-align: right">
                                    <asp:Label ID="lbTeam1Score" runat="server" Text="hosts"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbTeam2Score" runat="server" Text="guests"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:TextBox ID="tbTeam1Score" runat="server" Text='<%#Bind("Team1Score")%>' Width="35px" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbTeam2Score" runat="server" Text='<%#Bind("Team2Score")%>' Width="35px" />
                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Points">
                    <EditItemTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td style="text-align: right">
                                    <asp:Label ID="lbTeam1Pts" runat="server" Text="hosts"></asp:Label>
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lbDrawPts" runat="server" Text="draw"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbTeam2Pts" runat="server" Text="guests"></asp:Label>
                                </td>
                                <td style="padding-left: 50px;">
                                    <asp:Label ID="lbMultiplyValue" runat="server" Text="multiplier"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <asp:TextBox ID="tbTeam1Pts" runat="server" Text='<%#Bind("Team1Points")%>' Width="50px" />
                                </td>
                                <td style="text-align: center">
                                    <asp:TextBox ID="tbDrawPts" runat="server" Text='<%#Bind("DrawPoints")%>' Width="50px" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbTeam2Pts" runat="server" Text='<%#Bind("Team2Points")%>' Width="50px" />
                                </td>
                                <td style="padding-left: 50px;">
                                    <asp:TextBox ID="tbMultiplyValue" runat="server" Text='<%#Bind("MultiplyValue")%>' Width="50px" />
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            Width="99%" TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            Width="99%" TextMode="MultiLine"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Height="100px" Text='<%# Bind("Description") %>'
                            Width="99%"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" ShowEditButton="True" ButtonType="Button"
                    CancelText="cancel" DeleteText="delete" EditText="edit" InsertText="add"
                    NewText="new" SelectText="select" UpdateText="update">
                    <ControlStyle CssClass="btn btn-primary " />
                </asp:CommandField>
            </Fields>
            <InsertRowStyle BackColor="#EAF4FF" />
            <EditRowStyle BackColor="#EAF4FF" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="TeamsDS" runat="server" OldValuesParameterFormatString="{0}"
            SelectMethod="GetTeams" TypeName="Bets4Fun.BusinessLogic.TeamsLogic"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ContestsDS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic" />
        <asp:ObjectDataSource ID="GamesDSMod" runat="server" FilterExpression="Id={0}" InsertMethod="AddGame"
            SelectMethod="GetGames" TypeName="Bets4Fun.BusinessLogic.GamesLogic" UpdateMethod="UpdateGame" OnInserting="GamesDSMod_Inserting"
            OnUpdating="GamesDSMod_Updating">
            <FilterParameters>
                <asp:ControlParameter ControlID="GridView1" DefaultValue="" Name="@Id" PropertyName="SelectedValue" />
            </FilterParameters>
            <UpdateParameters>
                <asp:Parameter Name="contestId" Type="Int32" />
                <asp:Parameter Name="team1Id" Type="Int32" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Id" Type="Int32" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="gameDate" DbType="DateTimeOffset" />
                <asp:Parameter Name="team1Score" Type="Int32" />
                <asp:Parameter Name="team2Score" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
                <asp:Parameter Name="team1Points" Type="Decimal" />
                <asp:Parameter Name="team2Points" Type="Decimal" />
                <asp:Parameter Name="drawPoints" Type="Decimal" />
                <asp:Parameter Name="multiplyValue" Type="Decimal" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team1Alternate" Type="String" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Alternate" Type="String" ConvertEmptyStringToNull="true" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="contestId" Type="Int32" />
                <asp:Parameter Name="team1Id" Type="Int32" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Id" Type="Int32" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="gameDate" DbType="DateTimeOffset" />
                <asp:Parameter Name="team1Score" Type="Int32" />
                <asp:Parameter Name="team2Score" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="team1Points" Type="Decimal" />
                <asp:Parameter Name="team2Points" Type="Decimal" />
                <asp:Parameter Name="drawPoints" Type="Decimal" />
                <asp:Parameter Name="multiplyValue" Type="Decimal" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team1Alternate" Type="String" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="team2Alternate" Type="String" ConvertEmptyStringToNull="true" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
