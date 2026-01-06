using System;

namespace GadgetHubService.Models
{
    public class Quotation
    {
        public int QuotationId { get; set; }
        public int OrderId { get; set; }
        public int DistributorId { get; set; }
        public string DistributorName { get; set; } 
        public string Status { get; set; }
        public decimal PriceOffered { get; set; }
        public int EstimatedDeliveryDays { get; set; }

        public int RealStock { get; set; }
        public string CustomerName { get; set; } 
        public string ProductName { get; set; } 
        public int RequestedQty { get; set; } 

        public bool IsWinner { get; set; } 
    }
}