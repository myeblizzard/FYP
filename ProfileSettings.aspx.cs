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
    public partial class ProfileSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection conDisplayPw = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            if (String.IsNullOrEmpty(Session["Username"] as string))
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                lblErrMsg.InnerText = "";
                lblSuccessMsg.InnerText = "";
                lblNewPw.Visible = false;
                txtPassword.Visible = false;
                divConfirmPw.Visible = false;
                btnResetPw.Visible = false;
                lblEmail.Text = Session["Username"].ToString();
                string sqlDisplayPw = "SELECT Password FROM Profile WHERE Username = @Username";
                SqlCommand cmdDisplayPw = new SqlCommand(sqlDisplayPw, conDisplayPw);
                cmdDisplayPw.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conDisplayPw.Open();
                string password = cmdDisplayPw.ExecuteScalar().ToString();
                conDisplayPw.Close();
                lblPassword.Text = password;
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void EditPassword(object sender, EventArgs e)
        {
            lblNewPw.Visible = true;
            txtPassword.Visible = true;
            divConfirmPw.Visible = true;
            btnResetPw.Visible = true;
        }

        protected void UpdateProfile(object sender, EventArgs e)
        {
            SqlConnection conUpdateProfile = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblSuccessMsg.InnerText = "";
                modalTitle.InnerText = "ERROR";
                lblErrMsg.InnerText = "Password confirmation and new password does not match";
            }
            else
            {
                lblErrMsg.InnerText = "";
                string sqlRegister = "UPDATE Profile SET Password = @Password";
                SqlCommand cmdRegister = new SqlCommand(sqlRegister, conUpdateProfile);
                cmdRegister.Parameters.AddWithValue("@Password", txtPassword.Text);
                conUpdateProfile.Open();
                cmdRegister.ExecuteNonQuery();
                conUpdateProfile.Close();
                modalTitle2.InnerText = "SUCCESS";
                lblSuccessMsg.InnerText = "Password successfully updated";
                lblNewPw.Visible = false;
                txtPassword.Visible = false;
                divConfirmPw.Visible = false;
                btnResetPw.Visible = false;
            }
        }
    }
}