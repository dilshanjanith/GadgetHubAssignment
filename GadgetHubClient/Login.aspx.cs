using System;
using System.Web;
using System.Web.UI;
using GadgetHubClient.GadgetService; // Verify this namespace matches your Service Reference

namespace GadgetHubClient
{
    public partial class Login : System.Web.UI.Page
    {
        ProductService client = new ProductService();

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Call the Service to validate
                int customerId = client.Login(txtUser.Text, txtPass.Text);

                if (customerId > 0)
                {
                    // SUCCESS: Save ID to Session so we know who is logged in
                    Session["CustomerId"] = customerId;
                    Session["CustomerName"] = txtUser.Text;

                    // Redirect to the Store
                    Response.Redirect("ProductForm.aspx");
                }
                else
                {
                    lblMsg.Text = "❌ Invalid Username or Password";
                }
            }
            catch (Exception)
            {
                lblMsg.Text = "Error connecting to service. Did you update the Web Reference?";
            }
        }
    }
}