using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

namespace QR_Menu_Designer
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        private static string email;
        private static string verificationCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;
                lblErrMsg.InnerText = "";
                lblEnterEmail.Visible = true;
                txtUsername.Visible = true;
                lblEmail.Visible = false;
                btnGetCode.Visible = true;
                btnResendCode.Visible = false;
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            switch (MultiView1.ActiveViewIndex)
            {
                case 0:
                    Response.Redirect("Login.aspx");
                    break;

                case 1:
                    MultiView1.ActiveViewIndex = 0;
                    break;

                case 2:
                    MultiView1.ActiveViewIndex = 1;
                    break;

                default:
                    //err
                    break;
            }
        }

        protected void GenerateCode(object sender, EventArgs e)
        {
            Button btnResend = (Button)sender;
            string resendCode = btnResend.CommandArgument.ToString();
            if(resendCode == "resend")
            {
                int _min = 0000;
                int _max = 9999;
                Random r = new Random();
                verificationCode = r.Next(_min, _max).ToString(); string to = email; //To address    
                string from = "PassionArt2929@gmail.com"; //From address    
                MailMessage message = new MailMessage(from, to);

                message.Subject = "Auto-Generated 4-Digit Verification Code From QRMenuDesigner";
                AlternateView imgview = AlternateView.CreateAlternateViewFromString("Your 4-digit verification code is: " + verificationCode);
                message.AlternateViews.Add(imgview);

                SmtpClient client = new SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                client.UseDefaultCredentials = false;
                System.Net.NetworkCredential basicCredential1 = new System.Net.NetworkCredential("PassionArt2929@gmail.com", "qwertypa");
                client.EnableSsl = true;
                client.Credentials = basicCredential1;
                client.Send(message);

                MultiView1.ActiveViewIndex = 1;
                modalTitle.InnerText = "Verification Code";
                lblErrMsg.InnerText = "The code has been sent to your email";
            }
            else
            {
                string sqlInputCheck = "SELECT COUNT(*) FROM [Profile] WHERE Username = @Username COLLATE SQL_Latin1_General_CP1_CS_AS";

                SqlConnection conGetCode = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                SqlCommand cmdInputCheck = new SqlCommand(sqlInputCheck, conGetCode);
                cmdInputCheck.Parameters.AddWithValue("@Username", txtUsername.Text);

                conGetCode.Open();
                int count = Convert.ToInt32(cmdInputCheck.ExecuteScalar());
                conGetCode.Close();

                if (count == 1)
                {
                    lblEnterEmail.Visible = false;
                    txtUsername.Visible = false;
                    lblEmail.Visible = true;
                    lblEmail.InnerText = txtUsername.Text;
                    lblEmail2.InnerText = txtUsername.Text;
                    lblEmail3.InnerText = txtUsername.Text;
                    email = txtUsername.Text;
                    btnGetCode.Visible = false;
                    btnResendCode.Visible = true;

                    int _min = 0000;
                    int _max = 9999;
                    Random r = new Random();
                    verificationCode = r.Next(_min, _max).ToString();

                    string to = email; //To address    
                    string from = "PassionArt2929@gmail.com"; //From address    
                    MailMessage message = new MailMessage(from, to);

                    message.Subject = "Auto-Generated 4-Digit Verification Code From QRMenuDesigner";
                    AlternateView imgview = AlternateView.CreateAlternateViewFromString("Your 4-digit verification code is: " + verificationCode);
                    message.AlternateViews.Add(imgview);

                    SmtpClient client = new SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                    client.UseDefaultCredentials = false;
                    System.Net.NetworkCredential basicCredential1 = new System.Net.NetworkCredential("PassionArt2929@gmail.com", "qwertypa");
                    client.EnableSsl = true;
                    client.Credentials = basicCredential1;
                    client.Send(message);

                    MultiView1.ActiveViewIndex = 1;
                    modalTitle.InnerText = "Verification Code";
                    lblErrMsg.InnerText = "The code has been sent to your email";
                }
                else if (count == 0)
                {
                    modalTitle.InnerText = "Error";
                    lblErrMsg.InnerText = "This email has not registered, please enter another email or go to register";
                }
                else
                {
                    modalTitle.InnerText = "Error";
                    lblErrMsg.InnerText = "WHAT HAPPENED?";
                }
            }
        }

        protected void VerifyCode(object sender, EventArgs e)
        {
            if(txtVCode.Text == verificationCode)
            {
                lblErrMsg.InnerText = "";
                MultiView1.ActiveViewIndex = 2;
            }
            else
            {
                modalTitle.InnerText = "Error";
                lblErrMsg.InnerText = "Incorrect Code, please enter again";
            }
        }

        protected void ResetPassword(object sender, EventArgs e)
        {
            SqlConnection conResetPw = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                modalTitle.InnerText = "Error";
                lblErrMsg.InnerText = "Password confirmation and first password does not match";
            }
            else
            {
                modalTitle2.InnerText = "Success";
                lblSuccessMsg.InnerText = "Your password has been successfully reset, you will now be redirected to the log in page";
                string sqlResetPw = "UPDATE Profile SET Password = @Password WHERE Username = @Username";
                SqlCommand cmdResetPw = new SqlCommand(sqlResetPw, conResetPw);
                cmdResetPw.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmdResetPw.Parameters.AddWithValue("@Password", txtPassword.Text);
                conResetPw.Open();
                cmdResetPw.ExecuteNonQuery();
                conResetPw.Close();
            }
        }
        protected void Proceed(object sender, EventArgs e)
        {
            lblSuccessMsg.InnerText = "";
            Response.Redirect("Login.aspx");
        }
    }
}