<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorPage.aspx.cs"
    Inherits="GadgetHubClient.DistributorPage" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Distributor Portal</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                padding: 20px;
                background-color: #f0f8ff;
            }

            .grid {
                width: 100%;
                border-collapse: collapse;
                background: white;
                margin-top: 20px;
            }

            .grid th {
                background-color: #007bff;
                color: white;
                padding: 10px;
            }

            .grid td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }

            .input-box {
                width: 80px;
                padding: 5px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .btn-send {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 5px 15px;
                cursor: pointer;
            }

            .btn-send:hover {
                background-color: #218838;
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div style="max-width: 1000px; margin: auto;">
                <!-- HEADER with Logout Button -->
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h1>Distributor Portal (<asp:Label ID="lblDistributorName" runat="server" Text=""></asp:Label>)</h1>
                    <asp:Button ID="btnLogout" runat="server" Text="🔙 Switch Distributor" OnClick="btnLogout_Click"
                        style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-size: 14px;" />
                </div>
                <p>Below are new requests from GadgetHub. Please submit your best quote.</p>

                <!-- MESSAGE PANEL for Success/Error messages -->
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="14pt"></asp:Label>
                <br /><br />

                <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" CssClass="grid">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Item Needed" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty Needed" />

                        <asp:TemplateField HeaderText="Your Price ($)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="input-box" placeholder="$$$">
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Delivery (Days)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDays" runat="server" CssClass="input-box" placeholder="Days">
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Available Stock">
                            <ItemTemplate>
                                <asp:TextBox ID="txtStock" runat="server" CssClass="input-box" placeholder="Qty">
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnSendQuote" runat="server" Text="Send Quote" CssClass="btn-send"
                                    OnClick="btnSendQuote_Click" CommandArgument='<%# Eval("QuotationId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </body>

    </html>