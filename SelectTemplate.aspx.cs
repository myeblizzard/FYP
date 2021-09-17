using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using QRCoder;
using System.IO;
using System.Drawing;
using ZXing;
using ZXing.QrCode.Internal;
using ZXing.Rendering;

namespace QR_Menu_Designer
{
    public partial class SelectTemplate : System.Web.UI.Page
    {
        private static int menuType;
        private static int countImg;
        private static string templateID;
        private static string sqlDisplayTemplate;
        private static string sqlCheckImg;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["MenuID"] = "4000";
            //Session["Username"] = "test1";

            if (String.IsNullOrEmpty(Session["Username"] as string))
            {
                Response.Redirect("Login.aspx");
            }

            SqlConnection conDisplayTemplate = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(Session["MenuID"] as string)) 
                {
                    //decide the default template by firstly checking if there's any img
                    sqlCheckImg = "SELECT COUNT(ItemImage) FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdMenuTemplate = new SqlCommand(sqlCheckImg, conDisplayTemplate);
                    cmdMenuTemplate.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conDisplayTemplate.Open();
                    countImg = Convert.ToInt32(cmdMenuTemplate.ExecuteScalar());
                    conDisplayTemplate.Close();
                    if (countImg > 0)
                    {
                        sqlDisplayTemplate = "SELECT TemplateID, TemplateName, PreviewImage FROM Template WHERE TemplateType != 1";
                        templateID = "2001"; //default templateID
                    }
                    else if (countImg == 0)
                    {
                        sqlDisplayTemplate = "SELECT TemplateID, TemplateName, PreviewImage FROM Template WHERE TemplateType = 1";
                        templateID = "2000"; //default templateID 
                    }
                    else
                    {
                        //error
                    }
                    SqlCommand cmdDisplayTemplate = new SqlCommand(sqlDisplayTemplate, conDisplayTemplate);
                    conDisplayTemplate.Open();
                    using (SqlDataReader readDisplayTemplate = cmdDisplayTemplate.ExecuteReader())
                    {
                        rptTemplate.DataSource = readDisplayTemplate;
                        rptTemplate.DataBind();
                    }
                    conDisplayTemplate.Close();

                    //load default template for the draft
                    string sqlLoadTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";

                    SqlCommand cmdLoadTemplate = new SqlCommand(sqlLoadTemplate, conDisplayTemplate);
                    cmdLoadTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                    conDisplayTemplate.Open();
                    SqlDataReader readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                    while (readLoadTemplate.Read())
                    {
                        menuType = Convert.ToInt32(readLoadTemplate["TemplateType"]);
                        linkCSS.Attributes["href"] = readLoadTemplate["CssFile"].ToString();
                    }
                    conDisplayTemplate.Close();

                    string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                    SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conDisplayTemplate);
                    cmdDisplayMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conDisplayTemplate.Open();
                    SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                    switch (menuType)
                    {
                        case 1:
                            while (readDisplayMenu.Read())
                            {
                                lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();

                            MultiView1.ActiveViewIndex = 0;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory.DataSource = readDisplayMenu;
                                rptCategory.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;

                        case 2:
                            while (readDisplayMenu.Read())
                            {
                                lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();
                            MultiView1.ActiveViewIndex = 1;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu2.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle2.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle2.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle2.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory2.DataSource = readDisplayMenu;
                                rptCategory2.DataBind();
                            }
                            conDisplayTemplate.Close();

                            string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID IS NULL AND Username = @Username GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                            SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conDisplayTemplate);
                            cmdDisplayImg.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                            conDisplayTemplate.Open();
                            using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                            {
                                rptImg.DataSource = readDisplayImg;
                                rptImg.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;
                        case 3:
                            divView3.Style["margin-top"] = "23vh";
                            while (readDisplayMenu.Read())
                            {
                                lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();

                            MultiView1.ActiveViewIndex = 2;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu3.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle3.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle3.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle3.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory3.DataSource = readDisplayMenu;
                                rptCategory3.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;

                        default:
                            //unknown menu type
                            break;
                    }
                }
                else
                {
                    //Just proceed with the existing menuid
                    
                    //load the existing menu
                    string sqlLoadTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";

                    SqlCommand cmdLoadTemplate = new SqlCommand(sqlLoadTemplate, conDisplayTemplate);
                    cmdLoadTemplate.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    conDisplayTemplate.Open();
                    SqlDataReader readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                    while (readLoadTemplate.Read())
                    {
                        menuType = Convert.ToInt32(readLoadTemplate["TemplateType"]);
                        templateID = readLoadTemplate["TemplateID"].ToString();
                        linkCSS.Attributes["href"] = readLoadTemplate["CssFile"].ToString();
                    }
                    conDisplayTemplate.Close();

                    if(menuType == 1)
                    {
                        sqlDisplayTemplate = "SELECT TemplateID, TemplateName, PreviewImage FROM Template WHERE TemplateType = 1";
                    }
                    else if(menuType == 2 || menuType == 3)
                    {
                        sqlDisplayTemplate = "SELECT TemplateID, TemplateName, PreviewImage FROM Template WHERE TemplateType != 1";
                    }
                    else
                    {
                        //unknown menuType
                    }
                    SqlCommand cmdDisplayTemplate = new SqlCommand(sqlDisplayTemplate, conDisplayTemplate);
                    conDisplayTemplate.Open();
                    using (SqlDataReader readDisplayTemplate = cmdDisplayTemplate.ExecuteReader())
                    {
                        rptTemplate.DataSource = readDisplayTemplate;
                        rptTemplate.DataBind();
                    }
                    conDisplayTemplate.Close();

                    string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                    SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conDisplayTemplate);
                    cmdDisplayMenu.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    conDisplayTemplate.Open();
                    SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                    switch (menuType)
                    {
                        case 1:
                            while (readDisplayMenu.Read())
                            {
                                lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();

                            MultiView1.ActiveViewIndex = 0;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory.DataSource = readDisplayMenu;
                                rptCategory.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;

                        case 2:
                            while (readDisplayMenu.Read())
                            {
                                lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();
                            MultiView1.ActiveViewIndex = 1;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu2.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle2.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle2.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle2.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory2.DataSource = readDisplayMenu;
                                rptCategory2.DataBind();
                            }
                            conDisplayTemplate.Close();

                            string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                            SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conDisplayTemplate);
                            cmdDisplayImg.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());

                            conDisplayTemplate.Open();
                            using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                            {
                                rptImg.DataSource = readDisplayImg;
                                rptImg.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;

                        case 3:
                            divView3.Style["margin-top"] = "23vh";
                            while (readDisplayMenu.Read())
                            {
                                lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                            }
                            conDisplayTemplate.Close();
                            MultiView1.ActiveViewIndex = 2;

                            conDisplayTemplate.Open();
                            readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                            while (readLoadTemplate.Read())
                            {
                                divMenu3.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                                lblTitle3.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                                lblTitle3.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                                lblTitle3.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                            }
                            conDisplayTemplate.Close();

                            conDisplayTemplate.Open();
                            using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                            {
                                rptCategory3.DataSource = readDisplayMenu;
                                rptCategory3.DataBind();
                            }
                            conDisplayTemplate.Close();
                            break;

                        default:
                            //unknown menu type
                            break;
                    }
                }
            }
        }

        void ReloadRepeater()
        {
            SqlConnection conReloadRpt = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conReloadRpt);
                cmdDisplayMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conReloadRpt.Open();

                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                
                switch (menuType)
                {
                    case 1:
                        rptCategory.DataSource = readDisplayMenu;
                        rptCategory.DataBind();
                        conReloadRpt.Close();
                        break;

                    case 2:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conReloadRpt.Close();

                        conReloadRpt.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory2.DataSource = readDisplayMenu;
                            rptCategory2.DataBind();
                        }
                        conReloadRpt.Close();

                        string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID IS NULL AND Username = @Username GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conReloadRpt);
                        cmdDisplayImg.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conReloadRpt.Open();
                        using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                        {
                            rptImg.DataSource = readDisplayImg;
                            rptImg.DataBind();
                        }
                        conReloadRpt.Close();
                        break;

                    case 3:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conReloadRpt.Close();

                        conReloadRpt.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory3.DataSource = readDisplayMenu;
                            rptCategory3.DataBind();
                        }
                        conReloadRpt.Close();
                        break;

                    default:
                        // unknown menutype
                        break;
                }
            }
            else
            {
                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conReloadRpt);
                cmdDisplayMenu.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                conReloadRpt.Open();

                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                
                switch (menuType)
                {
                    case 1:
                        rptCategory.DataSource = readDisplayMenu;
                        rptCategory.DataBind();
                        conReloadRpt.Close();
                        break;

                    case 2:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conReloadRpt.Close();

                        conReloadRpt.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory2.DataSource = readDisplayMenu;
                            rptCategory2.DataBind();
                        }
                        conReloadRpt.Close();

                        string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conReloadRpt);
                        cmdDisplayImg.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());

                        conReloadRpt.Open();
                        using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                        {
                            rptImg.DataSource = readDisplayImg;
                            rptImg.DataBind();
                        }
                        conReloadRpt.Close();
                        break;

                    case 3:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conReloadRpt.Close();

                        conReloadRpt.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory3.DataSource = readDisplayMenu;
                            rptCategory3.DataBind();
                        }
                        conReloadRpt.Close();
                        break;

                    default:
                        // unknown menutype
                        break;
                }
            }
        }

        protected void Template_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btnImg = (ImageButton)sender;
            templateID = btnImg.CommandArgument.ToString();

            SqlConnection conTemplateType = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            string sqlTemplateType = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
            SqlCommand cmdTemplateType = new SqlCommand(sqlTemplateType, conTemplateType);
            cmdTemplateType.Parameters.AddWithValue("@TemplateID", templateID);
            conTemplateType.Open();
            SqlDataReader readTemplateType = cmdTemplateType.ExecuteReader();
            while (readTemplateType.Read())
            {
                menuType = Convert.ToInt32(readTemplateType["TemplateType"]);
                linkCSS.Attributes["href"] = readTemplateType["CssFile"].ToString();
            }
            conTemplateType.Close();

            switch (menuType)
            {
                case 1:
                    conTemplateType.Open();
                    readTemplateType = cmdTemplateType.ExecuteReader();
                    while (readTemplateType.Read())
                    {
                        divMenu.Style["background-image"] = readTemplateType["BackgroundImage"].ToString();
                        lblTitle.Style["font-family"] = readTemplateType["TitleFontStyle"].ToString();
                        lblTitle.Style["font-size"] = readTemplateType["TitleFontSize"].ToString();
                        lblTitle.Style["color"] = readTemplateType["TitleFontColour"].ToString();
                    }
                    conTemplateType.Close();
                    MultiView1.ActiveViewIndex = 0;
                    break;

                case 2:
                    conTemplateType.Open();
                    readTemplateType = cmdTemplateType.ExecuteReader();
                    while (readTemplateType.Read())
                    {
                        divMenu2.Style["background-image"] = readTemplateType["BackgroundImage"].ToString();
                        lblTitle2.Style["font-family"] = readTemplateType["TitleFontStyle"].ToString();
                        lblTitle2.Style["font-size"] = readTemplateType["TitleFontSize"].ToString();
                        lblTitle2.Style["color"] = readTemplateType["TitleFontColour"].ToString();
                    }
                    conTemplateType.Close();
                    MultiView1.ActiveViewIndex = 1;
                    break;

                case 3:
                    divView3.Style["margin-top"] = "23vh";
                    conTemplateType.Open();
                    readTemplateType = cmdTemplateType.ExecuteReader();
                    while (readTemplateType.Read())
                    {
                        divMenu3.Style["background-image"] = readTemplateType["BackgroundImage"].ToString();
                        lblTitle3.Style["font-family"] = readTemplateType["TitleFontStyle"].ToString();
                        lblTitle3.Style["font-size"] = readTemplateType["TitleFontSize"].ToString();
                        lblTitle3.Style["color"] = readTemplateType["TitleFontColour"].ToString();
                    }
                    conTemplateType.Close();
                    MultiView1.ActiveViewIndex = 2;
                    break;
                    
                default:
                    //unknown template type
                    break;
            }
            ReloadRepeater();
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("InputDetails.aspx");
        }
    
        //seperate rptCategory_ItemDataBound
        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conDisplayItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                var hdfCategory = (HiddenField)e.Item.FindControl("hdfCategory");
                var rptItem = (Repeater)e.Item.FindControl("rptItem");
                var lblCategory = (Label)e.Item.FindControl("lblCategory");

                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conDisplayItem);
                cmdMenuTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                conDisplayItem.Open();
                SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                while (readMenuTemplate.Read())
                {
                    lblCategory.Style["font-family"] = readMenuTemplate["CategoryFontStyle"].ToString();
                    lblCategory.Style["font-size"] = readMenuTemplate["CategoryFontSize"].ToString();
                    lblCategory.Style["color"] = readMenuTemplate["CategoryFontColour"].ToString();
                }
                conDisplayItem.Close();

                if (String.IsNullOrEmpty(Session["MenuID"] as string)) //Menu draft
                {
                    if (menuType == 1)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID IS NULL AND Username = @Username GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
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
                    else
                    {
                        //unknown menu type
                    }
                }
                else //Existing Menu
                {
                    if (menuType == 1)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItem.DataSource = readDisplayItem;
                            rptItem.DataBind();
                        }
                        conDisplayItem.Close();
                    }
                    else
                    {
                        //unknown menu type
                    }
                }
            }
        }

        protected void rptCategory_ItemDataBound2(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conDisplayItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var hdfCategory = (HiddenField)e.Item.FindControl("hdfCategory");
                var rptItem = (Repeater)e.Item.FindControl("rptItem");
                var lblCategory = (Label)e.Item.FindControl("lblCategory");

                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conDisplayItem);
                cmdMenuTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                conDisplayItem.Open();
                SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                while (readMenuTemplate.Read())
                {
                    lblCategory.Style["font-family"] = readMenuTemplate["CategoryFontStyle"].ToString();
                    lblCategory.Style["font-size"] = readMenuTemplate["CategoryFontSize"].ToString();
                    lblCategory.Style["color"] = readMenuTemplate["CategoryFontColour"].ToString();
                }
                conDisplayItem.Close();

                if (String.IsNullOrEmpty(Session["MenuID"] as string)) // draft menu
                {
                    if (menuType == 2)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID IS NULL AND Username = @Username GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
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
                else //existing menu
                {
                    if (menuType == 2)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
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

        protected void rptCategory_ItemDataBound3(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conDisplayItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var hdfCategory = (HiddenField)e.Item.FindControl("hdfCategory");
                var rptItem = (Repeater)e.Item.FindControl("rptItem");
                var lblCategory = (Label)e.Item.FindControl("lblCategory");

                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conDisplayItem);
                cmdMenuTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                conDisplayItem.Open();
                SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                while (readMenuTemplate.Read())
                {
                    lblCategory.Style["font-family"] = readMenuTemplate["CategoryFontStyle"].ToString();
                    lblCategory.Style["font-size"] = readMenuTemplate["CategoryFontSize"].ToString();
                    lblCategory.Style["color"] = readMenuTemplate["CategoryFontColour"].ToString();
                }
                conDisplayItem.Close();

                if (String.IsNullOrEmpty(Session["MenuID"] as string)) //draft menu
                {
                    if (menuType == 3)
                    {
                        var rptItemWithoutImg = (Repeater)e.Item.FindControl("rptItemWithoutImg");

                        string sqlDisplayItem = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NOT NULL AND MenuID IS NULL AND Username = @Username GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
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

                        string sqlDisplayItemWithoutImage = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NULL AND MenuID IS NULL AND Username = @Username GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
                        cmdDisplayItem = new SqlCommand(sqlDisplayItemWithoutImage, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItemWithoutImg.DataSource = readDisplayItem;
                            rptItemWithoutImg.DataBind();
                        }
                        conDisplayItem.Close();
                    }
                }
                else // existing menu
                {
                    if (menuType == 3)
                    {
                        var rptItemWithoutImg = (Repeater)e.Item.FindControl("rptItemWithoutImg");

                        string sqlDisplayItem = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
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
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        conDisplayItem.Open();
                        using (SqlDataReader readDisplayItem = cmdDisplayItem.ExecuteReader())
                        {
                            rptItemWithoutImg.DataSource = readDisplayItem;
                            rptItemWithoutImg.DataBind();
                        }
                        conDisplayItem.Close();
                    }

                }
            }
        }

        protected void rptItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conStyleItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                var lblItem = (Label)e.Item.FindControl("lblItem");
                var lblPrice = (Label)e.Item.FindControl("lblPrice");
                
                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conStyleItem);
                cmdMenuTemplate.Parameters.AddWithValue("@TemplateID", templateID);
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

        protected void rptItem_ItemDataBound2(object sender, RepeaterItemEventArgs e)
        {
            SqlConnection conStyleItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item) // e.Item.DataItem != null
            {
                var lblItemWithoutImg = (Label)e.Item.FindControl("lblItemWithoutImg");
                var lblPriceWithoutImg = (Label)e.Item.FindControl("lblPriceWithoutImg");

                //check templateType
                string sqlMenuTemplate = "SELECT * FROM Template WHERE TemplateID = @TemplateID";
                SqlCommand cmdMenuTemplate = new SqlCommand(sqlMenuTemplate, conStyleItem);
                cmdMenuTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                conStyleItem.Open();
                SqlDataReader readMenuTemplate = cmdMenuTemplate.ExecuteReader();
                if (menuType == 3)
                {
                    while (readMenuTemplate.Read())
                    {
                        lblItemWithoutImg.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                        lblItemWithoutImg.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                        lblItemWithoutImg.Style["color"] = readMenuTemplate["FontColour"].ToString();
                        lblPriceWithoutImg.Style["font-family"] = readMenuTemplate["FontStyle"].ToString();
                        lblPriceWithoutImg.Style["font-size"] = readMenuTemplate["FontSize"].ToString();
                        lblPriceWithoutImg.Style["color"] = readMenuTemplate["FontColour"].ToString();
                    }
                }
                conStyleItem.Close();
            }
        }


        protected void CompleteMenu(object sender, EventArgs e)
        {
            //when proceeding with the selected template
            //1. search for null qrcodeurl in menu, get the menu id and generate the qrcode with the id
            //2. store the template id and qrcode url at menu
            //3. set menu id in menudetails for this completed draft
            //4. 
            SqlConnection conCompleteMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            if(String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlSearchMenuID = "SELECT MenuID FROM Menu WHERE Username = @Username AND QRCodeURL IS NULL";
                SqlCommand cmdSearchMenuID = new SqlCommand(sqlSearchMenuID, conCompleteMenu);
                cmdSearchMenuID.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conCompleteMenu.Open();
                string MenuID = cmdSearchMenuID.ExecuteScalar().ToString();
                conCompleteMenu.Close();

                string sqlConvertDraftToMenu = "UPDATE MenuDetails SET MenuID = @MenuID WHERE MenuID IS NULL AND Username = @Username";
                SqlCommand cmdConvertDraftToMenu = new SqlCommand(sqlConvertDraftToMenu, conCompleteMenu);
                cmdConvertDraftToMenu.Parameters.AddWithValue("@MenuID", Convert.ToInt32(MenuID));
                cmdConvertDraftToMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conCompleteMenu.Open();
                cmdConvertDraftToMenu.ExecuteNonQuery();
                conCompleteMenu.Close();

                string queryString = "DisplayMenu.aspx?MenuID=" + MenuID;
                string qrCodeUrl = "http://localhost:65461/" + queryString;
            
                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(qrCodeUrl, QRCodeGenerator.ECCLevel.Q);
                System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
                imgBarCode.Height = 150;
                imgBarCode.Width = 150;
                using (Bitmap bitMap = qrCode.GetGraphic(20))
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                        byte[] byteImage = ms.ToArray();
                        imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                    }
                }
                string sqlUserID = "UPDATE Menu SET QRCodeURL = @QRCodeURL, TemplateID = @TemplateID WHERE Username = @Username";
                SqlCommand cmdAddUrl = new SqlCommand(sqlUserID, conCompleteMenu);
                cmdAddUrl.Parameters.AddWithValue("@QRCodeURL", qrCodeUrl);
                cmdAddUrl.Parameters.AddWithValue("@TemplateID", templateID);
                cmdAddUrl.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conCompleteMenu.Open();
                cmdAddUrl.ExecuteNonQuery();
                conCompleteMenu.Close();

                Response.Redirect(queryString);
            }
            else
            {
                string sqlUpdateTemplate = "UPDATE Menu SET TemplateID = @TemplateID WHERE MenuID = @MenuID";
                SqlCommand cmdUpdateTemplate = new SqlCommand(sqlUpdateTemplate, conCompleteMenu);
                cmdUpdateTemplate.Parameters.AddWithValue("@TemplateID", templateID);
                cmdUpdateTemplate.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                conCompleteMenu.Open();
                cmdUpdateTemplate.ExecuteNonQuery();
                conCompleteMenu.Close();
                string queryString = "DisplayMenu.aspx?MenuID=" + Session["MenuID"].ToString();
                Response.Redirect(queryString);
            }
        }

    }
}