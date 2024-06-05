<%@ Page Title="" Language="C#" MasterPageFile="~/User/Stats/Stats.master" AutoEventWireup="true" CodeBehind="Stats3.aspx.cs" Inherits="Bets4Fun.User.Stats.Stats3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StatsHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StatsSubtitleCPH" runat="server">
    <asp:Label ID="lbStats1" runat="server" Text="Zakłady" Font-Size="Medium"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="StatsMainCPH" runat="server">
    <asp:RadioButtonList ID="rblStats" runat="server">
        <asp:ListItem Text="najlepiej puntktowane zakłady" Selected="True"></asp:ListItem>
    </asp:RadioButtonList>
</asp:Content>
