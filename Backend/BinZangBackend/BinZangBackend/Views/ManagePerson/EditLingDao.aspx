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
								<i class="fa  fa-university"></i>修改代销商
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:780px; height:500px; margin-left:50px;">
                         <tr>
                         <td rowspan="9" style="width:180px;">
                           代销商图片:
                            <div class="form-group">
                            <div id="advertCarImg" class="form-group" style="width:122px; border:2px solid #BBB;">
                                <img src="<%= ViewData["rootUri"] %>Content/Images/default_img.jpg" id ="picture" height="120px" width="120px"/>	
                                <input type="hidden" id="img" class="img"  name="img" value="" />
                                </div>
                            </div>   
                            <div class="form-group" style="margin-left:0px">
                            <input type="file" class="upfiles" id="uploadify1" name="carImg2" />
                            </div>
                            <span style="color:red">**温馨提示:请选择文件大小在500kb以内的图片**</span>
                                                    
                         </td>
                         <td align="right"style="width:80px;">
                         代销商姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <input id="real_name" onblur="check1(this.value)" style="width:180px;height:30px;" />
                         </td>
                           <td style="width:200px;">
                         <input id="Text1" readonly="readonly" style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="phone" onblur="check2(this.value)" style="width:180px;height:30px;"/></td>
                          <td style="width:200px;">
                         <input id="Text2" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         Q Q&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="qqname" style="width:180px;height:30px;"/></td>
                          <td style="width:200px;">
                         <input id="Text3" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr><tr>
                         <td  align="right" style="width:80px;">
                           微 信&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="weixin" style="width:180px;height:30px;"/></td>
                           <td style="width:200px;">
                         <input id="Text4" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                           领导类型&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <select id="type" class="select2"style=" width:200px; height:30px;" >
                               <option value="1">董事长</option>
                        <option value="2">总经理</option>
                        <option value="3">副总经理</option>
                            </select></td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                          登陆账号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="name" onblur="check6(this.value)" style="width:180px;height:30px;"/></td>
                           <td style="width:200px;">
                         <input id="Text6" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                      <tr>
                      <td>
                      </td>
                      <td align="right">
                            <button id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:editscenic();" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								修改保存
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
     <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>
<script>
     var flag1=false;
     var flag2=false;
     var flag3=false;
     var flag4=false;
     var flag5=false;
     var flag6=false;
     var flag7=false;
     function check1(value){
     if(value.length>50){
        document.getElementById("Text1").style.display="block";
        $('#Text1').val("输入的字数不能多于50字");
        flag1 =false;
        }else  if(value.length<=0){
        document.getElementById("Text1").style.display="block";
        $('#Text1').val("输入不能为空");
        flag1 =false;
        }else{
        document.getElementById("Text1").style.display="none";
        flag1 =true;
        }
     }
      function check2(value){
       if(value.length>20){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("输入的字数不能多于20字");
        flag2 =false;
        }else  if(value.length<=0){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("输入不能为空");
        flag2 =false;
        }else{
        document.getElementById("Text2").style.display="none";
        flag2 =true;
        }
     }
      function check3(value){
       if(value.length>50){
        document.getElementById("Text3").style.display="block";
        $('#Text3').val("输入的字数不能多于50字");
        flag3 =false;
        }else  if(value.length<=0){
        document.getElementById("Text3").style.display="block";
        $('#Text3').val("输入不能为空");
        flag3 =false;
        }else{
        document.getElementById("Text3").style.display="none";
        flag3 =true;
        }
     }
      function check4(value){
       if(value.length>50){
        document.getElementById("Text4").style.display="block";
        $('#Text4').val("输入的字数不能多于50字");
        flag4 =false;
        }else  if(value.length<=0){
        document.getElementById("Text4").style.display="block";
        $('#Text4').val("输入不能为空");
        flag4 =false;
        }else{
        document.getElementById("Text4").style.display="none";
        flag4 =true;
        }
     }
      function check5(value){
       if($("#owner_name").val().length>50){
        document.getElementById("Text5").style.display="block";
        $('#Text5').val("输入的字数不能多于50字");
        flag5 =false;
        }else  if($("#owner_name").val().length<=0){
        document.getElementById("Text5").style.display="block";
        $('#Text5').val("输入不能为空");
        flag5 =false;
        }else{
        document.getElementById("Text5").style.display="none";
        flag5 =true;
        }
     }
      function check6(value){
       if(value.length>50){
        document.getElementById("Text6").style.display="block";
        $('#Text6').val("输入的字数不能多于50字");
        flag6 =false;
        }else  if(value.length<=0){
        document.getElementById("Text6").style.display="block";
        $('#Text6').val("输入不能为空");
        flag6 =false;
        }else{
        document.getElementById("Text6").style.display="none";
        flag6 =true;
        }
     }
      function check7(value){
       if(value.length>50){
        document.getElementById("Text7").style.display="block";
        $('#Text7').val("输入的字数不能多于50字");
        flag7 =false;
        }else  if(value.length<=0){
        document.getElementById("Text7").style.display="block";
        $('#Text7').val("输入不能为空");
        flag7 =false;
        }else{
        document.getElementById("Text7").style.display="none";
        flag7 =true;
        }
     }

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
    jQuery(function ($) {  
              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
         $("#img").val("<%= ViewData["img"]%>");
                    $("#name").val("<%= ViewData["name"]%>");
                    $("#real_name").val("<%= ViewData["real_name"]%>");
                    $("#phone").val("<%= ViewData["phone"]%>");
                    $("#type").val("<%= ViewData["type"]%>");
                    $("#type").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                    $("#weixin").val("<%= ViewData["weixin"]%>");
                    $("#qqname").val("<%= ViewData["qqname"]%>");
                    $("#picture").attr("src", "<%= ViewData["rootUri"] %><%= ViewData["img"]%>" );
                    check1("<%= ViewData["real_name"]%>");
                    check2("<%= ViewData["phone"]%>");
                    check6("<%= ViewData["name"]%>");
        });
     $(document).ready(function() {

            $('#uploadify1').uploadify({
                'buttonText': "选择图片",
                //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999
                'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
	            'fileSizeLimit': '500KB',
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

				        toastr["error"]("超过文件上传大小限制（500kb）!", "温馨敬告");
                          }
                      },
                'uploader':'<%= ViewData["rootUri"] %>ManagePerson/UploadifyImageS',
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

          function editscenic(){
          var img=$("#img").val();
            if (img!=null&&img!=""&&flag1==true&&flag2==true&&flag6==true)
            {
              
              var name=$("#name").val();
              var real_name=$("#real_name").val();
              var phone=$("#phone").val();
              var type=$("#type").val();
              var weixin=$("#weixin").val();
               var qqname=$("#qqname").val();
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/EditLingDaoInfo",
                data:{
                "id":"<%= ViewData["id"] %>",
                "img":img,
                "name":name,
                "real_name":real_name,
                "phone":phone,
                "type":type,
                "weixin":weixin,
                "qqname":qqname,
                },
                success: function (data) {
                 if (data=="success")
                 {
                 toas1("添加成功");
                 setTimeout(function(){
                 location.href="<%= ViewData["rootUri"] %>ManagePerson/LingDao";
                 },3000);
                  
                 }else
                 {
                 toas2(data);
                 }
                }
            });
            }else{
           toas3("验证不通过");
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
         function toas3(massage) {
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

            toastr["warning"](massage, "温馨提示");
        }

       
</script>

</asp:Content>
