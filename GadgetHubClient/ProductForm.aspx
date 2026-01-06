<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductForm.aspx.cs" Inherits="GadgetHubClient.ProductForm" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>GadgetHub Store</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                padding: 20px;
                background-color: #f8f9fa;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .grid {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
            }

            .grid tr:hover {
                background-color: #f1f1f1;
            }

            .btn-buy {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
                border-radius: 4px;
            }

            .btn-buy:hover {
                background-color: #218838;
            }

            .qty-box {
                width: 50px;
                padding: 5px;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="header">
                <h1>🛍️ GadgetHub Products</h1>
                <div>
                    Welcome, <asp:Label ID="lblUser" runat="server" Font-Bold="true"></asp:Label> |
                    <a href="Login.aspx" style="color:red; text-decoration:none;">Logout</a>
                </div>
            </div>

            <asp:Panel ID="pnlNotification" runat="server" Visible="false"
                style="background-color: #d4edda; border: 1px solid #c3e6cb; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
                <strong style="color: #155724;">📢 Order Update:</strong>
                <asp:Label ID="lblOrderNotification" runat="server" style="color: #155724;"></asp:Label>
            </asp:Panel>

            <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
            <br /><br />

            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="grid"
                OnRowCommand="gvProducts_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="BasePrice" HeaderText="Price ($)" DataFormatString="{0:C}" />

                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQty" runat="server" Text="1" CssClass="qty-box" TextMode="Number">
                            </asp:TextBox>
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
            <br />
            <hr /><br />

            <h2>📜 My Order History</h2>
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
            <br /><br />
        </form>
    </body>

    </html>