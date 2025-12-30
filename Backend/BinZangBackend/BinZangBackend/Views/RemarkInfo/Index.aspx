<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" />
    <div class="row">
        <div class="col-md-12">
    
          <div class="portlet box green-haze" style=" margin-top:5%;">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-send"></i>备注信息修改
							</div>
							
						</div>
						<div class="portlet-body" >
                      
							<table class="table table-striped table-bordered table-hover" id="sample_1">
						
							
							<tbody>
							
					
                            	<tr>
								<td>
									鲜花
								</td>
								<td>
								<textarea id="hua"  rows=5 style=" width:80%" ><%=ViewData["hua"] %></textarea>
								</td>
								
							</tr>
                            	<tr>
								<td>
									贡饭
								</td>
								<td>
									<textarea  id="gong" rows=5 style=" width:80%" ><%=ViewData["gong"]  %></textarea>
								</td>
								
							</tr>
                            	<tr>
								<td>
									随葬品
								</td>
								<td>
									 <textarea  id="sui" rows=5 style=" width:80%" ><%=ViewData["sui"]  %></textarea>
								</td>
								
							</tr>
                                	<tr>
								<td>
									其他
								</td>
								<td>
									 <textarea  id="qi" rows=5 style=" width:80%" ><%=ViewData["qi"]  %></textarea>
								</td>
								
							</tr>
							</tbody>
							</table>
						</div>
				
				</div>
                <div><a id="searchdata" class="btn  btn-success" onclick="ModifyRemark()" style=" margin-left:30%"><i class="fa  fa-check"> </i>保存</a></div>                
              
        
        </div>
    </div>
    <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <script>
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
            var table = $('#sample_1');

            var oTable = table.dataTable({
                
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "没有相关数据",
                    "info": "显示 _START_ 到 _END_ 共 _TOTAL_ 条",
                    "infoEmpty": "没有相关数据",
                    "infoFiltered": "(共_MAX_ 条数据)",
                    "lengthMenu": "显示 _MENU_ 条",
                    "search": "快速搜索:",
                    "zeroRecords": "没有发现"
                },

                "order": [
                [0, 'asc']
            ],

                "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] // change per page values here
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
        function ModifyRemark(){
        var hua = $('#hua').val();
        var sui = $('#sui').val();
        var gong = $('#gong').val();
        var qi = $('#qi').val();
                var rootUri ="<%= ViewData["rootUri"] %>";
                         $.ajax({

                            url: rootUri + "ShangPinOrder/RemarkModify",
                            data: {
                                "hua": hua,"gong":gong,"sui":sui,"qi":qi

                            },
                          
                          dataType:'json', 
                            type: "post",
                            success: function (message) {
                      
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
                                if (message == "ok") {
                                    toastr["success"]("操作成功！");
                                } else { toastr["error"](message); }
                                setTimeout(' window.location.reload()', 3000);
                          
                            }



                        }); 


        }
    </script>
</asp:Content>
