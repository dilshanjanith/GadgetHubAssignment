<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GadgetHubClient.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 50px; background-color: #f0f2f5; }
        .register-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 320px; text-align: center; }
        input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }
        .btn { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #218838; }
        .link { margin-top: 15px; display: block; font-size: 0.9em; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-box">
            <h2>📝 Create Account</h2>
            <asp:TextBox ID="txtFull" runat="server" placeholder="Full Name"></asp:TextBox>
            <asp:TextBox ID="txtUser" runat="server" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPass" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnRegister" runat="server" Text="Sign Up" CssClass="btn" OnClick="btnRegister_Click" />
            <br /><br />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            
            <a href="Login.aspx" class="link">Already have an account? Login</a>
        </div>
    </form>
</body>
</html>