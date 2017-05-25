<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DragAndDropShoppingCartjQuery.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


<script src="jQuery.min.js" type="text/javascript"></script>
<script src="jQuery.ui.js" type="text/javascript"></script>
    <script src="jQuery-json.js" type="text/javascript"></script>
<style type="text/css">

.block 
{
    z-index:9999;
    cursor:move;
}

.productCode 
{
    
}


li
{
    list-style:none;
}

</style>

</head>





<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DataList ID="dlProducts" RepeatDirection="Horizontal" RepeatColumns="3" runat="server">
    <ItemTemplate>
    
    <div class="block" style="width:150px;background-color:lightgreen;padding:10px;margin:10px">
    
    <ul>
    <li>
    <%# Eval("Name") %>
    </li>

    <li>
     <%# Eval("Description") %>
    </li>

    <li class="productCode">
    <%# Eval("ProductCode") %>
    </li>

    <li>
    $<%# Eval("Price") %>
    </li>

    </ul>

 
    </div>

    </ItemTemplate>
    
    </asp:DataList>

    <div id="shoppingCart" style="width:300px; overflow:auto; height:300px;background-color:yellow;position:absolute;top:100px; left:700px;">
    <div id="header" style="text-align:center"><h3>Shopping Cart</h3></div>

    <div>
    <ul id="items">
    
    </ul>
    
    </div>

    </div>


    </div>
    </form>
</body>
</html>


<script language="javascript" type="text/javascript">

    function loadProductsFromUser() {

        var params = new Object();
        params.userName = "azamsharp";

        $.ajax(

        {
            type: "POST",
            data: $.toJSON(params),
            dataType: "json",
            contentType: "application/json",
            url: "AjaxService.asmx/GetProductByUserName",
            success: function (response) {

                var products = $.evalJSON(response.d);

                for (i = 0; i <= products.length; i++) {

                    var list = $("#items");
                    var div = document.createElement("div");
                    div.innerHTML = products[i].ProductCode;


                    // you can store more information about the product in the UserProducts table
                    // and then display it over here! 

                    $(list).append(div);                    
                }

            }

        });

    }


    $(document).ready(function () {


       // loadProductsFromUser();


        $(".block").draggable({ helper: 'clone' });

        // drag zone 

        $("#shoppingCart").droppable(

        {
            accept: ".block",
            drop: function (ev, ui) {

                var droppedItem = $(ui.draggable).clone(); 
                $(this).append(droppedItem);

                var productCode = jQuery.trim($(droppedItem).children("ul").children(".productCode").text());

                // ajax request to persist product for the user 

                var params = new Object();
                params.productCode = productCode;
                params.userName = "azamsharp";

                $.ajax(

                {
                    type: "POST",
                    data: $.toJSON(params),
                    contentType: "application/json",
                    url: "AjaxService.asmx/SaveProduct",
                    success: function (response) {

                    }

                });


            }
        }

        );


    });



</script>





