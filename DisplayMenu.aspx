<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayMenu.aspx.cs" Inherits="QR_Menu_Designer.DisplayMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Concert+One&family=Orbitron:wght@900&family=Cinzel&family=Noto+Sans+TC:wght@300&family=Play:wght@700&family=Architects+Daughter&family=Pacifico&family=Permanent+Marker&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="css/template1.css" id="linkCSS" runat="server"/>
    <style>
        .m-hamburger {
            background-color: white;
            border: none;
            position: absolute;
            top: 3vh;
            left: 4%;
        }
        .m-nav .fa-bars{
            font-size: 40px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .sidepanel  {
            width: 0;
            position: fixed;
            z-index: 4;
            height: 100vh;
            top: 0;
            left: 0;
            background-color: #f3eee1;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
        }
        .sidepanel a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 25px;
            color: #C2AA6B;
            display: block;
            transition: 0.3s;
        }
        .sidepanel .closebtn {
            position: absolute;
            top: 0;
            right: 25px;
            font-size: 36px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <button id="btnHamburger" runat="server" class="m-hamburger" onclick="openNav(); return false" >
            <i class="fas fa-bars"></i>
        </button>
        <div id="mySidepanel" class="sidepanel">
          <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
          <a href="MainMenu.aspx">Main Menu</a>
          <a href="Login.aspx">Log Out</a>
        </div>
        <div class="vm-preview">
            <asp:MultiView ID="MultiView1" runat="server">

                <asp:View ID="View1" runat="server">
                    <div class="r-form" id="divMenu" runat="server">
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
                                                        <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                                        <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                                        <hr class="vm-menu-category-hr"/>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <asp:Repeater ID="rptItem" runat="server" OnItemDataBound="rptItem_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="vm-content-td"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                                            <td class="vm-content-td"><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>   
                                        </FooterTemplate>  
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:View>

                <asp:View ID="View2" runat="server">
                    <div class="r-form" id="divMenu2" runat="server">
                        <div class="vm-left-column text-center">
                            <asp:Label ID="lblTitle2" CssClass="vm-menu-title" runat="server"></asp:Label>
                            <div class="vm-img-scroll">
                                <asp:Repeater ID="rptImg" runat="server">
                                    <ItemTemplate>
                                        <asp:Image ID="imgItem" CssClass="vm-menu-img" ImageUrl='<%#Eval("ItemImage") %>' runat="server"></asp:Image>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="vm-right-column">
                            <div class="vm-menu-content-div">
                                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                    <asp:Repeater ID="rptCategory2" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="vm-menu-category-div text-center">
                                                <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                                <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                            </div>
                                            <asp:Repeater ID="rptItem" runat="server" OnItemDataBound="rptItem_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="d-flex">
                                                        <div class="mr-auto"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></div>
                                                        <div class=""><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:View>

                <asp:View ID="View3" runat="server">
                    <div class="r-form" id="divMenu3" runat="server">
                        <div class="vm-menu-title-div">
                            <div class="vm-menu-title-box text-center">
                                <asp:Label ID="lblTitle3" CssClass="vm-menu-title" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="vm-menu-content-div">
                            <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                <asp:Repeater ID="rptCategory3" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
                                    <HeaderTemplate>
                                        <table class="table table-borderless p-0 mb-0 vm-content-table">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td class="" colspan="2">
                                                <div class="vm-menu-category-div text-center">
                                                    <hr class="vm-menu-category-hr"/>
                                                    <asp:Label ID="lblCategory" CssClass="vm-menu-category" runat="server" Text='<%#Eval("ItemCategory") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdfCategory" runat="server" Value='<%#Eval("ItemCategory") %>'/>
                                                    <hr class="vm-menu-category-hr"/>
                                                </div>
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="rptItem" runat="server" OnItemDataBound="rptItem_ItemDataBound">
                                            <ItemTemplate>
                                                <tr class="vm-tr-1">
                                                    <td rowspan="2"><asp:Image ID="imgItem" CssClass="vm-img" ImageUrl='<%#Eval("ItemImage")%>' runat="server" /></td>
                                                    <td class="vm-td-1 vm-td"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                                </tr>
                                                <tr class="vm-tr-2">
                                                    <td class="vm-td-2 vm-td"><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:Repeater ID="rptItemWithoutImg" runat="server" OnItemDataBound="rptItem_ItemDataBound2">
                                            <ItemTemplate>
                                                <tr class="vm-tr-1">
                                                    <td colspan="2" class="vm-td-1 vm-td-alt text-center"><asp:Label ID="lblItemWithoutImg" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                                </tr>
                                                <tr class="vm-tr-2">
                                                    <td colspan="2" class="vm-td-2 vm-td-alt text-center"><asp:Label ID="lblPriceWithoutImg" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
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
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</body>
<script>
    //Prevent page resizing from mobile keyboard
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width,height='+window.innerHeight+', initial-scale=1.0';
    document.getElementsByTagName('head')[0].appendChild(meta);
    
    function openNav() {
        document.getElementById("mySidepanel").style.width = "250px";
    }

    function closeNav() {
        document.getElementById("mySidepanel").style.width = "0";
    }
</script>
</html>
