<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" style=" margin-left:10%;margin-right:10%">
				<div class="col-md-12">
				<!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div style="  margin-top:4%; border:2px solid #3B9C96">
                                    <div id="img" style="margin-left:2%;margin-top:2%">

                                    </div>
                                    <div class="form-group" style="margin-left:2%;margin-top:3%">
                                    <input type="file" class="upfiles" id="uploadify1" name="carImg2" />
                                    </div>
                                    
                                    <div style=" margin-left:2%"><span style="color:red">**温馨提示:请选择文件大小在3M以内的图片**</span> </div>
                                    <div style=" margin-left:2%; margin-top:5%"><span>描述：</span><br /><textarea id="remark" rows="7" style=" width:70%"></textarea></div>
						            <textarea id="num"  rows="4" style=" width:70%; display:none" ></textarea>
                                   <div><a id="searchdata" class="btn btn-sm btn-success" onclick="SendCallBack()" style=" margin-left:20%;margin-top:5%; margin-bottom:2%"><i class="fa fa-search"> </i>回函发送</a></div>
	                </div>
    		    </div>
</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript">
   var count=0;
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
        
     $(document).ready(function() {
         
            $('#uploadify1').uploadify({
                 // 'auto': false, //当文件被添加到队列时，
                    'buttonText': '<i class="ace-icon fa fa-book blue"></i>选择祭拜图片',
                    'multi': true, //设置为true将允许多文件上传
                //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999
             
                'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
	            'fileSizeLimit': '3MB',
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

				        toastr["error"]("超过文件上传大小限制（3MB）!", "温馨敬告");
                          }
                      },
                'uploader':'<%= ViewData["rootUri"] %>CallBack/SendCallBack',
              
                'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                    //alert('The file ' + file.name + ' finished processing.');
                },
                'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                    //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件   
                                    
                           data = data.replace(/\"/,"");
                           data = data.replace(/\"/,"");
                           count++;
                           if(count>5)
                           {
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
				        toastr["error"]("最多只能上传5张图片!", "温馨敬告");
                           }
                           else{

                            var k = $('#num').val();
                          if (k==""||k==null)
                          {
                          $('#num').val(data);
                          }
                          else{
                            var s=  $('#num').val();
                            var i = s+","+data;
                             $('#num').val(i);
                          }
                         $("#img").append('<img src="<%= ViewData["rootUri"]%>'+data+'" id ="picture'+count+'" height="150px" width="150px" style=" margin-left:10px;margin-top:5"/>');
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
                        toastr["success"]('第 '+count+' 张图片上传成功', "温馨提示"); 
                           }
                          
                   // data = data.replace(/\"/,"");
                  //  data = data.replace(/\"/,"");
                 //   var imgdata=$("#img").val();
                 //   imgdata=data+","+imgdata;
                //    $("#img").val(imgdata);
                //    $("#picture"+number+"").attr("src", "<%= ViewData["rootUri"]%>"+data);
                //    number=number+1;
                //    $("#number").val(number);
                }
            });
         });
         function SendCallBack() {
      
         var sid = <%=ViewData["uid"] %>;
         var urls = $('#').val();
         var phoneurls = $('#num').val();
         var remark = $('#remark').val();
         //alert("uid"+sid+","+"ph"+phoneurls+":::::"+"re"+remark);
          $.ajax({
		                        url: "<%=ViewData["rootUri"]%>CallBack/TUI",
		                        data: {
		                            "d": sid,"urls":phoneurls,"remark":remark 
                             
		                        },
		                        type: "post",
		                        success: function (message) {
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
                                    toastr["success"]('回函发送成功', "温馨提示"); 
                                    setTimeout(function(){
                                        window.location.href="<%= ViewData["rootUri"] %>JiBaiReserve/Index";
                                    }, 2500);
		                        }
		                    });


          }

</script>

</asp:Content>
