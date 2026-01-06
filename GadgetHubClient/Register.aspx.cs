using System;
using GadgetHubClient.GadgetService; // Verify namespace

namespace GadgetHubClient
{
    public partial class Register : System.Web.UI.Page
    {
        ProductService client = new ProductService();

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Get Inputs
                string full = txtFull.Text;
                string user = txtUser.Text;
                string pass = txtPass.Text;

                if (full == "" || user == "" || pass == "")
                {
                    lblMsg.Text = "Please fill all fields.";
                    return;
                }

                // 2. Call Service to Register
                bool success = client.Register(user, pass, full);

                if (success)
                {
                    // If successful, go straight to login
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    lblMsg.Text = "❌ Username already taken. Try another.";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}