<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectTemplate.aspx.cs" Inherits="QR_Menu_Designer.SelectTemplate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Template</title>
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
            height:13vh;
            width: 100%;
        }
        .d-preview {
            transform: scale(0.6173, 0.6173);
        }
        .d-preview2 {
            transform: scale(0.6173, 0.6173);
        }
        .d-preview3 {
            transform: scale(0.6173, 0.6173);
        }
        .d-edit-btn {
            color: white;
            background-color: #C2AA6B;
        }
        
        .st-template-scrollbar {
            position: relative;
            width: 100%;
        }
        /*.st-template-scroll-x {
	        display: block;
            margin-left: auto;
            width: 100%;
        }*/
        /* width */
        .st-template-scrollbar::-webkit-scrollbar {
            width: 8px;
        }
        /* Handle */
        .st-template-scrollbar::-webkit-scrollbar-thumb {
            background: #003d34; 
            border-radius: 10px;
        }
        .st-card {
            margin-bottom: 0;
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 100vh; background-color: lightpink">
            <div class="text-center" style="background-color: white; height: 35vh">
                <div style="height: 12vh">
                    <div class="m-nav p-2" style="width: 18%">
                        <button runat="server" class="r-backBtn" id="backBtn" onserverclick="ReturnPrev">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                    </div>
                    <div class="m-nav p-2" style="width: 64%">
                        <label class="d-title">Choose a Template</label>
                    </div>
                    <div class="m-nav p-2" style="width: 18%">
                    </div>
                </div>
                <div class="d-flex justify-content-between m-0 p-0" style="height: 23vh; padding-bottom:0; background-color: #C4C4C4">
                    <div class="st-template-scroll-x st-template-scrollbar m-0 p-0">
                        <div class="card-deck m-0 p-0">
                            <table class="table table-borderless p-0 m-0">
                                <tr>
                                    <asp:Repeater ID="rptTemplate" runat="server">
                                        <ItemTemplate>
                                                <td>
                                                    <div class="card st-card">
                                                        <asp:ImageButton ID="imgTemplate" CssClass="st-img card-img-top" ImageUrl='<%#Eval("PreviewImage") %>' CommandArgument='<%# Eval("TemplateID") %>' CommandName="Template1" runat="server" OnClick="Template_Click" />
                                                        <div class="card-body st-card-body">
                                                            <p class="card-text">
                                                                <asp:Label ID="lblTemplate" runat="server" Font-Size="X-Small" Text='<%#Eval("TemplateName") %>' CssClass="text-muted"></asp:Label>
                                                            </p>
                                                        </div>
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
            <div class="text-center" style="height: 65vh; background-color: white;">
                <div style="height: 48vh; position: relative" class="pt-3">
                    <div class="st-preview">
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="d-preview">
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
                                <div id="divView2" runat="server" class="d-preview2">
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
                                <div id="divView3" runat="server" class="d-preview3">
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
                        </asp:MultiView>
                    </div>
                </div>
                <div style="height: 17vh; width: 80%; left: 10%; position: absolute" class="text-center">
                    <div style="margin: 5vh">
                        <asp:Button ID="btnComplete" CssClass="btn btn-block d-edit-btn" runat="server" Text="Finish" OnClick="CompleteMenu" />
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

    //function changeCSS(templateNo, cssLinkIndex) {

    //    switch (templateNo) {
    //        case 1:
    //            cssFile = '/css/template1.css';
    //            break;
    //        case 2:
    //            cssFile = '/css/template1b.css';
    //            break;
    //        case 3:
    //            cssFile = '/css/template1c.css';
    //            break;
    //        default:
    //            break;
    //    }

    //    var oldlink = document.getElementsByTagName("link").item(cssLinkIndex);

    //    var newlink = document.createElement("link");
    //    newlink.setAttribute("rel", "stylesheet");
    //    newlink.setAttribute("type", "text/css");
    //    newlink.setAttribute("href", cssFile);

    //    document.getElementsByTagName("head").item(cssLinkIndex).replaceChild(newlink, oldlink);
    //}
</script>
</html>
