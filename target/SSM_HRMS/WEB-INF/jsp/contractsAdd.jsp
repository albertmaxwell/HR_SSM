<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>部门新增页面</title>
	<script src="<%=request.getContextPath()%>/plug-in/element-ui/css/index.css"></script>
	<script src="<%=request.getContextPath()%>/plug-in/element-ui/css/elementui-ext.css"></script>
	<script src="<%=request.getContextPath()%>/plug-in/vue/vue.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/vue/vue-resource.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/element-ui/index.js"></script>

	<link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">


	<style type="text/css">

		.inputStyle{
			width: 450px;
			border: 1px solid gray;
			border-radius: 18px;
			height: 30px;
			outline: none;
		}
		.pictureButton{
			background-color: #0062cc;
			height: 50px;
			width: 90px;
			margin-left: 100px;
			color: #ffffff;
			font-weight: bolder;
			font-size: large;
			outline:none;
			border-right: none;
		}
	</style>
</head>
<body>
<div class="modal fade con-add-modal" tabindex="-1" role="dialog" aria-labelledby="con-add-modal">
	<div style="width: 1000px;height: 1200px" class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">合同新增</h4>
			</div>
			<div class="modal-body">

				<form   class="form-horizontal add_con_form">
					<div class="form-group">
						<label for="add_conCode" class="col-sm-2 control-label">合同编号</label>
						<div class="col-sm-8">
							<input type="text" name="contractsCode" class="form-control" id="add_conCode" placeholder="人事部">
						</div>
					</div>
					<div class="form-group">
						<label for="add_conTitle" class="col-sm-2 control-label">合同标题</label>
						<div class="col-sm-8">
							<input onselect="getData()" type="text" name="contractsTitle" class="form-control" id="add_conTitle" placeholder="XXX">
						</div>
					</div>

					<div class="form-group">
						<label style="font-weight: bold;font-size: large" for="add_province" class="col-sm-2 control-label">省</label>
						<div class="col-sm-8">
							<div >
								<select    class="inputStyle" class="form-control" name="provincePid" id="add_province">

								</select>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label style="font-weight: bold;font-size: large" for="add_city" class="col-sm-2 control-label">市</label>
						<div class="col-sm-8">
							<div >
								<select   class="inputStyle" class="form-control" name="cityPid" id="add_city">

								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label style="font-weight: bold;font-size: large" for="add_area" class="col-sm-2 control-label">区</label>
						<div class="col-sm-8">
							<div >
								<select  class="inputStyle" class="form-control" name="areaPid" id="add_area">

								</select>
							</div>
						</div>
					</div>

					<div id="app">
						<el-button type="primary" @click="visible = true">Button</el-button>

						<el-dialog  :visible.sync="visible" title="Hello world">
							<el-form  style="width: 1000px" :model="form" label-width="125px" >

								<el-row>
									<el-col :span="8">
										<el-form-item label="身份证正面照片" >
											<el-button style="cursor: pointer; width:100px; height:40px;"  size="80" type="primary" >点击上传</el-button>
											<form action="file_plugin/upload.do" enctype="multipart/form-data" method="post">
												<input id='fileSizeZheng' type="file" style="cursor: pointer;position:absolute; top:0; width:100px; height:40px; filter:alpha(opacity:0);opacity: 0;" name="file" accept="image/*"  onChange="selFile(this, 1)" />
												<input type="hidden" name="suffix" />
											</form>
										</el-form-item>
									</el-col>
									</el-row>
								<el-row>
									<el-col :span="8" style="text-align:center;">
										<a href='javascript:;' target="_black"><img width="300" height="200" style="display:none;" id="idCardZImg"/></a>
									</el-col>

								</el-row>

							</el-form>

						</el-dialog>
					</div>


				</form>

			</div>
			<div class="modal-footer">


				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary con_save_btn">保存</button>
			</div>


		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================部门新增操作=================================== -->
    // 为简单操作，省去了输入名称的验证、错误信息提示等操作
    //1 点击部门新增按钮，弹出模态框；
    //2 输入新增部门信息，点击保存按钮，发送AJAX请求到后台进行保存；
    //3 保存成功跳转最后一页
    //存储图片id集
    var imgIds = {};
    var valiSuffix = ["jpg", "jpeg", "gif", "png"];
    var uploadIndex = 0;
    var id;                 //业务ID
    var busId;                 //业务ID
    var userName;           //人员姓名
    var idCard;           //身份证号码
    var frontIdCartUrl;     //身份证正面网络地址
    var ReverseIdCartUrl;   //身份证反面网络地址
    var isLt1M;             //文件上传大小控制在1MB
    var wheatherEdit;        //是否是调用人脸识别上传图片还是编辑的上传图片
    var departId;
    var rrba17;
    var valid=null;
    var departName="";
    $(function(){
        setInterval(function() {
            $(".upload-ing").each(function() {
                var h = $(this).html();
                if(h == "上传中...") {
                    $(this).html("上传中.");
                } else if(h == "上传中.") {
                    $(this).html("上传中..");
                } else if(h == "上传中..") {
                    $(this).html("上传中...");
                }
            });
        }, 700);
    });

    $("select#add_province").click(function(){

        getPrivinceData(1);

         });

    $("select#add_city").click(function() {

        var provincepid = document.getElementById("add_province").value;


        getCityData(provincepid);

    });

    $("select#add_area").click(function() {

        var cityPid = document.getElementById("add_city").value;

        getAreaData(cityPid);

    });


    $(".con_add_btn").click(function () {

        $('.emp-add-modal').modal({
            backdrop:static,
            keyboard:true
        });
    });

    function getPrivinceData(provincrePid){

        $.ajax({
            url:"/hrms/dept/getPCAList/"+provincrePid,
            type:"GET",
            async: false, //是否异步请求，默认为true
            success:function (result) {

                if (result.code == 100){
                    $.each(result.extendInfo.list, function () {
                        var optionEle = $("<option></option>").append(this.name).attr("value", this.id);
                        optionEle.appendTo("#add_province");
                    });
                }
            }
        });
    }


    function getCityData(provincrePid){

        $.ajax({
            url:"/hrms/dept/getPCAList/"+provincrePid,
            type:"GET",
            async: false, //是否异步请求，默认为true
            success:function (result) {

                if (result.code == 100){
                    $.each(result.extendInfo.list, function () {
                        var optionEle = $("<option></option>").append(this.name).attr("value", this.id);
                        optionEle.appendTo("#add_city");
                    });
                }
            }
        });
    }



    function getAreaData(citypid){

        $.ajax({
            url:"/hrms/dept/getPCAList/"+citypid,
            type:"GET",
            async: false, //是否异步请求，默认为true
            success:function (result) {

                if (result.code == 100){
                    $.each(result.extendInfo.list, function () {
                        var optionEle = $("<option></option>").append(this.name).attr("value", this.id);
                        optionEle.appendTo("#add_area");
                    });
                }
            }
        });
    }

    $(".con_save_btn").click(function () {
        var conCode = $("#add_conCode").val();
        var conTitle = $("#add_conTitle").val();
        var province = $("#add_province").val();
        //验证省略...
        $.ajax({
            url:"/hrms/contracts/addCon",
            type:"PUT",
            data:$(".add_con_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    layer.alert("新增成功", {icon:5} );
                    $('.con-add-modal').modal("hide");
                    $.ajax({
                        url:"/hrms/contracts/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/hrms/contracts/getConList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_con_error);
                }
            }
        });

    });


</script>

<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script>

  var id="435435345345345345";

    new Vue({
        el: '#app',
        data: function() {
            return {
                visible: false,

                url:{
                    getParentId:'url',
                },
                isAdd: false,

                form: {},
            }

        },
        methods: {

            //控制界面失效函数
            disableFunction: function () {

            },

        },

    });


    //传入一个file对象，传出访问地址
    function fileToUrl(fileObj) {
        var windowURL = window.URL || window.webkitURL;
        var dataURL;
        if (fileObj && fileObj.files && fileObj.files[0]) {
            dataURL = windowURL.createObjectURL(fileObj.files[0]);
        }
        return dataURL;
    }
    //--------------------------------
    //选择文件
    function selFile(obj, type) {
        obj = $(obj);
        var form = obj.parent("form"); //获取form对象
		console.log(form);
        var suffixObj = obj.next("input[name='suffix']"); //获取后缀名对象
        var str = obj.val();
        if(str.indexOf(".") != -1) {
            if(type=="1"){
                var zheng=$('#fileSizeZheng')[0].files[0].size/1024/1024;
                if(zheng.toFixed(2)>=1){
                    obj.val("");
                    layer.alert("文件过大，请选择小于等于1Mb的图片！", {icon:2});
                    return;
                }
            }
            else if(type=="2"){
                var fan=$('#fileSizeFan')[0].files[0].size/1024/1024;
                if(fan.toFixed(2)>=1){
                    obj.val("");
                    layer.alert("文件过大，请选择小于等于1Mb的图片！", {icon:2});
                    return;
                }
            }
            var suffix = str.substring(str.lastIndexOf(".")+1, str.length);
            var isVali = false;
            for(var i=0; i<valiSuffix.length; i++) {
                if(suffix.toLowerCase() == valiSuffix[i]) {
                    isVali = true;
                }
            }
            if(isVali) {
                suffixObj.val(suffix);
                uploadImg(form, obj, type); //上传文件
                return;
            }
        }
        obj.val("");
        layer.alert("文件类型不合法，请选择图片！", {icon:2});
    }

    //上传图片
    function uploadImg(form, obj, type) {

        var f = obj.val(); //获取本地文件路径
        if(f == null || f == undefined || f == "") {
            layer.alert("请先选择要上传的图片！", {icon:0});
            return;
        }
        var name = 'uploadIframe'+uploadIndex+'_'+type;//uploadIframe0_1

        var str = '<iframe style="display:none;" name="'+name+'" id="'+name+'"></iframe>';
        $("body").append(str);
        layer.load(0, {shade: [0.5, "#fff"]});
        listenerUploadimg(fileToUrl(obj[0]), name, obj);
    }

    function listenerUploadimg(url, name, obj) {
        var html = $("#" + name).contents().find('body').html();
        if (html != null && html != undefined && html.length > -1) {
            //转换成json
            var json = eval("(" + html + ")");
            console.log(json.code);
            if (json.code == "10000") {
                var id = vue.form.id;
                var type = name.substring(name.indexOf("_") + 1, name.length);
                var param = "{'fileId':'" + json.data + "', 'tableId':'" + id + "', 'type':'" + type + "'}";
                $.ajax({
                    //url: "resourceFileController.do?save", //请求路径
					url:"/hrms/resourceFileController/save",
                    async: false, //是否异步请求，默认为true
                    type: "POST",
                    data: eval("(" + param + ")"),
                    contentType: "application/x-www-form-urlencoded", //编码类型
                    dataType: "json", //预处理服务端可能返回的数据类型
                    scriptCharset: "UTF-8", //编码
                    success: function (data) { //请求成功的回调函数
                        if (data.ok) {
                            //这是resourcefile里面的fileid
                            uploadIndex++;
                            obj.val("");
                            obj.next("input[name='suffix']").val("");
                            if (name.indexOf("_1") != -1) {
                                //身份证正面
                                $("#idCardZImg").attr("src", url);
                                $("#idCardZImg").parent("a").attr("href", url);
                                $("#idCardZImg").show();
                            }
                            else if (name.indexOf("_2") != -1) {
                                $("#idCardFImg").attr("src", url);
                                $("#idCardFImg").parent("a").attr("href", url);
                                $("#idCardFImg").show();
                            }
                            else if (name.indexOf("_3") != -1) {
                                $("#personImg").attr("src", url);
                                $("#personImg").parent("a").attr("href", url);
                                $("#personImg").show();
                            }

                            layer.closeAll();
                        }
                    }
                });
                //调用人脸核身函数
                getFaceInfo();
            }
        } else {
            setTimeout(function () {
                listenerUploadimg(url, name, obj);
            }, 1000);
        }
    }

    //获取用户对应图片集
    function loadImgId(id) {
        $.ajax({
            url: "resourceFileController.do?getImgByTabIdGroupType&tableId="+id, //请求路径
            async: false, //是否异步请求，默认为true
            type: "GET",
            contentType: "application/x-www-form-urlencoded", //编码类型
            dataType: "json", //预处理服务端可能返回的数据类型
            scriptCharset: "UTF-8", //编码
            success: function(data) { //请求成功的回调函数
                if(data.ok) {
                    var d = data.data;
                    if(wheatherEdit=="face"){
                        for(var i=0; i<d.length; i++) {
                            loadImgs(d[i].type, d[i].file_id);
                        }
                    }
                    else if(wheatherEdit=="edit"){
                        setTimeout(function() {
                            for(var i=0; i<d.length; i++) {
                                loadImgs(d[i].type, d[i].file_id);
                            }
                        }, 1000);
                    }
                }
            }
        });
    }
    //载入图片 、
    function loadImgs(type, id) {
        $.ajax({
            url: "file_plugin/find.do?id=" + id, //请求路径
            async: false, //是否异步请求，默认为true
            type: "GET",
            contentType: "application/x-www-form-urlencoded", //编码类型
            dataType: "json", //预处理服务端可能返回的数据类型
            scriptCharset: "UTF-8", //编码
            success: function(data) { //请求成功的回调函数
                if(data.ok) {
                    var d = data.data;
                    if(type == "1") {
                        //身份证正面
                        frontIdCartUrl=d.url;     //身份证正面网络地址
                        $("#idCardZImg").attr("src", d.url);
                        $("#idCardZImg").parent("a").attr("href",d.url);
                        $("#idCardZImg").show();
                    }
                    else if(type == "2"){
                        //身份证反面
                        ReverseIdCartUrl=d.url;   //身份证反面网络地址
                        $("#idCardFImg").attr("src", d.url);
                        $("#idCardFImg").parent("a").attr("href",d.url);
                        $("#idCardFImg").show();
                    }
                    else if(type == "3"){
                        //身份证反面
                        $("#personImg").attr("src", d.url);
                        $("#personImg").parent("a").attr("href",d.url);
                        $("#personImg").show();
                    }
                }
            }
        });
    }
    //初始化三张图
    function initImg() {
        $("#idCardZImg").removeAttr("src").hide();
        $("#idCardFImg").removeAttr("src").hide();
        $("#personImg").removeAttr("src").hide();
    }
    function getFaceInfo(){
        wheatherEdit="face";
        //加载图片
        loadImgId(id);

        if(ReverseIdCartUrl!=undefined&&frontIdCartUrl!=undefined){

            $.ajax({
                url : "faceApi/saveFace.do", //请求路径
                async : false, //是否异步请求，默认为true
                data:{
                    idCardNum:idCard,
                    name:userName,
                    frontPicUrl:frontIdCartUrl,
                    backPicUrl:ReverseIdCartUrl,
                },
                type : "GET",
                contentType : "application/x-www-form-urlencoded", //编码类型
                dataType : "json", //预处理服务端可能返回的数据类型
                scriptCharset : "UTF-8", //编码
                success : function(data) { //请求成功的回调函数

                    if(data.code != "-1"){
                        /* layer.msg("需求数量超额！", {icon:2} );
						 return false;
						 toFaceCheck(data.obj);*/
                    }else{
                        layer.alert(data.msg, {icon: 2});
                    }
                },
                error: function(data) { //请求失败的回调函数
                    layer.alert("服务器异常", {icon: 2});
                    layer.close(loadIndex);
                }
            });

            /* toFaceCheck(info);*/
        }

    }


    function toFaceCheck(info){
        var json = JSON.parse(info);
        var successRedirect = "http://www.baidu.com";        //识别通过回调的地址
        var failRedirect = "http://www.sina.cn";             //识别不通过回调的地址
        location.href=json.url+"&successRedirect="+successRedirect+"&failRedirect="+failRedirect;
    }

</script>

</body>

</html>
