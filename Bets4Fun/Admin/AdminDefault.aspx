<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDefault.aspx.cs" Inherits="Bets4Fun.Admin.AdminDefault" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="AdminHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="AdminSubtitleCPH" runat="server">
<%--    <div style="text-align: center; width: 100%; background-color: #66CCFF">--%>
        <asp:Label ID="MainSiteLabel" runat="server" Text="Strona Główna" Font-Size="Medium"></asp:Label>
<%--    </div>--%>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="AdminMainCPH" runat="server">
    <div style="text-align:center;width:100%">
        <asp:Label ID="Label1" runat="server" Text="[Strona w przygotowaniu]" Font-Size="Large" BackColor="#FF6666"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
    </div>
</asp:Content>
