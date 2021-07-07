<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QR_Menu_Designer.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        .bs-example{
            margin: 5vh;
        }
        .m-nav {
            float:left;
            height: 25vh;
        }
        .r-backBtn {
            background-color: #C2AA6B;
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
        .r-form {
            background-color: white; 
            height: 70vh; 
            width: 80%; 
            position: absolute; 
            left: 10%; 
            top: 15%; 
            z-index: 1;
            box-shadow: 2px 10px 10px 2px rgba(0, 0, 0, 0.25);
        }
        .l-login-btn {
            background-color: #C2AA6B;
            color: white;
        }
        .l-signup-btn {
            background-color: rgba(194, 170, 107, 0.2);
            color: #C2AA6B;
            border: 2px solid rgba(194, 170, 107, 0.1);
        }
        .l-title {
            font-family: 'Baloo Tammudu 2', cursive;
            font-size: 36px;
            line-height: 40px;
            display: flex;
            align-items: center;
            letter-spacing: -0.015em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 100vh">
            <div class="text-center" style="background-color: #C2AA6B; height: 50vh">
                <div class="m-nav p-2" style="width: 18%">
                    <button runat="server" class="r-backBtn" id="backBtn" onserverclick="returnPrev">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                </div>
                <div class="m-nav p-2" style="width: 64%">
                    <div class="m-title" style="font-family: 'Permanent Marker', cursive; font-size: 15vw">QRMenu</div>
                </div>
                <div class="m-nav p-2" style="width: 18%">
                </div>
                <div class="m-btn-div">
                </div>
            </div>
            <div class="text-center" style="height: 50vh">
                <div class="m-btn-div">
                </div>
                <div class="" style="height: 25vh"></div>
            </div>
        </div>
    </form>
    <div class="r-form">
        <div class="bs-example">
            <div class="l-title">Log In</div>
            <form action="/examples/actions/confirmation.php" class="needs-validation" method="post" novalidate>
                <div class="form-group" style="height: 12vh">
                    <label for="inputUsername">Username</label>
                    <input type="email" class="form-control" runat="server" id="inputUsername" placeholder="Username" required>
                    <div class="invalid-feedback">Please enter a valid email address.</div>
                </div>
                <div class="form-group" style="height: 12vh">
                    <label for="inputPassword">Password</label>
                    <input type="password" class="form-control" runat="server" id="inputPassword" placeholder="Password" required>
                    <div class="invalid-feedback">Please enter your password to continue.</div>
                </div>
                <asp:Label ID="lblErrMsg" runat="server" Text="Label"></asp:Label>
                <button type="submit" class="btn btn-block l-login-btn" onclick="btnLogInClick">Log In</button>
                <button type="submit" class="btn btn-block l-signup-btn">Sign Up</button>
            </form>
        </div>
    </div>
</body>
<script>
    <!-- JavaScript for disabling form submissions if there are invalid fields -->
    // Self-executing function
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
</html>
