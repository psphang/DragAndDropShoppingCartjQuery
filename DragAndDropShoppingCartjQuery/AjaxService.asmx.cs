using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DragAndDropShoppingCartjQuery
{
   
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AjaxService : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetProductByUserName(string userName)
        {
            using(var db = new MyShopDataContext())
            {
                var products = from p in db.UserProducts
                               where p.UserName.Equals(userName)
                               select p;

                return new JavaScriptSerializer().Serialize(products); 
            }
        }

        [WebMethod]
        public void SaveProduct(string productCode, string userName)
        {
            productCode = productCode.Replace(" ", String.Empty); 

            using(var db = new MyShopDataContext())
            {
                var userProduct = new UserProduct();
                userProduct.ProductCode = productCode;
                userProduct.UserName = userName;

                db.UserProducts.InsertOnSubmit(userProduct); 
                db.SubmitChanges();
            }
        }
    }
}
