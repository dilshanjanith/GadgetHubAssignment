using GadgetHubClient.GadgetService;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHubClient
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        ProductService client = new ProductService();
        public string RecommendationSummary { get; set; } // For displaying in UI

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadDashboard();
        }

        private void LoadDashboard()
        {
            // Get the comparison table
            DataTable dt = client.GetAdminData();
            gvAdmin.DataSource = dt;
            gvAdmin.DataBind();

            // Build smart recommendation summary
            BuildRecommendationSummary(dt);
        }

        private void BuildRecommendationSummary(DataTable quotes)
        {
            if (quotes.Rows.Count == 0)
            {
                RecommendationSummary = "<p style='color:gray;'>No pending quotes to analyze.</p>";
                return;
            }

            // Group quotes by OrderId
            var orderGroups = quotes.AsEnumerable()
                .GroupBy(row => row.Field<int>("OrderId"))
                .ToList();

            string summary = "";

            foreach (var orderGroup in orderGroups)
            {
                var firstQuote = orderGroup.First();
                string customerName = firstQuote.Field<string>("CustomerName");
                string productName = firstQuote.Field<string>("ProductName");
                int qtyNeeded = firstQuote.Field<int>("RequestedQty");
                int orderId = firstQuote.Field<int>("OrderId");

                summary += $"<div style='background:#f0f8ff; padding:15px; margin-bottom:20px; border-radius:8px; border-left:4px solid #007bff;'>";
                summary += $"<h3 style='margin:0 0 10px 0; color:#343a40;'>📦 Order #{orderId}: {customerName} needs {qtyNeeded} {productName}(s)</h3>";

                // Analyze options
                var quotesList = orderGroup.ToList();
                
                // Single distributor options
                var singleOptions = quotesList
                    .Where(q => q.Field<int>("AvailableStock") >= qtyNeeded)
                    .Select(q => new {
                        Distributor = q.Field<string>("DistributorName"),
                        Price = q.Field<decimal>("PriceOffered"),
                        TotalCost = q.Field<decimal>("PriceOffered") * qtyNeeded,
                        Delivery = q.Field<int>("EstimatedDeliveryDays"),
                        Stock = q.Field<int>("AvailableStock")
                    })
                    .OrderBy(o => o.TotalCost)
                    .ToList();

                // Multi-distributor combinations (2-distributor only for simplicity)
                var multiOptions = new List<string>();
                for (int i = 0; i < quotesList.Count; i++)
                {
                    for (int j = i + 1; j < quotesList.Count; j++)
                    {
                        int stock1 = quotesList[i].Field<int>("AvailableStock");
                        int stock2 = quotesList[j].Field<int>("AvailableStock");
                        
                        if (stock1 + stock2 >= qtyNeeded && stock1 > 0 && stock2 > 0)
                        {
                            string dist1 = quotesList[i].Field<string>("DistributorName");
                            string dist2 = quotesList[j].Field<string>("DistributorName");
                            decimal price1 = quotesList[i].Field<decimal>("PriceOffered");
                            decimal price2 = quotesList[j].Field<decimal>("PriceOffered");
                            
                            int qty1 = Math.Min(stock1, qtyNeeded);
                            int qty2 = qtyNeeded - qty1;
                            
                            decimal totalCost = (qty1 * price1) + (qty2 * price2);
                            
                            multiOptions.Add($"{dist1} ({qty1}) + {dist2} ({qty2}) = ${totalCost:N2}");
                        }
                    }
                }

                // Determine BEST overall option (single vs multi)
                decimal bestSingleCost = singleOptions.Count > 0 ? singleOptions.First().TotalCost : decimal.MaxValue;
                decimal bestMultiCost = decimal.MaxValue;
                string bestMultiCombo = "";

                if (multiOptions.Count > 0)
                {
                    // Parse multi options to find cheapest
                    foreach (var combo in multiOptions)
                    {
                        // Extract cost from string like "ElectroCom (3) + GadgetCentral (2) = $5,600.00"
                        var parts = combo.Split('=');
                        if (parts.Length == 2)
                        {
                            string costStr = parts[1].Trim().Replace("$", "").Replace(",", "");
                            if (decimal.TryParse(costStr, out decimal cost))
                            {
                                if (cost < bestMultiCost)
                                {
                                    bestMultiCost = cost;
                                    bestMultiCombo = combo;
                                }
                            }
                        }
                    }
                }

                // Display ONLY the best option
                if (bestMultiCost < bestSingleCost)
                {
                    // Multi-distributor is best
                    summary += "<div style='margin:10px 0;'>";
                    summary += "<strong style='color:#28a745;'>✅ BEST OPTION (Multi-Distributor):</strong><br/>";
                    summary += $"<span style='background:#d4edda; padding:5px 10px; border-radius:4px; display:inline-block; margin-top:5px;'>";
                    summary += $"🟢 <strong>{bestMultiCombo}</strong>";
                    summary += "</span>";
                    summary += "</div>";
                }
                else if (singleOptions.Count > 0)
                {
                    // Single distributor is best
                    var best = singleOptions.First();
                    summary += "<div style='margin:10px 0;'>";
                    summary += "<strong style='color:#28a745;'>✅ BEST OPTION (Single Distributor):</strong><br/>";
                    summary += $"<span style='background:#d4edda; padding:5px 10px; border-radius:4px; display:inline-block; margin-top:5px;'>";
                    summary += $"🟢 <strong>{best.Distributor}</strong>: {qtyNeeded} available @ ${best.Price}/each = <strong>${best.TotalCost:N2}</strong> (Delivery: {best.Delivery} days)";
                    summary += "</span>";
                    summary += "</div>";
                }

                summary += "</div>";
            }

            RecommendationSummary = summary;
        }

        protected void gvAdmin_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Enhanced Smart Highlighting: Highlights best option (single OR multi-distributor)
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int stock = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "AvailableStock"));
                int needed = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "RequestedQty"));
                int orderId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OrderId"));
                decimal price = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PriceOffered"));
                int delivery = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "EstimatedDeliveryDays"));
                string distributorName = DataBinder.Eval(e.Row.DataItem, "DistributorName").ToString();

                // Get all quotes for this order
                DataTable dt = (DataTable)gvAdmin.DataSource;
                if (dt != null)
                {
                    var allQuotesForOrder = dt.AsEnumerable()
                        .Where(row => row.Field<int>("OrderId") == orderId)
                        .ToList();

                    // Find best SINGLE distributor option
                    var singleOptions = allQuotesForOrder
                        .Where(row => row.Field<int>("AvailableStock") >= needed)
                        .ToList();

                    decimal bestSingleCost = decimal.MaxValue;
                    if (singleOptions.Count > 0)
                    {
                        var bestSingle = singleOptions
                            .OrderBy(row => row.Field<decimal>("PriceOffered") * needed)
                            .ThenBy(row => row.Field<int>("EstimatedDeliveryDays"))
                            .First();
                        bestSingleCost = bestSingle.Field<decimal>("PriceOffered") * needed;
                    }

                    // Find best MULTI-DISTRIBUTOR combination (2-way only)
                    decimal bestMultiCost = decimal.MaxValue;
                    List<string> bestMultiDistributors = new List<string>();

                    for (int i = 0; i < allQuotesForOrder.Count; i++)
                    {
                        for (int j = i + 1; j < allQuotesForOrder.Count; j++)
                        {
                            int stock1 = allQuotesForOrder[i].Field<int>("AvailableStock");
                            int stock2 = allQuotesForOrder[j].Field<int>("AvailableStock");

                            if (stock1 + stock2 >= needed && stock1 > 0 && stock2 > 0)
                            {
                                decimal price1 = allQuotesForOrder[i].Field<decimal>("PriceOffered");
                                decimal price2 = allQuotesForOrder[j].Field<decimal>("PriceOffered");
                                string dist1 = allQuotesForOrder[i].Field<string>("DistributorName");
                                string dist2 = allQuotesForOrder[j].Field<string>("DistributorName");

                                int qty1 = Math.Min(stock1, needed);
                                int qty2 = needed - qty1;

                                decimal totalCost = (qty1 * price1) + (qty2 * price2);

                                if (totalCost < bestMultiCost)
                                {
                                    bestMultiCost = totalCost;
                                    bestMultiDistributors = new List<string> { dist1, dist2 };
                                }
                            }
                        }
                    }

                    // Determine overall best option
                    bool multiIsBest = bestMultiCost < bestSingleCost;

                    // Apply highlighting
                    if (multiIsBest && bestMultiDistributors.Contains(distributorName))
                    {
                        // This distributor is part of the best multi-distributor combination
                        e.Row.BackColor = System.Drawing.Color.LightGreen; // Green for best option
                    }
                    else if (!multiIsBest && stock >= needed)
                    {
                        // Check if this is the best single option
                        decimal currentTotalCost = price * needed;
                        if (Math.Abs(currentTotalCost - bestSingleCost) < 0.01m) // Float comparison
                        {
                            e.Row.BackColor = System.Drawing.Color.LightGreen; // Green for best option
                        }
                    }
                    else if (stock < needed)
                    {
                        e.Row.ForeColor = System.Drawing.Color.Red; // Can't fulfill alone
                    }
                }
            }
        }

        protected void gvAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int quoteId = Convert.ToInt32(e.CommandArgument);
            string decision = e.CommandName; // "Approve" or "Reject"

            // Get the row data to extract delivery info for notification
            if (decision == "Approve")
            {
                GridViewRow row = (GridViewRow)((Button)e.CommandSource).NamingContainer;
                
                // Extract data from the grid cells directly (DataItem is null during RowCommand)
                // Column indices: 0=CustomerName, 1=ProductName, 2=Qty, 3=Distributor, 4=Price, 5=DeliveryDays, 6=Stock
                string customerName = row.Cells[0].Text;  // CustomerName column
                string productName = row.Cells[1].Text;   // ProductName column
                string deliveryDays = row.Cells[5].Text;  // EstimatedDeliveryDays column
                
                // OrderId is not in the grid, so we'll use the quoteId as a placeholder
                // In production, you'd fetch this from the database
                int orderId = quoteId;

                // Set notification message for the customer
                // Note: This is a simplified approach using Session
                // In production, you'd use database notifications or email
                Session[$"Notification_{customerName}"] = 
                    $"Your order #{orderId} for '{productName}' has been confirmed! " +
                    $"Estimated delivery: {deliveryDays} days. Thank you for shopping with GadgetHub!";
            }

            // Call AdminDecision to process the approval/rejection
            client.AdminDecision(quoteId, decision);
            LoadDashboard();
        }

        // NEW: Handle multi-distributor selection approval
        protected void btnApproveSelected_Click(object sender, EventArgs e)
        {
            lblMultiMessage.Text = ""; // Clear previous messages

            // Get selected quotes with quantities
            var selectedQuotes = new List<(int QuoteId, int OrderId, int Quantity, int QtyNeeded)>();

            foreach (GridViewRow row in gvAdmin.Rows)
            {
                CheckBox checkbox = row.FindControl("chkSelect") as CheckBox;
                TextBox qtyTextBox = row.FindControl("txtQtyFulfill") as TextBox;

                if (checkbox != null && checkbox.Checked)
                {
                    int quoteId = Convert.ToInt32(gvAdmin.DataKeys[row.RowIndex]["QuotationId"]);
                    int orderId = Convert.ToInt32(gvAdmin.DataKeys[row.RowIndex]["OrderId"]);
                    int qtyNeeded = Convert.ToInt32(gvAdmin.DataKeys[row.RowIndex]["RequestedQty"]);
                    int qty = 0;

                    if (!int.TryParse(qtyTextBox.Text, out qty) || qty <= 0)
                    {
                        lblMultiMessage.ForeColor = System.Drawing.Color.Red;
                        lblMultiMessage.Text = "❌ Please enter valid quantities (must be > 0) for all selected distributors.";
                        return;
                    }

                    selectedQuotes.Add((quoteId, orderId, qty, qtyNeeded));
                }
            }

            // Validate selection
            if (selectedQuotes.Count == 0)
            {
                lblMultiMessage.ForeColor = System.Drawing.Color.Orange;
                lblMultiMessage.Text = "⚠️ Please select at least one distributor using the checkboxes.";
                return;
            }

            // Check all quotes are for same order
            int firstOrderId = selectedQuotes[0].OrderId;
            if (selectedQuotes.Any(s => s.OrderId != firstOrderId))
            {
                lblMultiMessage.ForeColor = System.Drawing.Color.Red;
                lblMultiMessage.Text = "❌ All selected quotes must be for the same order. Please select quotes from only one order.";
                return;
            }

            // Check total quantity matches order quantity needed
            int totalQty = selectedQuotes.Sum(s => s.Quantity);
            int orderQtyNeeded = selectedQuotes[0].QtyNeeded;

            if (totalQty != orderQtyNeeded)
            {
                lblMultiMessage.ForeColor = System.Drawing.Color.Red;
                lblMultiMessage.Text = $"❌ Total quantity ({totalQty}) must exactly equal order quantity ({orderQtyNeeded}). Please adjust quantities.";
                return;
            }

            // CAPTURE customer and product info BEFORE approving (while quotes are still in grid)
            string customerName = null;
            string productName = null;
            
            // Get from the first selected row
            foreach (GridViewRow row in gvAdmin.Rows)
            {
                CheckBox checkbox = row.FindControl("chkSelect") as CheckBox;
                if (checkbox != null && checkbox.Checked)
                {
                    // Grid columns: 0=Select, 1=QtyFulfill, 2=Customer, 3=Product, 4=QtyNeeded, 5=Distributor, 6=Price, 7=Delivery, 8=Stock, 9=Decision
                    customerName = row.Cells[2].Text;  // CustomerName is column 2
                    productName = row.Cells[3].Text;   // ProductName is column 3
                    break; // Only need first row
                }
            }

            // Process approvals
            try
            {
                // Build quotationsData string: "quoteId1:qty1,quoteId2:qty2"
                string quotationsData = string.Join(",", selectedQuotes.Select(q => $"{q.QuoteId}:{q.Quantity}"));
                
                // Call the new multi-distributor approval method
                bool success = client.ApproveMultiDistributor(quotationsData);

                if (!success)
                {
                    lblMultiMessage.ForeColor = System.Drawing.Color.Red;
                    lblMultiMessage.Text = "❌ Approval failed. Please check that quantities match order requirements.";
                    return;
                }

                // Build distributor breakdown for notification (using pre-captured row data)
                var distributorNames = new List<string>();
                foreach (var q in selectedQuotes)
                {
                    // Find the row for this quote
                    foreach (GridViewRow row in gvAdmin.Rows)
                    {
                        int rowQuoteId = Convert.ToInt32(gvAdmin.DataKeys[row.RowIndex]["QuotationId"]);
                        if (rowQuoteId == q.QuoteId)
                        {
                            string distName = row.Cells[5].Text;  // DistributorName column (adjust index if needed)
                            distributorNames.Add($"{distName}({q.Quantity})");
                            break;
                        }
                    }
                }

                string distributorBreakdown = string.Join(", ", distributorNames);

                // Set notification for customer
                if (!string.IsNullOrEmpty(customerName) && !string.IsNullOrEmpty(productName))
                {
                    Session[$"Notification_{customerName}"] =
                        $"Your order for {orderQtyNeeded} {productName}(s) has been confirmed! " +
                        $"Fulfilled by: {distributorBreakdown}. Thank you for shopping with GadgetHub!";
                }

                lblMultiMessage.ForeColor = System.Drawing.Color.Green;
                lblMultiMessage.Text = $"✅ Successfully approved {selectedQuotes.Count} distributor(s) for combined order!";
                System.Threading.Thread.Sleep(1500); // Brief pause to show message
                LoadDashboard();
            }
            catch (Exception ex)
            {
                lblMultiMessage.ForeColor = System.Drawing.Color.Red;
                lblMultiMessage.Text = $"❌ Error processing approval: {ex.Message}";
            }
        }
    }
}