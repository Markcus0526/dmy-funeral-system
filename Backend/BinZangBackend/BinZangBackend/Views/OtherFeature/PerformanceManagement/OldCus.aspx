<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div style="width:800px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                            <form id="Form1" runat="server" onsubmit="return false;">
                            <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="90%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>承办人：</label>
                                    </td>
                                    <td>
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px">                                              	  
                                                          <input id="chengbanren" type="text" class="activityname" name="activityname"/>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">承办人电话：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                           <input type="text"  id="chengphone"/> 
                                     </div> 
                                    </td>
                                </tr>
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
                                                          <input id="buyname" type="text" class="activityname"  value="<%=ViewData["name"] %>" readonly="readonly"/>
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
                                           <input type="text" id="buyphone"value="<%=ViewData["phone"] %>" readonly="readonly" /> 
                                      </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>墓区：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                         <select class="select2" id="muqu" onchange="muquselect(this.value)">   
                                            <option value="0" selected="selected">请选择</option>
                                            <% for (int i = 0; i < ViewBag.ylist.Count; i++)
                                            { %>
                                             <option value="<%=ViewBag.ylist[i].uid %>"><%=ViewBag.ylist[i].name %></option>
                                           <%}%>
                                        </select>
                                   </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>排号：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                        <select class="select2" style="width:150px;" id="pai" onchange="paiselect(this.value)">
                                            <option value="0" >请选择</option> 
                                        </select>   
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>号码：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                        <select class="select2" style="width:150px;" id="hao">
                                            <option value="0" >请选择</option> 
                                        </select>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>关系：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text" id="guanxi1" />  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>末者1：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text"  id="mozhe1"/>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>生日1：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input class="date-picker" id="shengri1" name="endtime" type="text" data-date-format="yyyy-mm-dd"   />
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>忌日1：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input class="date-picker" id="jiri1" name="endtime" type="text" data-date-format="yyyy-mm-dd"   />
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>关系2：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text" id="guanxi2" />  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>末者2：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text"  id="mozhe2"/>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>生日2：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input class="date-picker" id="shengri2" name="endtime" type="text" data-date-format="yyyy-mm-dd"   />

                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>忌日2：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                         <input class="date-picker" id="jiri2" name="endtime" type="text" data-date-format="yyyy-mm-dd"   />

                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>购买日期：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input class="date-picker" id="buytime" name="buytime" type="text" data-date-format="yyyy-mm-dd"   /> 
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>牌价：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text"  id="paijia"/>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>成交价格：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <input type="text"  id="chengjiaojia"/>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                    
                                        <input id="text1" readonly="readonly" style="margin-top:-8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:200px;color: Red" />
                                        <button class="btn btn-success loading-btn" id="sub" style="margin-top:10px;margin-left:10px" onclick="baocungoumai()">
								            <i class="ace-icon fa fa-check bigger-110"></i>保存
							            </button>
                                        &nbsp;
                                       <button id="sett" class="btn" type="reset" style="margin-top:10px;margin-left:10px">
								            <i class="ace-icon fa fa-undo bigger-110"></i>重置
							           </button>
                           
                                    </td>
                                </tr>
                            </table>
                            </form>
                             <br />
</div>
 <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
 <script type="text/javascript">  
    function baocungoumai(){
    
                             toastr.options = {
                                    "closeButton": false,
                                    "debug": true,
                                    "positionClass": "toast-bottom-left",
                                    "onclick": null,
                                    "showDuration": "3",
                                    "hideDuration": "3",
                                    "timeOut": "2000",
                                    "extendedTimeOut": "2000",
                                    "showEasing": "swing",
                                    "hideEasing": "linear",
                                    "showMethod": "fadeIn",
                                    "hideMethod": "fadeOut"
                                };
     var rootUri ="<%= ViewData["rootUri"] %>";
    var chengbanren = $('#chengbanren').val();
    var chengphone = $('#chengphone').val();
    var buyname = $('#buyname').val();
    var buyphone =$('#buyphone').val();
    var muqu = $('#muqu').val();
    var pai =$('#pai').val();
    var hao = $ ('#hao').val();
    var guanxi1 = $('#guanxi1').val();
    var mozhe1 = $('#mozhe1').val();
    var shengri1 = $('#shengri1').val();
    var jiri1 = $('#jiri1').val();
    var guanxi2 = $('#guanxi2').val();
    var mozhe2 = $('#mozhe2').val();
    var shengri2 = $('#shengri2').val();
    var jiri2 = $('#jiri2').val();
    var paijia = $('#paijia').val();
    var chengjiaojia =$('#chengjiaojia').val();
    var buytime =$('#buytime').val();
    var can ="0";
    if (chengbanren==""||chengphone==""||buyname==""||buyphone==""||muqu=="0"||pai=="0"||hao=="0"||paijia==""||chengjiaojia==""||buytime=="") {
    alert("基本信息不能为空！");
    }else{
    if (guanxi1!=""||mozhe1!=""||shengri1!=""||jiri1!="") {
       if (guanxi1==""||mozhe1==""||shengri1==""||jiri1=="") {
       
       alert("请补充完整亲人1信息！");
       }else{
          if (guanxi2!=""||mozhe2!=""||shengri2!=""||jiri2!="") {
       if (guanxi2==""||mozhe2==""||shengri2==""||jiri2=="") {
       
       alert("请补充完整亲人2信息！");
       }else{
       can="1";

       }
    }else{
    can="1";
    }

       }
    }else{
           if (guanxi2!=""||mozhe2!=""||shengri2!=""||jiri2!="") {
      
       alert("请先填写亲人1的信息");
     
       }else{
       can="1";

       }
    }
    
    }
    //alert(can);
    if (can=="1") {
    alert("可以提交！");
       $.ajax({
              url: rootUri+"PerformanceManagement/AddYeji",
             data: { "chengbanren":chengbanren, "chengphone":chengphone, "buyname": buyname, "buyphone": buyphone, "muqu":muqu, "pai":pai, "hao": hao, "guanxi1":guanxi1,"mozhe1":mozhe1, "shengri1":shengri1,"jiri1":jiri1,"guanxi2": guanxi2, "mzohe2":mozhe2, "shengri2":shengri2,"jiri2":jiri2,"buytime":buytime,"paijia":paijia, "chengjiaojia":chengjiaojia},
                                 dataType: "json",
                                 method: 'post',
                                 success: function (jsonObject) {
                                   if (jsonObject == "ok") {
                            toastr["success"]("操作成功！");
                        } else { toastr["error"](jsonObject); }
                          setTimeout(' window.location.reload()',3000);
                                }
                            });
    }
    }


      jQuery(document).ready(function () {
                $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
      });
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });

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
                                document.getElementById("pai").value = 0;        
                                $("#pai").select2({ allowClear: true, minimumResultsForSearch: -1 });
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
              document.getElementById("hao").value = 0;
              $("#hao").select2({ allowClear: true, minimumResultsForSearch: -1 });
         
              }
             });

       }
 </script>

</asp:Content>



    

    
