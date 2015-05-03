<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddQuery.aspx.cs" Inherits="AddQuery" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Query</title>
      <style>
        body
        {
            background-color: #284E59;
        }
        input
        {
            background-color: #F8F8F8;
            border: 1px solid #300;
            margin-right: 15px;
        }
        input[type=text]
        {
            background-color: #F8F8F8;
            border: 1px solid #330000;
            line-height: 1.8;
            margin-right: 15px;
            padding: 5px;
            height: 24px;
            width: 300px;
            padding: 5px 10px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
        }
        .tabloDetayCont
        {
            background-color: #F8F8F8;
            border: 1px solid #3300dd;
            padding: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
        }
    </style>
     <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css"
        rel="stylesheet" type="text/css" />
    <link href="//steamdev.com/snippet/css/jquery.snippet.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txtDsc" runat="server" Height="16px" Width="401px" ></asp:TextBox>
            <br />
        <br />
            <asp:TextBox ID="txtQuery" runat="server"  TextMode="MultiLine" 
            Height="84px" Width="401px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
        
    </div><asp:Label ID="lblQuery" runat="server" Text="Label"></asp:Label>
    </form>
</body>
</html>
