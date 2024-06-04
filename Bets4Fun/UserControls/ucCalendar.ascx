<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCalendar.ascx.cs" Inherits="Bets4Fun.UserControls.UcCalendar" %>

<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/Scripts/calendar.js?v=<%=Bets4Fun.AssemblyHelper.AssemblyVersion %>"></script>
<script type="text/javascript">
    function validateDate(sender, args) {
        args.IsValid = isDate(args.Value, '-', 2, 1, 0);
    }
</script>

<link type="text/css" rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
    .validation-error {
        border: 1px solid red;
    }


</style>

<asp:TextBox ID="tbDateEdit" CssClass="datepicker form-control" runat="server" />
<asp:RequiredFieldValidator Display="Dynamic" ID="cvDateRequired" ErrorMessage="* required" ControlToValidate="tbDateEdit" runat="server" Enabled="<%#Convert.ToBoolean(Required) %>">
</asp:RequiredFieldValidator>
<asp:CustomValidator ID="cvDateEdit" runat="server" ErrorMessage="*" Display="Dynamic" ClientValidationFunction="validateDate"
    CssClass="text-danger text-small" ForeColor="" ControlToValidate="tbDateEdit">
</asp:CustomValidator>
<script>
    $(document).ready(function () {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().beginAsyncPostBack();

        function EndRequestHandler(sender, args) {
            var dtPckr = $("#<%=tbDateEdit.ClientID%>");

            if (dtPckr.length > 0) {
                dtPckr.datepicker({
                    dateFormat: "yy-mm-dd"
                })
                    .on('change', function (ev) {
                        if (!$(this).val() || isDate($(this).val(), '-', 2, 1, 0)) {
                            $(this).removeClass('validation-error');
                        }
                        else {
                            $(this).addClass('validation-error');
                        }
                    });
            }
        }
    })
</script>
