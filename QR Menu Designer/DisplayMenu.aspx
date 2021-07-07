<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayMenu.aspx.cs" Inherits="QR_Menu_Designer.DisplayMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
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
        .d-edit-btn {
            color: white;
            background-color: #C2AA6B;
        }
        .d-preview {
            background-color: lightgrey;
            height: 43vh;
            margin: 5vh;
            box-shadow: 5px 5px 4px rgba(0, 0, 0, 0.25);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 100vh; background-color: lightpink">
            <div class="text-center" style="background-color: white; height: 33vh">
                <div style="height: 15vh">
                    <div class="m-nav p-2" style="width: 18%">
                        <button runat="server" class="r-backBtn" id="backBtn" onserverclick="returnPrev">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                    </div>
                    <div class="m-nav p-2" style="width: 64%">
                        <div class="d-title" style="">Your Menu</div>
                    </div>
                    <div class="m-nav p-2" style="width: 18%">
                    </div>
                </div>
                <div style="height: 18vh; background-color: #C4C4C4"></div>
            </div>
            <div class="text-center" style="height: 67vh; background-color: white">
                <div style="height: 52vh; width: 80%; left: 10%; position: relative" class="pt-3">
                    <div class="d-preview"></div>
                </div>
                <div style="height: 15vh; width: 80%; left: 10%; position: absolute" class="text-center">
                    <div style="margin: 5vh">
                        <asp:Button ID="Button1" CssClass="btn btn-block d-edit-btn" runat="server" Text="Edit Menu" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
