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
using System.Web.UI.HtmlControls;

namespace QR_Menu_Designer
{
    public partial class InputDetails : System.Web.UI.Page
    {
        class Variable
        {
            public static string strWorkplace;
            public static string currCategory;
            public static string currItem;
            public static string imgPath;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Username"] = "sweeloongp@gmail.com";
            Session["Username"] = "passionart2929@gmail.com";
            //Session["MenuID"] = "4005";

            if (String.IsNullOrEmpty(Session["Username"] as string))
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                btnUpdateWorkplace.Style["display"] = "none";
                Variable.strWorkplace = "";
                Variable.currCategory = "";
                Variable.currItem = "";
                Variable.imgPath = "";

                SqlConnection conWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

                if (String.IsNullOrEmpty(Session["MenuID"] as string)) //new menu or continue unfinished menu (assuming only 1 unfinished menu is allowed and new menu cant be created when there's an unfinished menu)
                {
                    string sqlDisplayDraft = "SELECT DISTINCT WorkplaceName FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdDisplayDraft = new SqlCommand(sqlDisplayDraft, conWorkplace);
                    cmdDisplayDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conWorkplace.Open();
                    SqlDataReader readIsDraft = cmdDisplayDraft.ExecuteReader();
                    if (readIsDraft.HasRows) //if workplacename exist means its an existing draft, else its a new draft
                    {
                        conWorkplace.Close();
                        btnWorkplaceNext.Style["display"] = "initial"; 
                        btnAddWorkplace.Style["display"] = "none";
                        lblWorkplace.Style["display"] = "initial";
                        btnEditWorkplace.Style["display"] = "initial";
                        inputWorkplace.Style["display"] = "none";
                        lblWorkplaceHeader.Style["display"] = "none";

                        LoadWorkplace();
                        LoadCategory();
                        LoadItem();
                    }
                    else //new draft
                    {
                        conWorkplace.Close();
                        Console.Write("loaded");
                        btnWorkplaceNext.Style["display"] = "none";
                        btnAddWorkplace.Style["display"] = "initial";
                        lblWorkplace.Style["display"] = "none";
                        btnEditWorkplace.Style["display"] = "none";
                        inputWorkplace.Style["display"] = "initial";
                        lblWorkplaceHeader.Style["display"] = "initial";
                    }
                }
                else //existing menu
                {
                    btnWorkplaceNext.Style["display"] = "initial";
                    btnAddWorkplace.Style["display"] = "none";
                    lblWorkplace.Style["display"] = "initial";
                    btnEditWorkplace.Style["display"] = "initial";
                    inputWorkplace.Style["display"] = "none";
                    lblWorkplaceHeader.Style["display"] = "none";

                    LoadWorkplace();
                    LoadCategory();
                    LoadItem();
                }
            }
        }
        public string sPath;    //path to the product's picture

        public string PicturePath(string sFilename)
        {
            if (String.IsNullOrEmpty(sFilename))
            {
                sFilename = @"uploaded/empty.jpg";
            }
            return sFilename;
        }

