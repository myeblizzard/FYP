<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="QR_Menu_Designer.ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Password Reset</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Concert+One&family=Orbitron:wght@900&family=Cinzel&family=Noto+Sans+TC:wght@300&family=Play:wght@700&family=Architects+Daughter&family=Pacifico&family=Permanent+Marker&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
    <style>
        .bs-example{
            margin: 0vh;
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
            padding: 5vh;
        }
        .r-title {
            font-family: 'Baloo Tammudu 2', cursive;
            font-size: 36px;
            line-height: 40px;
            display: flex;
            align-items: center;
            letter-spacing: -0.015em;
        }
        .fp-btn-getCode {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            top: 285%;
        }
        .fp-btn-verifyCode {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            top: 285%;
        }
        .fp-btn-resetPw {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            top: 113%;
        }
        .r-hl {
            position: absolute;
            top: 350%;
        }
        .r-hl2 {
            position: absolute;
            top: 133%;
        }
        .r-innerdiv {
            position: relative;
        }
        .r-modal-errMsg {
            position: fixed;
            width: 80%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: none;
            z-index: 3;
            transition: all 2s ease-in-out;
        }
        .r-blur {
            background: rgba(0,0,0,0.5);
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            z-index: 2;
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 100vh">
            <div class="text-center" style="background-color: #C2AA6B; height: 50vh">
                <div class="m-nav p-2" style="width: 18%">
                    <button runat="server" class="r-backBtn" id="backBtn" onserverclick="ReturnPrev">
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
        <div class="r-form">
            <div class="bs-example">
                <div class="r-innerdiv">
                    <div class="r-title">Reset Password</div>
                    <div class="r-innerdiv">
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="form-group" style="height: 12vh">
                                    <label id="lblEnterEmail" runat="server" for="inputEmail">Email</label>
                                    <label id="lblEmail" runat="server"></label>
                                    <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" placeholder="Enter your email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" Display="Dynamic" ValidationGroup="getCode" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revUsername" runat="server" Display="Dynamic" ValidationGroup="getCode" ErrorMessage="Please enter a valid email address" ForeColor="Red" Font-Size="Small" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtUsername"></asp:RegularExpressionValidator>
                                </div>
                                <asp:Button ID="btnGetCode" runat="server" CssClass="btn btn-block fp-btn-getCode" Text="Get Code" ValidationGroup="getCode" OnClick="GenerateCode"/>
                                <asp:Button ID="btnResendCode" runat="server" CssClass="btn btn-block fp-btn-getCode" Text="Resend Code" CommandArgument="resend" ValidationGroup="getCode" OnClick="GenerateCode"/>
                                <asp:HyperLink Height="1px" ID="hlLogin" CssClass="card-link r-hl" NavigateUrl="~/Login.aspx" Font-Size="Small" runat="server">Remembered your password? Click here to log in</asp:HyperLink>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div id="divVCode" runat="server" class="form-group" style="height: 12vh">
                                    <label id="lblEmail2" runat="server"></label>
                                    <label id="lblVCode" runat="server" for="inputPassword">Verification Code</label>
                                    <asp:TextBox ID="txtVCode" MaxLength="4" CssClass="form-control" placeholder="Enter your 4-digit code" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvVCode" runat="server" Display="Dynamic" ValidationGroup="verifyCode" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="txtVCode"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revVCode" runat="server" Display="Dynamic" ValidationGroup="verifyCode" ErrorMessage="The code has 4 digits" ForeColor="Red" Font-Size="Small" ValidationExpression="^[0-9]{4}$" ControlToValidate="txtVCode" />
                                </div>
                                <asp:Button ID="btnVerifyCode" runat="server" CssClass="btn btn-block fp-btn-verifyCode" Text="Verify" ValidationGroup="verifyCode" OnClick="VerifyCode"/>
                                <asp:HyperLink Height="1px" ID="hlLogin2" CssClass="card-link r-hl" NavigateUrl="~/Login.aspx" Font-Size="Small" runat="server">Remembered your password? Click here to log in</asp:HyperLink>
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div id="divNewPw" runat="server" class="form-group" style="height: 18vh">
                                    <label id="lblEmail3" runat="server"></label>
                                    <label id="lblNewPw" runat="server" for="inputPassword">New Password</label>
                                    <asp:TextBox ID="txtPassword" MaxLength="15" CssClass="form-control" TextMode="Password" placeholder="Enter new password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" Display="Dynamic" ValidationGroup="resetPw" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revPassword" runat="server" Display="Dynamic" ValidationGroup="resetPw" ErrorMessage="Minimum length is 6 characters" ForeColor="Red" Font-Size="Small" ValidationExpression=".{6}.*" ControlToValidate="txtPassword" />
                                </div>
                                <div id="divConfirmPw" runat="server" class="form-group" style="height: 12vh">
                                    <label id="lblConfirmPw" runat="server" for="inputPassword">Confirm Password</label>
                                    <asp:TextBox ID="txtConfirmPassword" MaxLength="15" CssClass="form-control" TextMode="Password" placeholder="Repeat your password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" Display="Dynamic" ValidationGroup="resetPw" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="txtConfirmPassword"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revConfirmPassword" runat="server" Display="Dynamic" ValidationGroup="resetPw" ErrorMessage="Minimum length is 6 characters" ForeColor="Red" Font-Size="Small" ValidationExpression=".{6}.*" ControlToValidate="txtConfirmPassword" />
                                </div>
                                <asp:Button ID="btnResetPw" runat="server" CssClass="btn btn-block fp-btn-resetPw" Text="Reset" ValidationGroup="resetPw" OnClick="ResetPassword"/>
                                <asp:HyperLink Height="1px" ID="hlLogin3" CssClass="card-link r-hl2" NavigateUrl="~/Login.aspx" Font-Size="Small" runat="server">Remembered your password? Click here to log in</asp:HyperLink>
                            </asp:View>
                        </asp:MultiView>
                    </div>
                </div>
            </div>
        </div>
        <%--<button type="button" class="btn btn-primary r-toggleModal" onclick="toggleModal()">
          Launch demo modal
        </button>--%>
        <div class="r-blur" runat="server" id="modalBlur"></div>
        <div class="r-modal-errMsg" runat="server" id="modalErrMsg">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle" runat="server"></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideModal()">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <label id="lblErrMsg" runat="server" form="form1"></label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="hideModal()">OK</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="r-modal-errMsg" runat="server" id="modalSuccess">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle2" runat="server"></h5>
                    </div>
                    <div class="modal-body">
                        <label id="lblSuccessMsg" runat="server" form="form1"></label>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnProceed" CssClass="btn btn-secondary" runat="server" Text="Proceed" OnClick="Proceed" />
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
        $("#modalErrMsg").fadeIn();
        $("#modalBlur").fadeIn();
    }
    function hideModal() {
        $("#modalErrMsg").fadeOut();
        $("#modalBlur").fadeOut();
        document.getElementById('lblErrMsg').innerText = "";
    }
    
    $(document).ready(function () {
        var toggleModal = document.getElementById('lblErrMsg').innerText;
       
        if (toggleModal) {
            $("#modalErrMsg").fadeIn();
            $("#modalBlur").fadeIn();
        }
    });
    $(document).ready(function () {
        var toggleModal = document.getElementById('lblSuccessMsg').innerText;
       
        if (toggleModal) {
            $("#modalSuccess").fadeIn();
            $("#modalBlur").fadeIn();
        }
    });

</script>
</html>
