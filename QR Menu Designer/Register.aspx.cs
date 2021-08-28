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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrMsg.InnerText = "";
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void BtnRegisterClick(object sender, EventArgs e)
        {
            string sqlInputCheck = "SELECT COUNT(*) FROM [Profile] WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS";

            SqlConnection conRegister = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand cmdInputCheck = new SqlCommand(sqlInputCheck, conRegister);
            cmdInputCheck.Parameters.AddWithValue("@Username", txtUsername.Text);
            cmdInputCheck.Parameters.AddWithValue("@Password", txtPassword.Text);

            conRegister.Open();
            int count = Convert.ToInt32(cmdInputCheck.ExecuteScalar());
            conRegister.Close();

            if(count == 1)
            {
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "javascript", "toggleModal()", true);
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "toggleModal()", true);
                lblErrMsg.InnerText = "This email has already been registered, please register another email";
                //lblErrMsg.Visible = true;
            }
            else if(count == 0)
            {
                if(txtPassword.Text != txtConfirmPassword.Text)
                {
                    //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "javascript", "toggleModal()", true);
                    //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "toggleModal()", true);
                    lblErrMsg.InnerText = "Password confirmation and first password does not match";
                    //lblErrMsg.Visible = true;
                }
                else
                {
                    string sqlRegister = "INSERT INTO Profile (Username, Password) VALUES (@Username, @Password)";
                    SqlCommand cmdRegister = new SqlCommand(sqlRegister, conRegister);
                    cmdRegister.Parameters.AddWithValue("@Username", txtUsername.Text);
                    cmdRegister.Parameters.AddWithValue("@Password", txtPassword.Text);
                    conRegister.Open();
                    cmdRegister.ExecuteNonQuery();
                    conRegister.Close();
                }
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "javascript", "toggleModal()", true);
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "toggleModal()", true);
                lblErrMsg.InnerText = "WHAT HAPPENED?";
                //lblErrMsg.Visible = true;
            }
        }
    }
}