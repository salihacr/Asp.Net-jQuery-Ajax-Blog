using BlogApp.Asp_Net_Web_Forms.SeedDatabase;
using System;

namespace BlogApp.Asp_Net_Web_Forms
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Seed Database (Users, Categories, Blogs)         
            SeedDb.Seed();
        }
    }
}