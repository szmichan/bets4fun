﻿<%@ Page Title="" Language="C#" MasterPageFile="~/zpLogin.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Bets4Fun.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginMainContent" runat="server">
    <div style="height:100%;position:relative;">
        <h1>Log in</h1>
        <hr />
        <div class="login-fieldset">
            <div class="input-group mt-5">
                <span class="input-group-addon"><i class="fa fa-user fa-lg"></i></span>
                <input id="UserName" type="text" class="form-control" name="login" placeholder="Login" runat="server">
            </div>
            <div class="input-group mt-4">
                <span class="input-group-addon"><i class="fa fa-key fa-lg"></i></span>
                <input id="Password" type="password" class="form-control" name="password" placeholder="Password" runat="server">
            </div>
            <asp:Button ID="bLogin" runat="server" Text="Login" OnClick="bLogin_Click" CssClass="btn btn-primary btn-block mt-4" />
           
            <%--<div class="alert alert-danger">--%>
               <asp:Label ID="lbError" runat="server" Text="* invalid login or password or account has not been activated" CssClass="text-danger text-small" Visible="false"></asp:Label>
          <%--  </div>--%>

            <div class="login-options">
                <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Anonymous/CreateAccount.aspx" CssClass="btn-link btn-sm">register account</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Anonymous/ResetPassword.aspx" CssClass="btn-link btn-sm">reset password</asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>