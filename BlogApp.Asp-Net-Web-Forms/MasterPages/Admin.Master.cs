using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlogApp.Asp_Net_Web_Forms.MasterPages
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"].ToString() != "Admin" || Session["Role"] == null) Response.Redirect("../Auth/Login.aspx");
        }
        protected void Logout_Button_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../Auth/Login.aspx");
        }
    }
}