<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
     <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 
<div class="row">
				<div class="col-md-12">
				<div>
                 <a id="Button1" class="btn btn-success loading-btn" href="<%=ViewData["rootUri"] %>OtherFeature/AddScenicSpots" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                    添加景点
							                    </a>
                </div>
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>旅游景点管理
							</div>
							
						</div>
						<div class="portlet-body">
                      
							<table class="table table-striped table-bordered table-hover" id="sample_1">
							<thead>
							<tr>
                            <th>
								   id

								</th>
								<th>
								   景点
								</th>
								<th>
									地址
								</th>
								<th>
									 操作
								</th>
							</tr>
							</thead>
							<!--  tbody>
							
					
                            	<tr>
								<td>
									 棋盘山
								</td>
								<td>
									 XXXXX,XXXX.....
								</td>
                                <td>
								 <a href="<%=ViewData["rootUri"] %>OtherFeature/ScenicSpotsDetails">查看</a> &nbsp;     <a  data-toggle="modal" href="<%=ViewData["rootUri"] %>OtherFeature/EditSpotsDetails" >修改</a>&nbsp; <a href="#">删除</a>
								</td>
							</tr>
                            	
							</tbody-->
							</table>
						</div>
                            
	
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
    		</div>
        <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>   
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.js"></script>
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.min.js"></script>
         <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>
<script>
  var oTable;
  var initTable1;
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
          initTable1= function () {

            var table = $('#sample_1');

          oTable = table.dataTable({
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
                'bPaginate': true,  //是否分页。
                "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。 
                "bServerSide": false,
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindAllScenicSpots",
                "aoColumns": [
                        {"mDataProp": "Id","bSortable": false },	
					    {"mDataProp": "Name","bSortable": false },	
                        {"mDataProp": "DiZhi","bSortable": false },
                        {"mDataProp": "Id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 3,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                   return '<a href="<%=ViewData["rootUri"] %>OtherFeature/ScenicSpotsDetails?id='+data+'">查看</a> &nbsp;    <a  data-toggle="modal" href="<%=ViewData["rootUri"] %>OtherFeature/EditSpotsDetails?id='+data+'" >修改</a>&nbsp; <a href="javascript:deletedspots('+data+')">删除</a>';
                            },
				            sClass: 'center'
				        }
                    ],
                "order": [
                [0, 'asc']
            ],  "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] 
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });

    $(document).ready(function() {

            $('#uploadify1').uploadify({
                'buttonText': "选择活动图片",
                //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999
                'swf': '<%= ViewData["rootUri"] %>Content/plugins/uploadify/uploadify.swf',

	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
	            'fileSizeLimit': '100KB',
                'onSelectError' : function (file, errorCode, errorMsg) {
                          if(errorCode=="-110")
                          {
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

				        toastr["error"]("超过文件上传大小限制（100kb）!", "温馨敬告");
                          }
                      },
                'uploader':'<%= ViewData["rootUri"] %>CMInfoManage/UploadifyImageS',
                'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                    //alert('The file ' + file.name + ' finished processing.');
                },
                'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                    //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件                                     
                    //alert('文件 ' + file.name + ' 已经上传成功，并返回 ' + response + ' 保存文件名称为 ' + data.SaveName);
                    data = data.replace(/\"/,"");
                    data = data.replace(/\"/,"");
                    $("#img").val(data);
                    $("#picture").attr("src", "<%= ViewData["rootUri"] %>"+ data);
                }
            });
          });
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
       
       function deletedspots(id){
       var gnl=confirm("你真的确定要删除吗?");
            if (gnl==true){
             $.ajax({
                    url: "<%= ViewData["rootUri"] %>OtherFeature/DeletedScenicSpots",
                    data:{"id":id},
                    success: function (data) {
                     if (data=="success")
                     {
                     toas1("删除成功");
                     setTimeout(function(){
                      oTable.fnDestroy();
                     initTable1();
                     },3000);
                    
                     }else
                     {
                     toas2(data);
                     }
                    }
                });
            }
            else{
            
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
