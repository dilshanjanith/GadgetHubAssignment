<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs"
    Inherits="GadgetHubClient.AdminDashboard" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Admin Dashboard</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                padding: 20px;
                background-color: #f4f6f9;
            }

            h1 {
                color: #343a40;
            }

            .grid {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .grid th {
                background-color: #343a40;
                color: white;
                padding: 12px;
                text-align: left;
            }

            .grid td {
                border-bottom: 1px solid #dee2e6;
                padding: 12px;
                vertical-align: middle;
            }

            /* Buttons */
            .btn-approve {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                border-radius: 4px;
                margin-right: 5px;
            }

            .btn-approve:hover {
                background-color: #218838;
            }

            .btn-reject {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                border-radius: 4px;
            }

            .btn-reject:hover {
                background-color: #c82333;
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h1>👮 Admin Dashboard (GadgetHub)</h1>
                <p>Review incoming quotes. The system highlights <b>Safe Choices</b> in green and provides smart
                    recommendations below.</p>

                <!-- SMART RECOMMENDATION PANEL -->
                <div style="margin:20px 0;">
                    <%= RecommendationSummary %>
                </div>

                <h2 style="margin-top:30px;">📋 All Quotes (Detailed View)</h2>
                <asp:GridView ID="gvAdmin" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    OnRowDataBound="gvAdmin_RowDataBound" OnRowCommand="gvAdmin_RowCommand"
                    DataKeyNames="QuotationId,OrderId,RequestedQty">
                    <Columns>
                        <%-- NEW: Checkbox for multi-selection --%>
                            <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- NEW: Quantity input for partial fulfillment --%>
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

                                <%-- Show Available Stock (what distributor entered) --%>
                                    <asp:BoundField DataField="AvailableStock" HeaderText="Available Stock"
                                        ItemStyle-Font-Bold="True" />

                                    <asp:TemplateField HeaderText="Decision">
                                        <ItemTemplate>
                                            <asp:Button ID="btnApprove" runat="server" Text="Approve"
                                                CssClass="btn-approve" CommandName="Approve"
                                                CommandArgument='<%# Eval("QuotationId") %>' />

                                            <asp:Button ID="btnReject" runat="server" Text="Reject"
                                                CssClass="btn-reject" CommandName="Reject"
                                                CommandArgument='<%# Eval("QuotationId") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <%-- Multi-Selection Controls --%>
                    <div style="margin-top:15px; padding:15px; background:#f8f9fa; border-radius:8px;">
                        <asp:Label ID="lblMultiMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                        <asp:Button ID="btnApproveSelected" runat="server" Text="✅ Approve Selected Combination"
                            OnClick="btnApproveSelected_Click" CssClass="btn-approve"
                            style="margin-top:10px; background:#17a2b8; padding:10px 20px; cursor:pointer;" />
                    </div>
            </div>
        </form>
    </body>

    </html>