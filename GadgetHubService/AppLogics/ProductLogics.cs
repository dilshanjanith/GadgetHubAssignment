using System;
using System.Data;
using System.Data.SqlClient;
using GadgetHubService.DataAccess;

namespace GadgetHubService.AppLogics
{
    public class ProductLogics
    {
        private DataAccessLayer dal = new DataAccessLayer();

        // 1. AUTHENTICATION
        public int ValidateCustomer(string user, string pass)
        {
            string q = "SELECT CustomerId FROM Customers WHERE Username=@u AND Password=@p";
            SqlParameter[] p = { new SqlParameter("@u", user), new SqlParameter("@p", pass) };
            object result = dal.ExecuteScalar(q, p);
            return (result != null) ? Convert.ToInt32(result) : 0;
        }

        public bool RegisterCustomer(string user, string pass, string full)
        {
            string check = "SELECT Count(*) FROM Customers WHERE Username=@u";
            SqlParameter[] p1 = { new SqlParameter("@u", user) };
            int exists = Convert.ToInt32(dal.ExecuteScalar(check, p1));
            if (exists > 0) return false;

            string q = "INSERT INTO Customers (Username, Password, FullName) VALUES (@u, @p, @f)";
            SqlParameter[] p2 = { new SqlParameter("@u", user), new SqlParameter("@p", pass), new SqlParameter("@f", full) };
            return dal.ExecuteNonQuery(q, p2) > 0;
        }

        // 2. STORE FRONT (THE FIX IS HERE)
        public DataTable GetAllProducts()
        {
            DataTable dt = dal.ExecuteQuery("SELECT * FROM Products");
            dt.TableName = "Products"; 
            return dt;
        }

        public bool CreateOrder(int customerId, int productId, int qty)
        {
            string nameQuery = "SELECT FullName FROM Customers WHERE CustomerId=" + customerId;
            object nameObj = dal.ExecuteScalar(nameQuery, null);
            string custName = (nameObj != null) ? nameObj.ToString() : "Unknown";

            string query = "INSERT INTO Orders (CustomerId, ProductId, Quantity, CustomerName, Status) VALUES (@Cid, @Pid, @Qty, @Name, 'Pending')";
            SqlParameter[] p = {
                new SqlParameter("@Cid", customerId),
                new SqlParameter("@Pid", productId),
                new SqlParameter("@Qty", qty),
                new SqlParameter("@Name", custName)
            };

            int result = dal.ExecuteNonQuery(query, p);

            if (result > 0)
            {
                int newOrderId = Convert.ToInt32(dal.ExecuteScalar("SELECT MAX(OrderId) FROM Orders", null));
                CreateQuotationRequests(newOrderId);
                return true;
            }
            return false;
        }

        public void CreateQuotationRequests(int orderId)
        {
            string q = "INSERT INTO Quotations (OrderId, DistributorId, Status) SELECT @Oid, DistributorId, 'Pending' FROM Distributors";
            SqlParameter[] p = { new SqlParameter("@Oid", orderId) };
            dal.ExecuteNonQuery(q, p);
        }

        // 3. DISTRIBUTOR PORTAL
        public DataTable GetDistributorRequests(string distributorName)
        {
            string idQuery = "SELECT DistributorId FROM Distributors WHERE DistributorName='" + distributorName + "'";
            object idObj = dal.ExecuteScalar(idQuery, null);
            if (idObj == null) return null;

            int distId = Convert.ToInt32(idObj);

            string query = @"
                SELECT Q.QuotationId, O.OrderId, P.ProductName, O.Quantity, Q.Status 
                FROM Quotations Q
                JOIN Orders O ON Q.OrderId = O.OrderId
                JOIN Products P ON O.ProductId = P.ProductId
                WHERE Q.DistributorId = " + distId + " AND Q.Status = 'Pending'";

            DataTable dt = dal.ExecuteQuery(query);
            dt.TableName = "Requests"; 
            return dt;
        }

        public bool SubmitQuotationResponse(int quotationId, decimal price, int days, int stock)
        {
            // Updated to include StockAvailable - the stock value distributor enters
            string query = "UPDATE Quotations SET PriceOffered=@Price, EstimatedDeliveryDays=@Days, StockAvailable=@Stock, Status='Responded' WHERE QuotationId=@Qid";
            SqlParameter[] p = {
                new SqlParameter("@Price", price),
                new SqlParameter("@Days", days),
                new SqlParameter("@Stock", stock),  
                new SqlParameter("@Qid", quotationId)
            };
            return dal.ExecuteNonQuery(query, p) > 0;
        }

