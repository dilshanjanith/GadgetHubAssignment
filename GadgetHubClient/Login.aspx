<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GadgetHubClient.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GadgetHub Login</title>
    <style>
        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display:flex;
            justify-content:center;
            align-items:center;
            min-height:100vh;
            margin:0;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            background-attachment:fixed;
        }
        
        .login-box {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            -webkit-backdrop-filter:blur(10px);
            padding:40px;
            border-radius:16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            width:360px;
            text-align:center;
            border:1px solid rgba(45, 53, 97, 0.5);
            animation:fadeIn 0.6s ease;
        }
        
        @keyframes fadeIn {
            from {
                opacity:0;
                transform:translateY(20px);
            }
            to {
                opacity:1;
                transform:translateY(0);
            }
        }
        
        h2 {
            color:#eee;
            margin-bottom: 30px;
            font-size:28px;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
        }
        
        input {
            width:100%;
            padding:12px 15px;
            margin:12px 0;
            border: 2px solid #2d3561;
            border-radius: 8px;
            background:#0f3460;
            color:#eee;
            font-size:14px;
            transition:all 0.3s ease;
            box-sizing:border-box;
        }
        
        input:focus {
            outline:none;
            border-color:#00d9ff;
            box-shadow:0 0 15px rgba(0, 217, 255, 0.5);
        }
        
        input::placeholder {
            color:#666;
        }
        
        .btn {
            width:100%;
            padding:12px;
            background:linear-gradient(135deg, #e94560, #d63350);
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            font-size:16px;
            font-weight:600;
            margin-top:10px;
            transition:all 0.3s ease;
            text-transform:uppercase;
            letter-spacing:1px;
        }
        
        .btn:hover {
            transform:translateY(-2px);
            box-shadow:0 8px 20px rgba(233, 69, 96, 0.4);
        }
        
        .btn:active {
            transform:translateY(0);
        }
        
        .link {
            margin-top:20px;
            display:block;
            font-size:14px;
            color:#00d9ff;
            text-decoration:none;
            transition:all 0.3s ease;
        }
        
        .link:hover {
            color:#00ffff;
            text-shadow: 0 0 10px rgba(0, 217, 255, 0.5);
        }
        
        .error-msg {
            color:#ff4757;
            margin-top:10px;
            font-size:14px;
            font-weight:500;
        }
        
        .logo {
            font-size:48px;
            margin-bottom:10px;
            filter:drop-shadow(0 0 10px rgba(233, 69, 96, 0.5));
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="logo">🔐</div>
            <h2>Welcome Back</h2>
            <asp:TextBox ID="txtUser" runat="server" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPass" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMsg" runat="server" CssClass="error-msg"></asp:Label>
            <a href="Register.aspx" class="link">Create New Account</a>
        </div>
    </form>
</body>
</html>