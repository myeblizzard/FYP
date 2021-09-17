<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMenu.aspx.cs" Inherits="QR_Menu_Designer.ViewMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Concert+One&family=Orbitron:wght@900&family=Cinzel&family=Noto+Sans+TC:wght@300&family=Play:wght@700&family=Architects+Daughter&family=Pacifico&family=Permanent+Marker&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
    <link rel="stylesheet" id="linkCSS" runat="server"/>
    <style>
        .st-modal {
            position: fixed;
            width: 80%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: none;
            z-index: 3;
            transition: all 2s ease-in-out;
        }
        .st-blur {
            background: rgba(0,0,0,0.4);
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            z-index: 2;
            display: none;
        }
        .st-qrcode {
            width: 200px;
            height: 200px;
        }
        .st-div-qrtext {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 0;
            border: 1px solid blue;
        }
        .st-lbl-qr {
            color: chocolate;
            font-size: 10px;
            font-weight:600 bold;
        }


        .m-nav {
            float:left;
        }
        .r-backBtn {
            background-color: white;
            border: none;
        }
        .m-nav .fa-chevron-left{
            font-size: 20px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .m-btn-div {
            float: left;
            position: relative;
            height: 25vh;
            width: 100%;
        }
        .d-title {
            font-family: 'Baloo Tammudu 2', cursive;
            font-size: 150%;
            line-height: 1;
            vertical-align: middle;
            letter-spacing: -0.015em;
            display: flex;
            justify-content: center;
            margin-top: 30px;
            padding-top: 5px;
            padding-bottom: 0;
            margin-bottom: 0;
        }
        .st-img {
            height:10vh;
            width: 100%;
        }
        .d-preview {
            margin-left: -18%;
            transform: scale(0.6173, 0.6173);
        }
        .d-preview2 {
            margin-left: -18%;
            transform: scale(0.6173, 0.6173);
        }
        .d-preview3 {
            margin-left: -18%;
            transform: scale(0.6173, 0.6173);
        }
        .d-edit-btn {
            color: white;
            background-color: #C2AA6B;
        }
        
        .st-template-scrollbar {
            position: relative;
            width: 100%;
            overflow-x: scroll;
        }
        /*.st-template-scroll-x {
	        display: block;
            margin-left: auto;
            width: 100%;
        }*/
        /* width */
        .st-template-scrollbar::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        /* Handle */
        .st-template-scrollbar::-webkit-scrollbar-thumb {
            background: #003d34; 
            border-radius: 10px;
        }
        .st-card {
            margin-top: 0;
            margin-bottom: 0;
            width: 85px;
            height: 90px;
            white-space: initial;
        }
        .vm-div-preview {
            margin-top: -2vh;
        }
        .st-preview {
            /*transform: scale(0.6173, 0.6173);*/
        }
        .st-card-body {
            padding-top: 0;
            padding-bottom: 5px;
            padding-left: 0;
            padding-right: 0;
            height: 20px;
            line-height: normal;
            margin-bottom: 0;
        }
        
        .vm-placeholder {
            background-color: #d9cfbd; 
            height: 70vh; 
            width: 90%; 
            position: absolute; 
            left: 5%; 
            top: 15%; 
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
            background-size: cover;
        }
        .vm-card {
            position: absolute;
            right: 5%;
            top: 50vh;
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
        }
        .vm-lbl-default-menu {
            position: absolute;
            top: 50%;
            right: 50%;
            transform: translate(50%,-50%);
            font-size: 25px;
        }
        .vm-btn-menu {
            margin-top: 0;
            margin-bottom: 0;
        }
    </style>
    <script>
        function printQRCode() {
            var getpanel = document.getElementById("<%= panelQR.ClientID%>");
            var MainWindow = window.open('', '', 'height=500, width=500');
            MainWindow.document.write('<html><head><meta name="viewport" content="width=device-width, initial-scale=1" /><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />');
            MainWindow.document.write('<link rel="stylesheet" href="css/qrCode.css" /></head><body>');
            MainWindow.document.write(getpanel.innerHTML);
            MainWindow.document.write('</body></html>');
            MainWindow.document.close();
            setTimeout(function () {
                MainWindow.print();
            }, 500);
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="st-blur" runat="server" id="modalBlur"></div>
        <div class="st-modal" runat="server" id="modalQR">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle" runat="server">QR Code</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideModal()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <asp:Panel ID="panelQR" runat="server">
                            <asp:Image ID="imgQR" CssClass="st-qrcode" runat="server" />
                            <div id="divLblQR" runat="server" class="st-div-qrtext text-center">
                                <asp:Label ID="lblQR" CssClass="st-lbl-qr" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnPrintQR" CssClass="btn btn-success" OnClientClick="return printQRCode();" runat="server" Text="Print" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="hideModal()">OK</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="divQRCode" runat="server" onclick="toggleModal()">
            <div class="card vm-card">
                <img src="images/QRCode.png" class="st-img card-img-top" />
                <div class="card-body st-card-body text-center">
                    <p class="card-text">
                        <asp:Label ID="lblTemplate" runat="server" Font-Size="Medium" Text="QR Code" CssClass="text-muted"></asp:Label>
                    </p>
                </div>
            </div>
        </div>

        <div class="st-modal" runat="server" id="modalActions">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Menu Actions</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideModal2()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <asp:Label ID="Label1" CssClass="" runat="server" Text="What Do You Want To Do With This Menu?"></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClientClick="if (!confirm('Are you sure you want to delete this menu?')) return false;" OnClick="DeleteMenu" />
                        <asp:Button ID="btnAction" CssClass="btn btn-info" runat="server" Text="" OnClick="MenuAction" />
                    </div>
                </div>
            </div>
        </div>
        <%--<asp:Button ID="Button1" runat="server" Text="Button" OnClick="RedirectToMenu" />--%>
        <div style="height: 100vh; background-color: lightpink">
            <div class="text-center" style="background-color: white; height: 36vh">
                <div style="height: 12vh">
                    <div class="m-nav p-2" style="width: 18%">
                        <button runat="server" class="r-backBtn" id="backBtn" onserverclick="ReturnPrev">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                    </div>
                    <div class="m-nav p-2" style="width: 64%">
                        <label class="d-title">Your Menu</label>
                    </div>
                    <div class="m-nav p-2" style="width: 18%">
                    </div>
                </div>
                <div class="d-flex justify-content-between m-0 p-0" style="height: 24vh; padding-bottom:0; background-color: #C4C4C4">
                    <div class="st-template-scroll-x st-template-scrollbar m-0 p-0">
                        <div class="card-deck m-0 p-0">
                            <table class="table table-borderless p-0 m-0">
                                <tr>
                                    <td class="vm-td-draft">
                                        <div id="divDraft" runat="server" class="text-center card-body vm-div-preview">
                                            <asp:Button ID="btnDefault" runat="server" CssClass="vm-btn-menu card-text st-card" Text="Draft" CommandName="Draft" OnClick="SelectMenu"/>
                                        </div>
                                    </td>
                                    <asp:Repeater ID="rptMenu" runat="server">
                                        <ItemTemplate>
                                            <td>
                                                <div class="text-center card-body vm-div-preview">
                                                    <asp:Button ID="imgTemplate" runat="server" CssClass="vm-btn-menu card-text st-card" Text='<%#Eval("WorkplaceName") %>' CommandArgument='<%# Eval("MenuID") %>' OnClick="SelectMenu"/>
                                                </div>
                                            </td>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tr>
                            </table>   
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center" style="height: 64vh; background-color: white;">
                <div style="height: 48vh; position: relative" class="pt-3">
                    <div class="st-preview">
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="d-preview" onclick="toggleModal2()">
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
                                                                    <div class="vm-menu-category-div text-left">
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
                                                                            <td class="vm-content-td text-left"><asp:Label ID="lblItem" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></td>
                                                                            <td class="vm-content-td text-left"><asp:Label ID="lblPrice" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price", "{0:C2}") %>'></asp:Label></td>
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
                                </div>
                            </asp:View>

                            <asp:View ID="View2" runat="server">
                                <div id="divView2" runat="server" class="d-preview2" onclick="toggleModal2()">
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
                                                    <asp:Repeater ID="rptCategory2" runat="server" OnItemDataBound="rptCategory_ItemDataBound2">
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
                                </div>
                            </asp:View>

                            <asp:View ID="View3" runat="server">
                                <div id="divView3" runat="server" class="d-preview3" onclick="toggleModal2()">
                                    <div class="r-form" id="divMenu3" runat="server">
                                        <div class="vm-menu-title-div">
                                            <div class="vm-menu-title-box text-center">
                                                <asp:Label ID="lblTitle3" CssClass="vm-menu-title" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="vm-menu-content-div">
                                            <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                                <asp:Repeater ID="rptCategory3" runat="server" OnItemDataBound="rptCategory_ItemDataBound3">
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
                                </div>
                            </asp:View>

                            <asp:View ID="View4" runat="server">
                                <div class="d-preview">
                                    <div class="vm-placeholder text-center">
                                        <label class="vm-lbl-default-menu">CLICK A MENU TO VIEW ABOVE</label>
                                    </div>
                                </div>
                            </asp:View>
                            
                            <asp:View ID="View5" runat="server">
                                <div class="d-preview" onclick="toggleModal2()">
                                    <div class="vm-placeholder text-center">
                                        <label class="vm-lbl-default-menu">THIS IS YOUR UNCOMPLETED MENU DRAFT</label>
                                    </div>
                                </div>
                            </asp:View>
                        </asp:MultiView>
                    </div>
                </div>
                <div style="height: 17vh; width: 80%; left: 10%; position: absolute" class="text-center">
                    <div style="margin: 5vh">
                        <asp:Button ID="btnComplete" CssClass="btn btn-block d-edit-btn" runat="server" Text="Edit Menu" OnClick="EditMenu" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script>
    //Prevent page resizing from mobile keyboard
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width,height='+window.innerHeight+', initial-scale=1.0';
    document.getElementsByTagName('head')[0].appendChild(meta);
    
    function toggleModal() {
        $("#modalQR").fadeIn();
        $("#modalBlur").fadeIn();
    }
    function hideModal() {
        $("#modalQR").fadeOut();
        $("#modalBlur").fadeOut();
    }
    
    function toggleModal2() {
        $("#modalActions").fadeIn();
        $("#modalBlur").fadeIn();
    }
    function hideModal2() {
        $("#modalActions").fadeOut();
        $("#modalBlur").fadeOut();
    }
</script>
</html>