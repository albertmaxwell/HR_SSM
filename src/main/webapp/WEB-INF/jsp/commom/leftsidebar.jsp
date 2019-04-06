<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<%=request.getContextPath()%>/plug-in/jquery/jquery-1.9.1.js"></script>
<script src="<%=request.getContextPath()%>/plug-in/layer/layer/layer.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<style type="text/css">
    .navigation_bar_font{
        font-size: large;
        font-weight: bolder;
        text-align: center;
    }

</style>
<div style="background-color: #26344b;height: 1200px" class="panel-group col-sm-2" id="hrms_sidebar_left" role="tablist" aria-multiselectable="true">
    <ul class="nav nav-pills nav-stacked emp_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_emp">
                <span class="navigation_bar_font" class="glyphicon glyphicon-user" aria-hidden="true">员工管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_emp">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="emp_info"><font color="#ffffff">员工信息</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" role="button" class="emp_add_btn" data-toggle="modal" data-target=".emp-add-modal"><font color="#ffffff">员工新增</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="emp_clearall_btn"><font color="#ffffff">员工清零</font></a></li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="navigation_bar_font" class="glyphicon glyphicon-cloud" aria-hidden="true">部门管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_info"><font color="#ffffff">部门信息</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_add_btn" data-toggle="modal" data-target=".dept-add-modal"><font color="#ffffff">部门新增</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_clearall_btn"><font color="#ffffff">部门清零</font></a></li>
            </ul>
        </li>
    </ul>

</div><!-- /.panel-group，#hrms_sidebar_left -->

<script type="text/javascript">
    //跳转到员工页面
    $(".emp_info").click(function () {
        $(this).attr("href", "/hrms/emp/getEmpList");
    });
    //跳转到部门页面
    $(".dept_info").click(function () {
        $(this).attr("href", "/hrms/dept/getDeptList");
    });
    //员工清零这个功能暂未实现
    $(".emp_clearall_btn").click(function () {

        layer.alert("对不起，您暂无权限进行操作！请先获取权限", {icon:5} );
        return false;


    });
    //部门清零这个功能暂未实现
    $(".dept_clearall_btn").click(function () {
        layer.alert("对不起，您暂无权限进行操作！请先获取权限", {icon:5} );
        return false;
    });
</script>
</body>
</html>
