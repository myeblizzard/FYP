<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMenu.aspx.cs" Inherits="QR_Menu_Designer.ViewMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Permanent+Marker&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
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
            background-image: url('/images/menubg3.jpg');
            background-size: cover;
        }
        .vm-background{
            width: 100%;
            height: 458px;
        }
        .vm-menu{
            background-color: rgba(238,238,238, 0.9);
            width: 90%;
            height: 60vh;
            align-content:center;
            position: absolute; 
            left: 5%; 
            top: 7.5%;
        }
        .vm-menu-title-div{
            height: 12vh;
            padding-top: 2vh;
        }
        .vm-menu-title{
            font-family: 'Zhi Mang Xing', cursive;
            font-size: 280%;
            line-height: 5vh;
            color: #848484;
        }
        .vm-menu-title-hr{
            border-top: 2px solid #70908D;
            width: 90%;
            margin-bottom: 3%;
        }
        .vm-menu-category{
            font-family: 'Didact Gothic', sans-serif;
            font-size: 160%;
            color: #848484;
            margin-bottom: 0;
        }
        .vm-menu-category-hr{
            border-top: 5px dotted #70908D;
            width: 30%;
            margin-left: 0;
            margin-top: 0;
        }
        .vm-menu-content-div{
            padding: 0 5% 0 5%;
            margin: 0;
        }
        .vm-menu-content{
            font-family: 'Quicksand', sans-serif;
            font-size: 100%;
        }
        .vm-preview {
            /*transform: scale(0.6173, 0.6173);*/
        }
        .my-custom-scrollbar {
            position: relative;
            height: 280px;
            overflow-y: scroll;
        }
        .table-wrapper-scroll-y {
	        display: block;
            margin-left: auto;
            width: 105%;
        }
        .vm-content-table {
            padding-top: 0;
            padding-bottom: 0;
            border-spacing: 0 0px;
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
        .vm-category-td {
            height: 0px;
            padding-top: 0px;
            padding-bottom: 0px;
            margin-top: 0;
        }
        .vm-content-td {
            height: 10px;
            padding-top: 0px;
            padding-bottom: 20px;
            margin-top: 0;
        }
        .vm-content-tr{
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="vm-preview">
            <div class="r-form">
                <div class="vm-menu">
                    <div class="vm-menu-title-div text-center">
                        <asp:Label ID="lblTitle" CssClass="vm-menu-title" runat="server"></asp:Label>
                    </div>
                    <hr class="vm-menu-title-hr" />
                    <div class="vm-menu-content-div">
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <asp:Repeater ID="rptCategory" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
                                <HeaderTemplate>
                                    <table class="table table-borderless p-0 mb-0 vm-content-table">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="vm-category-td" colspan="2">
                                            <div class="vm-menu-category-div">
                                                <asp:Label ID="Label2" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                                <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                                <hr class="vm-menu-category-hr"/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <asp:Repeater ID="rptItem" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="vm-content-td"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                                    <td class="vm-content-td"><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>  
                                    </table>   
                                </FooterTemplate>  
                            </asp:Repeater>
                    
                            <%--<table class="table table-borderless p-0 mb-0 vm-content-table">
                                <colgroup>
                                   <col span="1" style="width: 70%;" />
                                   <col span="1" style="width: 30%;" />
                                </colgroup>
                                <tr>
                                    <td class="vm-category-td" colspan="2">
                                        <div class="vm-menu-category-div">
                                            <asp:Label ID="Label2" CssClass="vm-menu-category" runat="server" Text="Mains"></asp:Label>
                                            <hr class="vm-menu-category-hr"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label13" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label14" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label15" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label16" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label17" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label18" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-category-td" colspan="2">
                                        <div class="vm-menu-category-div">
                                            <asp:Label ID="Label5" CssClass="vm-menu-category" runat="server" Text="Add Ons"></asp:Label>
                                            <hr class="vm-menu-category-hr"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="Herbal Egg"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label7" CssClass="vm-menu-content" runat="server" Text="RM0.80"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td class="vm-content-td"><asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="Aromatic Rice"></asp:Label></td>
                                    <td class="vm-content-td"><asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="RM1.00"></asp:Label></td>
                                </tr>
                            </table>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

<script>

</script>

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