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
								<i class="fa  fa-university"></i>游戏上传
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:700px; height:150px;">
                      <tr>   </tr>
                       <tr><td align="center" style="width:400px;">安卓外联地址：<input id="androidurl" style="width:220px; height:30px;"/></td></tr>
                       <tr><td align="center" style="width:400px;">IOS外联地址：<input id="iosurl" style="width:220px; height:30px;"/></td><td style="width:300px;">  
                       <button class="btn btn-success loading-btn" id="sub" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button></td>  </tr>
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
    jQuery(document).ready(function () {
        $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/FindGameURL",
            success: function (data) {
                for(var i=0;i<data.length;i++){
                if (data[i].name=="android_games")
                {
                 $("#androidurl").val(data[i].game_url);
                }
                if (data[i].name=="iphone_games")
                {
                $("#iosurl").val(data[i].game_url);
                }
                }
            }
        });
        $("#sub").click(function(){
             $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/UpdateGameURL",
                data:{"androidurl": $("#androidurl").val(),"iosurl":$("#iosurl").val()},
                success: function (data) {
                 if (data=="success")
                 {
                 toas1("修改成功");
                 setTimeout(function(){
                           location.href="<%= ViewData["rootUri"] %>OtherFeature/GameUpload";
                             },3000);
                 }else
                 {
                 toas2(data);
                 }
                }
            });
        });

    });


    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
    });
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
