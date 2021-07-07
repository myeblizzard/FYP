using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace QR_Menu_Designer
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void returnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void btnLogInClick(object sender, EventArgs e)
        {

            string sql = "SELECT COUNT(*) FROM [Profile] WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS AND Password = @Password COLLATE SQL_Latin1_General_CP1_CS_AS";

            string strCon = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(strCon);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@Username", inputUsername);
            cmd.Parameters.AddWithValue("@Password", inputPassword);

            con.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            if (count == 1)
            {
                
                Session["Username"] = inputUsername;
                //FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
                Response.Redirect("MainMenu.aspx");
            }
            else
            {
                //lblLoginErr.Visible = true;
                //lblLoginErr.Text = "Invalid username or password!";
            }
        }
    }
}