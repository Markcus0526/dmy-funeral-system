<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div style="width:600px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                          
                             <form class="form-horizontal" role="form" id="validation-form">
                            <table cellpadding="0" style="margin-top:20px;height:800px" cellspacing="0"width="93%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                     <label>园区名称：</label>
                                    </td>
                                    <td>
                                        
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px"> 
                                                         <div class="clearfix">                                             	  
                                                        <select class="select2" style="width:40%" id="zonename"  name="zonename" onchange="setqu(this.value)">
                                                       <option value="0" >请选择</option>
                                                       <%
                                                           for (int i = 0; i < ViewBag.zone.Count; i++)
                                                      {   
                                                           %>
                                                       <option value="<%=ViewBag.zone[i].uid %>" ><%=ViewBag.zone[i].name%></option>
                                                       <% }%>
                                           </select> 
                                                          </div>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">园区号：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                           <select class="select2" style="width:40%" id="quyu"  name="quyu" onchange="setpailie(this.value)">
                                                             <option value="0" >请选择</option>
                                                          </select> 
                                           
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                     <label>牌位排号：</label>
                                    </td>
                                    <td>
                                        
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px"> 
                                                         <div class="clearfix">                                             	  
                                                          <select class="select2" style="width:40%" id="cpai"  name="cpai" onchange="setsize()">
                                                             <option value="0" >请选择</option>
                                                          </select> 
                                                          </div>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                     <label>牌位列号：</label>
                                    </td>
                                    <td>
                                        
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px"> 
                                                         <div class="clearfix">                                             	  
                                                          <select class="select2" style="width:40%" id="clie"  name="clie" onchange="setsize()">
                                                       <option value="0" >请选择</option>
                                                          </select>
                                                          </div>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">牌位编号：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                          <input id="cnum" type="text" readonly class="cnum" name="cnum" placeholder="请选择区、排、列" />  
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">牌位价格：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                           <input id="price" type="text" class="price" name="price" style="width:100px"/>元
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                   <div style="margin-left:110px">
                  <input id="text1" readonly="readonly" style="margin-top:10px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:50px;color: Red" />
                </div> 
                                        <button class="btn btn-success loading-btn" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-check bigger-110"></i>
								保存
							</button>
                            &nbsp;
                                       <button id="sett" class="btn" type="reset" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								重置
							</button>
                           
                                    </td>
                                </tr>
                            </table>
                            </form>
                             <br />
                        </div>
 </div>
<script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>                        
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo&amp;services=&amp;t=20150330161927"></script>
 <script type="text/javascript" src="<%=ViewData["rootUri"] %>Content/js/baidumap.js"></script>
<script>
var rootUri="<%=ViewData["rootUri"] %>";
function setpailie(id)
{
    $("#cnum").val("");
    document.getElementById("cpai").options.length = 0;
    document.getElementById("clie").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqupai",
                    data: { 
                    "quname": id,
                    "zonename":$("#zonename").val()
                     },
                    method: 'post',
                    success: function (data) {
                      
                                   $("#cpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   $("#clie").append("<option value=" + "0" + ">" + "请选择" + "</option>");

                                   for (var i=1;i<=data[0];i++) {
                                    
                                        $("#cpai").append("<option value=" + i + ">" + i + "排</option>");
                                    
                                   
                                   }
                                   for (var i=1;i<=data[1];i++) {
                                    
                                        $("#clie").append("<option value=" + i + ">" + i + "列</option>");
                                    
                                   
                                   }
                                   
                        $("#cpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                        $("#clie").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                       }
                });
            } else {
               $("#cpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
               $("#clie").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#cpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
               $("#clie").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
              
           }
}
function setqu(id)
{
    $("#cnum").val("");
    document.getElementById("quyu").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqu",
                    data: { 
                       "quname": id
                       
                     },
                    method: 'post',
                    success: function (data) {
                                    $("#quyu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var s in data) {
                                   
                                        $("#quyu").append("<option value=" + data[s]+ ">" + data[s] + "</option>");
                                   
                                }
                       
                        $("#quyu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
               
               $("#quyu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#quyu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
           }
           setpailie($("#quyu").val());
}
function setsize()
{ 
   var zoneid=$("#zonename").val();
   var cpai= $("#cpai").val();
   var clie= $("#clie").val();
   var quyu= $("#quyu").val();
   if(zoneid!=0&&zoneid!=null&&cpai!=0&&cpai!=null&&clie!=0&&clie!=null&&quyu!=null&&quyu!=0)
   {
     $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/GetOneZone",
                    data: { "uid": zoneid },
                    method: 'post',
                    success: function (data) {
                       $("#cnum").val(data.name+quyu+cpai+"排"+clie+"列");
                                   
                    }
                });
   }
   else
   {
      $("#cnum").val("");
      toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				        toastr["error"]("请选择园区排数列数!", "温馨敬告");
   }
   
   
}
$(document).ready(function() {
    $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
    
           
             });
      jQuery(function ($) {
            $.validator.messages.remote = "这个办事处可能已经存在！";
	        $.validator.messages.required = "必须要填写";
            $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                zonename: {
	                    required: true
	                },
                    cpai: {
	                    required: true
	                },
                    clie: {
	                    required: true
	                },
                    cnum: {
	                    required: true
	                },
                    quyu: { 
                        required: true
	                },
                    price: {
	                    required: true
	                }
	            },  
	            highlight: function (e) {
	                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
	            },

	            success: function (e) {
	                $(e).closest('.form-group').removeClass('has-error'); //.addClass('has-info');
	                $(e).remove();
	            },

	            errorPlacement: function (error, element) {
	                if (element.is(':checkbox') || element.is(':radio')) {
	                    var controls = element.closest('div[class*="col-"]');
	                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
	                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
	                }
	                else if (element.is('.select2')) {
	                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
	                }
	                else if (element.is('.chosen-select')) {
	                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
	                }
	                else error.insertAfter(element.parent());
	            },

	            submitHandler: function (form) {
	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	               
	            }
          });
	        
    });
      function check2(){
           var re = /^[1-9]+[0-9]*]*$/;
           var price=$("#price").val();
                if (re.test(price)) {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入标准金额！");
                return false;
              }
      }
        function submitform() {
        if(check2()==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/InserVren",
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                            toas1();
                            setTimeout(function(){
                                window.location.href="<%= ViewData["rootUri"] %>ZoneInformation/CemeteryManagement";
                            }, 2500);

				    } else {
				        toas2();
				    }
				},
				error: function (data) {
				    alert("Error: " + data.status);
				    $('.loading-btn').button('reset');
				}
			});
            }
        }
        function toas1() {
           toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				        toastr["success"]("新增成功!", "恭喜您");
        }
         function toas2() {
           toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
				            "onclick": null,
				            "showDuration": "3",
				            "hideDuration": "3",
				            "timeOut": "1500",
				            "extendedTimeOut": "1000",
				            "showEasing": "swing",
				            "hideEasing": "linear",
				            "showMethod": "fadeIn",
				            "hideMethod": "fadeOut"
				        };

				        toastr["error"]("新增失败!", "温馨敬告");
        }
</script>

</asp:Content>


