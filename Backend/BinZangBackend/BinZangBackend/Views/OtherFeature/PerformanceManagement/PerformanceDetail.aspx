<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div style="width:800px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                            <form id="Form1" runat="server" onsubmit="return false;">
                            <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="90%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                          
                               
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>购买人：</label>
                                    </td>
                                    <td>
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px">                                              	  
                                                          <input id="buyname" type="text" class="activityname" />
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">购买人电话：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                           <input type="text" id="buyphone"  /> <a id="searchdata" class="btn btn-sm btn-success" onclick="YanZheng()" style="margin-left:10%"><i class="fa fa-check-circle-o"></i>旧客户验证</a>
                                      </div> 
                                    </td>
                                </tr>
                            
                        
                            </table>
                            </form>
                             <br />
                        </div>
                        <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
 <script type="text/javascript">  
jQuery(document).ready(function () {
    $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
    });
function YanZheng(){
var cname = $('#buyname').val();
var cphone = $('#buyphone').val();
//alert("name:"+cname+",phone:"+cphone);
 var rootUri ="<%= ViewData["rootUri"] %>";
    $.ajax({
        url: rootUri+"PerformanceManagement/ValidClient",
        data: { "name":cname,"phone":cphone},
        dataType: "json",
        method: 'post',
        success: function (jsonObject) {
      alert(jsonObject);
      if (jsonObject=="yes") {
      window.location.href="OldCus?name="+cname+"&&phone="+cphone;
      }else{

      alert("这里应该跳转到添加旧客户页面！");
      }
      
        }



    });

}
function muquselect(muid) {
       document.getElementById("pai").options.length = 1;
         document.getElementById("hao").options.length = 1;
         document.getElementById("hao").value = 0;
            $("#hao").select2({ allowClear: true, minimumResultsForSearch: -1 });
 var rootUri ="<%= ViewData["rootUri"] %>";
    $.ajax({
        url: rootUri+"PerformanceManagement/GetPai",
        data: { "yuanid": muid},
        dataType: "json",
        method: 'post',
        success: function (jsonObject) {
            for (var s in jsonObject) {


                $("#pai").append("<option value=" + jsonObject[s].row_number + ">" + jsonObject[s].row_number + "</option>");
            }
            //  document.getElementById("bkind").value=2;
            document.getElementById("pai").value = 0;
            //document.getElementById("bname").value=0;

            //  document.getElementById("tablename").value=0;
            //$("#bkind").select2({ allowClear: true,minimumResultsForSearch: -1 });
            $("#pai").select2({ allowClear: true, minimumResultsForSearch: -1 });
            // $("#bname").select2({ allowClear: true,minimumResultsForSearch: -1 });
           
            //  $("#tablename").select2({ allowClear: true,minimumResultsForSearch: -1 });
        }



    });

    }
    function paiselect(paiid) {
    var muid = $('#muqu').val();
       document.getElementById("hao").options.length = 1;
       var rootUri ="<%= ViewData["rootUri"] %>";
       $.ajax({
            url: rootUri+"PerformanceManagement/GetHao",
            data: { "yuanid": muid,"paiid":paiid},
            dataType: "json",
            method: 'post',
            success: function (jsonObject) {
            for (var s in jsonObject) {


                $("#hao").append("<option value=" + jsonObject[s].number + ">" + jsonObject[s].number + "</option>");
            }
            //  document.getElementById("bkind").value=2;
            document.getElementById("hao").value = 0;
            //document.getElementById("bname").value=0;

            //  document.getElementById("tablename").value=0;
            //$("#bkind").select2({ allowClear: true,minimumResultsForSearch: -1 });
            $("#hao").select2({ allowClear: true, minimumResultsForSearch: -1 });
            // $("#bname").select2({ allowClear: true,minimumResultsForSearch: -1 });
           
            //  $("#tablename").select2({ allowClear: true,minimumResultsForSearch: -1 });
        }



    });

    }
 </script>

</asp:Content>



    

    
