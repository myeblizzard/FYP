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

namespace QR_Menu_Designer
{
    public partial class ViewMenu : System.Web.UI.Page
    {
        private static int menuType;
        private static string templateID;
        private static string menuID;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Username"] = "test1";

            if (String.IsNullOrEmpty(Session["Username"] as string))
            {
                Response.Redirect("Login.aspx");
            }
            SqlConnection conDisplayMenuPreview = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 3;
                divQRCode.Visible = false;
                loadMenuPreview();
                //string sqlDisplayQR = "SELECT QRCodeURL FROM Menu WHERE MenuID = 4000";
                //SqlCommand cmdDisplayQR = new SqlCommand(sqlDisplayQR, conDisplayMenuPreview);
                //conDisplayMenuPreview.Open();
                //string displayQR = cmdDisplayQR.ExecuteScalar().ToString();
                //conDisplayMenuPreview.Close();
                //System.Web.UI.WebControls.Image imgQRCode = new System.Web.UI.WebControls.Image();

                //QRCodeGenerator qrGenerator = new QRCodeGenerator();
                //QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(displayQR, QRCodeGenerator.ECCLevel.Q);
                //System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
                //imgBarCode.Height = 150;
                //imgBarCode.Width = 150;
                //using (Bitmap bitMap = qrCode.GetGraphic(20))
                //{
                //    using (MemoryStream ms = new MemoryStream())
                //    {
                //        bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                //        byte[] byteImage = ms.ToArray();
                //        imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                //        imgQR.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                //    }
                //}
            }
        }

        protected void RedirectToMenu(object sender, EventArgs e)
        {
            string queryString = "DisplayMenu.aspx?MenuID=4000";
            Response.Redirect(queryString);
        }

        void loadMenuPreview()
        {
            SqlConnection conDisplayMenuPreview = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            string sqlCheckDraft = "SELECT COUNT(MenuID) FROM Menu WHERE QRCodeURL IS NULL AND Username = @Username";
            SqlCommand cmdCheckDraft = new SqlCommand(sqlCheckDraft, conDisplayMenuPreview);
            cmdCheckDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            conDisplayMenuPreview.Open();
            int countDraft = Convert.ToInt32(cmdCheckDraft.ExecuteScalar());
            conDisplayMenuPreview.Close();
            if (countDraft > 0) // check if user has draft
            {
                divDraft.Visible = true;
            }
            else
            {
                divDraft.Visible = false;
            }
            string sqlDisplayMenuSelection = "SELECT DISTINCT WorkplaceName, MenuID FROM MenuDetails WHERE MenuID IS NOT NULL AND Username = @Username";
            SqlCommand cmdDisplayMenuSelection = new SqlCommand(sqlDisplayMenuSelection, conDisplayMenuPreview);
            cmdDisplayMenuSelection.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            conDisplayMenuPreview.Open();
            using (SqlDataReader readDisplayMenuSelection = cmdDisplayMenuSelection.ExecuteReader())
            {
                rptMenu.DataSource = readDisplayMenuSelection;
                rptMenu.DataBind();
            }
            conDisplayMenuPreview.Close();
        }

        protected void DeleteMenu(object sender, EventArgs e)
        {
            SqlConnection conDeleteMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            if (String.IsNullOrEmpty(menuID))
            {
                string sqlDeleteMenu = "DELETE FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username";
                SqlCommand cmdDeleteMenu = new SqlCommand(sqlDeleteMenu, conDeleteMenu);
                cmdDeleteMenu.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conDeleteMenu.Open();
                cmdDeleteMenu.ExecuteNonQuery();
                conDeleteMenu.Close();
            }
            else
            {
                string sqlDeleteMenu = "DELETE FROM MenuDetails WHERE MenuID = @MenuID";
                SqlCommand cmdDeleteMenu = new SqlCommand(sqlDeleteMenu, conDeleteMenu);
                cmdDeleteMenu.Parameters.AddWithValue("@MenuID", menuID);
                conDeleteMenu.Open();
                cmdDeleteMenu.ExecuteNonQuery();
                conDeleteMenu.Close();
            }
            loadMenuPreview();
            MultiView1.ActiveViewIndex = 3;
        }
        
        protected void MenuAction(object sender, EventArgs e)
        {
            if(btnAction.Text == "Complete It")
            {
                Response.Redirect("InputDetails.aspx");
            }
            else if (btnAction.Text == "View Menu")
            {
                if (!String.IsNullOrEmpty(menuID))
                {
                    string queryString = "DisplayMenu.aspx?MenuID=" + menuID;
                    Response.Redirect(queryString);
                }
                else
                {
                    //menuID null
                }
            }
            else
            {
                //err
            }
        }

        protected void SelectMenu(object sender, EventArgs e)
        {
            Button btnMenu = (Button)sender;
            menuID = btnMenu.CommandArgument.ToString();
            divQRCode.Visible = true;

            SqlConnection conSelectMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            if(btnMenu.CommandName == "Draft")
            {
                //draft actions
                btnAction.Text = "Complete It";
                MultiView1.ActiveViewIndex = 4;
                menuID = "";
                lblQR.Text = "";
                divLblQR.Visible = false;
                btnPrintQR.Visible = false;
                modalTitle.InnerText = "Incomplete Menu";
                imgQR.ImageUrl = "uploaded/empty.jpg";
            }
            else if (!String.IsNullOrEmpty(menuID))
            {
                btnAction.Text = "View Menu";
                divLblQR.Visible = true;
                btnPrintQR.Visible = true;
                //display qr code 
                string sqlDisplayQR = "SELECT QRCodeURL FROM Menu WHERE MenuID = @MenuID";
                SqlCommand cmdDisplayQR = new SqlCommand(sqlDisplayQR, conSelectMenu);
                cmdDisplayQR.Parameters.AddWithValue("@MenuID", menuID);
                conSelectMenu.Open();
                string displayQR = cmdDisplayQR.ExecuteScalar().ToString();
                conSelectMenu.Close();
                System.Web.UI.WebControls.Image imgQRCode = new System.Web.UI.WebControls.Image();

                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(displayQR, QRCodeGenerator.ECCLevel.Q);
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
                        imgQR.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                    }
                }

                string sqlDisplayQRLbl = "SELECT DISTINCT WorkplaceName FROM MenuDetails WHERE MenuID = @MenuID";
                SqlCommand cmdDisplayQRLbl = new SqlCommand(sqlDisplayQRLbl, conSelectMenu);
                cmdDisplayQRLbl.Parameters.AddWithValue("@MenuID", menuID);
                conSelectMenu.Open();
                lblQR.Text = cmdDisplayQRLbl.ExecuteScalar().ToString();
                conSelectMenu.Close();


                //proceed with the selected menuid

                //load the existing menu
                string sqlLoadTemplate = "SELECT * FROM Template, Menu WHERE Template.TemplateID = Menu.TemplateID AND Menu.MenuID = @MenuID";

                SqlCommand cmdLoadTemplate = new SqlCommand(sqlLoadTemplate, conSelectMenu);
                cmdLoadTemplate.Parameters.AddWithValue("@MenuID", menuID);
                conSelectMenu.Open();
                SqlDataReader readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                while (readLoadTemplate.Read())
                {
                    menuType = Convert.ToInt32(readLoadTemplate["TemplateType"]);
                    templateID = readLoadTemplate["TemplateID"].ToString();
                    linkCSS.Attributes["href"] = readLoadTemplate["CssFile"].ToString();
                }
                conSelectMenu.Close();

                string sqlDisplayMenu = "SELECT WorkplaceName, ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID GROUP BY WorkplaceName, ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayMenu = new SqlCommand(sqlDisplayMenu, conSelectMenu);
                cmdDisplayMenu.Parameters.AddWithValue("@MenuID", menuID);
                conSelectMenu.Open();
                SqlDataReader readDisplayMenu = cmdDisplayMenu.ExecuteReader();
                switch (menuType)
                {
                    case 1:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conSelectMenu.Close();

                        MultiView1.ActiveViewIndex = 0;

                        conSelectMenu.Open();
                        readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                        while (readLoadTemplate.Read())
                        {
                            divMenu.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                            lblTitle.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                            lblTitle.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                            lblTitle.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                        }
                        conSelectMenu.Close();

                        conSelectMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory.DataSource = readDisplayMenu;
                            rptCategory.DataBind();
                        }
                        conSelectMenu.Close();
                        break;

                    case 2:
                        while (readDisplayMenu.Read())
                        {
                            lblTitle2.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conSelectMenu.Close();
                        MultiView1.ActiveViewIndex = 1;

                        conSelectMenu.Open();
                        readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                        while (readLoadTemplate.Read())
                        {
                            divMenu2.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                            lblTitle2.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                            lblTitle2.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                            lblTitle2.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                        }
                        conSelectMenu.Close();

                        conSelectMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory2.DataSource = readDisplayMenu;
                            rptCategory2.DataBind();
                        }
                        conSelectMenu.Close();

                        string sqlDisplayImg = "SELECT ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayImg = new SqlCommand(sqlDisplayImg, conSelectMenu);
                        cmdDisplayImg.Parameters.AddWithValue("@MenuID", menuID);

                        conSelectMenu.Open();
                        using (SqlDataReader readDisplayImg = cmdDisplayImg.ExecuteReader())
                        {
                            rptImg.DataSource = readDisplayImg;
                            rptImg.DataBind();
                        }
                        conSelectMenu.Close();
                        break;

                    case 3:
                        divView3.Style["margin-top"] = "23vh";
                        while (readDisplayMenu.Read())
                        {
                            lblTitle3.Text = readDisplayMenu["WorkplaceName"].ToString();
                        }
                        conSelectMenu.Close();
                        MultiView1.ActiveViewIndex = 2;

                        conSelectMenu.Open();
                        readLoadTemplate = cmdLoadTemplate.ExecuteReader();
                        while (readLoadTemplate.Read())
                        {
                            divMenu3.Style["background-image"] = readLoadTemplate["BackgroundImage"].ToString();
                            lblTitle3.Style["font-family"] = readLoadTemplate["TitleFontStyle"].ToString();
                            lblTitle3.Style["font-size"] = readLoadTemplate["TitleFontSize"].ToString();
                            lblTitle3.Style["color"] = readLoadTemplate["TitleFontColour"].ToString();
                        }
                        conSelectMenu.Close();

                        conSelectMenu.Open();
                        using (readDisplayMenu = cmdDisplayMenu.ExecuteReader())
                        {
                            rptCategory3.DataSource = readDisplayMenu;
                            rptCategory3.DataBind();
                        }
                        conSelectMenu.Close();
                        break;

                    default:
                        //unknown menu type
                        break;
                }
            }
            else
            {
                //err
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
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

                if (!String.IsNullOrEmpty(menuID)) //
                {
                    if (menuType == 1)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", menuID);
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

                if (!String.IsNullOrEmpty(menuID))
                {
                    if (menuType == 2)
                    {
                        string sqlDisplayItem = "SELECT ItemName, Price FROM MenuDetails WHERE ItemName IS NOT NULL AND ItemCategory = @CurrCategory AND MenuID = @MenuID GROUP BY ItemName, Price ORDER BY min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", menuID);
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

                if (!String.IsNullOrEmpty(menuID))
                {
                    if (menuType == 3)
                    {
                        var rptItemWithoutImg = (Repeater)e.Item.FindControl("rptItemWithoutImg");

                        string sqlDisplayItem = "SELECT ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemCategory = @CurrCategory AND ItemImage IS NOT NULL AND MenuID = @MenuID GROUP BY ItemImage, ItemName, Price ORDER BY ItemImage, min(ItemID) ASC";
                        SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conDisplayItem);
                        cmdDisplayItem.Parameters.AddWithValue("@CurrCategory", hdfCategory.Value.ToString());
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", menuID);
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
                        cmdDisplayItem.Parameters.AddWithValue("@MenuID", menuID);
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

        protected void EditMenu(object sender, EventArgs e)
        {
            Session["MenuID"] = menuID;
            Response.Redirect("InputDetails.aspx");
        }
    }
}