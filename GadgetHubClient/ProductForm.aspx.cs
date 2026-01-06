using System;
using System.Data;
using System.Web.UI.WebControls;
using GadgetHubClient.GadgetService;

namespace GadgetHubClient
{
    public partial class ProductForm : System.Web.UI.Page
    {
        ProductService client = new ProductService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check if user is logged in
            if (Session["CustomerId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Show username
            lblUser.Text = Session["CustomerName"].ToString();

            // 2. Show notification if order was confirmed by admin
            // Check both generic "OrderNotification" and customer-specific notification
            string customerName = Session["CustomerName"]?.ToString();
            
            if (Session["OrderNotification"] != null)
            {
                pnlNotification.Visible = true;
                lblOrderNotification.Text = Session["OrderNotification"].ToString();
                Session["OrderNotification"] = null; // Clear after showing
            }
            else if (customerName != null && Session[$"Notification_{customerName}"] != null)
            {
                pnlNotification.Visible = true;
                lblOrderNotification.Text = Session[$"Notification_{customerName}"].ToString();
                Session[$"Notification_{customerName}"] = null; // Clear after showing
            }

            // 2.5. Show order success message after redirect (Post-Redirect-Get pattern)
            if (Session["OrderSuccess"] != null)
            {
                lblMsg.Text = Session["OrderSuccess"].ToString();
                lblMsg.ForeColor = System.Drawing.Color.Green;
                Session["OrderSuccess"] = null; // Clear after showing
            }

            // 3. Load Data (Only on first page load)
            if (!IsPostBack)
            {
                LoadProducts();
            }

            // 4. Always load order history (to show newly placed orders)
            LoadHistory();
        }

        private void LoadProducts()
        {
            try
            {
                DataTable dt = client.GetProductList();
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error loading products: " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        // NEW METHOD: Loads the user's past orders
        private void LoadHistory()
        {
            try
            {
                int custId = Convert.ToInt32(Session["CustomerId"]);

                // This calls the new Service method you just created
                DataTable dt = client.GetMyOrders(custId);

                gvHistory.DataSource = dt;
                gvHistory.DataBind();
            }
            catch (Exception)
            {
                // If service isn't updated yet, this might fail silently
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Buy")
            {
                try
                {
                    // A. Get Order Details
                    int prodId = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = (GridViewRow)((Button)e.CommandSource).NamingContainer;
                    TextBox txtQty = (TextBox)row.FindControl("txtQty");

                    int qty = int.Parse(txtQty.Text);
                    int custId = Convert.ToInt32(Session["CustomerId"]);

                    // B. Place Order
                    bool success = client.PlaceOrder(custId, prodId, qty);

                    if (success)
                    {
                        // Store success message in session and redirect to prevent resubmission
                        Session["OrderSuccess"] = "✅ Order Placed! (Distributors notified)";
                        Response.Redirect(Request.RawUrl);
                    }
                    else
                    {
                        lblMsg.Text = "❌ Order Failed.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void gvHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the Status label and apply color coding
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                if (lblStatus != null)
                {
                    string status = lblStatus.Text;
                    if (status == "Confirmed")
                    {
                        lblStatus.ForeColor = System.Drawing.Color.Green;
                    }
                    else if (status == "Pending")
                    {
                        lblStatus.ForeColor = System.Drawing.Color.Orange;
                    }
                    else if (status == "Rejected")
                    {
                        lblStatus.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}