<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucMakeBet.ascx.cs" Inherits="Bets4Fun.UserControls.UcMakeBet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<link href="../App_Themes/Default/ModalPopupMakeBet.css" rel="stylesheet" type="text/css" />
<asp:Button ID="Button1" runat="server" Text="Button" Style="display: none" />
<act:ModalPopupExtender runat="server" ID="MakeBetPopup" TargetControlID="Button1"
    PopupControlID="PopupMain" DropShadow="false" BehaviorID="mpMakeBet" RepositionMode="RepositionOnWindowScroll"
    PopupDragHandleControlID="PopupHeader" BackgroundCssClass="modalBackground" CancelControlID="CancelButton">
</act:ModalPopupExtender>
<script language="javascript" type="text/javascript">
    function abc() {
        document.getElementById("<%=OkButton.ClientID %>").setAttribute("disabled", "true");
        document.getElementById("<%=OkButton.ClientID %>").click();
        return true;
    }
</script>
<div id="PopupMain" style="width: 500px; background-color: #F1FEED; display: none;">
    <div id="PopupHeader" style="background-color: Black; height: 20px;cursor:move;">
        <div class="TitlebarLeft">
            <asp:Label ID="lCaption" runat="server" Text="Zakład"></asp:Label>
        </div>
        <div onclick="$get('<%=CancelButton.ClientID %>').click();" class="TitlebarRight">
        </div>
    </div>
    <div id="PopupBody" style="clear: both;">
        <div style="text-align: center;">
            <br />
            <asp:Label ID="ContestLabel" runat="server" Font-Bold="True" Font-Size="Large" />
            <br />
            <asp:Label ID="GameDateLabel" runat="server" Font-Size="Medium" />
        </div>
        <table style="width: 100%;border-collapse:collapse;" border="0">
            <tr >
                <td style="text-align: right; width: 42.5%;">
                    <asp:Label ID="lbTeam1Points" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
                <td style="text-align: center; width: 10%;">
                    <asp:Label ID="lbDrawPoints" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
                <td style="text-align: left; width: 42.5%;">
                    <asp:Label ID="lbTeam2Points" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    <asp:Label ID="Team1Label" runat="server" Font-Bold="True"></asp:Label>
                    <asp:Image ID="imgTeam1" runat="server" ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px"/>
                </td>
                <td style="text-align: center">
                    <asp:Label ID="lbMultiplyValue" runat="server" Font-Size="XX-Small"></asp:Label>
                </td>
                <td>
                    <asp:Image ID="imgTeam2" runat="server" ImageAlign="AbsBottom" Width="30px" Height="20px" BorderWidth="1px"/>
                    <asp:Label ID="Team2Label" runat="server" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:TextBox ID="Team1ScoreTB" runat="server" Style="text-align: right" ValidationGroup="Score" Width="100px"></asp:TextBox>
                </td>
                <td style="text-align: center">
                    :
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="Team2ScoreTB" runat="server" ValidationGroup="Score" Width="100px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="Label1" runat="server" Text="&amp;nbsp;"></asp:Label>
                    <asp:RegularExpressionValidator ID="Team1ScoreREValidator" runat="server" ErrorMessage="* nieprawidłowa wartość"
                        ControlToValidate="Team1ScoreTB" ValidationExpression="\d+" ValidationGroup="Score"
                        Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="Team1ScoreRFValidator" runat="server" ErrorMessage="* musi być wypełnione"
                        ControlToValidate="Team1ScoreTB" ValidationGroup="Score" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
                <td style="text-align: center">
                </td>
                <td style="text-align: left">
                    <asp:RegularExpressionValidator ID="Team2ScoreREValidator" runat="server" ErrorMessage="* nieprawidłowa wartość"
                        ControlToValidate="Team2ScoreTB" ValidationExpression="\d+" ValidationGroup="Score"
                        Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="Team2ScoreRFValidator" runat="server" ErrorMessage="* musi być wypełnione"
                        ControlToValidate="Team2ScoreTB" ValidationGroup="Score" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <div style="margin-left:10px;">
            <asp:Label ID="DescriptionLabel" runat="server" Font-Italic="True" ></asp:Label>
        </div>
        <br />
        <br />
        <div style="text-align: right">
            <asp:Button ID="OkButton" runat="server" Text="Obstaw" ValidationGroup="Score" OnClick="OkButton_Click" CssClass="default_button"/>
            <asp:Button ID="CancelButton" runat="server" Text="Anuluj" ValidationGroup="None" CssClass="default_button"/>
            <br />
            <asp:HiddenField ID="BetIdHF" runat="server" />
            <asp:HiddenField ID="GameIdHF" runat="server" />
            <asp:HiddenField ID="UserIdHF" runat="server" />
        </div>
    </div>
</div>
