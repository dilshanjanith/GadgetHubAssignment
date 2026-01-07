<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorPage.aspx.cs"
    Inherits="GadgetHubClient.DistributorPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Distributor Portal - GadgetHub</title>
    <style>
        * {
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background:linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            background-attachment: fixed;
            color:#eee;
            padding:20px;
            min-height:100vh;
        }

        .container {
            max-width: 1200px;
            margin:0 auto;
        }

        /* Header Section */
        .header {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            border: 1px solid #2d3561;
            border-radius: 12px;
            padding: 25px 30px;
            margin-bottom:30px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
        }

        .header h1 {
            font-size:26px;
            color:#eee;
            margin: 0;
        }

        .header h1 span {
            color:#00d9ff;
            font-weight:700;
        }

        .btn-logout {
            background:linear-gradient(135deg, #ff4757, #e03e4e);
            color:white;
            border:none;
            padding:12px 24px;
            border-radius:8px;
            cursor:pointer;
            font-size:14px;
            font-weight: 600;
            transition:all 0.3s ease;
            box-shadow:0 4px 12px rgba(255, 71, 87, 0.3);
        }

        .btn-logout:hover {
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(255, 71, 87, 0.5);
        }

        /* Info Section */
        .info-section {
            background:rgba(0, 217, 255, 0.1);
            border:1px solid #00d9ff;
            border-radius:8px;
            padding:15px 20px;
            margin-bottom:25px;
            color:#aaa;
            font-size:15px;
        }

        /* Message Label */
        .message-success {
            background:rgba(0, 255, 136, 0.1);
            border:1px solid #00ff88;
            color:#00ff88;
            padding:15px;
            border-radius: 8px;
            margin-bottom:20px;
            font-weight: 600;
        }

        .message-error {
            background:rgba(255, 71, 87, 0.1);
            border:1px solid #ff4757;
            color:#ff4757;
            padding:15px;
            border-radius:8px;
            margin-bottom:20px;
            font-weight:600;
        }

        /* Grid Container */
        .grid-container {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:20px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            overflow: hidden;
        }

        .grid {
            width:100%;
            border-collapse:collapse;
            background:transparent;
        }

        .grid th {
            background:linear-gradient(135deg, #0f3460, #1e3a5f);
            color:#00d9ff ! important;
            padding:15px 12px;
            text-align: center;
            font-weight:600;
            text-transform:uppercase;
            letter-spacing:0.5px;
            font-size:13px;
        }

        .grid td {
            border-bottom:1px solid rgba(45, 53, 97, 0.5);
            padding:15px 12px;
            color:#eee;
            text-align:center;
            font-size:14px;
        }

        .grid tr:hover {
            background:rgba(30, 58, 95, 0.6);
        }

        .grid tr:nth-child(even) {
            background:rgba(15, 52, 96, 0.2);
        }

        /* Input Boxes */
        .input-box {
            background:#0f3460 !important;
            border:2px solid #2d3561 !important;
            color:#eee !important;
            padding:10px;
            border-radius:6px;
            text-align:center;
            width:90px;
            font-size: 14px;
            transition:all 0.3s ease;
        }

        .input-box:focus {
            outline:none;
            border-color:#00d9ff ! important;
            box-shadow: 0 0 10px rgba(0, 217, 255, 0.4);
        }

        .input-box::placeholder {
            color:#666;
        }

        /* Send Quote Button */
        .btn-send {
            background:linear-gradient(135deg, #00ff88, #00cc6f);
            color:white;
            border:none;
            padding:10px 20px;
            border-radius:6px;
            cursor:pointer;
            font-weight:600;
            font-size:13px;
            text-transform:uppercase;
            transition:all 0.3s ease;
            box-shadow:0 4px 12px rgba(0, 255, 136, 0.3);
        }

        .btn-send:hover {
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(0, 255, 136, 0.5);
        }

        /* Empty State */
        .empty-state {
            text-align:center;
            padding:60px 20px;
            color:#aaa;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity:0.5;
        }

        /* Responsive */
        @media (max-width:768px) {
            .header {
                flex-direction:column;
                gap:15px;
                text-align:center;
            }

            .grid-container {
                overflow-x:auto;
            }

            .grid {
                min-width:800px;
            }

            .input-box {
                width: 70px;
                padding:8px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1>🚚 Distributor Portal - <span><asp:Label ID="lblDistributorName" runat="server"></asp:Label></span></h1>
                <asp:Button ID="btnLogout" runat="server" Text="🔙 Switch Distributor" 
                    OnClick="btnLogout_Click" CssClass="btn-logout" />
            </div>

            <!-- Info Section -->
            <div class="info-section">
                📦 Below are new quotation requests from GadgetHub.Please submit your best quotes with accurate pricing, delivery times, and available stock.
            </div>

            <!-- Message Panel -->
            <asp:Label ID="lblMessage" runat="server"></asp:Label>

            <!-- Requests Grid -->
            <div class="grid-container">
                <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" CssClass="grid">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty Needed" />

                        <asp:TemplateField HeaderText="Your Price ($)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="input-box" 
                                    placeholder="0.00" TextMode="Number" step="0.01" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Delivery (Days)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDays" runat="server" CssClass="input-box" 
                                    placeholder="Days" TextMode="Number" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Available Stock">
                            <ItemTemplate>
                                <asp:TextBox ID="txtStock" runat="server" CssClass="input-box" 
                                    placeholder="Qty" TextMode="Number" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnSendQuote" runat="server" Text="Send Quote" 
                                    CssClass="btn-send" OnClick="btnSendQuote_Click" 
                                    CommandArgument='<%# Eval("QuotationId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <div class="empty-state-icon">📭</div>
                            <h3 style="color:#eee;">No Pending Requests</h3>
                            <p>You're all caught up! New quotation requests will appear here.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>

</html>