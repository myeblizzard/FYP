<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InputDetails.aspx.cs" Inherits="QR_Menu_Designer.InputDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Input Details 1</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>  
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <style>
        h2{
            color: #2F8D46;
        }
        #form {
            position: relative;
        }
        #form fieldset{
            height: 60vh;
        }
        #form fieldset:not(:first-of-type) {
            display: none;
        }

        #form .previous-step {
            width: 100px;
            font-weight: bold;
            color: white;
            border: 0 none;
            border-radius: 0px;
            padding: 10px 5px;
            margin: 10px 5px 10px 0px;
            float: right;
        }

        .form, .previous-step {
            background: #616161;
        }

        #form .previous-step:hover,
        #form .previous-step:focus {
            background-color: #000000
        }

        .text {
            color: #2F8D46;
            font-weight: normal;
        }

        #progressbar {
            position: relative;
            margin-bottom: 5vh;
            overflow: hidden;
            margin-left: -11%;
            color: lightgrey;
            margin-top: 5vh;
            z-index: -1;
            text-align: center;
        }
        #progressbar .active {
            color: #2F8D46;
        }

        #progressbar li {
            list-style-type: none;
            font-size: 15px;
            width: 33.33%;
            float: left;
            position: relative;
            font-weight: 300;
        }

        #progressbar #step1:before {
            content: "1";
        }

        #progressbar #step2:before {
            content: "2";
        }

        #progressbar #step3:before {
            content: "3";
        }

        #progressbar li:before {
            width: 25px;
            height: 25px;
            line-height: 22px;
            display: block;
            font-family: 'Roboto Condensed', sans-serif;
            font-size: 10px;
            color: #ffffff;
            background: lightgray;
            border-radius: 50%;
            margin: 0 auto 0 auto;
        }

        #progressbar li:after {
            content: '';
            height: 2px;
            background: lightgray;
            position: absolute;
            top: 12.5px;
            z-index: -1;
        }
        .i-step-1:after {
            width: 50%;
            right: 0;
        }
        .i-step-2:after {
            width: 100%;
            right: 0;
        }
        .i-step-3:after {
            width: 50%;
            left: 0;
        }

        #progressbar li.active:before,
        #progressbar li.active:after {
            background: #2F8D46;
        }

        .progress {
            height: 20px;
        }

        .progress-bar {
            background-color: #2F8D46;
        }
        .bs-example{
            margin: 0vh;
        }
        .m-nav {
            float:left;
            height: 25vh;
        }
        .r-backBtn {
            background-color: white;
            border: none;
        }
        .fa-chevron-left{
            font-size: 20px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .i-form { 
            height: 70vh; 
            width: 80%; 
            position: absolute; 
            left: 10%; 
            top: 15%; 
            z-index: 1;
            background: #EEEEEE;
            box-shadow: 4px 6px 4px rgba(0, 0, 0, 0.25);
            padding: 5vh;
        }
        .i-title {
            font-family: 'Roboto Condensed', sans-serif;
            font-size: 20px;
            line-height: normal;
            display: flex;
            align-items: center;
            letter-spacing: -0.015em;
            text-align: left;
        }
        .i-next-btn {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            bottom: 10%;
        }
        .my-custom-scrollbar {
            position: relative;
            height: 200px;
            overflow: auto;
        }
        .table-wrapper-scroll-y {
            display: block;
        }
    </style>
</head>
<body>
    <form id="form" runat="server">
        <div class="m-nav p-2" style="width: 18%">
            <button runat="server" class="r-backBtn" id="backBtn" onserverclick="returnPrev">
                <i class="fas fa-chevron-left"></i>
            </button>
        </div>
        <div class="m-nav" style="width: 64%">
            <ul id="progressbar">
                <li class="active i-step-1" id="step1">
                    <strong>Name</strong>
                </li>
                <li class=" i-step-2" id="step2"><strong>Category</strong></li>
                <li class=" i-step-3" id="step3"><strong>Item</strong></li>
            </ul>
        </div>
        <div class="m-nav p-2" style="width: 18%"></div>
    </form>
    <div class="i-form">
        <div class="bs-example">
            <form id="form" action="/examples/actions/confirmation.php" class="needs-validation" method="post" novalidate>
                <div class="progress">
                <div class="progress-bar"></div>
                </div> <br>
                <fieldset>
                    <div class="i-title">What is the name of your workplace?</div>
                    <div class="form-group" style="height: 12vh">
                        <label for="workplace">Name</label>
                        <input type="email" class="form-control" id="workplace" placeholder="Eg: Hainanese Chicken Rice" required/>
                        <div class="invalid-feedback">Please enter a name</div>
                    </div>
                    <button type="submit" id="btnSubmit" class="next-step btn btn-block i-next-btn">Next</button>
                    <%--<input type="button" name="next-step" class="next-step btn btn-block i-next-btn" value="Next" />--%>
                </fieldset>
                <fieldset>
                    <div class="i-title">What are the categories that you have?</div>
                    <div class="form-group" style="height: 12vh">
                        <label for="inputEmail">Category</label>
                        <input type="email" class="form-control" id="inputEmail" placeholder="Eg: Main/Sides/Add Ons" required>
                        <div class="invalid-feedback">Please enter a category</div>
                    </div>
                    <input type="button" name="next-step" class="next-step btn btn-block i-next-btn" value="Next" />
                    <input type="button" name="previous-step" class="previous-step" value="Previous Step" />
                </fieldset>
                <fieldset>
                    <div class="i-title">What are the items that you provide?</div>
                    <%--<div class="table-wrapper-scroll-y my-custom-scrollbar">
                        <table class="table table-bordered table-striped mb-0">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">First</th>
                                    <th scope="col">Last</th>
                                    <th scope="col">Handle</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Mark</td>
                                    <td>Otto</td>
                                    <td>@mdo</td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Jacob</td>
                                    <td>Thornton</td>
                                    <td>@fat</td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Larry</td>
                                    <td>the Bird</td>
                                    <td>@twitter</td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Mark</td>
                                    <td>Otto</td>
                                    <td>@mdo</td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Jacob</td>
                                    <td>Thornton</td>
                                    <td>@fat</td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Larry</td>
                                    <td>the Bird</td>
                                    <td>@twitter</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>--%>
                    <asp:Repeater ID="Repeater1" runat="server" >  
                    <HeaderTemplate>  
                        <table class="table table-striped table-bordered">  
                            <tr>  
                                <td><b>No.</b></td>  
                                <td><b>Item Name</b></td>  
                                <td><b>Price</b></td>  
                                <td><b>Category</b></td>  
                                <td><b>Image</b></td> 
                                <td><b>Edit</b></td> 
                                <td><b>Remove</b></td>
                            </tr>  
                    </HeaderTemplate>  
                    <ItemTemplate>  
                        <tr>
                            <td>
                                <asp:Label ID="lblNo" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="" ID="lblItemName" Text='<%#Eval("ItemName") %>' runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="" ID="lblArtName" Text='<%#Eval("Price") %>' runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="" ID="Label1" Text='<%#Eval("ItemCategory") %>' runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="" ID="Label2" Text='<%#Eval("ItemImage") %>' runat="server"></asp:Label>
                            </td>
                            <td>

                            </td>
                            <td>

                            </td>
<%--                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "CustomerID") %>   
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "CompanyName") %>   
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "ContactName") %>  
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "ContactTitle") %>   
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "Address") %>   
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "City") %>   
                            </td>  
                            <td>  
                                <%# DataBinder.Eval(Container.DataItem, "Phone") %>   
                            </td>  --%>
                        </tr>  
                    </ItemTemplate>  
                    <FooterTemplate>  
                        </table>   
                    </FooterTemplate>  
                </asp:Repeater>  
                    <div class="form-group" style="height: 12vh">
                        <label for="inputEmail">Name</label>
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email" required>
                        <div class="invalid-feedback">Please enter a name</div>
                    </div>
                    <button type="submit" class="btn btn-block i-next-btn">Next</button>
                    <input type="button" name="previous-step" class="previous-step" value="Previous Step" />
                </fieldset>
            </form>
        </div>
  	</div>
