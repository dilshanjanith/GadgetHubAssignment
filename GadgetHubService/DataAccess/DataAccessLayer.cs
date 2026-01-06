using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace GadgetHubService.DataAccess
{
    public class DataAccessLayer
    {
        // CRITICAL: This looks for a connection string named "GadgetHubDb" in your Web.config
        // If your Web.config uses a different name, update this string here!
        private string connStr = ConfigurationManager.ConnectionStrings["GadgetHubDb"].ConnectionString;

        // 1. Tool to modify data (INSERT, UPDATE, DELETE)
        public int ExecuteNonQuery(string query, SqlParameter[] p)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (p != null) cmd.Parameters.AddRange(p);
                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        // 2. Tool to get a single value (Like "Count" or "ID")
        public object ExecuteScalar(string query, SqlParameter[] p)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (p != null) cmd.Parameters.AddRange(p);
                    conn.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        // 3. Tool to get a table of data (SELECT *)
        public DataTable ExecuteQuery(string query, SqlParameter[] p = null)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (p != null) cmd.Parameters.AddRange(p);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
}