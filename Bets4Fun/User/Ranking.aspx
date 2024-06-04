<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Ranking.aspx.cs" Inherits="Bets4Fun.User.Ranking" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="MainHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="MainSubtitleCPH" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainMainCPH" runat="server">
    <div class="classification-container">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
                <div class="form-group row">
                        <label for="ddlContests" class="col-sm-2 col-form-label"><b>Competition:</b></label>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="ddlContests" runat="server" AutoPostBack="true" DataSourceID="dsContests"
                                DataTextField="Name" DataValueField="Id" OnDataBound="ddlContests_DataBound" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                      </div>
                      <div class="form-group row">
                         <label for="dllLeagues" class="col-sm-2 col-form-label"><b>League:</b></label>
                        <div class="col-sm-5">
                            <asp:DropDownList ID="dllLeagues" runat="server" AutoPostBack="true" DataSourceID="dsAssignedLeagues"
                                DataTextField="Name" DataValueField="Id" OnDataBound="dllLeagues_DataBound" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                      </div>
                <br />
                <br />

                <asp:ObjectDataSource ID="dsContests" runat="server" SelectMethod="GetContests" TypeName="Bets4Fun.BusinessLogic.ContestsLogic">
                </asp:ObjectDataSource>

                <asp:ObjectDataSource ID="dsAssignedLeagues" runat="server" SelectMethod="GetUserLeagues" TypeName="Bets4Fun.BusinessLogic.LeaguesLogic">
                    <SelectParameters>
                        <asp:SessionParameter DbType="Int32" Name="userId" SessionField="USER_ID" />
                        <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
                    </SelectParameters>
                </asp:ObjectDataSource>


                <div>
                    <asp:Label ID="lCount" runat="server" Text="" Font-Size="Small"></asp:Label>
                </div>
                <asp:GridView ID="RankingGV" runat="server" AutoGenerateColumns="False"
                    DataSourceID="RankingDS" AllowPaging="True" AllowSorting="True"
                    PageSize="30" Width="100%" OnRowDataBound="RankingGV_RowDataBound" OnDataBound="RankingGV_DataBound">
                    <RowStyle BackColor="#FFFFF4" />
                    <Columns>
                        <asp:BoundField DataField="Position_RANK" HeaderText="Pos."
                            ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:BoundField>
                         <asp:TemplateField HeaderText="Login">
                            <ItemTemplate>
                                <asp:Label ID="loginLabel" runat="server" Text='<%# Eval("Login").ToString().Length <= 17 ? Eval("Login").ToString() : Eval("Login").ToString().Substring(0, 17) + "..." %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20%" Font-Size="Small" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Points">
                            <ItemTemplate>
                                <asp:Label ID="ptsLabel" runat="server" Text='<%# string.Format("{0,8:####0.00}",Eval("Points"))%>' CssClass="pr-2 text-right" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hit results">
                            <ItemTemplate>
                                <div class="pr-2 text-right">
                                    <asp:Label ID="directBetsLabel" runat="server" Text='<%# string.Format("{0,3:##0}",Eval("DirectBetsCount"))%>'>
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                            <HeaderStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hit wins/draws">
                            <ItemTemplate>
                                <div class="pr-2 text-right">
                                    <asp:Label ID="resultBetsLabel" runat="server" Text='<%# string.Format("{0,3:##0}",Eval("ResultBetsCount"))%>'>
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Bets">
                            <ItemTemplate>
                                <div class="pr-2 text-right">
                                    <asp:Label ID="betsLabel" runat="server" Text='<%# string.Format("{0,3:##0}",Eval("GamesBet"))%>'>
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        No data to be displayed
                    </EmptyDataTemplate>
                    <PagerStyle BackColor="#4F9D9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" CssClass="pagerHeader" />
                    <HeaderStyle BackColor="#4F9D9D" ForeColor="White" HorizontalAlign="Center" CssClass="pagerHeader" />
                    <AlternatingRowStyle BackColor="#EAF4FF" />
                </asp:GridView>
            
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <div>
        <asp:Label ID="TitleLabel" runat="server" Font-Bold="True" Font-Underline="True">Order in classification follows below rules:</asp:Label>
        <ol class="rules-item-list">
            <li class="one">
                <asp:Label ID="Rule1Label1" runat="server" Text="<b><i>higher</i></b> sum of points scored"></asp:Label>
            </li>
            <li class="two">
                <asp:Label ID="Rule2Label1" runat="server" Text="<b><i>higher</i></b> number of hit results"></asp:Label>
            </li>
            <li class="three">
                <asp:Label ID="Rule3Label1" runat="server" Text="<b><i>higher</i></b> number of hit wins/draws"></asp:Label>
            </li>
            <li class="four">
                <asp:Label ID="Rule4Label1" runat="server" Text="<b><i>lower</i></b> number of games bet"></asp:Label>
            </li>
        </ol>
    </div>
    </div>

    <asp:ObjectDataSource ID="RankingDS" runat="server" OldValuesParameterFormatString="{0}"
        SelectMethod="GetRanking" TypeName="Bets4Fun.BusinessLogic.RankingLogic">
        <SelectParameters>
            <asp:ControlParameter ControlID="dllLeagues" Name="leagueId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="ddlContests" Name="contestId" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>