        public DataTable GetAdminDashboardData()
        {
            // Updated query to show StockAvailable (what distributor entered) instead of DB inventory
            string query = @"
                SELECT Q.QuotationId, O.OrderId, O.CustomerName, P.ProductName, O.Quantity AS RequestedQty,
                    D.DistributorName, Q.PriceOffered, Q.EstimatedDeliveryDays, Q.Status, 
                    ISNULL(Q.StockAvailable, 0) AS AvailableStock 
                FROM Quotations Q
                JOIN Orders O ON Q.OrderId = O.OrderId
                JOIN Products P ON O.ProductId = P.ProductId
                JOIN Distributors D ON Q.DistributorId = D.DistributorId
                WHERE Q.Status = 'Responded'";

            DataTable dt = dal.ExecuteQuery(query);
            dt.TableName = "AdminData"; 
            return dt;
        }

        // NEW: Get smart quote analysis with multi-distributor recommendations
        public DataTable GetQuoteAnalysis()
        {
            // Returns unique orders with recommendation data
            string query = @"
                SELECT DISTINCT O.OrderId, O.CustomerName, P.ProductName, O.Quantity AS RequestedQty
                FROM Quotations Q
                JOIN Orders O ON Q.OrderId = O.OrderId
                JOIN Products P ON O.ProductId = P.ProductId
                WHERE Q.Status = 'Responded'
                ORDER BY O.OrderId";

            DataTable dt = dal.ExecuteQuery(query);
            dt.TableName = "OrderAnalysis";
            return dt;
        }
        // NEW: Get Order History for a specific customer with distributor details
        public DataTable GetCustomerOrders(int customerId)
        {
            // Get orders with distributor details (handles multi-distributor orders)
            // Shows actual fulfilled quantities per distributor (e.g., "Tech world(2), Gadget Central(3)")
            string query = @"
                SELECT O.OrderId, P.ProductName, O.Quantity, O.OrderDate, O.Status,
                       ISNULL(MAX(Q.EstimatedDeliveryDays), 0) AS DeliveryDays,
                       STRING_AGG(D.DistributorName + ' (' + CAST(Q.QuantityFulfilled AS VARCHAR) + ')', ', ') 
                       WITHIN GROUP (ORDER BY D.DistributorName) AS Distributors
                FROM Orders O
                JOIN Products P ON O.ProductId = P.ProductId
                LEFT JOIN Quotations Q ON O.OrderId = Q.OrderId AND Q.Status = 'Approved'
                LEFT JOIN Distributors D ON Q.DistributorId = D.DistributorId
                WHERE O.CustomerId = " + customerId + @"
                GROUP BY O.OrderId, P.ProductName, O.Quantity, O.OrderDate, O.Status
                ORDER BY O.OrderDate DESC";

            DataTable dt = dal.ExecuteQuery(query);
            dt.TableName = "MyOrders";
            return dt;
        }


        public bool ProcessQuoteDecision(int quoteId, string decision)
        {
            if (decision == "Approve")
            {
                // A. Set QuantityFulfilled to the full order quantity for single-distributor approval
                string qSetQty = @"
                    UPDATE Quotations 
                    SET QuantityFulfilled = (SELECT Quantity FROM Orders WHERE OrderId = (SELECT OrderId FROM Quotations WHERE QuotationId=@Qid))
                    WHERE QuotationId=@Qid";
                dal.ExecuteNonQuery(qSetQty, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });

                // B. Approve the Quote
                string q1 = "UPDATE Quotations SET Status='Approved' WHERE QuotationId=@Qid";
                dal.ExecuteNonQuery(q1, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });

                // C. Confirm the Order
                string qOrder = "UPDATE Orders SET Status='Confirmed' WHERE OrderId=(SELECT OrderId FROM Quotations WHERE QuotationId=@Qid)";
                dal.ExecuteNonQuery(qOrder, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });

