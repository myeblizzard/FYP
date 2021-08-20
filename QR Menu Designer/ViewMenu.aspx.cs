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
    public partial class ViewMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Username"] = "test1";
            SqlConnection conDisplayMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if(String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC"; //ORDER BY ItemID
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conDisplayMenu);
                cmdDisplayMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                conDisplayMenu.Open();

                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                while (readDisplayMenu.Read())
                {
                    lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                }
                conDisplayMenu.Close();

                conDisplayMenu.Open();
                using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                {
                    rptCategory.DataSource = readDisplayMenu;
                    rptCategory.DataBind();
                }
                conDisplayMenu.Close();
            }
            else
            {
                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID AND Username = @Username GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conDisplayMenu);
                cmdDisplayMenu.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdDisplayMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                while (readDisplayMenu.Read())
                {
                    lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                }
                conDisplayMenu.Close();

                conDisplayMenu.Open();
                using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                {
                    rptCategory.DataSource = readDisplayMenu;
                    rptCategory.DataBind();
                }
                conDisplayMenu.Close();
            }
        }

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conDisplayItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                var hdfCategory = (HiddenField)e.Item.FindControl("hdfCategory");
                var rptItem = (Repeater)e.Item.FindControl("rptItem");

                if (String.IsNullOrEmpty(Session["MenuID"] as string))
                {
                    string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE MenuID IS NULL AND ItemCategory = @CurrCategory AND Username = @Username";
                    SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                    cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                    cmdDisplayItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conDisplayItem.Open();
                    using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                    {
                        rptItem.DataSource = readDisplayItem;
                        rptItem.DataBind();
                    }
                    conDisplayItem.Close();
                }
            }
        }
    }
}
