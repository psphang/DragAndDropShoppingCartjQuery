using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DragAndDropShoppingCartjQuery
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            using(var db = new MyShopDataContext())
            {
                dlProducts.DataSource = from d in db.Products
                                        select d;
                dlProducts.DataBind(); 
            }
        }
    }
}