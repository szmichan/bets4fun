<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/zpLogin.Master" CodeBehind="GameRules.aspx.cs" Inherits="Bets4Fun.Anonymous.GameRules" %>

<%@ Register TagPrefix="uc1" TagName="ucGameRules" Src="~/UserControls/ucGameRules.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="LoginMainContent" runat="server">
    <div style="height: 100%; position: relative;">
        <h1>Game Rules</h1>
        <hr />
        <div class="login-options">
            <asp:LinkButton ID="LinkButton3" runat="server" PostBackUrl="~/Login.aspx" CssClass="btn-link btn-sm">login</asp:LinkButton>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="LoginBottomContent" runat="server">
    <uc1:ucGameRules ID="ucGameRules1" runat="server"  />
    <div class="m-5">
        <asp:Button ID="btnLogIn" runat="server" Text="Log in" CssClass="btn btn-primary" ValidationGroup="ResetPassword" OnClick="btnLogIn_Click" />
    </div>
</asp:Content>