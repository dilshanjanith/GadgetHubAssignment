<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductForm.aspx.cs" Inherits="GadgetHubClient.ProductForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>GadgetHub Store</title>
    <style>
        body {
            font-family:'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            background-attachment:fixed;
            color:#eee;
            padding:20px;
            min-height:100vh;
            margin:0;
        }

        .header {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border: 1px solid #2d3561;
            border-radius:12px;
            padding:25px 30px;
            margin-bottom:30px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
        }

        .header h1 {
            margin:0;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            font-size:28px;
        }

        .user-info {
            color:#aaa;
            font-size:15px;
        }

        .user-info strong {
            color:#00d9ff;
        }

        .user-info a {
            color: #ff4757;
            text-decoration:none;
            font-weight:600;
            transition:all 0.3s ease;
        }

        .user-info a:hover {
            color:#ff6b7a;
            text-shadow:0 0 8px rgba(255, 71, 87, 0.5);
        }

        .notification {
            background:rgba(0, 255, 136, 0.1);
            border:1px solid #00ff88;
            color:#00ff88;
            padding:15px 20px;
            border-radius:8px;
            margin-bottom:20px;
            box-shadow:0 4px 12px rgba(0, 255, 136, 0.2);
        }

        .section-title {
            color:#00d9ff;
            font-size:24px;
            margin: 30px 0 20px 0;
            font-weight:600;
        }

        .grid-container {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:20px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            margin-bottom:20px;
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
            text-align: left;
            font-weight: 600;
            text-transform:uppercase;
            letter-spacing:0.5px;
            font-size:13px;
        }

        .grid td {
            border-bottom:1px solid rgba(45, 53, 97, 0.5);
            padding:15px 12px;
            color:#eee;
            font-size: 14px;
        }

        .grid tr:hover {
            background:rgba(30, 58, 95, 0.6);
        }

        .grid tr:nth-child(even) {
            background:rgba(15, 52, 96, 0.2);
        }

        .qty-box {
            background:#0f3460 !important;
            border:2px solid #2d3561 !important;
            color:#eee !important;
            padding:8px;
            border-radius:6px;
            text-align:center;
            width:60px;
            font-size: 14px;
        }

        .qty-box:focus {
            outline:none;
            border-color:#00d9ff ! important;
            box-shadow:0 0 8px rgba(0, 217, 255, 0.4);
        }

        .btn-buy {
            background:linear-gradient(135deg, #00ff88, #00cc6f);
            color:white;
            border:none;
            padding:10px 20px;
            cursor:pointer;
            border-radius:6px;
            font-weight:600;
            font-size:13px;
            text-transform:uppercase;
            transition:all 0.3s ease;
            box-shadow:0 4px 12px rgba(0, 255, 136, 0.3);
        }

        .btn-buy:hover {
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(0, 255, 136, 0.5);
        }

        .status-pending {
            color:#ffa500;
            font-weight:600;
        }

        .status-approved {
            color:#00ff88;
            font-weight: 600;
        }

        .status-rejected {
            color:#ff4757;
            font-weight: 600;
        }

        hr {
            border:none;
            border-top:1px solid #2d3561;
            margin:30px 0;
        }

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
                min-width:600px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <h1>🛍️ GadgetHub Store</h1>
            <div class="user-info">
                Welcome, <strong><asp:Label ID="lblUser" runat="server"></asp:Label></strong> |
                <a href="Login.aspx">Logout</a>
            </div>
        </div>

        <!-- Notification Panel -->
        <asp:Panel ID="pnlNotification" runat="server" Visible="false" CssClass="notification">
            <strong>📢 Order Update:</strong>
            <asp:Label ID="lblOrderNotification" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Message Label -->
        <asp:Label ID="lblMsg" runat="server" Font-Bold="true" ForeColor="#00d9ff"></asp:Label>

        <!-- Products Section -->
        <h2 class="section-title">🛒 Available Products</h2>
        <div class="grid-container">
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="grid"
                OnRowCommand="gvProducts_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="BasePrice" HeaderText="Price ($)" DataFormatString="{0:C}" />

                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQty" runat="server" Text="1" CssClass="qty-box" TextMode="Number" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnOrder" runat="server" Text="Order Now" CommandName="Buy"
                                CommandArgument='<%# Eval("ProductId") %>' CssClass="btn-buy" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <hr />

        <!-- Order History Section -->
        <h2 class="section-title">📜 My Order History</h2>
        <div class="grid-container">
            <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" CssClass="grid"
                EmptyDataText="No orders yet." OnRowDataBound="gvHistory_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="OrderId" HeaderText="Order #" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />

                    <asp:TemplateField HeaderText="Fulfilled By">
                        <ItemTemplate>
                            <asp:Label ID="lblDistributors" runat="server"
                                Text='<%# Eval("Distributors") ?? "Pending" %>' Font-Bold="true">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="DeliveryDays" HeaderText="Delivery (Days)" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' Font-Bold="true">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>

</html>