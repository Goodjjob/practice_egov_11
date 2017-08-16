package egovframework.example.left.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.left.service.LeftService;

@Controller
public class LeftController {

	@Resource(name = "leftService")
	private LeftService leftService;
	
	@RequestMapping(value = "mainMenuList.do")
	public void leftListLoad(HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		List<?> menuList = leftService.selectLeftList();
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(menuList));
		
		System.out.println(JsonUtil.ListToJson(menuList).toString());
	}
}
