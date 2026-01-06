<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorLogin.aspx.cs" Inherits="GadgetHubClient.DistributorLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Distributor Login</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 100px; background-color: #e9ecef; }
        .box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); text-align: center; width: 300px; }
        select { width: 100%; padding: 10px; margin: 20px 0; font-size: 16px; }
        .btn { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <h2>🚚 Distributor Portal</h2>
            <p>Select your company to log in:</p>
            
            <asp:DropDownList ID="ddlDistributors" runat="server">
                <asp:ListItem Value="TechWorld">TechWorld</asp:ListItem>
                <asp:ListItem Value="ElectroCom">ElectroCom</asp:ListItem>
                <asp:ListItem Value="GadgetCentral">GadgetCentral</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="Enter Portal" CssClass="btn" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>