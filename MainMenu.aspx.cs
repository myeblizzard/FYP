using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QR_Menu_Designer
{
    public partial class MainMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Session["Username"] as string))
            {
                Response.Redirect("Login.aspx");
            }
            Session["MenuID"] = "";
        }

        protected void CreateMenu(object sender, EventArgs e)
        {
            SqlConnection conCreateMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            string sqlCheckExistingDraft = "SELECT COUNT(*) FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username"; //check if this user has an existing draft
            SqlCommand cmdDisplayDraft = new SqlCommand(sqlCheckExistingDraft, conCreateMenu);
            cmdDisplayDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());

            conCreateMenu.Open();
            int hasDraft = Convert.ToInt32(cmdDisplayDraft.ExecuteScalar());
            conCreateMenu.Close();
            if (hasDraft > 0) //has existing draft
            {
                lblMenu.Text = "You have an unfinished menu, do you wish to continue?";
                btnAction.Text = "Continue Draft";
                btnDelete.Visible = true;
            }
            else
            {
                string sqlCreateDraft = "INSERT INTO Menu (Username) VALUES (@Username)";
                SqlCommand cmdCreateDraft = new SqlCommand(sqlCreateDraft, conCreateMenu);
                cmdCreateDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conCreateMenu.Open();
                cmdCreateDraft.ExecuteNonQuery();
                conCreateMenu.Close();
                Response.Redirect("InputDetails.aspx");
            }
        }

        protected void DeleteMenu(object sender, EventArgs e)
        {
            SqlConnection conDeleteMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            string sqlDeleteMenu = "DELETE FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username";
            SqlCommand cmdDeleteMenu = new SqlCommand(sqlDeleteMenu, conDeleteMenu);
            cmdDeleteMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            conDeleteMenu.Open();
            cmdDeleteMenu.ExecuteNonQuery();
            conDeleteMenu.Close();

            //create new draft after deleted the old
            string sqlCreateDraft = "INSERT INTO Menu (Username) VALUES (@Username)";
            SqlCommand cmdCreateDraft = new SqlCommand(sqlCreateDraft, conDeleteMenu);
            cmdCreateDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            conDeleteMenu.Open();
            cmdCreateDraft.ExecuteNonQuery();
            conDeleteMenu.Close();
            Response.Redirect("InputDetails.aspx");
        }

        protected void ContinueDraft(object sender, EventArgs e)
        {
            Response.Redirect("InputDetails.aspx");
        }

        protected void ViewMenu(object sender, EventArgs e)
        {
            SqlConnection conViewMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            string sqlCheckExistingMenu = "SELECT COUNT(*) FROM MenuDetails WHERE Username = @Username"; //check if this user has an existing menu or draft
            SqlCommand cmdDisplayMenu = new SqlCommand(sqlCheckExistingMenu, conViewMenu);
            cmdDisplayMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());

            conViewMenu.Open();
            int hasDraftOrMenu = Convert.ToInt32(cmdDisplayMenu.ExecuteScalar());
            if (hasDraftOrMenu > 0) //has existing menu or draft
            {
                Response.Redirect("ViewMenu.aspx");
            }
            else
            {
                lblMenu.Text = "You do not have any completed menu or uncompleted draft, do you wish to create one now?";
                btnDelete.Visible = false;
                btnAction.Text = "OK";
            }
            conViewMenu.Close();
        }
    }
}