<%@ Page Title="" Language="C#" MasterPageFile="~/zpLogin.Master" AutoEventWireup="true" CodeBehind="AccountVerify.aspx.cs" Inherits="Bets4Fun.Anonymous.AccountVerify" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginMainContent" runat="server">
    <div runat="server" id="divMain">
        <asp:Label ID="Label1" runat="server">Your account has been activated</asp:Label>
        <br />
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Login.aspx">Login</asp:LinkButton>
    </div>
</asp:Content>
