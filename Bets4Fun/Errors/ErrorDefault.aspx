<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorDefault.aspx.cs" Inherits="Bets4Fun.ErrorDefault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ERROR</title>
    <script type="text/javascript">

        function startTimer(time) {
            if (time == 0) {
                //alert(0);
                window.location = "../User/Default.aspx";
            }
            else {
                //alert(document.getElementById("<%=Label2.ClientID %>").innerHTML);
                document.getElementById("<%=Label2.ClientID %>").innerHTML = 'You will be redirected to Home page after ' + time / 1000 + ' seconds';
                setTimeout("startTimer(" + (time - 1000) + ")", 1000);
            }
        }
    </script>
</head>
<body onload="startTimer(5000);">
    <form id="form1" runat="server">
    <div style="text-align:center;background-color:Red; font-weight:bold;">
    ERROR OCCURED
    <br/>
    <asp:Label ID="Label2" runat="server" Text="You will be redirected to Home page after 5 seconds"></asp:Label>
    </div>
    </form>
</body>
</html>
