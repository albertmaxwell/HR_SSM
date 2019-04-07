<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>部门新增页面</title>
</head>
<body>
<div class="modal fade rights-add-modal" tabindex="-1" role="dialog" aria-labelledby="rights-add-modal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">用户新增</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal add_rithts_form">

					<div class="form-group">
						<label for="add_rightsName" class="col-sm-2 control-label">用户姓名</label>
						<div class="col-sm-8">
							<input type="text" name="rithtsName" class="form-control" id="add_rightsName" placeholder="人事部">
						</div>
					</div>

					<div class="form-group">
						<label for="add_rightsAccount" class="col-sm-2 control-label">账号</label>
						<div class="col-sm-8">
							<input type="text" name="rightsAccount" class="form-control" id="add_rightsAccount" placeholder="XXX">
						</div>
					</div>

					<div class="form-group">
						<label for="add_rightsPassword" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-8">
							<input type="text" name="rightsPassword" class="form-control" id="add_rightsPassword" placeholder="XXX">
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary rithts_save_btn">保存</button>
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
    $(".rights_add_btn").click(function () {
        $('.rights-add-modal').modal({
            backdrop:static,
            keyboard:true
        });

    });

    $(".rithts_save_btn").click(function () {
        var rithtsName = $("#add_rithtsName").val();
        var rithtsLeader = $("#add_rithtsLeader").val();
        //验证省略...
        $.ajax({
            url:"/hrms/rithts/addrithts",
            type:"PUT",
            data:$(".add_rithts_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("新增成功");
                    $('.rights-add-modal').modal("hide");
                    $.ajax({
                        url:"/hrms/rithts/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/hrms/rithts/getRighrMantList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_rithts_error);
                }
            }
        });



    });



</script>
</body>
</html>
