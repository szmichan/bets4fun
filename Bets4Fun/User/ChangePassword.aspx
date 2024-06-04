<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Bets4Fun.User.ChangePassword" UICulture="auto" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="MainHeadCPH" runat="server">
    <%--    <script type="text/javascript">
        var = 
        function hide_label()
        {
            
        }
    </script>--%>
</asp:Content>
<asp:Content ID="SubtitleContent" ContentPlaceHolderID="MainSubtitleCPH" runat="server">
    <%--    <div style="text-align:center;width:100%;background-color: #66CCFF">--%>
    <%--<asp:Label ID="DefaultLabel" runat="server" Text="Zmiana Hasła" Font-Size="X-Large"></asp:Label>--%>
    <%--    </div>--%>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainMainCPH" runat="server">
    <div style="padding:10px;">
        <asp:ChangePassword ID="ChangePassword1" runat="server" Width="100%">
            <ChangePasswordTemplate>
                <div style="width:100%;padding:10px">
                    <div class="form-group row">
                        <label for="CurrentPassword" class="col-sm-2 col-form-label"><b>Current password:</b></label>
                        <div class="col-sm-5">
                            <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" autocomplete="off" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" CssClass="text-danger"
                                    ControlToValidate="CurrentPassword" ErrorMessage="required."
                                    ToolTip="password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="NewPassword" class="col-sm-2 col-form-label"><b>New password:</b></label>
                        <div class="col-sm-5">
                            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" autocomplete="off" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" CssClass="text-danger"
                                    ControlToValidate="NewPassword" ErrorMessage="required."
                                    ToolTip="new password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="ConfirmNewPassword" class="col-sm-2 col-form-label"><b>Confirm password:</b></label>
                        <div class="col-sm-5">
                            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" autocomplete="off" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" CssClass="text-danger"
                                    ControlToValidate="ConfirmNewPassword" ErrorMessage="required."
                                    ToolTip="confirm new password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server"
                                ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                Display="Static" CssClass="text-danger" ForeColor=""
                                ErrorMessage="password and confirmation do not match" Text="password and confirmation do not match"
                                ValidationGroup="ChangePassword1">
                            </asp:CompareValidator>
                            
                        </div>
                    </div>
                </div>
                <asp:Button ID="ChangePasswordPushButton" runat="server"
                    Text="Change password"
                    ValidationGroup="ChangePassword1"
                    OnClick="ChangePasswordPushButton_Click" CssClass="btn btn-primary" />
                <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" PostBackUrl="~/User/Default.aspx" />
                <div>
                <br />
                <asp:Label ID="FailureText" runat="server" EnableViewState="False" CssClass="text-danger bg-white" Width="250px"></asp:Label>
            </ChangePasswordTemplate>
        </asp:ChangePassword>
    </div>
    <div class="login_main_content" style="display:none">
        <fieldset>
            <legend>Language:</legend>
            <asp:Label ID="lbChangeLanguage" runat="server" Text="Change language:" meta:resourcekey="lbChangeLanguage" CssClass="account_label"></asp:Label>
            <asp:DropDownList ID="ddlLanguage" runat="server" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged" AutoPostBack="true" 
                name="ddlLanguage" DataSourceID="LanguagessDSList" DataTextField="ShortName" DataValueField="Id" OnDataBound="ddlLanguage_DataBound">
            </asp:DropDownList>
            <asp:ObjectDataSource ID="LanguagessDSList" runat="server" SelectMethod="GetLanguages"
                TypeName="Bets4Fun.BusinessLogic.LanguagesLogic">
            </asp:ObjectDataSource>
        </fieldset>
    </div>
</asp:Content>
