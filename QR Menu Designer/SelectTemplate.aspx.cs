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
    public partial class SelectTemplate : System.Web.UI.Page
    {
        bool enter = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["MenuID"] = 4000;
            SqlConnection conDisplayQR = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);

            //lblTitle.Text = "Hainanese <br /> Chicken Rice";

            string sqlDisplayQR = "SELECT Url FROM QRCode";
            SqlCommand cmdDisplayQR = new SqlCommand(sqlDisplayQR, conDisplayQR);
            conDisplayQR.Open();
            string displayQR = cmdDisplayQR.ExecuteScalar().ToString();
            conDisplayQR.Close();
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
                }
                plbarcode.Controls.Add(imgBarCode);
            }
        }

        protected void ReturnPrev(object sender, EventArgs e)
        {
            Response.Redirect("InputDetails.aspx");
        }

        protected void CompleteMenu(object sender, EventArgs e)
        {
            SqlConnection conCompleteMenu = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString);
            

            string queryString = "SelectTemplate.aspx?MenuID=" + Session["MenuID"].ToString();
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
            string sqlUserID = "INSERT INTO QRCode (URL) VALUES (@Url)";
            SqlCommand cmdAddUrl = new SqlCommand(sqlUserID, conCompleteMenu);
            cmdAddUrl.Parameters.AddWithValue("@Url", qrCodeUrl);
            conCompleteMenu.Open();
            cmdAddUrl.ExecuteNonQuery();
            conCompleteMenu.Close();

            Response.Redirect(queryString);
        }
    }
}