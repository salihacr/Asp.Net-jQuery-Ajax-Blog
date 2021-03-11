using BlogApp.Asp_Net_Web_Forms.Helpers;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BlogApp.Asp_Net_Web_Forms.SeedDatabase
{
    public static class SeedDb
    {
        static SqlConnection connection = MyConnection.GetConnection();
        static Helpers.Auth authManager = new Helpers.Auth();
        public static void Seed()
        {
            string users = "Insert Users(UserId, FullName, Email, Username, Image, Gender, Password, RoleName)" +
                " Values" +
                "('u1','Admin Admin','admin@blog.com','admin','no-image','male','" + authManager.CreatePasswordHash("admin") + "','Admin')," +
                "('u2','User1 User','user1@blog.com','user1','no-image','male','" + authManager.CreatePasswordHash("user1") + "','User')," +
                "('u3','User2 User','user2@blog.com','user2','no-image','male','" + authManager.CreatePasswordHash("user2") + "','User')";

            string categories = "Insert Categories(CategoryName)" +
                " Values('Yazılım')," +
                "('Programlama')," +
                "('Yapay Zeka')," +
                "('Veritabanı')," +
                "('Asp.Net Core')";

            string blogs = "Insert Blogs(BlogId, BlogName, BlogURL, BlogContent, HeaderImage, CreationDate, BlogCategoryId, BlogUserId)" +
                " Values" +
                "('blog1','1.Blog','blog1','<h1>1. Blog Icerik</h1>','no-image','" + DateTime.Now.ToShortDateString() + "','1','u1')," +
                "('blog2','2.Blog','blog2','<h1>1. Blog Icerik</h1>','no-image','" + DateTime.Now.ToShortDateString() + "','2','u2')," +
                "('blog3','3.Blog','blog3','<h1>1. Blog Icerik</h1>','no-image','" + DateTime.Now.ToShortDateString() + "','3','u3')";

            if (!HasData("Users"))
            {
                Insert(users);
            }
            if (!HasData("Categories"))
            {
                Insert(categories);
            }
            if (!HasData("Blogs"))
            {
                Insert(blogs);
            }
        }
        public static void Insert(string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, connection))
            {
                connection.Open();
                cmd.ExecuteNonQuery();
                connection.Close();
            }
        }
        public static bool HasData(string tableName)
        {
            using (SqlCommand cmd = new SqlCommand("Select Count(*) From " + tableName + "", connection))
            {
                connection.Open();
                object result = cmd.ExecuteScalar();
                connection.Close();
                if (result.ToString() == "0")
                {
                    return false;
                }
            }
            return true;
        }
    }
}