package com.qjx.test;

import com.qjx.dao.DepartmentMapper;
import com.qjx.dao.EmployeeMapper;
import com.qjx.pojo.Department;
import com.qjx.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @PackageName: com.qjx.test
 * @ClassName: MapperTest
 * @Author: qjx
 * @Date: 2020/10/20 22:28
 * @Description: 测试dao层工作
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})     //指定spring配置文件的位置
public class MapperTest {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    /**
     * @Author: qjx
     * @Date: 8:49 2020/10/21
     * @Param: []
     * @return: void
     * @Description: 测试DepartmentMapper
     **/
    @Test
    public void testCRUD(){

//        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//
//        DepartmentMapper bean = context.getBean(DepartmentMapper.class);
//

        //使用spring的单元测试
        //departmentMapper.insertSelective(new Department(null, "开发部"));
       // departmentMapper.insertSelective(new Department(null, "测试部"));
       // departmentMapper.insertSelective(new Department(null, "运维部"));

        System.out.println(departmentMapper.selectByPrimaryKey(3));

        //employeeMapper.insertSelective(new Employee(null, "Tom", "1", "tom@123.com", 1));
        //批量插入

//        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 100; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5);
//            mapper.insert(new Employee(null, uid, "1", uid+"@123.com", 1));
//        }
//        System.out.println("批量操作完成");

        //批量删除
//        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
//        for(int i = 0; i < 50; i++){
//            mapper.deleteByPrimaryKey(i);
//        }
//        System.out.println("批量操作完成");



        /*//批量修改 错
        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
        for(int i = 50; i < 101; i++){
            mapper.updateByPrimaryKey(new Employee(1, "", "", "", 1));
        }*/
    }
}
