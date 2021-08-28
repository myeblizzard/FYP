<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMenu3.aspx.cs" Inherits="QR_Menu_Designer.ViewMenu3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Noto+Sans+TC:wght@300&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Permanent+Marker&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        .r-form {
            background-color: white; 
            height: 458px; 
            width: 324px; 
            /*position: absolute;*/ 

            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);

            /*left: 5%; 
            top: 15%;*/ 
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
            display: flex;
            flex-wrap: wrap;
            background-image: url('/images/menubg6.jpg');
            background-size: cover;

        }
        .vm-menu-title-div{
            width: 100%;
            height: 20%;
            padding: 15px;
        }
        .vm-menu-title-box{
            width: 90%;
            border: 2px solid white;
            margin: auto;
            padding: 5px 0;
        }
        .vm-menu-title{
            font-family: 'ZCOOL QingKe HuangYou', cursive;
            font-size: 200%;
            color: white;
        }
        .vm-menu-content-div{
            padding: 2%;
            margin-top: 0;
            height: 80%;
        }
        .vm-menu-category-div{

        }
        .vm-menu-category{
            font-family: 'Noto Sans TC', sans-serif;
            font-size: 120%;
            color: white;
        }
        .vm-content-table{
            border-spacing: 0 2px;
        }
        .vm-img{
            width: 100%;
            height: 70px;
            border: 1px solid white;
        }
        .vm-menu-content{
            font-family: 'Noto Sans TC', sans-serif;
            font-size: 80%;
            color: white;
        }
        .my-custom-scrollbar {
            position: relative;
            height: 330px;
            overflow-y: scroll;
        }
        .table-wrapper-scroll-y {
	        display: block;
            margin-left: auto;
            width: 90%;
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
        .vm-content-table .vm-td-1{
            padding-top: 20px;
            padding-bottom: 0;
        }
        .vm-content-table .vm-td-2{
            padding-bottom: 20px;
            padding-top: 0;
        }
        .vm-content-table .vm-tr-1{
            column-span: all;
            width: 40%;
        }
        .vm-content-table .vm-tr-2{
            column-span: all;
            width: 60%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="r-form">

            <div class="vm-menu-title-div">
                <div class="vm-menu-title-box text-center">
                    <asp:Label ID="Label20" CssClass="vm-menu-title" runat="server"></asp:Label>
                </div>
            </div>
            <div class="vm-menu-content-div">
                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                    <asp:Repeater ID="rptCategory" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
                        <HeaderTemplate>
                            <table class="table table-borderless p-0 mb-0 vm-content-table">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td colspan="2">
                                    <div class="vm-menu-category-div text-center">
                                        <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="vm-category-td" colspan="2">
                                    <div class="vm-menu-category-div">
                                        <asp:Label ID="Label2" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                        <hr class="vm-menu-category-hr"/>
                                    </div>
                                </td>
                            </tr>
                            <asp:Repeater ID="rptItem" runat="server">
                                <ItemTemplate>
                                    <tr class="vm-tr-1">
                                        <td rowspan="2"><asp:Image ID="Image1" CssClass="vm-img" ImageUrl='<%#Eval("ItemImage") %>' runat="server" /></td>
                                        <td class="vm-td-1"><asp:Label ID="Label21" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                    </tr>
                                    <tr class="vm-tr-2">
                                        <td class="vm-td-2"><asp:Label ID="Label22" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                        <FooterTemplate>  
                            </table>   
                        </FooterTemplate>  
                    </asp:Repeater>
                </div>
            </div>

            <%--<div class="vm-menu-title-div">
                <div class="vm-menu-title-box text-center">
                    <asp:Label ID="lblTitle" CssClass="vm-menu-title" runat="server"></asp:Label>
                </div>
            </div>
            <div class="vm-menu-content-div">
                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                    <table class="table table-borderless mb-0 vm-content-table">
                        <colgroup>
                           <col span="1" style="width: 40%;" />
                           <col span="1" style="width: 60%;" />
                        </colgroup>
                        <tr>
                            <td colspan="2">
                                <div class="vm-menu-category-div text-center">
                                    <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text="Main"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image1" CssClass="vm-img" ImageUrl="~/images/noodle.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr>
                         <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image2" CssClass="vm-img" ImageUrl="~/images/noodle2.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label4" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr> 
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image3" CssClass="vm-img" ImageUrl="~/images/noodle3.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label13" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr> 
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image4" CssClass="vm-img" ImageUrl="~/images/noodle4.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label14" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr> 
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image5" CssClass="vm-img" ImageUrl="~/images/noodle5.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label15" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="vm-menu-category-div text-center">
                                    <asp:Label ID="Label2" CssClass="vm-menu-category" runat="server" Text="Side"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image6" CssClass="vm-img" ImageUrl="~/images/noodle4.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label3" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label5" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr> 
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image7" CssClass="vm-img" ImageUrl="~/images/noodle5.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label7" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image8" CssClass="vm-img" ImageUrl="~/images/noodle4.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label16" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label17" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr> 
                        <tr class="vm-tr-1">
                            <td rowspan="2"><asp:Image ID="Image9" CssClass="vm-img" ImageUrl="~/images/noodle5.jpg" runat="server" /></td>
                            <td class="vm-td-1"><asp:Label ID="Label18" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></td>
                        </tr>
                        <tr class="vm-tr-2">
                            <td class="vm-td-2"><asp:Label ID="Label19" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></td>
                        </tr>
                    </table>
                </div>
            </div>--%>
        </div>
    </form>
</body>
</html>
