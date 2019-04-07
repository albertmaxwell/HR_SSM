<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>权限更改页面</title>
</head>
<body>
<div class="modal fade rights-update-modal" tabindex="-1" role="dialog" aria-labelledby="rights-update-modal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">权限更改</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal update_rights_form">

					<div class="form-group">
						<label for="update_rightsId" class="col-sm-2 control-label">人员ID</label>
						<div class="col-sm-8">
							<input type="text" name="rightsId" class="form-control" id="update_rightsId">
						</div>
					</div>

					<div class="form-group">
						<label for="update_rightsName" class="col-sm-2 control-label">人员名称</label>
						<div class="col-sm-8">
							<input type="text" name="rightsName" class="form-control" id="update_rightsName">
						</div>
					</div>

					<div class="form-group">
						<label for="update_rightsAccount" class="col-sm-2 control-label">账号</label>
						<div class="col-sm-8">
							<input type="text" name="rightsAccount" class="form-control" id="update_rightsAccount">
						</div>
					</div>

					<div class="form-group">
						<label for="update_rightsPassword" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-8">
							<input type="text" name="rightsPassword" class="form-control" id="update_rightsPassword">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary rights_update_btn">保存</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================权限新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的权限信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_rightsId = 0;
    var curPageNo = ${curPageNo};

    $(".rights_edit_btn").click(function () {
        edit_rightsId = $(this).parent().parent().find("td:eq(0)").text();
        //alert("id"+edit_rightsId);
        //查询对应rightsId的权限信息
        $.ajax({
            url:"/hrms/rights/getRightsById/"+edit_rightsId,
            type:"GET",
            success:function (result) {

                if (result.code == 100){
                    var rightsData = result.extendInfo.rightsMan;
                    //回显
                    $("#update_rightsId").val(rightsData.rightsId);
                    $("#update_rightsName").val(rightsData.rightsName);
                    $("#update_rightsAccount").val(rightsData.rightsAccount);
                    $("#update_rightsPassword").val(rightsData.rightsPassword);
                }else {
                    alert(result.extendInfo.get_rights_error);
                }
            }
        });
    });

    $(".rights_update_btn").click(function () {
        $.ajax({
            url:"/hrms/rights/updateRights/"+edit_rightsId,
            type:"PUT",
            data:$(".update_rights_form").serialize(),
            success:function (result) {

                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/hrms/rights/getRightsList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_rights_error);
                }
            }

        });
    });


</script>
</body>
</html>
