<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorLogin.aspx.cs" Inherits="GadgetHubClient.DistributorLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Distributor Login - GadgetHub</title>
    <style>
        * {
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display:flex;
            justify-content:center;
            align-items:center;
            min-height:100vh;
            background:linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            background-attachment:fixed;
        }

        .login-box {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            -webkit-backdrop-filter:blur(10px);
            padding:40px;
            border-radius:16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            width:380px;
            text-align:center;
            border:1px solid rgba(45, 53, 97, 0.5);
            animation:fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from {
                opacity:0;
                transform: translateY(20px);
            }
            to {
                opacity:1;
                transform: translateY(0);
            }
        }

        .logo {
            font-size:64px;
            margin-bottom:20px;
            filter:drop-shadow(0 0 10px rgba(0, 217, 255, 0.5));
            animation:float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform:translateY(0px); }
            50% { transform:translateY(-10px); }
        }

        h2 {
            color:#eee;
            font-size: 28px;
            margin-bottom:15px;
            background:linear-gradient(135deg, #00d9ff, #00a8cc);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            font-weight:700;
        }

        p {
            color:#aaa;
            margin-bottom:30px;
            font-size: 15px;
        }

        select {
            width:100%;
            background:#0f3460 !important;
            border:2px solid #2d3561 !important;
            color: #eee !important;
            padding:14px 15px;
            border-radius: 8px;
            font-size:16px;
            margin: 20px 0;
            cursor:pointer;
            transition:all 0.3s ease;
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            appearance:none;
            -webkit-appearance:none;
            -moz-appearance:none;
            background-image:url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2300d9ff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat:no-repeat;
            background-position: right 12px center;
            background-size:20px;
            padding-right:40px;
        }

        select:focus {
            outline:none;
            border-color:#00d9ff !important;
            box-shadow:0 0 15px rgba(0, 217, 255, 0.5);
        }

        select option {
            background:#16213e;
            color:#eee;
            padding:12px;
        }

        .btn {
            width:100%;
            padding:14px;
            background:linear-gradient(135deg, #00d9ff, #00a8cc);
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            font-size:16px;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:1px;
            transition:all 0.3s ease;
            margin-top:10px;
            box-shadow: 0 4px 15px rgba(0, 217, 255, 0.3);
        }

        .btn:hover {
            transform:translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.5);
            background:linear-gradient(135deg, #00a8cc, #00d9ff);
        }

        .btn:active {
            transform:translateY(0);
        }

        .info-text {
            margin-top:25px;
            padding-top:25px;
            border-top: 1px solid rgba(45, 53, 97, 0.5);
            color:#666;
            font-size:13px;
        }

        .distributor-list {
            background:rgba(15, 52, 96, 0.4);
            border: 1px solid #2d3561;
            border-radius:8px;
            padding:15px;
            margin-top: 20px;
            text-align:left;
        }

        .distributor-list h4 {
            color:#00d9ff;
            font-size:14px;
            margin-bottom: 10px;
            text-transform:uppercase;
            letter-spacing:0.5px;
        }

        .distributor-list ul {
            list-style:none;
            padding:0;
        }

        .distributor-list li {
            color:#aaa;
            padding:5px 0;
            font-size:14px;
        }

        .distributor-list li:before {
            content:"✓ ";
            color:#00ff88;
            font-weight: bold;
            margin-right:8px;
        }

        /* Responsive */
        @media (max-width:480px) {
            .login-box {
                width:90%;
                padding:30px 20px;
            }

            .logo {
                font-size:48px;
            }

            h2 {
                font-size:24px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="logo">🚚</div>
            <h2>Distributor Portal</h2>
            <p>Select your company to access the portal</p>
            
            <asp:DropDownList ID="ddlDistributors" runat="server">
                <asp:ListItem Value="TechWorld">🏢 TechWorld</asp:ListItem>
                <asp:ListItem Value="ElectroCom">⚡ ElectroCom</asp:ListItem>
                <asp:ListItem Value="GadgetCentral">🎮 Gadget Central</asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnLogin" runat="server" Text="Enter Portal" 
                CssClass="btn" OnClick="btnLogin_Click" />

            <div class="distributor-list">
                <h4>Trusted Partners</h4>
                <ul>
                    <li>TechWorld - Premium Electronics</li>
                    <li>ElectroCom - Consumer Tech</li>
                    <li>Gadget Central - Latest Gadgets</li>
                </ul>
            </div>

            <div class="info-text">
                Authorized distributors only • Secure portal access
            </div>
        </div>
    </form>
</body>
</html>