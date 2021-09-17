<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InputDetails.aspx.cs" Inherits="QR_Menu_Designer.InputDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Input Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>  
    <script src="https://kit.fontawesome.com/6eb49a722e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&family=Concert+One&family=Orbitron:wght@900&family=Cinzel&family=Noto+Sans+TC:wght@300&family=Play:wght@700&family=Architects+Daughter&family=Pacifico&family=Permanent+Marker&family=ZCOOL+QingKe+HuangYou&family=Montserrat:wght@300&family=Fredoka+One&family=Didact+Gothic&family=Quicksand:wght@300&family=Roboto+Condensed&family=Zhi+Mang+Xing&family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet" />
    <style>
        .i-afu {
            display: none;
        }
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
        .fa-chevron-left {
            font-size: 20px;
            margin-top: 5vh;
            margin-left: 5vw;
        }
        .fa-edit {
            color: dodgerblue;
        }
        .fa-trash-alt {
            color: red;
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
            top: 108%;
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
            bottom: 42%;
        }
        .i-fu-div {
            display: inline-flex;
            align-items: center;
        }
        .i-upload-icon {
            font-size: 30px;
            position: absolute;
            bottom: 42%;
            right: 0%;
        }
        .i-fileUpload {
            display: none;
        }
        .i-btn-removeImg {
            position: absolute;
            bottom: 43%;
            right: 31%;
        }
        .i-img-preview {
            width: 30px;
            height: 30px;
            position: absolute;
            bottom: 42%;
            right: 15%;
            border: none;
        }
        .i-btn-item {
            display: none;
        }
        .i-rfv-category {
            position: absolute;
            bottom: 4%;
        }
        .i-rfv-item {
            position: absolute;
            top: 73%;
        }
        .i-rfv-price {
            position:absolute;
            top: 91%;
        }
        .i-rev-price {
            position:absolute;
            top: 91%;
        }
    </style>
    <script>
    </script>
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
        <asp:AsyncFileUpload ID="AsyncFileUpload1" CssClass="i-afu" runat="server" OnClientUploadComplete="uploadComplete" OnUploadedComplete="AsyncFileUpload1_UploadedComplete"/>
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
                            <asp:RequiredFieldValidator ID="rfvWorkplace" runat="server" Display="Dynamic" ValidationGroup="workplace" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="inputWorkplace"></asp:RequiredFieldValidator>
                        </div>
                        <input type="button" id="btnWorkplaceNext" name="next-step" class="next-step btn btn-block i-btn-workplace i-next-btn" value="Next" runat="server" /> 
                        <input type="button" id="btnAddWorkplace" class="btn btn-block i-wadd-btn" validationgroup="workplace" value="Add Workplace" runat="server" onserverclick="AddWorkplace" /> 
                        <input type="button" id="btnUpdateWorkplace" class="btn btn-block i-wadd-btn" validationgroup="workplace" value="Update & Proceed" runat="server" onserverclick="UpdateWorkplace" />
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
                                <input type="button" id="btnUpdateCategory" class="btn btn-block i-add-btn i-btn-category i-hidden" validationgroup="Category" value="Update Category" runat="server" onserverclick="UpdateCategory" />                          
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
                            <asp:RequiredFieldValidator ID="rfvCategory" CssClass="i-rfv-category" runat="server" Display="Dynamic" ValidationGroup="Category" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="inputCategory"></asp:RequiredFieldValidator>
                        </div>
                        <input type="button" id="btnCategoryNext" name="next-step" class="next-step btn btn-block i-btn-category i-next-btn" runat="server" value="Next"/>
                        <input type="button" name="previous-step" class="previous-step previous-linker" value="Previous Step"/>
                    </fieldset>
                    <fieldset>
                        <asp:UpdatePanel ID="updatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="i-title">What are the items that you provide?</div>
                                <div class="table-wrapper-scroll-y my-custom-scrollbar">
                                    <asp:Repeater ID="RptItems" runat="server" OnItemCommand="RpItem">  
                                        <HeaderTemplate>  
                                            <table class="table table-striped table-bordered">  
                                                <tr>  
                                                    <td><b>No.</b></td>  
                                                    <td><b>Category</b></td>  
                                                    <td><b>Item Name</b></td>  
                                                    <td><b>Price</b></td>  
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
                                                    <asp:Label CssClass="" ID="lblPrice" Text='<%#Eval("Price", "{0:C2}") %>' runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <img src='<%# PicturePath(sPath = "" + Eval("ItemImage") + "")%>' style="width: 50px; height: 50px" id="imgItemDisplay" alt="" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lbEditItem" onclick='<%# String.Format("javascript:return EditItem(\"{0}\", \"{1}\", \"{2}\")", Eval("ItemName").ToString(), Eval("Price", "{0:N2}").ToString(), Eval("ItemImage").ToString()) %>'><i class="far fa-edit"></i></asp:LinkButton>
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
                                <asp:Button ID="btnAddItem" CssClass="btn btn-block i-add-btn" OnClick="AddItem" ValidationGroup="Item" runat="server" Text="Add Item" />
                                <input type="button" id="btnUpdateItem" class="btn btn-block i-add-btn i-btn-item" validationgroup="Item" value="Update Item" runat="server" onserverclick="UpdateItem" />
                                <asp:FileUpload ID="ImageUpload" CssClass="i-fileUpload" runat="server" Font-Size="XX-Large" onchange="loadFile(event)" Height="100px" Width="100px" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAddItem" />
                                <asp:AsyncPostBackTrigger ControlID="btnUpdateItem" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <label class="i-output" id="lblOutput" runat="server"></label>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlCategory" CssClass="form-select form-select-sm i-category-ddl" runat="server"></asp:DropDownList>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:LinkButton ID="lbRemoveImg" CssClass="i-btn-removeImg" runat="server" OnClientClick="RemoveImg(); return false;"><i class="far fa-trash-alt"></i></asp:LinkButton>
                        <p><img src="" class="i-img-preview" id="imgItem" alt="" runat="server" /></p>
                        <i class="fa fa-camera i-upload-icon" onclick="document.getElementById('<%=AsyncFileUpload1.ClientID %>_ctl02').click();" ></i>
                        <div class="form-group" style="height: 12vh">
                            <label class="col-form-label-sm i-input-title2">Item Name</label>
                            <input class="form-control form-control-sm i-input-placeholder2 i-hidden" id="oldItem" runat="server" form="form1"/>
                            <input class="form-control form-control-sm i-input-placeholder2" id="inputItemName" placeholder="Eg: Roasted Chicken Rice" runat="server" form="form1"/>
                            <asp:RequiredFieldValidator ID="rfvItem" runat="server" CssClass="i-rfv-item" Display="Dynamic" ValidationGroup="Item" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="inputItemName"></asp:RequiredFieldValidator>
                            <label class="col-form-label-sm i-input-title">Price</label>
                            <input class="form-control form-control-sm i-input-placeholder" id="inputPrice" placeholder="Eg: 6.50" runat="server" form="form1"/>
                            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" CssClass="i-rfv-price" Display="Dynamic" ValidationGroup="Item" ErrorMessage="This field cannot be empty" ForeColor="Red" Font-Size="Small" ControlToValidate="inputPrice"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPrice" runat="server" CssClass="i-rev-price" Display="Dynamic" ValidationGroup="Item" ErrorMessage="Only numbers up to 2 decimals allowed" ForeColor="Red" Font-Size="Small" ValidationExpression="^([0-9]+([.][0-9]{1,2})?)?$" ControlToValidate="inputPrice" />
                        </div>
                        <input type="button" name="previous-step" class="previous-step previous-linkerB" value="Previous Step" />
                        <input type="button" id="btnSubmit" class="btn btn-block i-special-btn" runat="server" value="Next" onserverclick="ProceedToTemplate"/>
                    </fieldset>
                </div>
            </div>
  	    </div>
        <input id="inpImg" type="hidden" runat="server" />
        <input id="inpHid" type="hidden" runat="server" onkeyup='saveValue(this);'/>
        <input id="inpHid2" type="hidden" runat="server"/>
        <label id="lblPageTracker" class="i-hidden" runat="server" form="form1"></label>
        <label id="lblMedium" class="i-hidden" runat="server" form="form1"></label>
    </form>
