<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="QR_Menu_Designer.MainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        .m-nav {
            float:left;
            height: 20vh;
        }
        .m-hamburger {
            background-color: #C2AA6B;
            border: none;
        }
        .m-nav .fa-bars{
            font-size: 20px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .m-btn-div {
            float: left;
            position: relative;
            height: 30vh;
            width: 100%;
        }
        .m-create-btn {
            color: #C2AA6B;
            background-color: white;
            font-family: 'Roboto Condensed', sans-serif;
            font-size: 5vw;
            border: 2px solid white;
            border-radius: 5px;
            position: absolute;
            left:12.5%;
            top: 50%;
            transform: translateY(-50%);
        }

        .m-view-btn {
            color: white;
            background-color: #C2AA6B;
            font-family: 'Roboto Condensed', sans-serif;
            font-size: 5vw;
            border: 2px solid #C2AA6B;
            border-radius: 5px;
            position: absolute;
            left:12.5%;
            top: 50%;
            transform: translateY(-50%);
        }
        .sidepanel  {
            width: 0;
            position: fixed;
            z-index: 1;
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
            color: #black;
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
        <div style="height: 100vh">
            <div class="text-center" style="background-color: #C2AA6B; height: 50vh">
                <div class="m-nav p-2" style="width: 18%">
                    <button class="m-hamburger" onclick="openNav(); return false" >
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
                <div class="m-nav p-2" style="width: 64%">
                    <div class="m-title" style="font-family: 'Permanent Marker', cursive; font-size: 15vw">QRMenu</div>
                </div>
                <div class="m-nav p-2" style="width: 18%">
                </div>
                <div class="m-btn-div">
                    <asp:Button ID="Button1" CssClass="m-create-btn w-75 px-3 py-5" runat="server" Text="CREATE NEW MENU" />
                </div>
            </div>
            <div class="text-center" style="height: 50vh">
                <div style="height: 25vh">
                    <div class="m-btn-div">
                        <asp:Button ID="Button2" CssClass="m-view-btn w-75 px-3 py-5" runat="server" Text="VIEW MY MENU" />
                    </div>
                </div>
                <div class="m-nav"></div>
            </div>
        </div>

        <div id="mySidepanel" class="sidepanel">
          <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
          <a href="#">About</a>
          <a href="#">Services</a>
          <a href="#">Clients</a>
          <a href="#">Contact</a>
        </div>

        <script>
            function openNav() {
              document.getElementById("mySidepanel").style.width = "250px";
            }

            function closeNav() {
              document.getElementById("mySidepanel").style.width = "0";
            }
        </script>
    </form>
</body>
</html>
