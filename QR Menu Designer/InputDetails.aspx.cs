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
    public partial class InputDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //con.Open();
            //string query = "SELECT ItemName, Price, ItemCategory, ItemImage FROM MenuDetails WHERE Menu.MenuID = MenuDetails.MenuID AND Menu.Username = @Username";
            //SqlCommand cmdSelect = new SqlCommand(query, con);
            //cmdSelect.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            //con.Close();

            //SqlDataAdapter da = new SqlDataAdapter();
            //da.SelectCommand = cmdSelect;
            //DataTable dt = new DataTable();
            //da.Fill(dt);
            //SqlDataReader reader = cmdSelect.ExecuteReader();


        }

        protected void returnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }
    }
}