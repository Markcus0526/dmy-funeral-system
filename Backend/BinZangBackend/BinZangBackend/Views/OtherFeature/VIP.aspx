<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="row" style=" min-width:1000px">
  <div class="form-group">
                            <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                <img src="<%= ViewData["img"]%>"id ="picture" height="150px" width="156px"/>	
                                <input type="hidden" id="img" class="img"  name="img" value="" />
                                </div>
                            </div>
			  <div class="form-group" style="margin-left:2%;margin-top:5%">
                   <input type="file" class="upfiles" id="uploadify1" name="carImg2" />
               </div>
                <div style=" margin-left:2%"><span style="color:red">**温馨提示:请选择文件大小在3M以内的图片,选择后图片将自动上传.**</span></div>

</div>
</div>
<script type="text/javascript">

     $(document).ready(function() {
      
            $('#uploadify1').uploadify({
                 // 'auto': false, //当文件被添加到队列时，
                    'buttonText': '<i class="ace-icon fa fa-book blue"></i>选择图片',
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
                'uploader':'<%= ViewData["rootUri"] %>OtherFeature/VIPIMG',
              
                'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                    //alert('The file ' + file.name + ' finished processing.');
                },
                'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                    //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件   
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
                        toastr["success"]('文件上传成功', "温馨提示");
                         window.location.reload();
                   
            
                }
            });
         });


</script>
</asp:Content>
