<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Add Page</title>
    <style type="text/css">
        .addPerson{
            background-color: #ffffff;

            position:absolute;/**绝对定位**/
            left:0%;/**左边50%**/
            top:50%;/**顶部50%**/
            height: 500px;
            width: 700px;
            margin-top:50px;/**上移-50%**/
            margin-left:70px;/**左移-50%**/
            margin-right:100px;/**左移-50%**/
        }
        .inputStyle{
            width: 500px;
            border: 1px solid gray;
            border-radius: 18px;
            height: 30px;
            outline: none;
        }

    </style>
</head>
<body>
<div class="modal fade emp-add-modal" tabindex="-1" role="dialog" aria-labelledby="emp-add-modal">
    <div class="modal-dialog" role="document">
        <div class="addPerson"  class="modal-content">
            <div style="background-color: #26344b"  class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="color: #ffffff;font-weight: bold">员工新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_emp_form">
                    <div class="form-group">
                        <label style="font-weight: bold;font-size: large" for="add_inputName" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input class="inputStyle" type="text" name="empName" class="form-control" id="add_inputName" placeholder="如：张三">
                            <span id="helpBlock_add_inputName" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold;font-size: large" for="add_inputEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input  class="inputStyle" type="email" name="empEmail" class="form-control" id="add_inputEmail" placeholder="zs@qq.com">
                            <span id="helpBlock_add_inputEmail" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold;font-size: large" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-8">
                            <label style="font-weight: bold" class="radio-inline">
                                <input  type="radio" checked="checked" name="gender" id="add_inputGender1" value="M">男
                            </label>
                            <label style="font-weight: bold" class="radio-inline">
                                <input type="radio" name="gender" id="add_inputGender2" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold;font-size: large" for="add_department" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-8">
                            <div >
                                <select  class="inputStyle" class="form-control" name="departmentId" id="add_department">
                                   <%-- <option value="1">CEO</option>--%>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal" style="">关闭</button>
                <button type="button" class="btn btn-primary emp_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">

    <!-------------------------------------员工新增操作-------------------------------------->
    //=======0 点击 员工新增按钮，发送AJAX请求查询部门列表信息，弹出模态框，
    // 将查询得到的部门列表信息显示在对应模态框中部门信息处。=============================
    $(".emp_add_btn").click(function () {

        $.ajax({
            url:"/hrms/dept/getDeptName",
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    $.each(result.extendInfo.departmentList, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo("#add_department");
                    });
                }
            }
        });

        $('.emp-add-modal').modal({
            backdrop:static,
            keyboard:true
        });
    });

    //=========1 当鼠标从姓名输入框移开的时候，判断姓名输入框内的姓名是否重复 ============
    $("#add_inputName").change(function () {
        var empName = $("#add_inputName").val();
        $.ajax({
            url:"/hrms/emp/checkEmpExists",
            type:"GET",
            data:"empName="+empName,
            success:function (result) {
                if (result.code == 100){
                    $("#add_inputName").parent().parent().removeClass("has-error");
                    $("#add_inputName").parent().parent().addClass("has-success");
                    $("#helpBlock_add_inputName").text("用户名可用！");
                    $(".emp_save_btn").attr("btn_name_exists", "success");
                }else {
                    $("#add_inputName").parent().parent().removeClass("has-success");
                    $("#add_inputName").parent().parent().addClass("has-error");
                    $("#helpBlock_add_inputName").text(result.extendInfo.name_reg_error);
                    $(".emp_save_btn").attr("btn_name_exists", "error");
                }
            }
        });
    });

    //3 保存

    $(".emp_save_btn").click(function () {

        //1 获取到第3步：$(".emp_save_btn").attr("btn_name_exists", "success");中btn_name_exists的值
        // btn_name_exists = error，就是姓名重复
        if($(".emp_save_btn").attr("btn_name_exists") == "error"){
            return false;
        }

        //================2 对输入的姓名和邮箱格式进行验证===============
        var inputName = $("#add_inputName").val();
        var inputEmail = $("#add_inputEmail").val();
        //验证格式。姓名：2-5位中文或6-16位英文和数字组合；
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regName.test(inputName)){
            alert("测试：输入姓名格式不正确！");
            //输入框变红
            $("#add_inputName").parent().parent().addClass("has-error");
            //输入框下面显示红色提示信息
            $("#helpBlock_add_inputName").text("输入姓名为2-5位中文或6-16位英文和数字组合");
            return false;
        }else {
            //移除格式
            $("#add_inputName").parent().parent().removeClass("has-error");
            $("#add_inputName").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputName").hide();
        }
        if (!regEmail.test(inputEmail)){
            //输入框变红
            $("#add_inputEmail").parent().parent().addClass("has-error");
            //输入框下面显示红色提示信息
            $("#helpBlock_add_inputEmail").text("输入邮箱格式不正确！");
            return false;
        }else {
            //移除格式
            $("#add_inputEmail").parent().parent().removeClass("has-error");
            $("#add_inputName").parent().parent().addClass("has-success");
            $("#helpBlock_add_inputEmail").hide();
        }



        $.ajax({
            url:"/hrms/emp/addEmp",
            type:"POST",
            data:$(".add_emp_form").serialize(),
            success:function (result) {
                if (result.code == 100){
                    alert("员工新增成功");
                    $('#emp-add-modal').modal("hide");
                    //跳往最后一页，由于新增记录，所以要重新查询总页数
                    $.ajax({
                        url:"/hrms/emp/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            var totalPage = result.extendInfo.totalPages;
                            window.location.href="/hrms/emp/getEmpList?pageNo="+totalPage;
                        }
                    })
                } else {
                    alert("员工新增失败！");
                }
            }

        });





    });



</script>
</body>
</html>
