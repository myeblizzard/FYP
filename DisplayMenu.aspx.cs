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
    public partial class DisplayMenu : System.Web.UI.Page
    {
        private int menuType;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(String.IsNullOrEmpty(Session["Username"] as string))
            {
                btnHamburger.Visible = false;
            }
            else
            {
                btnHamburger.Visible = true;
            }

            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;
            }
            SqlConnection conDisplayMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            
            if (Request.QueryString["MenuID"] != null)
            {
                Session["MenuID"] = Request.QueryString["MenuID"];
                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conDisplayMenu);
                cmdMenuTemplate.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                conDisplayMenu.Open();
                SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                while (readMenuTemplate.Read())
                {
                    menuType = Convert.ToInt32(readMenuTemplate["TemplateType"]);
                    linkCSS.Attributes["href"] = readMenuTemplate["CssFile"].ToString();
                }
                conDisplayMenu.Close();
                
                //load parts in common
                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conDisplayMenu);
                cmdDisplayMenu.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                conDisplayMenu.Open();
                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                switch (menuType)
                {
                    case 1:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conDisplayMenu.Close();

                        MultiView1.ActiveViewIndex = 0;

                        conDisplayMenu.Open();
                        readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                        while (readMenuTemplate.Read())
                        {
                            divMenu.Style["background-image"] = readMenuTemplate["BackgroundImage"].ToString();
                            lblTitle.Style["font-family"] = readMenuTemplate["TitleFontStyle"].ToString();
                            lblTitle.Style["font-size"] = readMenuTemplate["TitleFontSize"].ToString();
                            lblTitle.Style["color"] = readMenuTemplate["TitleFontColour"].ToString();
                        }
                        conDisplayMenu.Close();

                        conDisplayMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory.DataSource = readDisplayMenu;
                            rptCategory.DataBind();
                        }
                        conDisplayMenu.Close();
                        break;

                    case 2:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conDisplayMenu.Close();

                        MultiView1.ActiveViewIndex = 1;

                        conDisplayMenu.Open();
                        readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                        while (readMenuTemplate.Read())
                        {
                            divMenu2.Style["background-image"] = readMenuTemplate["BackgroundImage"].ToString();
                            lblTitle2.Style["font-family"] = readMenuTemplate["TitleFontStyle"].ToString();
                            lblTitle2.Style["font-size"] = readMenuTemplate["TitleFontSize"].ToString();
                            lblTitle2.Style["color"] = readMenuTemplate["TitleFontColour"].ToString();
                        }
                        conDisplayMenu.Close();

                        conDisplayMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory2.DataSource = readDisplayMenu;
                            rptCategory2.DataBind();
                        }
                        conDisplayMenu.Close();

                        string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conDisplayMenu);
                        cmdDisplayImg.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);

                        conDisplayMenu.Open();
                        using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                        {
                            rptImg.DataSource = readDisplayImg;
                            rptImg.DataBind();
                        }
                        conDisplayMenu.Close();
                        break;

                    case 3:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conDisplayMenu.Close();

                        MultiView1.ActiveViewIndex = 2;

                        conDisplayMenu.Open();
                        readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                        while (readMenuTemplate.Read())
                        {
                            divMenu3.Style["background-image"] = readMenuTemplate["BackgroundImage"].ToString();
                            lblTitle3.Style["font-family"] = readMenuTemplate["TitleFontStyle"].ToString();
                            lblTitle3.Style["font-size"] = readMenuTemplate["TitleFontSize"].ToString();
                            lblTitle3.Style["color"] = readMenuTemplate["TitleFontColour"].ToString();
                        }
                        conDisplayMenu.Close();

                        conDisplayMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory3.DataSource = readDisplayMenu;
                            rptCategory3.DataBind();
                        }
                        conDisplayMenu.Close();
                        break;

                    default:
                        //unknown menu type
                        break;
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("InputDetails.aspx");
        }

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conDisplayItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                if (Request.QueryString["MenuID"] != null)
                {
                    var hdfCategory = (HiddenField)e.Item.FindControl("hdfCategory");
                    var rptItem = (Repeater)e.Item.FindControl("rptItem");
                    var lblCategory = (Label)e.Item.FindControl("lblCategory");

                    //check templateType
                    string sqlMenuTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";
                    SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conDisplayItem);
                    cmdMenuTemplate.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                    conDisplayItem.Open();
                    SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                    while (readMenuTemplate.Read())
                    {
                        lblCategory.Style["font-family"] = readMenuTemplate["CategoryFontStyle"].ToString();
                        lblCategory.Style["font-size"] = readMenuTemplate["CategoryFontSize"].ToString();
                        lblCategory.Style["color"] = readMenuTemplate["CategoryFontColour"].ToString();
                    }
                    conDisplayItem.Close();

                    if (menuType == 1)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItem.DataSource = readDisplayItem;
                            rptItem.DataBind();
                        }
                        conDisplayItem.Close();
                    }
                    else if(menuType == 2)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItem.DataSource = readDisplayItem;
                            rptItem.DataBind();
                        }
                        conDisplayItem.Close();
                    }
                    else if(menuType == 3)
                    {
                        var rptItemWithoutImg = (Repeater)e.Item.FindControl("rptItemWithoutImg");

                        string sqlDisplayItem = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItem.DataSource = readDisplayItem;
                            rptItem.DataBind();
                        }
                        conDisplayItem.Close();

                        string sqlDisplayItemWithoutImage = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NULL AND MenuID = @MenuID GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
                        cmdDisplayItem = new SqlCommand(sqlDisplayItemWithoutImage, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItemWithoutImg.DataSource = readDisplayItem;
                            rptItemWithoutImg.DataBind();
                        }
                        conDisplayItem.Close();
                    }
                    else
                    {
                        //unknown menu type
                    }
                }
                else
                {
                    //menu id null
                }
            }
        }
        protected void rptItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conStyleItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                if (Request.QueryString["MenuID"] != null)
                {
                    var lblItem = (Label)e.Item.FindControl("lblItem");
                    var lblPrice = (Label)e.Item.FindControl("lblPrice");

                    //check templateType
                    string sqlMenuTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";
                    SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conStyleItem);
                    cmdMenuTemplate.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                    conStyleItem.Open();
                    SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                    while (readMenuTemplate.Read())
                    {
                        lblItem.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                        lblItem.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                        lblItem.Style["color"] = readMenuTemplate["FontColour"].ToString();
                        lblPrice.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                        lblPrice.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                        lblPrice.Style["color"] = readMenuTemplate["FontColour"].ToString();
                    }
                    conStyleItem.Close();
                }
            }
        }

        protected void rptItem_ItemDataBound2(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conStyleItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                if (Request.QueryString["MenuID"] != null)
                {
                    //check templateType
                    string sqlMenuTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";
                    SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conStyleItem);
                    cmdMenuTemplate.Parameters.AddWithValue("@MenuID", Request.QueryString["MenuID"]);
                    conStyleItem.Open();
                    SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                    conStyleItem.Close();
                    if (menuType == 3)
                    {
                        var lblItemWithoutImg = (Label)e.Item.FindControl("lblItemWithoutImg");
                        var lblPriceWithoutImg = (Label)e.Item.FindControl("lblPriceWithoutImg");

                        conStyleItem.Open();
                        readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                        while (readMenuTemplate.Read())
                        {
                            lblItemWithoutImg.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                            lblItemWithoutImg.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                            lblItemWithoutImg.Style["color"] = readMenuTemplate["FontColour"].ToString();
                            lblPriceWithoutImg.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                            lblPriceWithoutImg.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                            lblPriceWithoutImg.Style["color"] = readMenuTemplate["FontColour"].ToString();
                        }
                        conStyleItem.Close();
                    }
                }
            }
        }
    }
}