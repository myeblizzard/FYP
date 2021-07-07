<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMenu.aspx.cs" Inherits="QR_Menu_Designer.ViewMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        .r-form {
            background-color: white; 
            height: 70vh; 
            width: 90%; 
            position: absolute; 
            left: 5%; 
            top: 15%; 
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
        }
        .vm-background{
            width: 100%;
            height: 70vh;
        }
        .vm-menu{
            background-color: white;
            width: 90%;
            height: 60vh;
            align-content:center;
            position: absolute; 
            left: 5%; 
            top: 7.5%;
        }
        .vm-menu-title-div{
            height: 11vh;
            background-color: lightgreen;
            padding-top: 2vh;
        }
        .vm-menu-title{
            font-family: 'Zhi Mang Xing', cursive;
            font-size: 10vw;
            color: #848484;
        }
        .vm-menu-content{
            font-family: 'Quicksand', sans-serif;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="r-form">
            <asp:Image ID="Image1" Cssclass="vm-background" runat="server" ImageUrl="~/images/menubg3.jpg" />
            <div class="vm-menu">
                <div class="vm-menu-title-div text-center">
                    <asp:Label ID="Label1" CssClass="vm-menu-title" runat="server" Text="Hainanese Chicken Rice"></asp:Label>
                </div>
                <br />
                <asp:Label ID="Label2" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label3" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label4" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label5" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label7" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
                <asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="Label"></asp:Label>
                <br />
            </div>
        </div>
    </form>
</body>

</html>
<%--<p><input type="file"  accept="image/*" name="image" id="file"  onchange="loadFile(event)" style="display: none;"></p>
    <p><label for="file" style="cursor: pointer;">Upload Image</label></p>
    <p><img id="output" width="200" /></p>

<script>
var loadFile = function(event) {
	var image = document.getElementById('output');
	image.src = URL.createObjectURL(event.target.files[0]);
};
</script>--%>