<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucMakeContestInfoBet.ascx.cs"
    Inherits="Bets4Fun.UserControls.UcMakeContestInfoBet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<link href="../App_Themes/Default/ModalPopupMakeBet.css" rel="stylesheet" type="text/css" />
<asp:Button ID="Button1" runat="server" Text="Button" Style="display: none" />
<act:ModalPopupExtender runat="server" ID="MakeContestsInfoBetPopup" TargetControlID="Button1"
    PopupControlID="PopupMain" DropShadow="false" BehaviorID="mpMakeBet" RepositionMode="RepositionOnWindowScroll"
    PopupDragHandleControlID="PopupHeader" BackgroundCssClass="modalBackground" CancelControlID="CancelButton">
</act:ModalPopupExtender>
<script type="text/javascript">
    function ChildClick(CheckBox) {

        var TargetBaseControl = document.getElementById('<%= this.ContestInfoOptionsGV.ClientID %>');
        var Inputs = TargetBaseControl.getElementsByTagName("input");

        for (var n = 0; n < Inputs.length; n++) {
            if (Inputs[n].type == 'checkbox' && Inputs[n].id != CheckBox.id) {

                Inputs[n].checked = false;
            }
        }
    }

    function chooseOptionValidate(source, arguments) {

        var TargetBaseControl = document.getElementById('<%= this.ContestInfoOptionsGV.ClientID %>');
        var Inputs = TargetBaseControl.getElementsByTagName("input");

        var ok = false;

        for (var n = 0; n < Inputs.length; n++) {
            if (Inputs[n].type == 'checkbox' && Inputs[n].checked) {

                ok = true;
                break;
            }
        }

        arguments.IsValid = ok;
    }

</script>
<div id="PopupMain" style="width: 500px; background-color: #F1FEED; display: none;">
    <%--   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
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
            <asp:Label ID="ContestInfoLabel" runat="server" Font-Size="Large" />
        </div>
        <br />
        <asp:GridView ID="ContestInfoOptionsGV" runat="server" DataSourceID="ContestInfoOptionsDS"
            DataKeyNames="Id" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"
            OnRowDataBound="ContestInfoOptionsGV_RowDataBound" OnPageIndexChanged="ContestInfoOptionsGV_PageIndexChanged"
            OnSorted="ContestInfoOptionsGV_Sorted">
            <RowStyle BackColor="#FFFFF4" />
            <AlternatingRowStyle BackColor="#EAF4FF" />
            <HeaderStyle BackColor="#4F9D9D" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Wynik zakładu" SortExpression="Name">
                    <ItemStyle HorizontalAlign="Center" Width="45%" />
                </asp:BoundField>
                <asp:BoundField DataField="Points" HeaderText="Punkty do zdobycia" SortExpression="Points">
                    <ItemStyle HorizontalAlign="Center" Width="45%" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="wybierz">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbOptionChoosen" runat="server" Checked='<%#Convert.ToBoolean(Eval("IsBet")) %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                </asp:TemplateField>
                <%-- 
                        <asp:CheckBoxField DataField="IsBet" HeaderText="wybierz" SortExpression="IsBet" />--%>
                <%--                      <asp:BoundField DataField="IsBet" HeaderText="wybierz" SortExpression="IsBet">
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:BoundField>--%>
            </Columns>
            <EmptyDataRowStyle VerticalAlign="Top" HorizontalAlign="Center" BackColor="#FF6666" />
            <EmptyDataTemplate>
                <asp:Label ID="Empty" runat="server" Text="Brak opcji"></asp:Label>
            </EmptyDataTemplate>
        </asp:GridView>
   <%--      <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Display="Dynamic"
                    ValidationGroup="Save">
                </asp:RequiredFieldValidator>--%>
        <br />
        <asp:CustomValidator ID="cvOptionChoosen" runat="server" ErrorMessage="* należy wybrać opcję"
            Font-Italic="True" ValidationGroup="Save" ClientValidationFunction="chooseOptionValidate">
        </asp:CustomValidator>
        <asp:ObjectDataSource ID="ContestInfoOptionsDS" runat="server" SelectMethod="GetContestsInfoOptions"
            TypeName="Bets4Fun.BusinessLogic.ContestsInfoOptionsLogic">
            <SelectParameters>
                <asp:Parameter DbType="Int32" Name="contestInfoId" />
                <asp:Parameter DbType="Int32" Name="userId" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <%--        <table style="width: 100%">
            <tr>
                <td style="text-align: right; width: 45%;">
                    <asp:Label ID="lbTeam1Points" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
                <td style="text-align: center; width: 10%;">
                    <asp:Label ID="lbDrawPoints" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
                <td style="text-align: left; width: 45%;">
                    <asp:Label ID="lbTeam2Points" runat="server" Font-Size="X-Small"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 45%;">
                    <asp:Label ID="Team1Label" runat="server" Font-Bold="True"></asp:Label>
                    <asp:Image ID="imgTeam1" runat="server" ImageAlign="AbsBottom" Width="20px" Height="20px"/>
                </td>
                <td style="text-align: center; width: 5%;">
                    :
                </td>
                <td>
                    <asp:Image ID="imgTeam2" runat="server" ImageAlign="AbsBottom" Width="20px" Height="20px"/>
                    <asp:Label ID="Team2Label" runat="server" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 45%;">
                    <asp:TextBox ID="Team1ScoreTB" runat="server" Style="text-align: right" ValidationGroup="Score"></asp:TextBox>
                </td>
                <td style="text-align: center; width: 5%;">
                    :
                </td>
                <td style="text-align: left; width: 45%;">
                    <asp:TextBox ID="Team2ScoreTB" runat="server" ValidationGroup="Score"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; width: 50%">
                    <asp:Label ID="Label1" runat="server" Text="&amp;nbsp;"></asp:Label>
                    <asp:RegularExpressionValidator ID="Team1ScoreREValidator" runat="server" ErrorMessage="* nieprawidłowa wartość"
                        ControlToValidate="Team1ScoreTB" ValidationExpression="\d+" ValidationGroup="Score"
                        Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="Team1ScoreRFValidator" runat="server" ErrorMessage="* musi być wypełnione"
                        ControlToValidate="Team1ScoreTB" ValidationGroup="Score" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
                <td style="text-align: center; width: 0%">
                </td>
                <td style="text-align: left; width: 50%;">
                    <asp:RegularExpressionValidator ID="Team2ScoreREValidator" runat="server" ErrorMessage="* nieprawidłowa wartość"
                        ControlToValidate="Team2ScoreTB" ValidationExpression="\d+" ValidationGroup="Score"
                        Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="Team2ScoreRFValidator" runat="server" ErrorMessage="* musi być wypełnione"
                        ControlToValidate="Team2ScoreTB" ValidationGroup="Score" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <asp:Label ID="DescriptionLabel" runat="server" Font-Italic="True"></asp:Label>--%>
        <br />
        <br />
        <div style="text-align: right">
            <asp:Button ID="OkButton" runat="server" Text="Obstaw" ValidationGroup="Save" OnClick="OkButton_Click" CssClass="default_button"/>
            <asp:Button ID="CancelButton" runat="server" Text="Anuluj" ValidationGroup="None"CssClass="default_button" />
            <br />
            <asp:HiddenField ID="ContestInfoIdHF" runat="server" />
            <asp:HiddenField ID="UserIdHF" runat="server" />
        </div>
    </div>
</div>
