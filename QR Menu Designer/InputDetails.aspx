<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InputDetails.aspx.cs" Inherits="QR_Menu_Designer.InputDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Input Details 1</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Permanent+Marker&family=Roboto+Condensed&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet">
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
            width: 50px;
            height: 80px;
            font-weight: bold;
            color: hotpink;
            border: 0 none;
            border-radius: 5px;
            position: absolute;
            top: -130px;
            left: -50px;
            opacity: 0;
        }

        .form, .previous-step {
            background: #616161;
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
            height: 10px;
            margin-bottom: -5%;
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
            display: none;
        }
        .r-backBtn2 {
            background-color: white;
            border: none;
        }
        .fa-chevron-left{
            font-size: 20px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .i-form { 
            height: 80vh; 
            width: 80%; 
            position: absolute; 
            left: 10%; 
            top: 15%; 
            z-index: 1;
            background: #EEEEEE;
            box-shadow: 4px 6px 4px rgba(0, 0, 0, 0.25);
            padding: 3vh 3vh 1vh 3vh;
        }
        .i-title {
            font-family: 'Roboto Condensed', sans-serif;
            font-size: 18px;
            line-height: normal;
            display: flex;
            align-items: center;
            letter-spacing: -0.015em;
            text-align: left;
            margin-bottom: 1%;
        }
        .i-input-title {
            position: absolute;
            bottom: 13%;
        }
        .i-input-placeholder {
            position: absolute;
            bottom: 8%;
        }
        .i-input-title2 {
            position: absolute;
            bottom: 31%;
        }
        .i-input-placeholder2 {
            position: absolute;
            bottom: 26%;
        }
        .i-workplace {
            margin: 3vh 0;
        }
        .i-next-btn {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            bottom: -18%;
        }
        .i-special-btn {
            background-color: #C2AA6B;
            color: white;
            position: absolute;
            bottom: -18%;
        }
        .i-hidden {
            display: none;
        }
        .i-wadd-btn {
            background-color: black;
            color: white;
            position: absolute;
            bottom: -18%;
        }
        .i-add-btn {
            background-color: black;
            color: white;
            position: absolute;
            bottom: -7%;
        }
        .my-custom-scrollbar {
            position: relative;
            height: 150px;
            overflow-y: scroll;
            margin-top: 1%;
            margin-bottom: 1%;
        }
        .table-wrapper-scroll-y {
	        display: block;
            width: 110%;
            margin-left: -3%;
        }
        /* width */
        ::-webkit-scrollbar {
            width: 8px;
        }
        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: white; 
            border-radius: 10px;
        }
        .i-input-img {
            width: 20px;
            height: 20px;
        }
        .i-table {
            font-size: 10px;
        }
        .i-table th {
            text-align: center;
        }
        .i-edit-btn {
            border: none;
        }
        .i-remove-btn {
            border: none;
        }
        .i-category-ddl {
            width: 60%;
            border-radius: 5%;
            position: absolute;
            bottom: 40%;
        }
        .i-fu-div {
            display: inline-flex;
            align-items: center;
        }
        .i-upload-icon {
            font-size: 30px;
            position: absolute;
            bottom: 40%;
            right: 0%;
        }
        .i-fileUpload {
            display: none;
        }
        .i-img-preview {
            width: 30px;
            height: 30px;
            position: absolute;
            bottom: 40%;
            right: 15%;
            border: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="m-nav p-2" style="width: 18%">
            <button runat="server" class="r-backBtn" id="backBtn" onserverclick="ReturnPrev">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="r-backBtn2" id="backBtn2">
                <i class="fas fa-chevron-left"></i>
            </button>
        </div>
        <div class="m-nav" style="width: 64%">
            <ul id="progressbar">
                <li class="active i-step-1" id="step1" runat="server"><strong>Name</strong></li>
                <li class="i-step-2" id="step2" runat="server"><strong>Category</strong></li>
                <li class="i-step-3" id="step3" runat="server"><strong>Item</strong></li>
            </ul>
        </div>
        <div class="m-nav p-2" style="width: 18%"></div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
        <%--<asp:AsyncFileUpload ID="AsyncFileUpload1" ThrobberID="ImageUpload" runat="server" />--%>
        <div class="i-form">
            <div class="bs-example">
                <div id="form">
                    <div class="progress">
                        <div class="progress-bar"></div>
                    </div> <br />
                    <fieldset>
                        <div class="i-title">What is the name of your workplace?</div>
                                <div runat="server" id="divWorkplace" class="d-flex">
                                    <div class="mr-auto"><asp:Label ID="lblWorkplace" CssClass="col-form-label-sm i-workplace" runat="server"></asp:Label></div>
                                    <div class="">
                                        <asp:LinkButton ID="btnEditWorkplace" runat="server" OnClick="EditWorkplace"><i class="far fa-edit"></i></asp:LinkButton>
                                    </div>
                                </div>
                        <div class="form-group" style="height: 12vh">
                            <label id="lblWorkplaceHeader" runat="server" class="col-form-label-sm" for="workplace">Name</label>
                            <input type="text" class="form-control form-control-sm" id="inputWorkplace" placeholder="Eg: Hainanese Chicken Rice" runat="server" form="form1" />
                            <div class="invalid-feedback">Please enter a name</div>
                        </div>
                        <input type="button" id="btnWorkplaceNext" name="next-step" class="next-step btn btn-block i-workplace-btn i-next-btn" value="Next" runat="server" /> 
                        <input type="button" id="btnAddWorkplace" class="btn btn-block i-wadd-btn" value="Add Workplace" runat="server" onserverclick="AddWorkplace" /> 
                        <input type="button" id="btnUpdateWorkplace" class="btn btn-block i-wadd-btn" value="Update & Proceed" runat="server" onserverclick="UpdateWorkplace" />
                    </fieldset>
                    <fieldset>
                        <asp:UpdatePanel ID="updatePanelChat" runat="server" UpdateMode="Always">
                            <ContentTemplate>
                                <div class="i-title">What are the categories that you have?</div>
                                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                    <asp:Repeater ID="RptCategories" runat="server" OnItemCommand="RpCategory" >  
                                        <HeaderTemplate>  
                                            <table class="table table-striped table-bordered">
                                        </HeaderTemplate>  
                                        <ItemTemplate>  
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblNoCategory" runat="server" Text='<%# Container.ItemIndex + 1 %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="" ID="lblCategory" Text='<%#Eval("ItemCategory") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <%--<button onclick='<%# String.Format("javascript:return EditCategory(\"{0}\")", Eval("ItemCategory").ToString()) %>'>
                                                        <i class="far fa-edit"></i>
                                                    </button>--%>
                                                    <asp:LinkButton CssClass="i-edit-category" ID="lbEditCategory" onclick='<%# String.Format("javascript:return EditCategory(\"{0}\")", Eval("ItemCategory").ToString()) %>'><i class="far fa-edit"></i></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lbRemoveCategory" CommandArgument='<%# Eval("ItemCategory") %>' runat="server" OnClientClick="if (!confirm('Are you sure you want to delete this category? *NOTE: Deleting this category will remove all the items under this category as well*')) return false;" OnClick="RemoveCategory"><i class="far fa-trash-alt"></i></asp:LinkButton>
                                                </td>
                                            </tr>  
                                        </ItemTemplate>  
                                        <FooterTemplate>  
                                            </table>   
                                        </FooterTemplate>  
                                    </asp:Repeater>
                                </div>
                                <input type="button" id="btnAddCategory" class="btn btn-block i-add-btn" value="Add Category" runat="server" onserverclick="AddCategory" />
                                <input type="button" id="btnUpdateCategory" class="btn btn-block i-add-btn i-btn-category" value="Update Category" runat="server" onserverclick="UpdateCategory" />                                
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAddCategory" />
                                <asp:AsyncPostBackTrigger ControlID="btnUpdateCategory" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <div class="form-group" style="height: 12vh">
                            <label for="inputEmail" class="col-form-label-sm i-input-title">Category Name</label>
                            <input class="form-control form-control-sm i-input-placeholder i-hidden" id="oldCategory" runat="server" form="form1"/>
                            <input class="form-control form-control-sm i-input-placeholder" id="inputCategory" runat="server" placeholder="Eg: Main/Sides/Add Ons" form="form1"/>
                            <div class="invalid-feedback">Please enter a category</div>
                        </div>
                        <input type="button" id="btnCategoryNext" name="next-step" class="next-step btn btn-block i-next-btn" runat="server" value="Next"/>
                        <input type="button" name="previous-step" class="previous-step previous-linker" value="Previous Step"/>
                    </fieldset>
                    <fieldset>
                        <asp:UpdatePanel ID="updatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                    <%--<asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>--%>
                                <div class="i-title">What are the items that you provide?</div>
                                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                    <asp:Repeater ID="RptItems" runat="server" OnItemCommand="RpItem" >  
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
                                                    <asp:Label ID="lblNoItem" runat="server" Text='<%# Container.ItemIndex + 1 %>'></asp:Label>
                                                </td>
                                                
                                                <td>
                                                    <asp:Label CssClass="" ID="lblCategory2" Text='<%#Eval("ItemCategory") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="i-itemName" ID="lblItemName" Text='<%#Eval("ItemName") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="" ID="lblPrice" Text='<%#Eval("Price") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="" ID="lblImage" Text='<%#Eval("ItemImage") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <%--<button onclick='<%# String.Format("javascript:return EditCategory(\"{0}\", \"{1}\")", Eval("ItemName").ToString(), Eval("Price").ToString()) %>'>
                                                        <i class="far fa-edit"></i>
                                                    </button>--%>
                                                    <asp:LinkButton ID="lbEditItem" onclick='<%# String.Format("javascript:return EditItem(\"{0}\", \"{1}\")", Eval("ItemName").ToString(), Eval("Price").ToString()) %>'><i class="far fa-edit"></i></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lbRemoveItem" CommandArgument='<%# Eval("ItemName") %>' runat="server" OnClientClick="if (!confirm('Are you sure you want to delete this item?')) return false;" OnClick="RemoveItem"><i class="far fa-trash-alt"></i></asp:LinkButton>
                                                </td>
                                            </tr>  
                                        </ItemTemplate>
                                        <FooterTemplate>  
                                            </table>   
                                        </FooterTemplate>  
                                    </asp:Repeater>
                                </div>
                                <asp:Button ID="btnAddItem" CssClass="btn btn-block i-add-btn" OnClick="AddItem" runat="server" Text="Add Item" />
                                <input type="button" id="btnUpdateItem" class="btn btn-block i-add-btn i-btn-item" value="Update Item" runat="server" onserverclick="UpdateItem" />
                                <asp:FileUpload ID="ImageUpload" CssClass="i-fileUpload" runat="server" Font-Size="XX-Large" onchange="loadFile(event)" Height="100px" Width="100px" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAddItem" />
                                <asp:AsyncPostBackTrigger ControlID="btnUpdateItem" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <label class="i-output" id="lblOutput" runat="server"></label>
                        <div class="d-flex">
                            <div class="mr-auto">
                                <asp:DropDownList ID="ddlCategory" CssClass="form-select form-select-sm i-category-ddl" runat="server"></asp:DropDownList>
                            </div>
                            <div class="">
                                <div class="i-fu-div">
                                    <p><img class="i-img-preview" id="imgItem" /></p>
                                    <i class="fa fa-camera i-upload-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" style="height: 12vh">
                            <label class="col-form-label-sm i-input-title2">Item Name</label>
                            <input class="form-control form-control-sm i-input-placeholder2 i-hidden" id="oldItem" runat="server" form="form1"/>
                            <input class="form-control form-control-sm i-input-placeholder2" id="inputItemName" placeholder="Eg: Roasted Chicken Rice" runat="server" form="form1"/>
                            <label class="col-form-label-sm i-input-title">Price</label>
                            <input class="form-control form-control-sm i-input-placeholder" id="inputPrice" placeholder="Eg: 6.50" runat="server" form="form1"/>
                            <div class="invalid-feedback">Please enter a name</div>
                        </div>
                        <input type="button" name="previous-step" class="previous-step previous-linkerB" value="Previous Step" />
                        <input type="button" id="btnSubmit" name="submit" class="btn btn-block i-special-btn" runat="server" value="Next"/>
                    </fieldset>
                </div>
            </div>
  	    </div>
    </form>
</body>
<script>

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_beginRequest(beginRequest);

    function beginRequest() {
        prm._scrollPosition = null;
    }

    //Prevent page resizing from mobile keyboard
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width,height='+window.innerHeight+', initial-scale=1.0';
    document.getElementsByTagName('head')[0].appendChild(meta);

    //var DTO = { 'userdata': 'Saran' };
    //$.ajax({
    //     type: "POST",
    //     contentType: "application/json; charset=utf-8",
    //     url: "InputDetails.aspx/update",
    //     data: JSON.stringify(DTO),
    //     datatype: "json",
    //     success: function (result) {
    //       //do something
    //       alert("SUCCESS = " + result.d);
    //           console.log(result);
    //     },
    //     error: function (xmlhttprequest, textstatus, errorthrown) {
    //         alert(" conection to the server failed ");
    //         console.log("error: " + errorthrown);
    //     }
    //});//end of $.ajax()
    var oldCategory;
    var oldItem;
    var oldPrice;
    
    function EditCategory(category) {
        oldCategory = category;
        document.getElementById('oldCategory').value = oldCategory;
        document.getElementById('inputCategory').value = oldCategory;
        console.log(oldCategory);
        document.getElementById("btnCategoryNext").style.display = "none";
        document.getElementById("btnAddCategory").style.display = "none";
        document.getElementById("btnUpdateCategory").style.display = "initial";
    }

    function EditItem(item, price) {
        oldItem = item;
        oldPrice = price;
        document.getElementById('oldItem').value = oldItem;
        document.getElementById('inputItemName').value = oldItem;
        document.getElementById('inputPrice').value = oldPrice;
        console.log(oldItem);
        console.log(oldPrice);
        document.getElementById("btnSubmit").style.display = "none";
        document.getElementById("btnAddItem").style.display = "none";
        document.getElementById("btnUpdateItem").style.display = "initial";
    }
    $(".i-btn-category").click(function () {
        var newCategory = document.getElementById('inputCategory').value;
        if (newCategory && oldCategory != newCategory) {
            document.getElementById("btnCategoryNext").style.display = "initial";
            document.getElementById("btnAddCategory").style.display = "initial";
            document.getElementById("btnUpdateCategory").style.display = "none";
        }
    });
    
    $(".i-btn-item").click(function () {
        var newItem = document.getElementById('inputItemName').value;
        if (newItem && oldItem != newItem) {
            document.getElementById("btnSubmit").style.display = "initial";
            document.getElementById("btnAddItem").style.display = "initial";
            document.getElementById("btnUpdateItem").style.display = "none";
        }
    });

    function SimulateClick(buttonId) {
        var button = document.getElementById(buttonId);
        if (button) {
            if (button.click) {
                button.click();
            }
            else if (button.onclick) {
                button.onclick();
            }
            else {
                alert("DEBUG: button '" + buttonId + "' is not clickable");
            }
        }
        else {
            alert("DEBUG: button with ID '" + buttonId + "' does not exist");
        }
    }
    
    //$("#btnAddWorkplace").click(function () {
    //    $(".i-workplace-btn").trigger('click');
    //});
    
    //$("#btnUpdateWorkplace").click(function () {
    //    $(".i-workplace-btn").trigger('click');
    //});

    //$(".i-edit-btn").click(function() {
    //    var $itemName = $(this).closest("tr")   // Finds the closest row <tr> 
    //                       .find(".i-itemName")     // Gets a descendent with class="nr"
    //                       .text();         // Retrieves the text within <td>

    //    $("#lblOutput").text($itemName);       // Outputs the answer
    //});

    $(".i-upload-icon").click(function () {
        $(".i-fileUpload").trigger('click');
    });
    
    var loadFile = function(event) {
	    var image = document.getElementById('imgItem');
	    image.src = URL.createObjectURL(event.target.files[0]);
    };

    var pageTracker = 1;
    console.log(pageTracker);

    $(".r-backBtn2").click(function (event) { //track the appearance of the 2nd back btn
        event.stopImmediatePropagation();
        var executed = false;
        if (!executed) {
            executed = true;
            if (pageTracker > 2) {
                console.log("hi");
                $(".previous-linkerB").trigger('click');
                event.stopImmediatePropagation();
            }
            else if (pageTracker > 1) {
                console.log("hi2");
                $(".previous-linker").trigger('click');
                event.stopImmediatePropagation();
            }
            else {
                console.log("hi3");
                $(".r-backBtn").trigger('click');
            }
        }
    });

    //Switch tab

    $(document).one('ready', function () {
        //switch (pageTracker) {
        //    case 2:
        //        $("i-next-btn").trigger('click');
        //        break;
        //    case 3:
        //        $("i-next-btn").trigger('click');
        //        $("i-next-btn").trigger('click');
        //        break;
        //    default:
        //        break;
        //}
    });

    $(document).ready(function () {
        var currentGfgStep, nextGfgStep, previousGfgStep;
        var opacity;
        var current = 1;
        var steps = $("fieldset").length;        //

        setProgressBar(current);

        $(".next-step").click(function () {
            pageTracker++;
            console.log(pageTracker);
            currentGfgStep = $(this).parent(); //
            console.log("pagetrack: "+ currentGfgStep);
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
            pageTracker--;
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
    //(function() {
    //    'use strict';
    //    window.addEventListener('load', function() {
    //        // Fetch all the forms we want to apply custom Bootstrap validation styles to
    //        var forms = document.getElementsByClassName('needs-validation');
    //        // Loop over them and prevent submission
    //        var validation = Array.prototype.filter.call(forms, function(form) {
    //            form.addEventListener('submit', function(event) {
    //                if (form.checkValidity() === false) {
    //                    event.preventDefault();
    //                    event.stopPropagation();
    //                }
    //                form.classList.add('was-validated');
    //                //$("#nextStep").trigger("click");
    //            }, false);
    //        });
    //    }, false);
    //})();
    
    //function dohtmlvalidation(sender, args) {
    //    if ($("#inputEmail").val() == "") {
    //        args.IsValid = false;
    //    }
    //}
</script>
</html>
