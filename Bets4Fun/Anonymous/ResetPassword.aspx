<%@ Page Title="" Language="C#" MasterPageFile="~/zpLogin.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Bets4Fun.Anonymous.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginMainContent" runat="server">

    <h1>Reset password</h1>
    <hr />
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="Default" runat="server">
            <div class="input-group mt-4">
                <span class="input-group-addon"><i class="fa fa-user fa-lg"></i></span>
                <asp:TextBox ID="UserName" class="form-control" runat="server" autocomplete="off" placeholder="Login" required />
            </div>
            <div class="input-group mt-4">
                <span class="input-group-addon"><i class="fa fa-at fa-lg"></i></span>
                <asp:TextBox ID="Email" runat="server" class="form-control" placeholder="Email" required pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:TextBox>
            </div>
            <div class="mt-4 mb-4">
                <asp:Button ID="btnReset" runat="server" Text="Reset password" CssClass="btn btn-primary" ValidationGroup="ResetPassword" OnClick="btnReset_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="btnCancel_Click" CausesValidation="false" UseSubmitBehavior="false" />
            </div>
            <asp:Label ID="lbError" runat="server" Text="invalid login or password" CssClass="text-danger" Visible="false" Font-Size="X-Small"></asp:Label>
        </asp:View>
        <asp:View ID="Success" runat="server">
            <table>
                <tr>
                    <td>Your password was successfully reset.
                        <br />
                        New password was sent on your e-mail. Password should be changed after first sign in.</td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <asp:LinkButton ID="btnLogin" runat="server" CausesValidation="False" CommandName="Continue" Text="Login" PostBackUrl="~/Login.aspx"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</asp:Content>
