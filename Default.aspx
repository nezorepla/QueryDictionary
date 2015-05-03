<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Query Dictionary</title>
    <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css"
        rel="stylesheet" type="text/css" />
    <%--<link href="//steamdev.com/snippet/css/jquery.snippet.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

    <script type="text/javascript" src="//steamdev.com/snippet/js/jquery.snippet.js"></script>

    <script type="text/javascript">
  


        $(document).ready(function () {
       
            $("#txtAutoComplete").autocomplete({
                minLength: 2,
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/GetCategory",
                        data: "{'term':'" + $("#txtAutoComplete").val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (xhr, status, error) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        }
                    });
                }
                ,
                select: function (event, ui) {

                    $("#column").html(""); $(".description_SQL").html(""); ShowTableDesc(ui.item.label);
                    return false;
                }
            });

            //$("pre").snippet("sql",{style:"dull",startText:true});



        });

        function ShowTableDesc(d) {
            $("#txtAutoComplete").val(d);

            $.ajax({
                type: "POST",
                url: "Default.aspx/TabloBilgi",
                data: '{name: "' + d + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    //  $(".description").html(response.d); 
                }
            });
            $(".description").html("oluyo");

        }
        function OnSuccess(response) {
            //  alert(response.d);
            $(".description").html(response.d);
        }

        function btnClk1(tbl) {
            $("#column").html("OLUYOR");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/TabloKolon",
                data: "{'name':'" + tbl + "'}",
                dataType: "json",
                success: function (data) {
                    $("#column").html(data.d);
                    //$("pre.sql").snippet("sql");
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
        function btnClk2(tbl) {
            $(".description_SQL").html("OLUYOR");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/TabloQuery",
                data: "{'name':'" + tbl + "'}",
                dataType: "json",
                success: function (data) {
                    $(".description_SQL").html(data.d);
                    $("pre.sql").snippet("sql", { style: "ide-msvcpp", showNum: true });
                },
                error: function (result) {
                    alert("Error");
                }
            });

        }


    </script>
    <style>
        body {
            background-color: #284E59;
        }

        input {
            background-color: #F8F8F8;
            border: 1px solid #300;
            margin-right: 15px;
        }

            input[type=text] {
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

        .DetayCont {
            background-color: #F8F8F8;
            border: 1px solid #3300dd;
            padding: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
        }

        .Left {
            padding: 1em;
            line-height: 1.8em;
            overflow: auto;
            position: relative;
            -moz-border-radius: 15px;
            -webkit-border-radius: 15px;
            border-radius: 15px;
            box-shadow: 2px 2px 5px #000;
            -moz-box-shadow: 2px 2px 5px #000;
            -webkit-box-shadow: 2px 2px 5px #000;
            margin-top: 12px;
        }

        .auto-style1 {
            width: 300px;
        }
        /*---------- ide-msvcpp Styles ---------*/
        .sh_ide-msvcpp {
            background: none;
            padding: 0;
            margin: 0;
            border: 0 none;
        }

            .sh_ide-msvcpp .sh_sourceCode {
                background-color: #fff;
                color: #000;
                font-weight: normal;
                font-style: normal;
            }

                .sh_ide-msvcpp .sh_sourceCode .sh_keyword {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_type {
                    color: #00f;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_string {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_regexp {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_specialchar {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_comment {
                    color: #008000;
                    font-weight: normal;
                    font-style: italic;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_number {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_preproc {
                    color: #00f;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_function {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_url {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_date {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_time {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_file {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_ip {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_name {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_variable {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_oldfile {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_newfile {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_difflines {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_selector {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_property {
                    color: #00f;
                    font-weight: bold;
                    font-style: normal;
                }

                .sh_ide-msvcpp .sh_sourceCode .sh_value {
                    color: #000;
                    font-weight: normal;
                    font-style: normal;
                }

        /*-------- Snippet Base Styles ----------*/
        .snippet-wrap {
            position: relative;
        }

        *:first-child + html .snippet-wrap {
            display: inline-block;
        }

        * html .snippet-wrap {
            display: inline-block;
        }

        .snippet-reveal {
            text-decoration: underline;
        }

        .snippet-wrap .snippet-menu, .snippet-wrap .snippet-hide {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: .9em;
            z-index: 1;
            background-color: transparent;
        }

        .snippet-wrap .snippet-hide {
            top: auto;
            bottom: 10px;
        }

        *:first-child + html .snippet-wrap .snippet-hide {
            bottom: 25px;
        }

        * html .snippet-wrap .snippet-hide {
            bottom: 25px;
        }

            .snippet-wrap .snippet-menu pre, .snippet-wrap .snippet-hide pre {
                background-color: transparent;
                margin: 0;
                padding: 0;
            }

            .snippet-wrap .snippet-menu a, .snippet-wrap .snippet-hide a {
                padding: 0 5px;
                text-decoration: underline;
            }

        .snippet-wrap pre.sh_sourceCode {
            padding: 1em;
            line-height: 1.8em;
            overflow: hidden;
            position: relative;
            -moz-border-radius: 15px;
            -webkit-border-radius: 15px;
            border-radius: 15px;
            box-shadow: 2px 2px 5px #000;
            -moz-box-shadow: 2px 2px 5px #000;
            -webkit-box-shadow: 2px 2px 5px #000;
        }

        .snippet-wrap pre.snippet-textonly {
            padding: 2em;
        }

        *:first-child + html .snippet-wrap pre.snippet-formatted {
            padding: 2em 1em;
        }

        * html .snippet-wrap pre.snippet-formatted {
            padding: 2em 1em;
        }

        .snippet-reveal pre.sh_sourceCode {
            padding: .5em 1em;
            text-align: right;
        }

        .snippet-wrap .snippet-num li {
            padding-left: 1.5em;
        }

        .snippet-wrap .snippet-no-num {
            list-style: none;
            padding: .6em 1em;
            margin: 0;
        }

            .snippet-wrap .snippet-no-num li {
                list-style: none;
                padding-left: 0;
            }

        .snippet-wrap .snippet-num {
            margin: 1em 0 1em 1em;
            padding-left: 3em;
        }

            .snippet-wrap .snippet-num li {
                list-style: decimal-leading-zero outside none;
            }

        .snippet-wrap .snippet-no-num li.box {
            padding: 0 6px;
            margin-left: -6px;
        }

        .snippet-wrap .snippet-num li.box {
            border: 1px solid;
            list-style-position: inside;
            margin-left: -3em;
            padding-left: 6px;
        }

        *:first-child + html .snippet-wrap .snippet-num li.box {
            margin-left: -2.4em;
        }

        * html .snippet-wrap .snippet-num li.box {
            margin-left: -2.4em;
        }

        .snippet-wrap li.box-top {
            border-width: 1px 1px 0 !important;
        }

        .snippet-wrap li.box-bot {
            border-width: 0 1px 1px !important;
        }

        .snippet-wrap li.box-mid {
            border-width: 0 1px !important;
        }

        .snippet-wrap .snippet-num li .box-sp {
            width: 18px;
            display: inline-block;
        }

        *:first-child + html .snippet-wrap .snippet-num li .box-sp {
            width: 27px;
        }

        * html .snippet-wrap .snippet-num li .box-sp {
            width: 27px;
        }

        .snippet-wrap .snippet-no-num li.box {
            border: 1px solid;
        }

        .snippet-wrap .snippet-no-num li .box-sp {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td class="auto-style1" valign="middle">
                    <input type="text" id="txtAutoComplete" css="txtAutoComplete" />
                </td>
                <td style="width: 800px">
                    <asp:Label ID="Label1" CssClass="description" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" valign="top"><span id="column"></span>
                </td>
                <td>
                    <asp:Label ID="Label2" CssClass="description_SQL" runat="server" Width="800px"></asp:Label>
                </td>
            </tr>
        </table>
        <%--
     CREATE TABLE [dbo].[QD_Dim_Tables](
        [INTCODE] int identity(1,1),
        [SEMA] [varchar](10) NULL,
        [TABLO] [varchar](50) NULL,
        [ACIKLAMA] [varchar](250) NULL	
    ) ON [PRIMARY]

    INSERT INTO QD_Dim_Tables (SEMA,TABLO,ACIKLAMA) VALUES('EDW','IND','AÇIKLAMA')
    INSERT INTO QD_Dim_Tables (SEMA,TABLO,ACIKLAMA) VALUES('EDW','CUST','AÇIKLAMA2')
    INSERT INTO QD_Dim_Tables (SEMA,TABLO,ACIKLAMA) VALUES('EDW','CUSTOMER','BAŞKA AÇIKLAMA2')--%>
    </form>
</body>
</html>
