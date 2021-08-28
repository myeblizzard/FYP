<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectTemplate.aspx.cs" Inherits="QR_Menu_Designer.SelectTemplate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="/css/template1.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
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
            font-size: 36px;
            line-height: 40px;
            vertical-align: middle;
            letter-spacing: -0.015em;
            display: flex;
            justify-content: center;
            margin-top: 8%;
            padding-top: 6%;
        }
        .st-img {

        }
        .d-preview {
            background-color: lightgrey;
            /*height: 282.84px;
            width: 200px;*/
            margin: 5vh auto;
            box-shadow: 5px 5px 4px rgba(0, 0, 0, 0.25);
            transform: scale(0.6173, 0.6173);
        }
        .d-edit-btn {
            color: white;
            background-color: #C2AA6B;
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
            font-size: 12vw;
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
            font-size: 7vw;
            color: #848484;
            margin-bottom: 0;
        }
        .vm-menu-category-hr{
            border-top: 2px dotted #70908D;
            width: 22%;
            margin-top: 0;
            position: relative;
            margin-left: 0;
            margin-bottom: 0;
        }
        .vm-menu-content-div{
            padding: 0 5% 0 5%;
        }
        .vm-menu-content{
            font-family: 'Quicksand', sans-serif;
            font-size: 4.5vw;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:placeholder id="plbarcode" runat="server" />
        <%--<div style="height: 100vh; background-color: lightpink">
            <div class="text-center" style="background-color: white; height: 33vh">
                <div style="height: 15vh">
                    <div class="m-nav p-2" style="width: 18%">
                        <button runat="server" class="r-backBtn" id="backBtn" onserverclick="ReturnPrev">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                    </div>
                    <div class="m-nav p-2" style="width: 64%">
                        <div class="d-title" style="">Your Menu</div>
                    </div>
                    <div class="m-nav p-2" style="width: 18%">
                    </div>
                </div>
                <div class="d-flex justify-content-between" style="height: 18vh; background-color: #C4C4C4">
                    <input type="image" class="st-img" onclick="changeCSS(1, 0); return false;" src="/images/menubg1.jpg" />
                    <input type="image" class="st-img" onclick="changeCSS(2, 0); return false;" src="/images/menubg2.png" />
                    <input type="image" class="st-img" onclick="changeCSS(3, 0); return false;" src="/images/menubg3.jpg" />
                </div>
            </div>
            <div class="text-center" style="height: 67vh; background-color: white">
                <div style="height: 52vh; width: 80%; left: 10%; position: relative" class="pt-3">
                    <div class="d-preview">
                        <div class="r-form">
                            <div class="vm-menu">
                                <div class="vm-menu-title-div text-center">
                                    <asp:Label ID="lblTitle" CssClass="vm-menu-title" runat="server" Text=""></asp:Label>
                                </div>
                                <hr class="vm-menu-title-hr" />
                                <div class="vm-menu-content-div">
                                    <asp:Label ID="Label2" CssClass="vm-menu-category text-center" runat="server" Text="Main"></asp:Label>
                                    <hr class="vm-menu-category-hr"/>--%>

                                    <%--<asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                            <div class="d-flex">
                                              <div class="mr-auto"><asp:Label ID="Label3" CssClass="vm-menu-content" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label></div>
                                              <div class=""><asp:Label ID="Label4" CssClass="vm-menu-content" runat="server" Text='<%#Eval("Price") %>'></asp:Label></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>--%>
                    
                                    <%--<div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label1" CssClass="vm-menu-content" runat="server" Text="Roasted Pork Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label12" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></div>
                                    </div>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label13" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label14" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></div>
                                    </div>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label10" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label11" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></div>
                                    </div>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label15" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label16" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></div>
                                    </div>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label17" CssClass="vm-menu-content" runat="server" Text="Roasted Chicken Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label18" CssClass="vm-menu-content" runat="server" Text="RM6.20"></asp:Label></div>
                                    </div>
                                    <asp:Label ID="Label5" CssClass="vm-menu-category text-center" runat="server" Text="Add Ons"></asp:Label>
                                    <hr class="vm-menu-category-hr"/>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label6" CssClass="vm-menu-content" runat="server" Text="Herbal Egg"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label7" CssClass="vm-menu-content" runat="server" Text="RM0.80"></asp:Label></div>
                                    </div>
                                    <div class="d-flex">
                                      <div class="mr-auto"><asp:Label ID="Label8" CssClass="vm-menu-content" runat="server" Text="Aromatic Rice"></asp:Label></div>
                                      <div class=""><asp:Label ID="Label9" CssClass="vm-menu-content" runat="server" Text="RM1.00"></asp:Label></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="height: 15vh; width: 80%; left: 10%; position: absolute" class="text-center">
                    <div style="margin: 5vh">
                        <asp:Button ID="btnComplete" CssClass="btn btn-block d-edit-btn" runat="server" Text="Finish" OnClick="CompleteMenu" />
                    </div>
                </div>
            </div>
        </div>--%>
    </form>
</body>
<script>
    function changeCSS(templateNo, cssLinkIndex) {

        switch (templateNo) {
            case 1:
                cssFile = '/css/template1.css';
                break;
            case 2:
                cssFile = '/css/template1b.css';
                break;
            case 3:
                cssFile = '/css/template1c.css';
                break;
            default:
                break;
        }

        var oldlink = document.getElementsByTagName("link").item(cssLinkIndex);

        var newlink = document.createElement("link");
        newlink.setAttribute("rel", "stylesheet");
        newlink.setAttribute("type", "text/css");
        newlink.setAttribute("href", cssFile);

        document.getElementsByTagName("head").item(cssLinkIndex).replaceChild(newlink, oldlink);
    }
</script>
</html>
