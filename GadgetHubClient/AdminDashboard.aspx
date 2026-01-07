<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs"
    Inherits="GadgetHubClient.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Admin Dashboard - GadgetHub</title>
    <style>
        * {
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body {
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            background-attachment:fixed;
            color:#eee;
            padding:0;
            min-height:100vh;
        }

        /* Header Section */
        .dashboard-header {
            background:linear-gradient(135deg, #16213e, #0f3460);
            padding:30px;
            box-shadow:0 4px 20px rgba(0, 0, 0, 0.5);
            border-bottom:2px solid #2d3561;
            margin-bottom:30px;
        }

        .dashboard-header h1 {
            color:#eee;
            font-size:32px;
            margin-bottom: 10px;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display:inline-block;
        }

        .dashboard-header p {
            color:#aaa;
            font-size: 16px;
            line-height:1.6;
        }

        /* Container */
        .container {
            max-width:1400px;
            margin:0 auto;
            padding:0 30px;
        }

        /* Recommendation Panel */
        .recommendation-panel {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border: 1px solid #2d3561;
            border-radius:12px;
            padding:25px;
            margin-bottom: 30px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            animation:slideIn 0.5s ease;
        }

        .recommendation-panel h3 {
            color:#00d9ff;
            margin-bottom:15px;
            font-size: 20px;
        }

        /* Section Header */
        .section-header {
            display:flex;
            align-items:center;
            margin-bottom:20px;
            padding-bottom:15px;
            border-bottom: 2px solid #2d3561;
        }

        .section-header h2 {
            color:#00d9ff;
            font-size:24px;
            margin: 0;
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
            animation:fadeIn 0.6s ease;
        }

        /* Grid Table */
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
            border-bottom: 2px solid #2d3561;
        }

        .grid td {
            border-bottom:1px solid rgba(45, 53, 97, 0.5);
            padding:15px 12px;
            color:#eee;
            vertical-align:middle;
            font-size:14px;
        }

        .grid tr {
            transition:all 0.3s ease;
        }

        .grid tr:hover {
            background: rgba(30, 58, 95, 0.6);
            transform:scale(1.01);
        }

        .grid tr:nth-child(even) {
            background:rgba(15, 52, 96, 0.2);
        }

        /* Checkbox Styling */
        .grid input[type="checkbox"] {
            width:18px;
            height:18px;
            cursor:pointer;
            accent-color:#00d9ff;
        }

        /* Quantity Input */
        .qty-input {
            background:#0f3460 !important;
            border:2px solid #2d3561 !important;
            color:#eee !important;
            padding:8px;
            border-radius:6px;
            text-align:center;
            font-size:14px;
            width:60px;
            transition:all 0.3s ease;
        }

        .qty-input:focus {
            outline:none;
            border-color:#00d9ff ! important;
            box-shadow:0 0 10px rgba(0, 217, 255, 0.4);
        }

        /* Buttons */
        .btn-approve {
            background:linear-gradient(135deg, #00ff88, #00cc6f);
            color:white;
            border:none;
            padding:10px 16px;
            cursor:pointer;
            border-radius:6px;
            margin-right:8px;
            font-weight:600;
            font-size:13px;
            text-transform:uppercase;
            letter-spacing:0.5px;
            transition:all 0.3s ease;
            box-shadow:0 4px 15px rgba(0, 255, 136, 0.2);
        }

        .btn-approve:hover {
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(0, 255, 136, 0.4);
            background:linear-gradient(135deg, #00cc6f, #00ff88);
        }

        .btn-approve:active {
            transform:translateY(0);
        }

        .btn-reject {
            background:linear-gradient(135deg, #ff4757, #e03e4e);
            color:white;
            border:none;
            padding:10px 16px;
            cursor:pointer;
            border-radius:6px;
            font-weight:600;
            font-size:13px;
            text-transform:uppercase;
            letter-spacing:0.5px;
            transition:all 0.3s ease;
            box-shadow:0 4px 15px rgba(255, 71, 87, 0.2);
        }

        .btn-reject:hover {
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(255, 71, 87, 0.4);
            background:linear-gradient(135deg, #e03e4e, #ff4757);
        }

        .btn-reject:active {
            transform:translateY(0);
        }

        /* Multi-Selection Panel */
        .multi-selection-panel {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:25px;
            margin-top:20px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .multi-selection-panel label {
            color:#ff4757;
            font-weight:600;
            font-size:15px;
            display:block;
            margin-bottom:15px;
        }

        .btn-approve-selected {
            background:linear-gradient(135deg, #00d9ff, #00a8cc);
            color:white;
            border:none;
            padding:14px 30px;
            border-radius:8px;
            cursor:pointer;
            font-weight:600;
            font-size:15px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition:all 0.3s ease;
            box-shadow:0 6px 20px rgba(0, 217, 255, 0.3);
        }

        .btn-approve-selected:hover {
            transform:translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.5);
            background:linear-gradient(135deg, #00a8cc, #00d9ff);
        }

        .btn-approve-selected:active {
            transform:translateY(0);
        }

        /* Status Badge */
        .status-badge {
            padding:6px 12px;
            border-radius:20px;
            font-size: 11px;
            font-weight: 600;
            text-transform:uppercase;
            letter-spacing:0.5px;
            display:inline-block;
        }

        .status-pending {
            background:rgba(255, 165, 0, 0.1);
            color:#ffa500;
            border:1px solid #ffa500;
        }

        .status-approved {
            background:rgba(0, 255, 136, 0.1);
            color:#00ff88;
            border:1px solid #00ff88;
        }

        .status-rejected {
            background:rgba(255, 71, 87, 0.1);
            color:#ff4757;
            border:1px solid #ff4757;
        }

        /* Highlight Row - Safe Choice */
        .safe-choice {
            background:rgba(0, 255, 136, 0.1) !important;
            border-left:4px solid #00ff88;
        }

        .safe-choice:hover {
            background: rgba(0, 255, 136, 0.15) !important;
        }

        /* Animations */
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

        @keyframes slideIn {
            from {
                opacity:0;
                transform: translateX(-20px);
            }
            to {
                opacity:1;
                transform: translateX(0);
            }
        }

        /* Loading Spinner */
        .loading {
            display:inline-block;
            width:20px;
            height:20px;
            border:3px solid rgba(0, 217, 255, 0.3);
            border-radius:50%;
            border-top-color:#00d9ff;
            animation:spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform:rotate(360deg); }
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width:10px;
            height:10px;
        }

        ::-webkit-scrollbar-track {
            background:#16213e;
        }

        ::-webkit-scrollbar-thumb {
            background: #0f3460;
            border-radius:5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background:#2d3561;
        }

        /* Responsive Design */
        @media screen and (max-width:1200px) {
            .container {
                padding:0 20px;
            }

            .grid th, .grid td {
                padding:10px 8px;
                font-size:12px;
            }
        }

        @media screen and (max-width:768px) {
            .dashboard-header {
                padding:20px;
            }

            .dashboard-header h1 {
                font-size:24px;
            }

            .grid-container {
                overflow-x:auto;
            }

            .grid {
                min-width:1000px;
            }

            .btn-approve, .btn-reject {
                padding:8px 12px;
                font-size:11px;
            }
        }

        /* Empty State */
        .empty-state {
            text-align:center;
            padding:60px 20px;
            color:#aaa;
        }

        .empty-state .icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity:0.5;
        }

        .empty-state h3 {
            color:#eee;
            margin-bottom:10px;
        }

        /* Price Highlight */
        .best-price {
            color:#00ff88;
            font-weight: bold;
        }

        .worst-price {
            color:#ff4757;
        }

        /* Tooltip */
        [title] {
            position:relative;
            cursor:help;
        }

        /* Success Message */
        .success-message {
            background:rgba(0, 255, 136, 0.1);
            border:1px solid #00ff88;
            color:#00ff88;
            padding:15px;
            border-radius:8px;
            margin-bottom:20px;
            animation:slideIn 0.5s ease;
        }

        /* Error Message */
        .error-message {
            background:rgba(255, 71, 87, 0.1);
            border:1px solid #ff4757;
            color:#ff4757;
            padding:15px;
            border-radius:8px;
            margin-bottom:20px;
            animation:slideIn 0.5s ease;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div class="container">
                <h1>👮 Admin Dashboard</h1>
                <p>Review incoming quotes. The system highlights <b style="color:#00ff88;">Safe Choices</b> in green and provides smart recommendations below.</p>
            </div>
        </div>

        <!-- Main Container -->
        <div class="container">
            <!-- Smart Recommendation Panel -->
            <div class="recommendation-panel">
                <h3>🎯 Smart Recommendations</h3>
                <%= RecommendationSummary %>
            </div>

            <!-- Section Header -->
            <div class="section-header">
                <h2>📋 All Quotations - Detailed View</h2>
            </div>

            <!-- Grid Container -->
            <div class="grid-container">
                <asp:GridView ID="gvAdmin" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    OnRowDataBound="gvAdmin_RowDataBound" OnRowCommand="gvAdmin_RowCommand"
                    DataKeyNames="QuotationId,OrderId,RequestedQty">
                    <Columns>
                        <%-- Checkbox for multi-selection --%>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Quantity input for partial fulfillment --%>
                        <asp:TemplateField HeaderText="Qty to Fulfill">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQtyFulfill" runat="server" Width="60px" Text="0"
                                    CssClass="qty-input" style="text-align:center;" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product" />
                        <asp:BoundField DataField="RequestedQty" HeaderText="Qty Needed" />

                        <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                        <asp:BoundField DataField="PriceOffered" HeaderText="Price ($)"
                            DataFormatString="{0:C}" />
                        <asp:BoundField DataField="EstimatedDeliveryDays" HeaderText="Delivery (Days)" />

                        <%-- Show Available Stock --%>
                        <asp:BoundField DataField="AvailableStock" HeaderText="Available Stock"
                            ItemStyle-Font-Bold="True" />

                        <asp:TemplateField HeaderText="Decision">
                            <ItemTemplate>
                                <asp:Button ID="btnApprove" runat="server" Text="✓ Approve"
                                    CssClass="btn-approve" CommandName="Approve"
                                    CommandArgument='<%# Eval("QuotationId") %>' />

                                <asp:Button ID="btnReject" runat="server" Text="✗ Reject"
                                    CssClass="btn-reject" CommandName="Reject"
                                    CommandArgument='<%# Eval("QuotationId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <%-- Multi-Selection Controls --%>
            <div class="multi-selection-panel">
                <asp:Label ID="lblMultiMessage" runat="server" Font-Bold="true"></asp:Label>
                <asp:Button ID="btnApproveSelected" runat="server" Text="✅ Approve Selected Combination"
                    OnClick="btnApproveSelected_Click" CssClass="btn-approve-selected" />
            </div>
        </div>
    </form>
</body>

</html>