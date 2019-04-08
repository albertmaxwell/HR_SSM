<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>部门更改页面</title>
</head>
<body>
<div class="modal fade con-update-modal" tabindex="-1" role="dialog" aria-labelledby="con-update-modal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">合同更改</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal update_con_form">
					<div class="form-group">
						<label for="update_conCode" class="col-sm-2 control-label">合同编号</label>
						<div class="col-sm-8">
							<input type="text" name="contractsCode" class="form-control" id="update_conCode">
						</div>
					</div>
					<div class="form-group">
						<label for="update_conTitle" class="col-sm-2 control-label">合同标题</label>
						<div class="col-sm-8">
							<input type="text" name="contractsTitle" class="form-control" id="update_conTitle">
						</div>
					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary con_update_btn">保存</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================部门新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的部门信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_conId = 0;
    var curPageNo = ${curPageNo};

    $(".con_edit_btn").click(function () {
        edit_conId = $(this).parent().parent().find("td:eq(0)").text();

        //查询对应conId的部门信息
        $.ajax({
            url:"/hrms/contracts/getConById/"+edit_conId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var conData = result.extendInfo.contractsEntity;
                    //回显
                    $("#update_conCode").val(conData.contractsCode);
                    $("#update_conTitle").val(conData.contractsTitle);
                }else {
                    alert(result.extendInfo.get_con_error);
                }
            }
        });
    });

    $(".con_update_btn").click(function () {
        $.ajax({
            url:"/hrms/contracts/updateCon/"+edit_conId,
            type:"PUT",
            data:$(".update_con_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/hrms/contracts/getConList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_con_error);
                }
            }

        });
    });


</script>
</body>
</html>
