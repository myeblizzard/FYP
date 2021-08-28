<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMenu2.aspx.cs" Inherits="QR_Menu_Designer.ViewMenu2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Permanent+Marker&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        * {
            box-sizing: border-box;
        }
        .r-form {
            background-color: white; 
            height: 70vh; 
            width: 90%; 
            position: absolute; 
            left: 5%; 
            top: 15%; 
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
            display: flex;
            flex-wrap: wrap;
            background-image: url('/images/menubg4.jpg');
        }
        .vm-background {
            width: 100%;
            height: 100%;
        }
        .vm-left-column { 
            padding: 2%;
            width: 45%;
            height: 100%;
            float: left;
        }
        .vm-menu-title {
            font-family: 'Fredoka One', cursive;
            font-size: 170%;
            color: #edb104;
            text-shadow: 2px 2px #808080;
        }
        .vm-menu-img {
            width: 100%;
            margin-top: 5%;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
        }
        .vm-right-column { 
            background: transparent;
            padding: 2% 2% 2% 0;
            width: 55%;
            float: left;
        }
        .vm-menu-content-div {
            background: rgba(239,239,239,0.7);
            height: 100%;
            padding: 2%;
        }
        .vm-menu-category-div {
            margin-top: 5%;
        }
        .vm-menu-category {
            font-family: 'Fredoka One', cursive;
            font-size: 100%;
            color: #edb104;
        }
        .vm-menu-content {
            font-family: 'Montserrat', sans-serif;
            color: black;
            font-size: 60%;
        }
        .vm-button-div {
            width: 80%;
            position: absolute;
            bottom: 5%;
            left: 10%;
        }
        .i-next-btn {
            background-color: #C2AA6B;
            color: white;
        }
        .vm-menu-squigglyline {
            /* Clip edges, as some of the lines don't terminate nicely. */
            overflow: hidden;
            position: relative;
            width: 200px;
            height: 50px;
        }
        .ellipse {
            position: absolute;
            background: radial-gradient(ellipse, transparent, transparent 5px, #edb104 7px, #edb104 10px, transparent 11px);
            background-size: 36px 16px;
            width: 120px;
            height: 8px;
        }
        .ellipse2 {
            top: 8px;
            left: 18px;
            background-position: 0px -8px;
        }
        .my-custom-scrollbar {
            position: relative;
            height: 420px;
            overflow-y: scroll;
        }
        .table-wrapper-scroll-y {
	        display: block;
            margin-left: auto;
            width: 100%;
        }
        /* width */
        ::-webkit-scrollbar {
            width: 8px;
        }
        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: white; 
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="r-form">
            <%--<asp:Image ID="Image1" Cssclass="vm-background" runat="server" ImageUrl="~/images/menubg4.jpg" /> OnItemDataBound="rptImg_ItemDataBound"--%>
            <div class="vm-left-column text-center">
                <asp:Label ID="lblTitle" CssClass="vm-menu-title" runat="server"></asp:Label>
                <asp:Repeater ID="rptImg" runat="server">
                    <ItemTemplate>
                        <asp:Image ID="imgItem" CssClass="vm-menu-img" ImageUrl='<%#Eval("ItemImage") %>' runat="server"></asp:Image>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="vm-right-column">
                <div class="vm-menu-content-div">
                    <div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <asp:Repeater ID="rptCategory" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
                            <ItemTemplate>
                                <div class="vm-menu-category-div text-center">
                                    <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                    <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                </div>
                                <asp:Repeater ID="rptItem" runat="server">
                                    <ItemTemplate>
                                        <div class="d-flex">
                                            <div class="mr-auto"><asp:Label ID="lblName" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></div>
                                            <div class=""><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ItemTemplate>
                        </asp:Repeater>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label2" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label3" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label4" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label5" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                    
                        <div class="vm-menu-category-div text-center">
                            <asp:Label ID="Label7" CssClass="vm-menu-category" runat="server" Text="Add On"></asp:Label>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label13" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                        <div class="d-flex">
                            <div class="mr-auto"><asp:Label ID="Label14" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                            <div class=""><asp:Label ID="Label15" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <%--<div class="vm-right-column text-center">
                <asp:Label ID="lblTitle" CssClass="vm-menu-title" runat="server"></asp:Label>
                <asp:Image ID="Image1" CssClass="vm-menu-img" ImageUrl="~/images/nasilemak.jpg" runat="server" />
                <asp:Image ID="Image2" CssClass="vm-menu-img" ImageUrl="~/images/nasilemak2.jpg" runat="server" />
                <asp:Image ID="Image3" CssClass="vm-menu-img" ImageUrl="~/images/nasilemak3.jpg" runat="server" />
                <asp:Image ID="Image4" CssClass="vm-menu-img" ImageUrl="~/images/nasilemak4.jpg" runat="server" />
            </div>
            <div class="vm-left-column">
                <div class="vm-menu-content-div">
                    <div class="vm-menu-category-div text-center">
                        <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text="Main"></asp:Label>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label2" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label3" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label4" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label5" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    
                    <div class="vm-menu-category-div text-center">
                        <asp:Label ID="Label7" CssClass="vm-menu-category" runat="server" Text="Add On"></asp:Label>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label13" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-auto"><asp:Label ID="Label14" CssClass="vm-menu-content" runat="server" Text="Classic"></asp:Label></div>
                        <div class=""><asp:Label ID="Label15" CssClass="vm-menu-content" runat="server" Text="RM6.50"></asp:Label></div>
                    </div>
                </div>
            </div>--%>
        </div>
        <%--<div class="vm-button-div">
            <asp:Button ID="Button1" CssClass="btn btn-block i-next-btn" runat="server" Text="OK" />
        </div>--%>
    </form>
</body>
</html>
