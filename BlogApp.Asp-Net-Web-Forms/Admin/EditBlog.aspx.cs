using BlogApp.Asp_Net_Web_Forms.Helpers;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlogApp.Asp_Net_Web_Forms.Admin
{
    public partial class EditBlog : System.Web.UI.Page
    {
        static SqlConnection connection = MyConnection.GetConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }
        public void LoadCategories()
        {
            ddlCategories.Items.Insert(0, new ListItem("Lütfen Seçim Yapınız...", "0"));

            string query = "SELECT * FROM Categories";
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ListItem list = new ListItem();
                list.Text = dr["CategoryName"].ToString();
                list.Value = dr["CategoryId"] + "";
                ddlCategories.Items.Add(list);
            }
            connection.Close();
        }
        [WebMethod]
        public static string GetBlogById(string blogId)
        {
            // Sessiondan gelen user id yi vereceğiz arka tarafta önde de verebiliriz keyfe kalmış
            string _data = "";
            string query = "Select * From Blogs INNER JOIN Categories ON Categories.CategoryId = Blogs.BlogCategoryId Where BlogId = @blogId";
            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@blogId", blogId);

            connection.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            connection.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                _data = JsonConvert.SerializeObject(ds.Tables[0]);
            }
            return _data;
        }
        [WebMethod]
        public static void UpdateBlog(string blogId, string blogName, string blogUrl, string blogContent, int blogCategoryId)
        {

            string query = "Update Blogs(BlogName, BlogUrl, BlogContent, BlogCategoryId) Values" +
                "(@blogName, @blogUrl, @blogContent, @blogCategoryId)" +
                " Where BlogId=" + blogId;

            SqlCommand cmd = new SqlCommand(query, connection);

            cmd.Parameters.AddWithValue("@blogName", blogName);
            cmd.Parameters.AddWithValue("@blogUrl", blogUrl);
            cmd.Parameters.AddWithValue("@blogContent", blogContent);
            cmd.Parameters.AddWithValue("@blogCategoryId", blogCategoryId);
            connection.Open();
            cmd.ExecuteNonQuery();
            connection.Close();
        }
    }
}