        protected void AsyncFileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            string strPath = MapPath("uploaded/") + Path.GetFileName(e.filename);
            Variable.imgPath = "uploaded/" + Path.GetFileName(e.filename);
        }
        
        void LoadWorkplace()
        {
            inputWorkplace.Value = string.Empty;
            SqlConnection conWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            
            if (String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlDisplayDraft = "SELECT DISTINCT WorkplaceName FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username";
                SqlCommand cmdDisplayDraft = new SqlCommand(sqlDisplayDraft, conWorkplace);
                cmdDisplayDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                
                conWorkplace.Open();
                SqlDataReader readIsDraft = cmdDisplayDraft.ExecuteReader();
                while (readIsDraft.Read())
                {
                    Variable.strWorkplace = readIsDraft["WorkplaceName"].ToString();
                    lblWorkplace.Text = readIsDraft["WorkplaceName"].ToString();
                }
                conWorkplace.Close();
            }
            else
            {
                string sqlCompleteDraft = "SELECT DISTINCT WorkplaceName FROM MenuDetails WHERE MenuID = @MenuID AND Username = @Username";
                SqlCommand cmdCompleteDraft = new SqlCommand(sqlCompleteDraft, conWorkplace);
                cmdCompleteDraft.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdCompleteDraft.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                conWorkplace.Open();
                SqlDataReader readComplete = cmdCompleteDraft.ExecuteReader();
                while (readComplete.Read())
                {
                    Variable.strWorkplace = readComplete["WorkplaceName"].ToString();
                    lblWorkplace.Text = readComplete["WorkplaceName"].ToString();
                }
                conWorkplace.Close();
            }
        }

        void LoadCategory()
        {
            SqlConnection conWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlCompleteCategory = "SELECT ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID IS NULL AND Username = @Username GROUP BY ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdCompleteCategory = new SqlCommand(sqlCompleteCategory, conWorkplace);
                cmdCompleteCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                conWorkplace.Open();
                SqlDataAdapter daCompleteCategory = new SqlDataAdapter();
                daCompleteCategory.SelectCommand = cmdCompleteCategory;
                DataTable dtCompleteCategory = new DataTable();
                daCompleteCategory.Fill(dtCompleteCategory);
                SqlDataReader readCompleteCategory = cmdCompleteCategory.ExecuteReader();

                ddlCategory.DataSource = dtCompleteCategory;
                ddlCategory.DataBind();
                ddlCategory.DataTextField = "ItemCategory";
                ddlCategory.DataValueField = "ItemCategory";
                ddlCategory.DataBind();

                RptCategories.DataSource = readCompleteCategory;
                RptCategories.DataBind();
                conWorkplace.Close();
            }
            else
            {
                string sqlCompleteCategory = "SELECT ItemCategory, min(ItemID) as MinID FROM MenuDetails WHERE MenuID = @MenuID AND Username = @Username GROUP BY ItemCategory ORDER BY min(ItemID) ASC";
                SqlCommand cmdCompleteCategory = new SqlCommand(sqlCompleteCategory, conWorkplace);
                cmdCompleteCategory.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdCompleteCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                conWorkplace.Open();
                SqlDataAdapter daCompleteCategory = new SqlDataAdapter();
                daCompleteCategory.SelectCommand = cmdCompleteCategory;
                DataTable dtCompleteCategory = new DataTable();
                daCompleteCategory.Fill(dtCompleteCategory);
                SqlDataReader readCompleteCategory = cmdCompleteCategory.ExecuteReader();

                ddlCategory.DataSource = dtCompleteCategory;
                ddlCategory.DataBind();
                ddlCategory.DataTextField = "ItemCategory";
                ddlCategory.DataValueField = "ItemCategory";
                ddlCategory.DataBind();

                RptCategories.DataSource = readCompleteCategory;
                RptCategories.DataBind();
                conWorkplace.Close();
            }
        }

        void LoadItem()
        {
            SqlConnection conWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if(String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                conWorkplace.Open();
                string sqlDisplayItem = "SELECT ItemCategory, ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemName IS NOT NULL AND MenuID IS NULL AND Username = @Username GROUP BY ItemName, ItemCategory, ItemImage, Price ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conWorkplace);
                cmdDisplayItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                SqlDataReader readItem = cmdDisplayItem.ExecuteReader();
                
                RptItems.DataSource = readItem;
                RptItems.DataBind();
                conWorkplace.Close();
            }
            else
            {
                conWorkplace.Open();
                string sqlDisplayItem = "SELECT ItemCategory, ItemName, Price, ItemImage, min(ItemID) as MinID FROM MenuDetails WHERE ItemName IS NOT NULL AND MenuID = @MenuID AND Username = @Username GROUP BY ItemName, ItemCategory, ItemImage, Price ORDER BY min(ItemID) ASC";
                SqlCommand cmdDisplayItem = new SqlCommand(sqlDisplayItem, conWorkplace);
                cmdDisplayItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdDisplayItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                SqlDataReader readItem = cmdDisplayItem.ExecuteReader();
                
                RptItems.DataSource = readItem;
                RptItems.DataBind();
                conWorkplace.Close();
            }
        }
        
        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("MainMenu.aspx");
        }

        protected void EditWorkplace(object sender, EventArgs e)
        {
            btnWorkplaceNext.Style["display"] = "none";
            btnAddWorkplace.Style["display"] = "none";
            btnUpdateWorkplace.Style["display"] = "initial";
            lblWorkplace.Style["display"] = "none";
            btnEditWorkplace.Style["display"] = "none";
            inputWorkplace.Style["display"] = "initial";
            lblWorkplaceHeader.Style["display"] = "initial";
            inputWorkplace.Value = lblWorkplace.Text;
        }

        protected void AddWorkplace(object sender, EventArgs e)
        {
            SqlConnection conAddWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
             
            if(!String.IsNullOrEmpty(inputWorkplace.Value))
            {
                if(String.IsNullOrEmpty(Session["MenuID"] as string))
                {
                    string sqlAddWorkplace = "INSERT INTO MenuDetails (WorkplaceName, Username) VALUES (@Workplace, @Username)";
                    SqlCommand cmdAddWorkplace = new SqlCommand(sqlAddWorkplace, conAddWorkplace);
                    cmdAddWorkplace.Parameters.AddWithValue("@Workplace", inputWorkplace.Value);
                    cmdAddWorkplace.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conAddWorkplace.Open();
                    cmdAddWorkplace.ExecuteNonQuery();
                    conAddWorkplace.Close();
                }
                else
                {
                    string sqlAddWorkplace = "INSERT INTO MenuDetails (WorkplaceName, MenuID, Username) VALUES (@Workplace, @MenuID, @Username)";
                    SqlCommand cmdAddWorkplace = new SqlCommand(sqlAddWorkplace, conAddWorkplace);
                    cmdAddWorkplace.Parameters.AddWithValue("@Workplace", inputWorkplace.Value);
                    cmdAddWorkplace.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    cmdAddWorkplace.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conAddWorkplace.Open();
                    cmdAddWorkplace.ExecuteNonQuery();
                    conAddWorkplace.Close();
                }
                Variable.strWorkplace = inputWorkplace.Value;

                btnWorkplaceNext.Style["display"] = "initial";
                btnAddWorkplace.Style["display"] = "none";
                lblWorkplace.Style["display"] = "initial";
                btnEditWorkplace.Style["display"] = "initial";
                inputWorkplace.Style["display"] = "none";
                lblWorkplaceHeader.Style["display"] = "none";

                LoadWorkplace();
            }
            else
            {
               //errMsg No value entered
            }
        }

        protected void UpdateWorkplace(object sender, EventArgs e)
        {
            SqlConnection conUpdateWorkplace = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (!String.IsNullOrEmpty(inputWorkplace.Value))
            {
                if (String.IsNullOrEmpty(Session["MenuID"] as string))
                {
                    string sqlUpdateWorkplace = "UPDATE MenuDetails SET WorkplaceName = @NewWorkplace WHERE MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdUpdateWorkplace = new SqlCommand(sqlUpdateWorkplace, conUpdateWorkplace);
                    cmdUpdateWorkplace.Parameters.AddWithValue("@NewWorkplace", inputWorkplace.Value);
                    cmdUpdateWorkplace.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conUpdateWorkplace.Open();
                    cmdUpdateWorkplace.ExecuteNonQuery();
                    conUpdateWorkplace.Close();
                }
                else
                {
                    string sqlUpdateWorkplace = "UPDATE MenuDetails SET WorkplaceName = @NewWorkplace WHERE MenuID = @MenuID AND Username = @Username";
                    SqlCommand cmdUpdateWorkplace = new SqlCommand(sqlUpdateWorkplace, conUpdateWorkplace);
                    cmdUpdateWorkplace.Parameters.AddWithValue("@NewWorkplace", inputWorkplace.Value);
                    cmdUpdateWorkplace.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    cmdUpdateWorkplace.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    conUpdateWorkplace.Open();
                    cmdUpdateWorkplace.ExecuteNonQuery();
                    conUpdateWorkplace.Close();
                }
                Variable.strWorkplace = inputWorkplace.Value;
                
                btnUpdateWorkplace.Style["display"] = "none";
                btnWorkplaceNext.Style["display"] = "initial";
                btnAddWorkplace.Style["display"] = "none";
                lblWorkplace.Style["display"] = "initial";
                btnEditWorkplace.Style["display"] = "initial";
                inputWorkplace.Style["display"] = "none";
                lblWorkplaceHeader.Style["display"] = "none";

                LoadWorkplace();
            }
            else
            {
                //errMsg Value is Empty
            }
        }

        protected void RpCategory(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void RemoveCategory(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            Variable.currCategory = btn.CommandArgument.ToString();

            SqlConnection conRemoveCategory = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlRemoveCategory = "DELETE FROM MenuDetails WHERE ItemCategory = @Category AND MenuID IS NULL AND Username = @Username";
                SqlCommand cmdRemoveCategory = new SqlCommand(sqlRemoveCategory, conRemoveCategory);
                cmdRemoveCategory.Parameters.AddWithValue("@Category", Variable.currCategory);
                cmdRemoveCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conRemoveCategory.Open();
                cmdRemoveCategory.ExecuteNonQuery();
                conRemoveCategory.Close();
            }
            else
            {
                string sqlRemoveCategory = "DELETE FROM MenuDetails WHERE ItemCategory = @Category AND MenuID = @MenuID AND Username = @Username";
                SqlCommand cmdRemoveCategory = new SqlCommand(sqlRemoveCategory, conRemoveCategory);
                cmdRemoveCategory.Parameters.AddWithValue("@Category", Variable.currCategory);
                cmdRemoveCategory.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdRemoveCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conRemoveCategory.Open();
                cmdRemoveCategory.ExecuteNonQuery();
                conRemoveCategory.Close();
            }
            LoadCategory();
            LoadItem();
        }

        protected void AddCategory(object sender, EventArgs e)
        {
            SqlConnection conAddCategory = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (!String.IsNullOrEmpty(inputCategory.Value))
            {
                if (String.IsNullOrEmpty(Session["MenuID"] as string)) //Check if this is a draft or an existing menu
                {
                    //Check if this category alrd existed in this menu
                    string sqlCategoryIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemCategory = @Category COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdCategoryIsExist = new SqlCommand(sqlCategoryIsExist, conAddCategory);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Category", inputCategory.Value);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conAddCategory.Open();
                    int count = Convert.ToInt32(cmdCategoryIsExist.ExecuteScalar());
                    conAddCategory.Close();

                    if (count == 0)
                    {//Check if there's a workplace with null category
                        string sqlWorkplaceCategoryIsNull = "SELECT WorkplaceName FROM MenuDetails WHERE ItemCategory IS NULL AND MenuID IS NULL AND Username = @Username"; 
                        SqlCommand cmdWorkplaceCategoryIsNull = new SqlCommand(sqlWorkplaceCategoryIsNull, conAddCategory);
                        cmdWorkplaceCategoryIsNull.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conAddCategory.Open();
                        SqlDataReader readWorkplaceCategoryIsNull = cmdWorkplaceCategoryIsNull.ExecuteReader();
                        if (readWorkplaceCategoryIsNull.HasRows)
                        {
                            conAddCategory.Close();

                            //fill up the workplace with null category
                            string sqlCurrentAddCategory = "UPDATE MenuDetails SET ItemCategory = @Category WHERE ItemCategory IS NULL AND MenuID IS NULL AND Username = @Username"; 
                            SqlCommand cmdCurrentAddCategory = new SqlCommand(sqlCurrentAddCategory, conAddCategory);
                            cmdCurrentAddCategory.Parameters.AddWithValue("@Category", inputCategory.Value);
                            cmdCurrentAddCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    
                            conAddCategory.Open();
                            cmdCurrentAddCategory.ExecuteNonQuery();
                            conAddCategory.Close();
                        }
                        else
                        {
                            //create new row
                            conAddCategory.Close();

                            string sqlNewAddCategory = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, Username) VALUES (@Workplace, @Category, @Username)"; //create new category
                            SqlCommand cmdNewAddCategory = new SqlCommand(sqlNewAddCategory, conAddCategory);
                            cmdNewAddCategory.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                            cmdNewAddCategory.Parameters.AddWithValue("@Category", inputCategory.Value);
                            cmdNewAddCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    
                            conAddCategory.Open();
                            cmdNewAddCategory.ExecuteNonQuery();
                            conAddCategory.Close();
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clear", "ClearTxtBox()", true);
                        LoadCategory();
                        LoadItem();
                    }
                    else
                    {
                        //errmsg alrd existed
                    }
                }
                else
                {
                    //Check if this category alrd existed in this menu
                    string sqlCategoryIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemCategory = @Category COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuiD = @MenuID AND Username = @Username";
                    SqlCommand cmdCategoryIsExist = new SqlCommand(sqlCategoryIsExist, conAddCategory);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Category", inputCategory.Value);
                    cmdCategoryIsExist.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    cmdCategoryIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conAddCategory.Open();
                    int count = Convert.ToInt32(cmdCategoryIsExist.ExecuteScalar());
                    conAddCategory.Close();

                    if (count == 0)
                    {
                        //Check if there's a workplace without category
                        string sqlWorkplaceCategoryIsNull = "SELECT WorkplaceName FROM MenuDetails WHERE ItemCategory IS NULL AND MenuiD = @MenuID AND Username = @Username";
                        SqlCommand cmdWorkplaceCategoryIsNull = new SqlCommand(sqlWorkplaceCategoryIsNull, conAddCategory);
                        cmdWorkplaceCategoryIsNull.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        cmdWorkplaceCategoryIsNull.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conAddCategory.Open();
                        SqlDataReader readWorkplaceCategoryIsNull = cmdWorkplaceCategoryIsNull.ExecuteReader();
                        if (readWorkplaceCategoryIsNull.HasRows)
                        {
                            conAddCategory.Close();

                            //fill up the workplace without category
                            string sqlCurrentAddCategory = "UPDATE MenuDetails SET ItemCategory = @Category WHERE ItemCategory IS NULL AND MenuiD = @MenuID AND Username = @Username";
                            SqlCommand cmdCurrentAddCategory = new SqlCommand(sqlCurrentAddCategory, conAddCategory);
                            cmdCurrentAddCategory.Parameters.AddWithValue("@Category", inputCategory.Value);
                            cmdCurrentAddCategory.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                            cmdCurrentAddCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                            conAddCategory.Open();
                            cmdCurrentAddCategory.ExecuteNonQuery();
                            conAddCategory.Close();
                        }
                        else
                        {
                            conAddCategory.Close();

                            string sqlNewAddCategory = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, MenuID, Username) VALUES (@WorkplaceName, @Category, @MenuID, @Username)"; //create new category
                            SqlCommand cmdNewAddCategory = new SqlCommand(sqlNewAddCategory, conAddCategory);
                            cmdNewAddCategory.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                            cmdNewAddCategory.Parameters.AddWithValue("@Category", inputCategory.Value);
                            cmdNewAddCategory.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                            cmdNewAddCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                            conAddCategory.Open();
                            cmdNewAddCategory.ExecuteNonQuery();
                            conAddCategory.Close();
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clear", "ClearTxtBox()", true);
                        LoadCategory();
                        LoadItem();
                    }
                    else
                    {
                        //errmsg alrd existed
                    }
                }
            }
            else
            {
                //errmsg value is empty
            }
        }

        protected void UpdateCategory(object sender, EventArgs e)
        {
            Variable.currCategory = oldCategory.Value;
            SqlConnection conUpdateCategory = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (!String.IsNullOrEmpty(inputCategory.Value)) {
                if (String.IsNullOrEmpty(Session["MenuID"] as string))
                {
                    //Check if this category alrd existed in this menu
                    string sqlCategoryIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemCategory = @Category COLLATE SQL_Latin1_General_CP1_CI_AS AND ItemCategory != @CurrCategory COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdCategoryIsExist = new SqlCommand(sqlCategoryIsExist, conUpdateCategory);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Category", inputCategory.Value);
                    cmdCategoryIsExist.Parameters.AddWithValue("@CurrCategory", Variable.currCategory);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conUpdateCategory.Open();
                    int count = Convert.ToInt32(cmdCategoryIsExist.ExecuteScalar());
                    conUpdateCategory.Close();

                    if (count == 0)
                    {
                        string sqlUpdateCategory = "UPDATE MenuDetails SET ItemCategory = @NewCategory WHERE ItemCategory = @CurrCategory AND MenuID IS NULL AND Username = @Username";
                        SqlCommand cmdUpdateCategory = new SqlCommand(sqlUpdateCategory, conUpdateCategory);
                        cmdUpdateCategory.Parameters.AddWithValue("@NewCategory", inputCategory.Value);
                        cmdUpdateCategory.Parameters.AddWithValue("@CurrCategory", Variable.currCategory); // Take value from edit button
                        cmdUpdateCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                
                        conUpdateCategory.Open();
                        cmdUpdateCategory.ExecuteNonQuery();
                        conUpdateCategory.Close();

                        //btnCategoryNext.Style["display"] = "initial";
                        //btnAddCategory.Style["display"] = "initial";
                        //btnUpdateCategory.Style["display"] = "none";

                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "category", "UpdateCategory()", true);
                        inputCategory.Value = "";
                        LoadCategory();
                        LoadItem();
                    }
                    else
                    {
                        //errmsg alrd existed
                    }
                }
                else
                {
                    //Check if this category alrd existed in this menu
                    string sqlCategoryIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemCategory = @Category COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuID = @MenuID AND Username = @Username";
                    SqlCommand cmdCategoryIsExist = new SqlCommand(sqlCategoryIsExist, conUpdateCategory);
                    cmdCategoryIsExist.Parameters.AddWithValue("@Category", inputCategory.Value);
                    cmdCategoryIsExist.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    cmdCategoryIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conUpdateCategory.Open();
                    int count = Convert.ToInt32(cmdCategoryIsExist.ExecuteScalar());
                    conUpdateCategory.Close();

                    if (count == 0)
                    {
                        string sqlUpdateCategory = "UPDATE MenuDetails SET ItemCategory = @NewCategory WHERE ItemCategory = @CurrCategory AND MenuID = @MenuID AND Username = @Username";
                        SqlCommand cmdUpdateCategory = new SqlCommand(sqlUpdateCategory, conUpdateCategory);
                        cmdUpdateCategory.Parameters.AddWithValue("@NewCategory", inputCategory.Value);
                        cmdUpdateCategory.Parameters.AddWithValue("@CurrCategory", Variable.currCategory); // take value from edit button
                        cmdUpdateCategory.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        cmdUpdateCategory.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conUpdateCategory.Open();
                        cmdUpdateCategory.ExecuteNonQuery();
                        conUpdateCategory.Close();
                        
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "category", "UpdateCategory()", true);
                        inputCategory.Value = "";
                        LoadCategory();
                        LoadItem();
                    }
                    else
                    {
                        //errmsg alrd existed or do nothing
                    }
                }
            }
            else
            {
                //errmsg inputCategory value is empty
            }
        }

        protected void RpItem(object source, RepeaterCommandEventArgs e)
        {
        }

        protected void RemoveItem(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            Variable.currItem = btn.CommandArgument.ToString();

            SqlConnection conRemoveItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if(String.IsNullOrEmpty(Session["MenuID"] as string))
            {
                string sqlRemoveItem = "DELETE FROM MenuDetails WHERE ItemName = @ItemName AND MenuID IS NULL AND Username = @Username";
                SqlCommand cmdRemoveItem = new SqlCommand(sqlRemoveItem, conRemoveItem);
                cmdRemoveItem.Parameters.AddWithValue("@ItemName", Variable.currItem);
                cmdRemoveItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conRemoveItem.Open();
                cmdRemoveItem.ExecuteNonQuery();
                conRemoveItem.Close();
            }
            else
            {
                string sqlRemoveItem = "DELETE FROM MenuDetails WHERE ItemName = @ItemName AND MenuID = @MenuID AND Username = @Username";
                SqlCommand cmdRemoveItem = new SqlCommand(sqlRemoveItem, conRemoveItem);
                cmdRemoveItem.Parameters.AddWithValue("@ItemName", Variable.currItem);
                cmdRemoveItem.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                cmdRemoveItem.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                conRemoveItem.Open();
                cmdRemoveItem.ExecuteNonQuery();
                conRemoveItem.Close();
            }
            LoadItem();
        }

        protected void AddItem(object sender, EventArgs e)
        {
            var selectedCategory = ddlCategory.SelectedItem.Text;

            SqlConnection conAddItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (!String.IsNullOrEmpty(inputItemName.Value))
            {
                if (String.IsNullOrEmpty(Session["MenuID"] as string))
                {
                    //Check if this item alrd existed in the menu
                    string sqlItemIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemName = @ItemName COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuID IS NULL AND Username = @Username";
                    SqlCommand cmdItemIsExist = new SqlCommand(sqlItemIsExist, conAddItem);
                    cmdItemIsExist.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                    cmdItemIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conAddItem.Open();
                    int count = Convert.ToInt32(cmdItemIsExist.ExecuteScalar());
                    conAddItem.Close();

                    if (count == 0)
                    {   //Check if there's a category without an item
                        string sqlCategoryItemIsNull = "SELECT ItemCategory FROM MenuDetails WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID IS NULL AND Username = @Username";
                        SqlCommand cmdCategoryItemIsNull = new SqlCommand(sqlCategoryItemIsNull, conAddItem);
                        cmdCategoryItemIsNull.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                        cmdCategoryItemIsNull.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conAddItem.Open();
                        SqlDataReader readCategoryItemIsNull = cmdCategoryItemIsNull.ExecuteReader();
                        if (readCategoryItemIsNull.HasRows) //Existing itemId where itemname is null
                        {
                            conAddItem.Close();
                            if (!String.IsNullOrEmpty(Variable.imgPath)) //with image
                            {
                                string sqlAddItemToCurrWithImage = "UPDATE MenuDetails SET ItemName = @ItemName, Price = @Price, ItemImage = @ItemtImage WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID IS NULL AND Username = @Username";
                                using (SqlCommand cmdAddItemToCurrWithImage = new SqlCommand(sqlAddItemToCurrWithImage, conAddItem))
                                {
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                    conAddItem.Open();
                                    cmdAddItemToCurrWithImage.ExecuteNonQuery();
                                    conAddItem.Close();
                                    Variable.imgPath = "";
                                }
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);
                            }
                            else //without image
                            {
                                string sqlAddItemToCurrWithoutImage = "UPDATE MenuDetails SET ItemName = @ItemName, Price = @Price WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID IS NULL AND Username = @Username";
                                SqlCommand cmdAddItemToCurrWithoutImage = new SqlCommand(sqlAddItemToCurrWithoutImage, conAddItem);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                conAddItem.Open();
                                cmdAddItemToCurrWithoutImage.ExecuteNonQuery();
                                conAddItem.Close();
                            }
                        }
                        else //New ItemID
                        {
                            conAddItem.Close();
                            if (!String.IsNullOrEmpty(Variable.imgPath)) //with image
                            {
                                string sqlAddItemToNewWithImage = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, ItemName, Price, ItemImage, Username) VALUES (@Workplace, @Category, @ItemName, @Price, @ItemImage, @Username)";
                                using (SqlCommand cmdAddItemToNewWithImage = new SqlCommand(sqlAddItemToNewWithImage, conAddItem))
                                {
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                    conAddItem.Open();
                                    cmdAddItemToNewWithImage.ExecuteNonQuery();
                                    conAddItem.Close();
                                    Variable.imgPath = "";
                                }
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);
                            }
                            else // without image
                            {
                                string sqlAddItemToNewWithoutImage = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, ItemName, Price, Username) VALUES (@Workplace, @Category, @ItemName, @Price, @Username)";
                                SqlCommand cmdAddItemToNewWithoutImage = new SqlCommand(sqlAddItemToNewWithoutImage, conAddItem);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                conAddItem.Open();
                                cmdAddItemToNewWithoutImage.ExecuteNonQuery();
                                conAddItem.Close();
                            }
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clear", "ClearTxtBox()", true);
                        LoadItem();
                    }
                    else
                    {
                        //errmsg item alrd existed
                    }
                }
                else
                {
                    //Check if this item alrd existed in the menu
                    string sqlItemIsExist = "SELECT COUNT(*) FROM MenuDetails WHERE ItemName = @ItemName COLLATE SQL_Latin1_General_CP1_CI_AS AND MenuID = @MenuID AND Username = @Username";
                    SqlCommand cmdItemIsExist = new SqlCommand(sqlItemIsExist, conAddItem);
                    cmdItemIsExist.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                    cmdItemIsExist.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                    cmdItemIsExist.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                    conAddItem.Open();
                    int count = Convert.ToInt32(cmdItemIsExist.ExecuteScalar());
                    conAddItem.Close();

                    if (count == 0)
                    {   //Check if there's a category without an item
                        string sqlCategoryItemIsNull = "SELECT ItemCategory FROM MenuDetails WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID = @MenuID AND Username = @Username";
                        SqlCommand cmdCategoryItemIsNull = new SqlCommand(sqlCategoryItemIsNull, conAddItem);
                        cmdCategoryItemIsNull.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                        cmdCategoryItemIsNull.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        cmdCategoryItemIsNull.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                        conAddItem.Open();
                        SqlDataReader readCategoryItemIsNull = cmdCategoryItemIsNull.ExecuteReader();
                        if (readCategoryItemIsNull.HasRows) //Existing itemId where itemname is null
                        {
                            conAddItem.Close();
                            if (!String.IsNullOrEmpty(Variable.imgPath)) //with image
                            {
                                string sqlAddItemToCurrWithImage = "UPDATE MenuDetails SET ItemName = @ItemName, Price = @Price, ItemImage = @ItemtImage WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID = @MenuID AND Username = @Username";
                                using (SqlCommand cmdAddItemToCurrWithImage = new SqlCommand(sqlAddItemToCurrWithImage, conAddItem))
                                {
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                                    cmdAddItemToCurrWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                    conAddItem.Open();
                                    cmdAddItemToCurrWithImage.ExecuteNonQuery();
                                    conAddItem.Close();
                                    Variable.imgPath = "";
                                }
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);
                            }
                            else //without image
                            {
                                string sqlAddItemToCurrWithoutImage = "UPDATE MenuDetails SET ItemName = @ItemName, Price = @Price WHERE ItemCategory = @Category AND ItemName IS NULL AND MenuID = @MenuID AND Username = @Username";
                                SqlCommand cmdAddItemToCurrWithoutImage = new SqlCommand(sqlAddItemToCurrWithoutImage, conAddItem);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                                cmdAddItemToCurrWithoutImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                conAddItem.Open();
                                cmdAddItemToCurrWithoutImage.ExecuteNonQuery();
                                conAddItem.Close();
                            }
                        }
                        else //New ItemID
                        {
                            conAddItem.Close();
                            if (!String.IsNullOrEmpty(Variable.imgPath)) //with image
                            {
                                string sqlAddItemToNewWithImage = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, ItemName, Price, ItemImage, MenuID, Username) VALUES (@Workplace, @Category, @ItemName, @Price, @ItemtImage, @MenuID, @Username)";
                                using (SqlCommand cmdAddItemToNewWithImage = new SqlCommand(sqlAddItemToNewWithImage, conAddItem))
                                {
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                                    cmdAddItemToNewWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                    conAddItem.Open();
                                    cmdAddItemToNewWithImage.ExecuteNonQuery();
                                    conAddItem.Close();
                                    Variable.imgPath = "";
                                }
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);
                            }
                            else // without image
                            {
                                string sqlAddItemToNewWithoutImage = "INSERT INTO MenuDetails (WorkplaceName, ItemCategory, ItemName, Price, MenuID. Username) VALUES (@Workplace, @Category, @ItemName, @Price, @MenuID, @Username)";
                                SqlCommand cmdAddItemToNewWithoutImage = new SqlCommand(sqlAddItemToNewWithoutImage, conAddItem);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Workplace", Variable.strWorkplace);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@ItemName", inputItemName.Value);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                                cmdAddItemToNewWithoutImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                                conAddItem.Open();
                                cmdAddItemToNewWithoutImage.ExecuteNonQuery();
                                conAddItem.Close();
                            }
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clear", "ClearTxtBox()", true);
                        LoadItem();
                    }
                    else
                    {
                        //errmsg item alrd existed
                    }
                }
            }
            else
            {
                //errmsg inputItemName value is empty
            }
        }

        protected void UpdateItem(object sender, EventArgs e)
        {
            Variable.currItem = oldItem.Value;
            var selectedCategory = ddlCategory.SelectedItem.Text;
            bool removeImg = false;
            //check if photo has changes
            if (String.IsNullOrEmpty(Variable.imgPath)) //no changes
            {
                if (!String.IsNullOrEmpty(inpImg.Value)) //check if there was photo before
                {
                    Variable.imgPath = inpImg.Value; //the photo remains
                }
                else
                {
                    removeImg = true;
                }
            }

            SqlConnection conUpdateItem = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            if (!String.IsNullOrEmpty(inputItemName.Value))
            {
                if (String.IsNullOrEmpty(Session["MenuID"] as string)) //update menu draft
                {
                    string sqlUpdateItemWithImage = "UPDATE MenuDetails SET ItemCategory = @Category, ItemName = @NewItem, Price = @Price, ItemImage = @ItemImage WHERE ItemName = @CurrItem AND MenuID IS NULL AND Username = @Username";
                    using (SqlCommand cmdUpdateItemWithImage = new SqlCommand(sqlUpdateItemWithImage, conUpdateItem))
                    {
                        //cmd.Parameters.AddWithValue("@Name", Path.GetFileName(FileUpload1.PostedFile.FileName));
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@NewItem", inputItemName.Value);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@CurrItem", Variable.currItem);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                        conUpdateItem.Open();
                        cmdUpdateItemWithImage.ExecuteNonQuery();
                        conUpdateItem.Close();
                        Variable.imgPath = "";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);

                    //remove img
                    if (removeImg)
                    {
                        string sqlRmvImg = "UPDATE MenuDetails SET ItemImage = NULL WHERE ItemName = @NewItem AND MenuID IS NULL AND Username = @Username"; //set img to null
                        using (SqlCommand cmdUpdateItemWithImage = new SqlCommand(sqlRmvImg, conUpdateItem))
                        {
                            cmdUpdateItemWithImage.Parameters.AddWithValue("@NewItem", inputItemName.Value);
                            cmdUpdateItemWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                            conUpdateItem.Open();
                            cmdUpdateItemWithImage.ExecuteNonQuery();
                            conUpdateItem.Close();
                        }
                        removeImg = false;
                    }
                    lblMedium.InnerText = "doneUpdate";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "pop", "UpdateItem()", true);
                    LoadItem();
                }
                else //update existing menu
                {
                    string sqlUpdateItemWithImage = "UPDATE MenuDetails SET ItemCategory = @Category, ItemName = @NewItem, Price = @Price, ItemImage = @ItemImage WHERE ItemName = @CurrItem AND MenuID = @MenuID AND Username = @Username";
                    using (SqlCommand cmdUpdateItemWithImage = new SqlCommand(sqlUpdateItemWithImage, conUpdateItem))
                    {
                        //cmd.Parameters.AddWithValue("@Name", Path.GetFileName(FileUpload1.PostedFile.FileName));
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Category", selectedCategory.ToString());
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@NewItem", inputItemName.Value);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Price", inputPrice.Value);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@ItemImage", Variable.imgPath);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@CurrItem", Variable.currItem);
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                        cmdUpdateItemWithImage.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                        conUpdateItem.Open();
                        cmdUpdateItemWithImage.ExecuteNonQuery();
                        conUpdateItem.Close();
                        Variable.imgPath = "";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "clearImg", "ClearImg()", true);

                    //remove img
                    if (removeImg)
                    {
                        string sqlRmvImg = "UPDATE MenuDetails SET ItemImage = NULL WHERE ItemName = @NewItem AND MenuID = @MenuID"; //set img to null
                        using (SqlCommand cmdUpdateItemWithImage = new SqlCommand(sqlRmvImg, conUpdateItem))
                        {
                            cmdUpdateItemWithImage.Parameters.AddWithValue("@NewItem", inputItemName.Value);
                            cmdUpdateItemWithImage.Parameters.AddWithValue("@MenuID", Session["MenuID"].ToString());
                            conUpdateItem.Open();
                            cmdUpdateItemWithImage.ExecuteNonQuery();
                            conUpdateItem.Close();
                        }
                        removeImg = false;
                    }
                    lblMedium.InnerText = "doneUpdate";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "pop", "UpdateItem()", true);
                    LoadItem();
                }
            }
            else
            {
                //errmsg inputItemName value is empty
            }
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
        }

        [System.Web.Services.WebMethod]
        public static string update(string userdata)
        {
            return "Posted";
        }

        protected void ProceedToTemplate(object sender, EventArgs e)
        {
            Response.Redirect("SelectTemplate.aspx");
        }
    }
}