using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class AddQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public static string Encode(string xx)
    {
        string x;

        x = xx.Replace("'", "&#39;").ToUpper();
        x = x.Replace("\"", "&#34;");
        x = x.Replace("<", "&#60;");
        x = x.Replace("İ", "I");
        return x;
    }
    public static string Decode(string xx)
    {
        string x;

        x = xx.Replace("&#39;", "'");
        x = x.Replace("&#34;", "\"");
        x = x.Replace("&#60;", "<");
        return x;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

//        CREATE TABLE [dbo].[QD_Dim_Querys](
//    [INTCODE] [int] IDENTITY(1,1) NOT NULL,
//    CREATOR VARCHAR(15),
//    DT DATETIME,
//    DSC VARCHAR(MAX),
//    QUERY TEXT	
//) ON [PRIMARY]
        string user = "A25318";
        string query = txtQuery.Text.ToString();
        string dsc = txtDsc.Text.ToString();
        string sql = string.Format("insert into QD_Dim_Querys(CREATOR,DT,DSC,QUERY) VALUES ( '" + user + "',GETDATE(),'" + dsc  + "','{0}')", Encode(query));

        PCL.MsSQL_DBOperations.ExecuteSQLStr(sql, "con");
        
        
        string query2 = string.Format("SELECT * FROM dbo.QD_Dim_Querys WHERE DSC= '{0}'", dsc);
        DataTable dt = PCL.MsSQL_DBOperations.GetData(query2, "con");
        string val = "";
        foreach (DataRow dr in dt.Rows)
        {

            val += "<Div><H3>--" + PCL.Utility.DBtoMT.ToString(dr["DSC"]) + "</h3><pre class=\"sql\">" + Decode(PCL.Utility.DBtoMT.ToString(dr["QUERY"])) + "</pre></Div>";

        }
        lblQuery.Text = val;

        txtQuery.Text = "";
        txtDsc.Text = "";

    }
}
