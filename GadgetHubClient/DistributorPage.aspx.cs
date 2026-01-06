using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace GadgetHubClient
{
    public partial class DistributorPage : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // 1. PAGE LOAD: Fixes the "TechWorld" Title Issue
        // ---------------------------------------------------------
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            
                if (Session["CurrentDistributor"] == null)
                {
                    // If not logged in, kick them back to the login page
                    Response.Redirect("DistributorLogin.aspx");
                }
                else
                {
                    string distName = Session["CurrentDistributor"].ToString();

                   
                    if (lblDistributorName != null)
                    {
                        lblDistributorName.Text = distName;
                    }

                    // Load the table data
                    LoadRequests();
                }
            }
        }

        // ---------------------------------------------------------
        // 2. LOAD DATA: Populates the Grid/Table
        // ---------------------------------------------------------
        private void LoadRequests()
        {
            try
            {
                // Get the distributor name from session
                if (Session["CurrentDistributor"] == null)
                {
                    Response.Redirect("DistributorLogin.aspx");
                    return;
                }

                string distributorName = Session["CurrentDistributor"].ToString();
                
                // Call the web service to get actual quotation requests
                GadgetService.ProductService client = new GadgetService.ProductService();
                System.Data.DataTable dt = client.GetRequests(distributorName);
                
                // Bind to GridView
                gvRequests.DataSource = dt;
                gvRequests.DataBind();

                // Show message if no requests found
                if (dt.Rows.Count == 0)
                {
                    lblMessage.Text = "No pending requests at the moment.";
                    lblMessage.ForeColor = System.Drawing.Color.Gray;
                }
            }
            catch (Exception ex)
            {
                // Show error on page instead of alert
                lblMessage.Text = "❌ Error loading requests: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // ---------------------------------------------------------
        // 3. BUTTON CLICK: Handle Quote Submission
        // ---------------------------------------------------------
        protected void btnSendQuote_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the button that was clicked
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;

                // Get the quotation ID from command argument
                int quotationId = Convert.ToInt32(btn.CommandArgument);

                // Get the input values from the row
                TextBox txtPrice = (TextBox)row.FindControl("txtPrice");
                TextBox txtDays = (TextBox)row.FindControl("txtDays");
                TextBox txtStock = (TextBox)row.FindControl("txtStock");

                // Validate inputs
                if (string.IsNullOrEmpty(txtPrice.Text) || 
                    string.IsNullOrEmpty(txtDays.Text) || 
                    string.IsNullOrEmpty(txtStock.Text))
                {
                    lblMessage.Text = "⚠️ Please fill all fields before submitting.";
                    lblMessage.ForeColor = System.Drawing.Color.Orange;
                    return;
                }

                decimal price = decimal.Parse(txtPrice.Text);
                int days = int.Parse(txtDays.Text);
                int stock = int.Parse(txtStock.Text);

                // Call the web service to submit the quote
                GadgetService.ProductService client = new GadgetService.ProductService();
                bool success = client.SubmitQuote(quotationId, price, days, stock);

                if (success)
                {
                    lblMessage.Text = "✅ Quote submitted successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    LoadRequests(); // Refresh the list
                }
                else
                {
                    lblMessage.Text = "❌ Failed to submit quote.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        // ---------------------------------------------------------
        // 4. LOGOUT/SWITCH DISTRIBUTOR
        // ---------------------------------------------------------
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear the session
            Session["CurrentDistributor"] = null;
            
            // Redirect back to distributor login
            Response.Redirect("DistributorLogin.aspx");
        }
    }
}