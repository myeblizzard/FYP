<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="QR_Menu_Designer.MainMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Concert+One&family=Orbitron:wght@900&family=Cinzel&family=Noto+Sans+TC:wght@300&family=Play:wght@700&family=Architects+Daughter&family=Pacifico&family=Permanent+Marker&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
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
    </style>
    <script>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
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
                    <asp:Button ID="btnCreateMenu" CssClass="m-create-btn w-75 px-3 py-5" runat="server" Text="CREATE NEW MENU" OnClick="CreateMenu" />
                </div>
            </div>
            <div class="text-center" style="height: 50vh">
                <div style="height: 25vh">
                    <div class="m-btn-div">
                        <asp:Button ID="btnViewMenu" CssClass="m-view-btn w-75 px-3 py-5" runat="server" Text="VIEW MY MENU" OnClick="ViewMenu" />
                    </div>
                </div>
                <div class="m-nav"></div>
            </div>
        </div>

        <div id="mySidepanel" class="sidepanel">
          <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
          <a href="ProfileSettings.aspx">Profile Settings</a>
          <a href="Login.aspx">Log Out</a>
        </div>

        <div class="st-blur" runat="server" id="modalBlur"></div>
        <div class="st-modal" runat="server" id="modalActions">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Menu Actions</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideModal()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <asp:Label ID="lblMenu" CssClass="" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClientClick="if (!confirm('Are you sure you want to delete the draft and create new?')) return false;" OnClick="DeleteMenu" />
                        <asp:Button ID="btnAction" CssClass="btn btn-info" runat="server" Text="" OnClick="ContinueDraft" />
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

    function openNav() {
        document.getElementById("mySidepanel").style.width = "250px";
    }

    function closeNav() {
        document.getElementById("mySidepanel").style.width = "0";
    }
    
    function toggleModal() {
        $("#modalActions").fadeIn();
        $("#modalBlur").fadeIn();
    }
    function hideModal() {
        $("#modalActions").fadeOut();
        $("#modalBlur").fadeOut();
    }
    
    $(document).ready(function () {
        var toggleModal = document.getElementById('lblMenu').innerText;
       
        if (toggleModal) {
            $("#modalActions").fadeIn();
            $("#modalBlur").fadeIn();
        }
    });
</script>
</html>
