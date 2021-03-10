using BlogApp.Asp_Net_Web_Forms.Helpers;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace BlogApp.Asp_Net_Web_Forms
{
    public class Global : System.Web.HttpApplication
    {
        SqlConnection connection = MyConnection.GetConnection();
        /*Helpers.Auth authManager = new Helpers.Auth();
        Helpers.DbManager dbManager = new DbManager();*/
        protected void Application_Start(object sender, EventArgs e)
        {
            /*string password = "admin";
            string inputPasswordHash = authManager.CreatePasswordHash(password);
            string query = "INSERT INTO Users(FullName,Email,Username,Password,RoleName) VALUES" +
                "('Admin User','admin@admin.com','admin','" + inputPasswordHash + "','Admin')";

            if (dbManager.IsNull("Users"))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }*/
        }
    }
}