</body>
<script>
    document.getElementById("inpHid").value = getSavedValue("inpHid");    // set the value to this input
    /* Here you can add more inputs to set value. if it's saved */

    //Save the value function - save it to localStorage as (ID, VALUE)
    function saveValue(e){
        var id = e.id;  // get the sender's id to save it . 
        var val = e.value; // get the value. 
        localStorage.setItem(id, val);// Every time user writing something, the localStorage's value will override . 
    }

    //get the saved value function - return the value of "v" from localStorage. 
    function getSavedValue  (v){
        if (!localStorage.getItem(v)) {
            return "";// You can change this to your defualt value. 
        }
        return localStorage.getItem(v);
    }
    $(document).ready(function () {
        console.log('The Script will load now.');
        var setToPage = document.getElementById('inpHid2').value;
        if (setToPage) {
            console.log('page set valid');
        }
        else {
            console.log('page set null');
        }
        console.log("set page: ", setToPage);
        if (setToPage == 3) {
            console.log('page set to: ', setToPage);
            setTimeout(function(){ SimulateClick("btnWorkplaceNext"); }, 500);
            setTimeout(function(){ SimulateClick("btnCategoryNext"); }, 500);
            //$(".i-btn-workplace").trigger('click');
            //$(".i-btn-category").trigger('click');
        }
        else if (setToPage == 2) {
            console.log('page set to: ', setToPage);
            setTimeout(function(){ SimulateClick("btnWorkplaceNext"); }, 500);
            //$(".i-btn-workplace").trigger('click');
        }
    });

    function SetToPage3() {
        console.log('page set to: ', setToPage);
        setTimeout(function(){ SimulateClick("btnWorkplaceNext"); }, 500);
        setTimeout(function(){ SimulateClick("btnCategoryNext"); }, 500);
    }
    function SetToPage2() {
        console.log('page set to: ', setToPage);
        setTimeout(function(){ SimulateClick("btnWorkplaceNext"); }, 500);
    }

    //window.onload = function exampleFunction() {
    //}

    function ClearTxtBox() {
        document.getElementById('inputCategory').value = "";
        document.getElementById('inputItemName').value = "";
        document.getElementById('inputPrice').value = "";
    }

    function UpdateCategory() {
        var newCategory = document.getElementById('inputCategory').value;
        console.log(newCategory);
        if (newCategory) {
            console.log('category edited');
            $("#btnCategoryNext").fadeIn();
            $("#btnAddCategory").fadeIn();
            $("#btnUpdateCategory").fadeOut();
            document.getElementById('inputCategory').value = "";
            alert("category successfully updated");
        }
    }

    function UpdateItem() {
        var newItem = document.getElementById('inputItemName').value;
        var newPrice = document.getElementById('inputPrice').value;
        var priceREGEX = /^[0-9]+([.][0-9]{1,2})?$/;
        var priceResult = priceREGEX.test(newPrice);
        //console.log(priceResult);
        if (newItem) {
            console.log('newItem true');
        }
        if (newItem && priceResult) {
            console.log('item edited');
            $("#btnAddItem").fadeIn();
            $("#btnSubmit").fadeIn();
            $("#btnUpdateItem").fadeOut();
            document.getElementById('inputItemName').value = "";
            document.getElementById('inputPrice').value = "";
            alert("item successfully udpated");
        }
    }

    function uploadComplete(sender, args) {
        var filename = args.get_fileName();
        $get("imgItem").src = "uploaded/" + filename;
    }

    function ClearImg() {
        $get("imgItem").src = "";
    }

    function RemoveImg() {
        $get("imgItem").src = "";
        document.getElementById('inpImg').value = "";
    }
    
    //Prevent page resizing from mobile keyboard
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width,height='+window.innerHeight+', initial-scale=1.0';
    document.getElementsByTagName('head')[0].appendChild(meta);
    
    var oldCategory;
    var oldItem;
    var oldPrice;
    
    function EditCategory(category) {
        oldCategory = category;
        document.getElementById('oldCategory').value = oldCategory;
        document.getElementById('inputCategory').value = oldCategory;
        console.log(oldCategory);
        console.log('editing category');
        $("#btnCategoryNext").fadeOut();
        $("#btnAddCategory").fadeOut();
        $("#btnUpdateCategory").fadeIn();
    }

    function EditItem(item, price, imgPath) {
        oldItem = item;
        oldPrice = price;
        if (imgPath) {
            console.log(imgPath);
            $get("imgItem").src = imgPath;
        }
        document.getElementById('inpImg').value = imgPath;
        document.getElementById('oldItem').value = oldItem;
        document.getElementById('inputItemName').value = oldItem;
        document.getElementById('inputPrice').value = oldPrice;
        console.log(oldItem);
        console.log(oldPrice);
        console.log('editing item');
        $("#btnAddItem").fadeOut();
        $("#btnSubmit").fadeOut();
        $("#btnUpdateItem").fadeIn();
    }
    
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
    var pageTracker = 1;
    console.log(pageTracker);

    $(".r-backBtn2").click(function (event) { //track the appearance of the 2nd back btn
        event.stopImmediatePropagation();
        var executed = false;
        if (!executed) {
            executed = true;
            if (pageTracker > 2) {
                $(".previous-linkerB").trigger('click');
                event.stopImmediatePropagation();
            }
            else if (pageTracker > 1) {
                $(".previous-linker").trigger('click');
                event.stopImmediatePropagation();
            }
            else {
                $(".r-backBtn").trigger('click');
            }
        }
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
            document.getElementById('inpHid2').value = pageTracker;
            var lblPage = document.getElementById('inpHid2').value;
            console.log("lblPage: ", lblPage);
            currentGfgStep = $(this).parent(); //
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
            pageTracker--;
            console.log(pageTracker);
            document.getElementById('inpHid2').value = pageTracker;
            var lblPage = document.getElementById('inpHid2').value;
            console.log("lblPage: ", lblPage);
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
</script>
</html>
