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
            Session.Clear();

            if (!IsPostBack)
            {
                lblErrMsg.InnerText = "";
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void BtnLogInClick(object sender, EventArgs e)
        {
            SqlConnection conLogin = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            string sqlVerifyAccount = "SELECT COUNT(*) FROM [Profile] WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS";
            SqlCommand cmdVerifyAccount = new SqlCommand(sqlVerifyAccount, conLogin);
            cmdVerifyAccount.Parameters.AddWithValue("@Username", txtUsername.Text);

            conLogin.Open();
            int count = Convert.ToInt32(cmdVerifyAccount.ExecuteScalar());
            conLogin.Close();

            if(count == 1)
            {
                string sqlLogin = "SELECT COUNT(*) FROM [Profile] WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS AND Password = @Password COLLATE SQL_Latin1_General_CP1_CS_AS";

                SqlCommand cmdLogin = new SqlCommand(sqlLogin, conLogin);
                cmdLogin.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmdLogin.Parameters.AddWithValue("@Password", txtPassword.Text);

                conLogin.Open();
                int count2 = Convert.ToInt32(cmdLogin.ExecuteScalar());
                conLogin.Close();

                if (count2 == 1)
                {
                    Session["Username"] = txtUsername.Text;
                    Response.Redirect("MainMenu.aspx");
                }
                else
                {
                    lblErrMsg.InnerText = "Password does not match the username";
                }
            }
            else if(count == 0)
            {
                lblErrMsg.InnerText = "Username not registered, please click sign up to register";
            }
            else
            {
                lblErrMsg.InnerText = "WHAT HAPPENED?";
            }
        }

        protected void BtnSignUpClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}
