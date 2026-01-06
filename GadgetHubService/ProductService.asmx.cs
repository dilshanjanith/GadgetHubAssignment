using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using GadgetHubService.AppLogics; // Links to your Logic folder

namespace GadgetHubService
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class ProductService : System.Web.Services.WebService
    {
        ProductLogics logic = new ProductLogics();

        // 1. CUSTOMER LOGIN
        [WebMethod]
        public int Login(string user, string pass)
        {
            return logic.ValidateCustomer(user, pass);
        }

        // 2. CUSTOMER REGISTER
        [WebMethod]
        public bool Register(string user, string pass, string full)
        {
            return logic.RegisterCustomer(user, pass, full);
        }

        // 3. GET PRODUCTS (Returns a Table now, not a List)
        [WebMethod]
        public DataTable GetProductList()
        {
            return logic.GetAllProducts();
        }

        // 4. PLACE ORDER
        [WebMethod]
        public bool PlaceOrder(int custId, int prodId, int qty)
        {
            return logic.CreateOrder(custId, prodId, qty);
        }

        // 5. DISTRIBUTOR: GET REQUESTS
        [WebMethod]
        public DataTable GetRequests(string distributorName)
        {
            return logic.GetDistributorRequests(distributorName);
        }

        // 6. DISTRIBUTOR: SEND QUOTE
        [WebMethod]
        public bool SubmitQuote(int quotationId, decimal price, int days, int stock)
        {
            return logic.SubmitQuotationResponse(quotationId, price, days, stock);
        }

        // 7. ADMIN: GET DASHBOARD DATA
        [WebMethod]
        public DataTable GetAdminData()
        {
            return logic.GetAdminDashboardData();
        }

        // 8. ADMIN: APPROVE/REJECT
        [WebMethod]
        public bool AdminDecision(int quoteId, string decision)
        {
            return logic.ProcessQuoteDecision(quoteId, decision);
        }
        [WebMethod]
        public DataTable GetMyOrders(int custId)
        {
            return logic.GetCustomerOrders(custId);
        }

        // 9. ADMIN: GET QUOTE ANALYSIS (for multi-distributor recommendations)
        [WebMethod]
        public DataTable GetQuoteAnalysis()
        {
            return logic.GetQuoteAnalysis();
        }

        // 10. ADMIN: APPROVE MULTI-DISTRIBUTOR ORDER
        [WebMethod]
        public bool ApproveMultiDistributor(string quotationsData)
        {
            return logic.ProcessMultiDistributorApproval(quotationsData);
        }
    }
}