</body>
<script>
    //Prevent page resizing from mobile keyboard
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width,height='+window.innerHeight+', initial-scale=1.0';
    document.getElementsByTagName('head')[0].appendChild(meta);

    //Next tab
    $(document).ready(function () {
        var currentGfgStep, nextGfgStep, previousGfgStep;
        var opacity;
        var current = 1;
        var steps = $("fieldset").length;

        setProgressBar(current);
        $(".next-step").click(function () {

            currentGfgStep = $(this).parent();
            nextGfgStep = $(this).parent().next();

            $("#progressbar li").eq($("fieldset")
                .index(nextGfgStep)).addClass("active");

            nextGfgStep.show();
            currentGfgStep.animate({ opacity: 0 }, {
                step: function (now) {
                    opacity = 1 - now;

                    currentGfgStep.css({
                        'display': 'none',
                        'position': 'relative'
                    });
                    nextGfgStep.css({ 'opacity': opacity });
                },
                duration: 500
            });
            setProgressBar(++current);
        });

        $(".previous-step").click(function () {

            currentGfgStep = $(this).parent();
            previousGfgStep = $(this).parent().prev();

            $("#progressbar li").eq($("fieldset")
                .index(currentGfgStep)).removeClass("active");

            previousGfgStep.show();

            currentGfgStep.animate({ opacity: 0 }, {
                step: function (now) {
                    opacity = 1 - now;

                    currentGfgStep.css({
                        'display': 'none',
                        'position': 'relative'
                    });
                    previousGfgStep.css({ 'opacity': opacity });
                },
                duration: 500
            });
            setProgressBar(--current);
        });

        //Progress bar
        function setProgressBar(currentStep) {
            var percent = parseFloat(100 / steps) * current;
            percent = percent.toFixed();
            $(".progress-bar")
                .css("width", percent + "%")
        }

        $(".submit").click(function () {
            return false;
        })
    });

    // JavaScript for disabling form submissions if there are invalid fields
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
                    //$("#nextStep").trigger("click");
                }, false);
            });
        }, false);
    })();
</script>
</html>
