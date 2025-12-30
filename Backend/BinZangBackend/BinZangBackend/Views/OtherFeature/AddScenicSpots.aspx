<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
   <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 


<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>新增景点
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:580px; height:400px; margin-left:50px;">
                         <tr>
                         <td rowspan="2" style="width:220px;">
                           图片:
                            <div class="form-group">
                            <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                <img src="<%= ViewData["rootUri"] %>Content/Images/default_img.jpg" id ="picture" height="150px" width="156px"/>	
                                <input type="hidden" id="img" class="img"  name="img" value="" />
                                </div>
                            </div>   
                            <div class="form-group" style="margin-left:0px">
                            <input type="file" class="upfiles" id="uploadify1" name="carImg2" />
                            </div>
                            <span style="color:red">**温馨提示:请选择文件大小在100kb以内的图片**</span>
                                                    
                         </td>
                         <td align="left"style="width:80px;">
                         景点名称:
                         </td>
                         <td style="width:200px;"> &nbsp;<input id="name" style="width:180px;height:30px;"/></td>
                         </tr>
                         
                        <tr>
                         <td  align="left" style="width:80px;">
                         联系电话:
                         </td>
                         <td style="width:200px;">&nbsp;<input id="phone" style="width:180px;height:30px;"/></td>
                         </tr>
                         <tr>
                         
                         <td align="left" style="width:80px;">
                         地址:
                         </td>
                         </tr>
                         <tr>
                         
                         <td colspan="2">
                        <div class="form-group" style="margin-left:0px">
                                        <div class="col-md-8" >
                                            <input type="text" id="suggestId"  value="" name="suggestId" data-rule-required="true" class="form-control">
                                            <%--<span for="suggestId" class="help-block"></span>--%>
				                        </div> 
                                        <div class="col-md-1" >
						                    <a class="btn btn-sm  btn-success cancel" id="positioning"  onclick=""><i class="fa fa-search"></i> 搜索</a>
                                        </div>   
                                    </div>
                                     <br />
                                    <div id="l-map" style="height:300px; width:550px; border:1px solid #CCC;"></div>
                                     <div class="form-group" style="margin-top:7px;margin-left:120px">
                                     <div class="clearfix">
                                    <div id="r-result" style="">
                                        <input type="text" readonly id="lng" name="lng" value="">
                                        <input type="text" readonly id="lat" value="" name="lat">
                                    </div>
                                    </div>
                                    </div>
                                    
                         </tr>
                        <tr style="width:300px;">
                         <td colspan="3">
                         景点介绍:
                         <div>
                         <textarea id="contents1" style="width:550px;height:300px; resize:none;" rows="8"></textarea>
                         </div>
                         </td>
                         
                         </tr>
                      <tr>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td align="right">
                            <button id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:addscenic();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                   确定添加
							                    </button>
                      </td>
                      </tr>
                      </table>
						</div>
					</div>
				</div>
	
    		</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>   
     <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo&amp;services=&amp;t=20150330161927"></script>
<script type="text/javascript" src="<%=ViewData["rootUri"] %>Content/js/baidumap.js"></script>
     <script>

    KindEditor.ready(function (K) {
        editor = K.create('#contents1', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
               
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
    });
        jQuery(function ($) {
        var orgAddr = "沈阳";
          // $("#address").val(orgAddr);
            if (orgAddr != null && orgAddr != "") {
                var orglng = "123.6976931";
                var orglat = "41.91541";
                var orgmark = new BMap.Point(orglng, orglat);
                baidu_map(orgmark);
            } else {
                baidu_map();
            }
    });

     $(document).ready(function() {

            $('#uploadify1').uploadify({
                'buttonText': "选择活动图片",
                //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999
                'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

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
                'uploader':'<%= ViewData["rootUri"] %>OtherFeature/UploadifyImageS',
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

          function addscenic(){
            editor.sync();
          var img=$("#img").val();
          var name=$("#name").val();
          var address=$("#suggestId").val();
           var lng=$("#lng").val();
            var lat=$("#lat").val();
          var phone=$("#phone").val();
          var contents=escape($("#contents1").val());
            $.ajax({
                type: "POST",
                method: 'post',
                url: "<%= ViewData["rootUri"] %>OtherFeature/AddScenicSpotsDetails",
                data:{"img":img,"name":name,"address":address,"phone":phone,"contents":contents, "lng":lng, "lat":lat},
                success: function (data) {
                 if (data=="success")
                 {
                 toas1("添加成功");
                 setTimeout(function(){
                 location.href="<%= ViewData["rootUri"] %>OtherFeature/ScenicSpots";
                 },3000);
                  
                 }else
                 {
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
