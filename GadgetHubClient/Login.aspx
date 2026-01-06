<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GadgetHubClient.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GadgetHub Login</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 50px; background-color: #f0f2f5; }
        .login-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }
        .btn { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
        .link { margin-top: 15px; display: block; font-size: 0.9em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <h2>🔐 Login</h2>
            <asp:TextBox ID="txtUser" runat="server" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPass" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn" OnClick="btnLogin_Click" />
            <br /><br />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            
            <a href="Register.aspx" class="link">Create New Account</a>
        </div>
    </form>
</body>
</html>