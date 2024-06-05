<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Bets4Fun.User.Default" %>

<%@ Register TagPrefix="uc1" TagName="ucGameRules" Src="~/UserControls/ucGameRules.ascx" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="MainHeadCPH" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainMainCPH" runat="server">
    <uc1:ucGameRules ID="ucGameRules1" runat="server"  />
</asp:Content>
