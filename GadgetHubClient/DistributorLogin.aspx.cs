using System;
using System.Web.UI;

namespace GadgetHubClient
{
    public partial class DistributorLogin : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Save the selected company name into the Session
            Session["CurrentDistributor"] = ddlDistributors.SelectedValue;

            // Go to the main distributor dashboard
            Response.Redirect("DistributorPage.aspx");
        }
    }
}