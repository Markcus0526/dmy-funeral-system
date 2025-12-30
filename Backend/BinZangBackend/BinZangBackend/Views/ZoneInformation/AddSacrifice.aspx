<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div style="width:700px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                            <form class="form-horizontal" role="form" id="validation-form">
                            <table cellpadding="0" style="margin-top:20px;height:750px"  cellspacing="0"width="93%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>商品名称：</label>
                                    </td>
                                    <td>
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px">
                                                         <div class="clearfix">                                                	  
                                                          <input id="pname" type="text" class="pname" name="pname"/>
                                                          <div class="clearfix">  
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>商品图片：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:0px;margin-left:20px">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                        <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                                         <img src="" id = "picture" height="150px" width="156px"/>	
                                                         <input type="hidden" id="img" class="img"  name="img" value="" />
                                                         </div>
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                    <div class="form-group" style="margin-left:60px">
                                                        <input type="file" class="upfiles" id="uploadify" name="carImg2" />
                                                   </div>
                                                    <span style="color:red;margin-left:30px">*提示:请选择小于500kb的图片*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">商品价格：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">  
                                           <input type="text" id="price" name="price" style="width:100px"/>元 
                                     <div class="clearfix">  
                                      </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>商品种类：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                        <select class="select2" id="ptype" name="ptype" style="width:150px" onchange="set(this.value)">
                                            <option value="1" >随葬品</option>
                                            <option value="0" >鲜花</option>
                                            <option value="2" >供饭/水果</option>
                                            <option value="4" >法会商品</option>
                                            <option value="3" >其他</option> 
                                       </select>  
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>法会活动名称：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                        <input type="text" id="fahui" disabled=disabled value="无" /> 
                                        <select class="select2" id="fahuiactivity" style="width:150px;display:none" >
                                            <%
                                                for (int i = 0; i < ViewBag.fahui.Count; i++)
                                          {   
                                               %>
                                           <option value="<%=ViewBag.fahui[i].uid %>" ><%=ViewBag.fahui[i].title%></option>
                                           <% }%>           
                                            </select>
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                
                                    <td style="text-align:right;">
                                        <label>商品介绍：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-top:0px;margin-left:10px">
                                    <div class="clearfix">  
                                      <textarea id="pdetail" class="pdetail"  name="pdetail" style="width:350px;height:200px;" rows="8"></textarea>
                                   </div>
                                   </div>
                                   </td>
                                </tr>
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                    
                                    <input id="text1" readonly="readonly" style="margin-top:-8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:200px;color: Red" />
                                        <button class="btn btn-success loading-btn" id="sub" style="margin-top:10px;margin-left:10px">
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
                        <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
   
<script>
 function set(id)
    {
      if(id==4)
      {
      document.getElementById("s2id_fahuiactivity").style.display="block";
        $("#fahuiactivity").show();
        $("#fahui").hide();
      }
      else{
       document.getElementById("s2id_fahuiactivity").style.display="none";
     $("#fahuiactivity").hide();
       $("#fahui").show();
      }
    }
$(document).ready(function() {
 $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
    var rootUri="<%=ViewData["rootUri"] %>";
            $('#uploadify').uploadify({
                'buttonText': "<i class='ace-icon fa fa-book'></i> &nbsp;选择图片",
                'queueSizeLimit': 999,  //设置上传队列中同时允许的上传文件数量，默认为999
                'uploadLimit': 999,   //设置允许上传的文件数量，默认为999
                'swf': rootUri + 'Content/js/uploadify/uploadify.swf',
                 //'auto': false,
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
                'uploader': rootUri + 'ZoneInformation/UploadifyActivityImage',
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
            $.validator.messages.remote = "这个办事处可能已经存在！";
	        $.validator.messages.required = "必须要填写";
            $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                pname: {
	                    required: true
	                },
                    img: {
	                    required: true
	                },
                    price: {
	                    required: true
	                },
                    pdetail: {
	                    required: true
	                },
                    ptype: {
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
    function check1(){
           var img=$("#img").val();
                if (img!=null&&img!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择上传图片！");
                return false;
              }
      }
      function check3(id){
      if(id==4)
      {
            var fahuiactivity=$("#fahuiactivity").val();
                if (fahuiactivity!=0&&fahuiactivity!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择法会活动！");
                return false;
              }
      }
      else
      {
         return true;
      }
           
      }
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
//       function check3(){
//            var reg=/^-?\d+(\.\d*)?$/; //正则表达式
//           var approve=$("#approve").val();
//                if (reg.test(approve)&&approve<=100) {
//               document.getElementById("text1").style.display="none";
//               return true;
//              }
//              else{
//               document.getElementById("text1").style.display="block";
//                $('#text1').val("请输入标准的认同度！");
//                return false;
//              }
//      }
        function submitform() {
        if(check1()==true&&check2()==true&&check3($("#ptype").val())==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/InserSacrifice/?fahuiactivity="+$("#fahuiactivity").val(),
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                            toas1();
                            setTimeout(function(){
                                window.location.href="<%= ViewData["rootUri"] %>ZoneInformation/SacrificeManagement";
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

