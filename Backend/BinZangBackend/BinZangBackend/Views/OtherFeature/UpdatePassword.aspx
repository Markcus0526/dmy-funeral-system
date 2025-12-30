<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>修改密码
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:700px; height:250px;">
                      <tr>   </tr>
                       <tr><td align="right" style="width:100px;">输入账号：</td><td> <input id="name" onblur="namefind()" style="width:220px; height:30px;" /></td><td><input id="Text1" readonly="readonly" style="width:220px; height:30px; color:Red; display:none; border:0px solid #ffffff" value="* 查无此账号"/></td></tr>
                       <tr><td align="right" style="width:100px;">输入电话：</td><td> <input id="phone" disabled="disabled" style="width:220px; height:30px;"/></td></tr>
                       <tr><td align="right" style="width:100px;">输入真实姓名：</td><td><input id="real_name" disabled="disabled" style="width:220px; height:30px;"/></td></tr>
                       <tr><td align="right" style="width:100px;">输入新密码：</td><td> <input id="newpassword" style="width:220px; height:30px;"/></td></tr>
                       <tr><td align="right" style="width:100px;">确认新密码：</td><td> <input id="checknew" onblur="checknew1()" style="width:220px; height:30px;"/></td><td><input id="Text2" readonly="readonly" style="width:220px; height:30px; color:Red; display:none; border:0px solid #ffffff" value="* 新密码与确认密码不匹配"/></td>  </tr>
                       <tr><td style="width:300px;">  
                       <input id="user_id" style=" display:none"/>
                       <button class="btn btn-success loading-btn" id="sub" onclick="updatepassword()" style="margin-top:10px;margin-left:200px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                      </table>
                           
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
         <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>
<script>
var flag1=false;
var flag2=false;
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
        }
        initTable1();

    });
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
    });

    function namefind() {
    var name =$("#name").val();
          $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/FindInfoByName",
                data:{"name":name},
                method:'post',
                success: function (data) {
                if (data.status==0)
                {
                   $("#phone").val(data.info.phone);
                $("#real_name").val(data.info.realname);
                $("#user_id").val(data.info.uid);
                flag1=true;
                document.getElementById("Text1").style.display="none";
                }else{
                flag1=false;
                   document.getElementById("Text1").style.display="block";
                }
             
                }
            }); 
    }

    function checknew1(){
     var newpassword =$("#newpassword").val();
      var checknew =$("#checknew").val();
      if (checknew==newpassword)
      {
        flag2=true;
        document.getElementById("Text2").style.display="none";
      }else{
         flag2=false;
        document.getElementById("Text2").style.display="block";
      }
    }
    function updatepassword(){
     var newpassword =$("#newpassword").val();
    if (flag2==true&&flag1==true&&newpassword!="")
    {
      $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/EditPassword",
                data:{"password":$("#newpassword").val(),"id":$("#user_id").val()},
                method:'post',
                success: function (data) {
             if (data=="success")
                     {
                     toas1("修改成功");
                      setTimeout(function(){
                           location.href="<%= ViewData["rootUri"] %>OtherFeature/UpdatePassword";
                             },3000);
                     }else
                     {
                     toas2(data);
                     }
                }
            }); 
    }
    else
    {
       toas2("请填写修改密码！");
    }
    }
     function toas1(massage) {
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
          toastr["success"](massage, "温馨提示");
      }
      function toas2(massage) {
          toastr.options = {
              "closeButton": false,
              "debug": true,
              "positionClass": "toast-bottom-left",
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

          toastr["error"](massage, "温馨提示");
      }
</script>

</asp:Content>
