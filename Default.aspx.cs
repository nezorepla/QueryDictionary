using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public static string Decode(string xx)
    {
        string x;

        x = xx.Replace("&#39;", "'");
        x = x.Replace("&#34;", "\"");
        // x = x.Replace("&#60;", "<");
        return x;
    }



    [WebMethod]
    public static string TabloKolon(string name)
    {
        string query = string.Format("select *,'<button type=\"button\" onclick=\"btnClk2('''+UPPER(SEMA+'.'+TABLO)+''')\" class=\"tabloDetayLink\" >Detay</button>' DETAY  from QD_Dim_Tables where UPPER(SEMA+'.'+TABLO) = '{0}'", name);
        DataTable dt = PCL.MsSQL_DBOperations.GetData(query, "con");
        string val = "<div class=\"DetayCont Left\"><h3>" + name + "(" + dt.Rows.Count.ToString() + ")</h3>" + HTMLTableString(dt, "tabloDetayCont2", "tabloDetayCont2") + "</div>";
        return val;
    }

    [WebMethod]
    public static string TabloBilgi(string name)
    {
        string query = string.Format("select *,'<button type=\"button\" onclick=\"btnClk1('''+UPPER(SEMA+'.'+TABLO)+''')\" class=\"tabloDetayLink\" >Detay</button>' DETAY  from QD_Dim_Tables where UPPER(SEMA+'.'+TABLO) = '{0}'", name);
        DataTable dt = PCL.MsSQL_DBOperations.GetData(query, "con");
        string val = "<div class=\"DetayCont\"><h3>" + name + "(" + dt.Rows.Count.ToString() + ")</h3>" + HTMLTableString(dt, "tabloDetayCont2", "tabloDetayCont2") + "</div>";
        return val;
    }
    [WebMethod]
    public static string TabloQuery(string name)
    {
        string val = "";
        try
        {
            string query = string.Format("SELECT * FROM dbo.QD_Dim_Querys WHERE QUERY LIKE '%{0} %'", name);
            DataTable dt = PCL.MsSQL_DBOperations.GetData(query, "con");
            //     val = dt.Rows.Count.ToString();
            foreach (DataRow dr in dt.Rows)
            {

                val += "<Div><pre class=\"sql\"><H3>" + PCL.Utility.DBtoMT.ToString(dr["DSC"]) + "</h3>" + Decode(PCL.Utility.DBtoMT.ToString(dr["QUERY"])) + "</pre></Div>";

            }
        }
        catch (Exception e)
        {
            val = e.ToString();
        }
        return val;

    }



    [WebMethod]
    public static string[] GetCategory(string term)
    {
        string tablo = term.ToUpper().Replace("i", "I");

        List<string> retCategory = new List<string>();
        string ConnectionString = @"Data Source=.;Initial Catalog=COLLECTiON;  Integrated Security=SSPI;Connection Timeout=1200";
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("select top 10 UPPER(SEMA+'.'+TABLO) AS VAL   from QD_Dim_Tables where UPPER(SEMA+'.'+TABLO) Like '%{0}%'", tablo);
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    retCategory.Add(reader.GetString(0));
                }
            }
            con.Close();
        }
        return retCategory.ToArray();
    }


    public static string HTMLTableString(DataTable dt, string id, string css)
    {
       

        String RVl = "";
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table id=\"" + id + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\"  class=\"" + css + "\"  ><thead><tr>");
            foreach (DataColumn c in dt.Columns)
            {
                sb.AppendFormat("<th  scope=\"col\">{0}</th>", c.ColumnName);
            }
            sb.AppendLine("</tr></thead><tbody>");
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<tr>"); foreach (object o in dr.ItemArray)
                {
                    sb.AppendFormat("<td>{0}</td>", o.ToString());
                    //System.Web.HttpUtility.HtmlEncode());
                } sb.AppendLine("</tr>");
            } sb.AppendLine("</tbody></table>");
            RVl = sb.ToString();
        }
        catch (Exception ex)
        {
            RVl = "HATA @ConvertDataTable2HTMLString: " + ex;//  Page.ClientScript.RegisterStartupScript(typeof(Page), "bisey3", "alert('bunu Alper Özen e gönderiniz\n" + strM + "\n" + ex.ToString() + "');", true);
        }
        return RVl;
    }

}