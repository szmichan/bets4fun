<%@ Page Title="" Language="C#" MasterPageFile="~/zpLogin.Master" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="Bets4Fun.Anonymous.CreateAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("input").change(function () {
                $("span[id$=ErrorMessage]").hide();
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginMainContent" runat="server">

    <h2>Register account</h2>
    <hr />
<%--    <form class="needs-validation" novalidate>--%>
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" Width="100%"
            AnswerLabelText=""
            AnswerRequiredErrorMessage=""
            CancelButtonText="Cancel"
            CancelDestinationPageUrl="~/Login.aspx"
            CompleteSuccessText="Account was successfully created. <br/> Activation link was sent to your e-mail address."
            ConfirmPasswordCompareErrorMessage="password and confirmation must match"
            ConfirmPasswordLabelText="Confirm password:"
            ConfirmPasswordRequiredErrorMessage="password confirmation required"
            ContinueButtonText="Login"
            CreateUserButtonText="Register"
            DisplayCancelButton="True"
            DuplicateEmailErrorMessage="e-mail already exists in the system"
            DuplicateUserNameErrorMessage="user already exists in the system"
            EmailRegularExpressionErrorMessage="email invalid"
            EmailRequiredErrorMessage="email required"
            FinishCompleteButtonText="End"
            FinishPreviousButtonText="Back"
            InvalidAnswerErrorMessage=""
            InvalidEmailErrorMessage=""
            InvalidPasswordErrorMessage=""
            InvalidQuestionErrorMessage=""
            LoginCreatedUser="False"
            PasswordLabelText="Password:"
            PasswordRegularExpressionErrorMessage="enter different password"
            PasswordRequiredErrorMessage="password is required"
            QuestionLabelText=""
            QuestionRequiredErrorMessage=""
            StartNextButtonText="Next"
            StepNextButtonText="Next"
            StepPreviousButtonText="Back"
            UnknownErrorMessage="cannot register account"
            UserNameLabelText="Login:"
            UserNameRequiredErrorMessage="login required"
            ContinueDestinationPageUrl="~/Login.aspx"
            OnSendingMail="CreateUserWizard1_SendingMail"
            ContinueButtonType="Link"
            CancelButtonType="Button"
            EmailRegularExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
            <MailDefinition IsBodyHtml="true" BodyFileName="~/mail_formats/create_user_mail.txt" From="Bets4Fun &lt;b3ts4fun@gmail.com&gt;" Subject="account registration confirmation">
            </MailDefinition>
            <CancelButtonStyle CssClass="btn btn-primary cancel-button" />
            <CreateUserButtonStyle CssClass="btn btn-primary" />
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    <ContentTemplate>

                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-user fa-lg"></i></span>
                            <asp:TextBox ID="UserName" class="form-control" runat="server" autocomplete="off" placeholder="Login" required />
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-addon"><i class="fa fa-key fa-lg"></i></span>
                            <asp:TextBox ID="Password" class="form-control" runat="server" TextMode="Password" autocomplete="off" placeholder="Password" required></asp:TextBox>
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-addon"><i class="fa fa-key fa-lg"></i></span>
                            <asp:TextBox ID="ConfirmPassword" class="form-control" runat="server" TextMode="Password" autocomplete="off" placeholder="Confirm Password" required></asp:TextBox>
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-addon"><i class="fa fa-at fa-lg"></i></span>
                            <asp:TextBox ID="Email" runat="server" class="form-control" placeholder="Email" required pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:TextBox>
                        </div>

                        <div class="input-group mt-1">
                            <span class="input-group-addon"><i class="fa fa-check fa-lg"></i></span>
                            <asp:TextBox ID="FirstName" runat="server" class="form-control" placeholder="First name" required></asp:TextBox>
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-addon"><i class="fa fa-check fa-lg"></i></span>
                            <asp:TextBox ID="LastName" runat="server" class="form-control" placeholder="Last name" required></asp:TextBox>
                        </div>
                        <div class="input-group mt-1" style="font-size:xx-small">
                             <asp:CompareValidator ID="PasswordCompare" runat="server"
                                ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                Display="Dynamic" CssClass="text-danger" ForeColor=""
                                ErrorMessage="passwords do not match" Text="passwords do not match"
                                ValidationGroup="CreateUserWizard1">
                            </asp:CompareValidator>
                            <asp:Label ID="ErrorMessage" runat="server" CssClass="text-danger"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>Account was successfully registered, but it's not yet active,
                                    <br />
                                    Activation link was sent to e-mail address you supplied during registration.
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:LinkButton ID="btnLogin" runat="server" CausesValidation="False" CommandName="Continue" Text="Login"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
 <%--   </form>--%>
    <br />
    <br />
    <br />
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

            $(".cancel-button").attr("type", "button");
            $(".cancel-button").click(function () {
                window.location = "/Login.aspx";
            });

        })();
    </script>
</asp:Content>