                // D. DEDUCT STOCK (Update Inventory)
                string qStock = @"
                    UPDATE DistributorInventory 
                    SET StockQty = StockQty - (SELECT Quantity FROM Orders WHERE OrderId=(SELECT OrderId FROM Quotations WHERE QuotationId=@Qid))
                    WHERE DistributorId=(SELECT DistributorId FROM Quotations WHERE QuotationId=@Qid)
                    AND ProductId=(SELECT ProductId FROM Orders WHERE OrderId=(SELECT OrderId FROM Quotations WHERE QuotationId=@Qid))";
                dal.ExecuteNonQuery(qStock, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });

                // E. Reject other distributors for this same order
                string qReject = "UPDATE Quotations SET Status='Rejected' WHERE OrderId=(SELECT OrderId FROM Quotations WHERE QuotationId=@Qid) AND QuotationId != @Qid";
                dal.ExecuteNonQuery(qReject, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });
            }
            else if (decision == "Reject")
            {
                string q1 = "UPDATE Quotations SET Status='Rejected' WHERE QuotationId=@Qid";
                dal.ExecuteNonQuery(q1, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });
            }

            return true;
        }

        // NEW: Process multi-distributor approval with specific quantities
        public bool ProcessMultiDistributorApproval(string quotationsData)
        {
            // quotationsData format: "quoteId1:qty1,quoteId2:qty2,quoteId3:qty3"
            // Example: "15:2,16:3" means QuoteId 15 fulfills 2 units, QuoteId 16 fulfills 3 units
            
            if (string.IsNullOrEmpty(quotationsData))
                return false;

            try
            {
                var quotePairs = quotationsData.Split(',');
                int? orderId = null;
                int totalQtyNeeded = 0;
                int totalQtyAssigned = 0;

                // First pass: validate and get order info
                foreach (var pair in quotePairs)
                {
                    var parts = pair.Split(':');
                    if (parts.Length != 2) continue;

                    int quoteId = int.Parse(parts[0]);
                    int qtyToFulfill = int.Parse(parts[1]);
                    totalQtyAssigned += qtyToFulfill;

                    // Get OrderId if not yet set
                    if (orderId == null)
                    {
                        string getOrderQuery = "SELECT OrderId, (SELECT Quantity FROM Orders WHERE OrderId = Q.OrderId) AS QtyNeeded FROM Quotations Q WHERE QuotationId = " + quoteId;
                        DataTable dtOrder = dal.ExecuteQuery(getOrderQuery);
                        if (dtOrder.Rows.Count > 0)
                        {
                            orderId = Convert.ToInt32(dtOrder.Rows[0]["OrderId"]);
                            totalQtyNeeded = Convert.ToInt32(dtOrder.Rows[0]["QtyNeeded"]);
                        }
                    }
                }

                // Validation: total assigned must equal total needed
                if (totalQtyAssigned != totalQtyNeeded)
                    return false;

                // Second pass: update each quotation
                foreach (var pair in quotePairs)
                {
                    var parts = pair.Split(':');
                    if (parts.Length != 2) continue;

                    int quoteId = int.Parse(parts[0]);
                    int qtyToFulfill = int.Parse(parts[1]);

                    // Set QuantityFulfilled
                    string qSetQty = "UPDATE Quotations SET QuantityFulfilled = @Qty WHERE QuotationId = @Qid";
                    dal.ExecuteNonQuery(qSetQty, new SqlParameter[] { 
                        new SqlParameter("@Qty", qtyToFulfill),
                        new SqlParameter("@Qid", quoteId)
                    });

                    // Approve the quote
                    string qApprove = "UPDATE Quotations SET Status='Approved' WHERE QuotationId = @Qid";
                    dal.ExecuteNonQuery(qApprove, new SqlParameter[] { new SqlParameter("@Qid", quoteId) });

                    // Deduct stock from distributor inventory
                    string qStock = @"
                        UPDATE DistributorInventory 
                        SET StockQty = StockQty - @Qty
                        WHERE DistributorId = (SELECT DistributorId FROM Quotations WHERE QuotationId = @Qid)
                        AND ProductId = (SELECT ProductId FROM Orders WHERE OrderId = @Oid)";
                    dal.ExecuteNonQuery(qStock, new SqlParameter[] { 
                        new SqlParameter("@Qty", qtyToFulfill),
                        new SqlParameter("@Qid", quoteId),
                        new SqlParameter("@Oid", orderId)
                    });
                }

                // Confirm the order
                string qConfirm = "UPDATE Orders SET Status='Confirmed' WHERE OrderId = @Oid";
                dal.ExecuteNonQuery(qConfirm, new SqlParameter[] { new SqlParameter("@Oid", orderId) });

                // Reject other distributors for this order
                string qReject = "UPDATE Quotations SET Status='Rejected' WHERE OrderId = @Oid AND Status = 'Responded'";
                dal.ExecuteNonQuery(qReject, new SqlParameter[] { new SqlParameter("@Oid", orderId) });

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}