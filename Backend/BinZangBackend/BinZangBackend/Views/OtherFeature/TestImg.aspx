<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row" style="min-width: 1000px">
        <table   border="1px" style="width:70%; margin-left:20%; margin-top:10%;">
            <tr>
                <td style="text-align:center">
                    公务员考试
                </td>
                <td>
                 
                    <div class="form-group" style="margin-left: 30%;margin-top:1%">
                        <input type="file" class="upfiles" id="uploadify1" name="carImg1" /><span id="importsuccess1" style="color: red;display:none;margin-left: 3%;">上传成功</span>
                    </div>
                    <div style="margin-left: 20%">
                        <span style="color: red">**温馨提示:请选择文件大小在3M以内的图片,选择完成请点击上传按钮.**</span></div>
                         <textarea id="num1"  rows="4" style=" width:70%; display:none" ></textarea>
                </td>
            </tr>
            <tr>
                <td style="text-align:center">
                    学校考试
                </td>
                <td>
                   
                    <div class="form-group" style="margin-left: 30%;margin-top:1%">
                        <input type="file" class="upfiles" id="uploadify2" name="carImg2" /><span id="importsuccess2" style="color: red;display:none;margin-left: 3%;">上传成功</span>
                    </div>
                    <div style="margin-left: 20%%">
                        <span style="color: red">**温馨提示:请选择文件大小在3M以内的图片,选择完成请点击上传按钮.**</span></div>
                         <textarea id="num2"  rows="4" style=" width:70%; display:none" ></textarea>
                </td>
            </tr>
            <tr>
                <td style="text-align:center">
                    证照考试
                </td>
                <td>
                
                    <div class="form-group" style="margin-left: 30%;margin-top:1% ">
                        <input type="file" class="upfiles" id="uploadify3" name="carImg3" /><span id="importsuccess3" style="color: red;display:none;margin-left: 3%;">上传成功</span>
                    </div>
                    <div style="margin-left:20%">
                        <span style="color: red">**温馨提示:请选择文件大小在3M以内的图片,选择完成请点击上传按钮.**</span></div>
                         <textarea id="num3"  rows="4" style=" width:70%; display:none" ></textarea>
                </td>
            </tr>
        </table>
        <div><a id="searchdata" class="btn btn-sm btn-success" onclick="LoadImg()" style=" margin-left:40%;margin-top:5%; margin-bottom:2%"><i class="fa fa-check"> </i>上传</a></div>
    </div>

<script type="text/javascript">

    $(document).ready(function () {

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
            'onSelectError': function (file, errorCode, errorMsg) {
                if (errorCode == "-110") {
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
            'uploader': '<%= ViewData["rootUri"] %>OtherFeature/IMG1',

            'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                //alert('The file ' + file.name + ' finished processing.');
            },
            'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件
               $("#importsuccess1").show();   
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
                 data = data.replace(/\"/,"");
                    data = data.replace(/\"/,"");
                var k = $('#num1').val();
                if (k == "" || k == null) {
                    $('#num1').val(data);
                }
                else {
                    var s = $('#num1').val();
                    var i = s + "," + data;
                    $('#num1').val(i);
                }

              //  window.location.reload();


            }
        });
        $('#uploadify2').uploadify({
            // 'auto': false, //当文件被添加到队列时，
            'buttonText': '<i class="ace-icon fa fa-book blue"></i>选择图片',
            'multi': true, //设置为true将允许多文件上传
            //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
            //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999

            'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

            'fileTypeExts': '*.jpg;*.png;*.jpeg',
            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
            'fileSizeLimit': '3MB',
            'onSelectError': function (file, errorCode, errorMsg) {
                if (errorCode == "-110") {
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
            'uploader': '<%= ViewData["rootUri"] %>OtherFeature/IMG2',

            'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                //alert('The file ' + file.name + ' finished processing.');
            },
            'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件   
                $("#importsuccess2").show(); 
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
                //  window.location.reload();
                 data = data.replace(/\"/,"");
                data = data.replace(/\"/,"");
                var k = $('#num2').val();
                if (k == "" || k == null) {
                    $('#num2').val(data);
                }
                else {
                    var s = $('#num2').val();
                    var i = s + "," + data;
                    $('#num2').val(i);
                }


            }
        });
        $('#uploadify3').uploadify({
            // 'auto': false, //当文件被添加到队列时，
            'buttonText': '<i class="ace-icon fa fa-book blue"></i>选择图片',
            'multi': true, //设置为true将允许多文件上传
            //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
            //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999

            'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

            'fileTypeExts': '*.jpg;*.png;*.jpeg',
            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
            'fileSizeLimit': '3MB',
            'onSelectError': function (file, errorCode, errorMsg) {
                if (errorCode == "-110") {
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
            'uploader': '<%= ViewData["rootUri"] %>OtherFeature/IMG3',

            'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                //alert('The file ' + file.name + ' finished processing.');
            },
            'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件  
                $("#importsuccess3").show();  
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
                 data = data.replace(/\"/,"");
                    data = data.replace(/\"/,"");
                var k = $('#num3').val();
                if (k == "" || k == null) {
                    $('#num3').val(data);
                }
                else {
                    var s = $('#num3').val();
                    var i = s + "," + data;
                    $('#num3').val(i);
                }
                //window.location.reload();


            }
        });
    });

   function LoadImg() {
      
     
         var url1 = $('#num1').val();
         var url2 = $('#num2').val()
         var url3 = $('#num3').val()
     
       
         alert("url1"+url1+","+"url2"+url2+":::::"+"url3"+url3);
          $.ajax({
		                       url: "<%=ViewData["rootUri"]%>OtherFeature/UpImg",
		                        data: {
		                            "url1":url1,"url2":url2,"url3":url3
                             
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
                                  if (message=="ok") {
                                    toastr["success"]('操作成功', "温馨提示");
                                  }else{
                                  toastr["error"]('操作失败', "温馨提示");
                                  }
                                  setTimeout(' window.location.reload()',3000);
		                        }
		                    });


          }
</script>
</asp:Content>
