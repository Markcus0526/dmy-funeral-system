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
								<i class="fa  fa-university"></i>个案奖金
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:900px; height:100px;" id="table1">
                       <td align="right" style="width:200px;">提成比例(墓地)：</td>
                       <td align="center" style="width:200px;"><input id="false_mudi_ticheng"  style="width:180px; height:30px;"/></td>
                       <td>(单位:%) (员工实际销售墓地时提成比例)  <button class="btn btn-success loading-btn" onclick="falsemudi()" id="Button5" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例(祭品)：</td>
                       <td align="center" style="width:200px;"><input id="false_jipin_ticheng"   style="width:180px; height:30px;"/></td>
                       <td>(单位:%) (员工实际销售祭品时提成比例) <button class="btn btn-success loading-btn" id="Button6" onclick="falsejipin()" style="margin-top:10px;margin-left:50px;">
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
    <script type="text/javascript">

        $(function () {
            findfalse();
        });
        function findfalse() {
        $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/FindFalseAward",
                success: function (data) {
                $("#false_mudi_ticheng").val(data.false_mudi_ticheng);
                $("#false_jipin_ticheng").val(data.false_jipin_ticheng);
                }
            }); 
        }

        function falsejipin(){
           var false_jipin_ticheng =$("#false_jipin_ticheng").val();
          $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/EditFalseAward",
                 data:{"param":false_jipin_ticheng,"leixing":"0" },
                method:'post',
                success: function (data) {
                  if (data=="success") {
                toas1("修改成功");
                     setTimeout(function(){
                location.href="<%= ViewData["rootUri"] %>OtherFeature/FalseAwardCalculation";
                },3000);
                }else{
                toas2(data);
                }
                }
            }); 
        }
        function falsemudi(){
     
         var false_mudi_ticheng =$("#false_mudi_ticheng").val();
          $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/EditFalseAward",
               
                data:{"param":false_mudi_ticheng,"leixing":"1"},
                method:'post',
                success: function (data) {
                  if (data=="success") {
                toas1("修改成功");
                setTimeout(function(){
                location.href="<%= ViewData["rootUri"] %>OtherFeature/FalseAwardCalculation";
                },3000);
                   
                }else{
                toas2(data);
                }
                }
            }); 
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
