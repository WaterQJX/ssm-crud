package com.qjx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qjx.pojo.Employee;
import com.qjx.pojo.Msg;
import com.qjx.service.EmpolyeeService;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.BeanInfoFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @PackageName: com.qjx.controller
 * @ClassName: EmpolyeeController
 * @Author: qjx
 * @Date: 2020/10/21 13:44
 * @Description:
 */

@Controller
public class EmpolyeeController {
    @Autowired
    private EmpolyeeService empolyeeService;


    /**
     * @Author: qjx
     * @Date: 20:50 2020/10/24
     * @Param: [id]
     * @return: com.qjx.pojo.Msg
     * @Description: 单个删除和多个删除
     **/
    @ResponseBody
    @DeleteMapping("/emp/{empIds}")
    public Msg deleteEmp(@PathVariable("empIds") String empIds){

        if(empIds.contains("-")){

            List<Integer> ids = new ArrayList<>();

            String[] del_ids = empIds.split("-");
            for (String del_id : del_ids) {
                ids.add(Integer.parseInt(del_id));
            }
            empolyeeService.deleteBatch(ids);


        }else{

            Integer id = Integer.parseInt(empIds);

            empolyeeService.deleteEmp(id);


        }
        
        return Msg.success();

    }


    /**
     * @Author: qjx
     * @Date: 19:42 2020/10/24
     * @Param: []
     * @return: com.qjx.pojo.Msg
     * @Description: 更新员工信息
     **/
    @ResponseBody
    @PutMapping("/emp/{empId}")
    public Msg updateEmp(Employee employee){

        empolyeeService.updateEmp(employee);

        return Msg.success();
    }

    /**
     * @Author: qjx
     * @Date: 18:59 2020/10/24
     * @Param: [id]
     * @return: com.qjx.pojo.Msg
     * @Description: 通过Id查询员工信息
     **/

    @ResponseBody
    @GetMapping("/emp/{id}")
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = empolyeeService.getEmpById(id);

        return Msg.success().add("emp", emp);
    }

    /**
     * @Author: qjx
     * @Date: 13:42 2020/10/23
     * @Param: [empName]
     * @return: com.qjx.pojo.Msg
     * @Description: 检查用户名是否可用
     **/
    @ResponseBody
    @PostMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){

        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
        }


        boolean b = empolyeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户名重复");
        }
    }


    /**
     * @Author: qjx
     * @Date: 20:35 2020/10/22
     * @Param: []
     * @return: com.qjx.pojo.Msg
     * @Description: 保存员工信息
     **/
    @ResponseBody
    @PostMapping("/emp")
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        if(result.hasErrors()){
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {

                map.put(fieldError.getField(), fieldError.getDefaultMessage());

            }

            return Msg.fail().add("errorFields", map);
        }else{
            empolyeeService.saveEmp(employee);

            return Msg.success();
        }

    }


    /**
     * @Author: qjx
     * @Date: 13:45 2020/10/21
     * @Param: []
     * @return: java.lang.String
     * @Description: 查询员工数据
     **/
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam( value = "pageNumber", defaultValue = "1") Integer pageNumber){
        PageHelper.startPage(pageNumber, 5);
        List<Employee> emps = empolyeeService.getAllEmps();

        PageInfo pageInfo = new PageInfo(emps, 5);


        return Msg.success().add("pageInfo", pageInfo);
    }

   // @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model){
//
//        PageHelper.startPage(pageNumber, 5);
//
//        List<Employee> emps = empolyeeService.getAll();
//
//        PageInfo pageInfo = new PageInfo(emps, 5);
//        model.addAttribute("pageInfo", pageInfo);
//
//        return "list";
//    }
}
