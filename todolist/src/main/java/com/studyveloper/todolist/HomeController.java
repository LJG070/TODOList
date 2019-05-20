package com.studyveloper.todolist;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.studyveloper.todolist.bean.TodoBean;
import com.studyveloper.todolist.service.TodoService;
import com.studyveloper.todolist.util.DateUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private TodoService todoService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		DateUtil dateUtil = new DateUtil();
		
		String currentDate = dateUtil.getCurrentDate("yyyy-MM-dd", "Asia/Seoul");
		
		List<TodoBean> todoList = this.todoService.searchCompletedTodo(currentDate, false, 0);
		
		model.addAttribute("todoList", todoList);
		model.addAttribute("year", currentDate.split("-")[0]);
		model.addAttribute("month", currentDate.split("-")[1]);
		model.addAttribute("day", currentDate.split("-")[2]);
		
		return "todo";
	}
	
	@RequestMapping(value="/addtodo", method = RequestMethod.POST)
	public String addTodo(@RequestParam(value="path") String url,
						@RequestParam(value="title") String title,
						@RequestParam(value="contents") String contents,
						@RequestParam(value="importancy") int importancy,
						@RequestParam(value="performDate", required=false) String performDate,
						@RequestParam(value="dueDate", required=false) String dueDate) {
		DateUtil dateUtil = new DateUtil();
		
		String currentDate = dateUtil.getCurrentDate("yyyy-MM-dd", "Asia/Seoul");
		
		TodoBean todoBean = new TodoBean();
		
		todoBean.setCompleted(false);
		todoBean.setContents(contents);
		todoBean.setImportancy(importancy);
		
		if(performDate.trim().length() != 0) {todoBean.setPerformDate(performDate);}
		else todoBean.setPerformDate(currentDate);
		
		todoBean.setTitle(title);
		
		if(dueDate.trim().length() != 0) {todoBean.setDueDate(dueDate);}
		
		logger.info("ADDTODO : " + todoBean.toString());
		this.todoService.registerTodo(todoBean);
		
		if(url.equals("/weekly")) return "redirect:/weekly";
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/modifytodo", method=RequestMethod.POST)
	public String modifyTodo(@RequestParam(value="path") String url,
							@RequestParam(value="todoNumber") int todoNumber,
							@RequestParam(value="title") String title,
							@RequestParam(value="contents") String contents,
							@RequestParam(value="importancy") int importancy,
							@RequestParam(value="performDate") String performDate,
							@RequestParam(value="dueDate", required=false) String dueDate,
							@RequestParam(value="completed", required=false, defaultValue="false")
							boolean completed) {
		
		TodoBean todoBean = new TodoBean();
		
		todoBean.setTodoNumber(todoNumber);
		todoBean.setCompleted(false);
		todoBean.setContents(contents);
		todoBean.setImportancy(importancy);
		todoBean.setPerformDate(performDate);
		todoBean.setTitle(title);
		if(dueDate.trim().length() != 0) {todoBean.setDueDate(dueDate);}
		if(completed) {todoBean.setCompleted(true);}
		boolean result = this.todoService.modifyTodo(todoNumber, todoBean);
		
		if(url.equals("/weekly")) return "redirect:/weekly";
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/deletetodo", method=RequestMethod.POST)
	public Map<String, Object> deleteTodo(@RequestBody Map<String, Object> parameters){
		Map<String, Object> result = new HashMap<String, Object>();
		
		String number = parameters.get("todoNumber").toString();
		
		int todoNumber = Integer.parseInt(number);
		
		List<Integer> todoNumbers = new ArrayList<Integer>();
		todoNumbers.add(todoNumber);
		
		boolean flag = this.todoService.deleteTodo(todoNumbers);
		
		result.put("flag", flag);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/duetodo", method=RequestMethod.GET)
	public Map<String, Object> dueTodo(){
		Map<String, Object> result = new HashMap<String, Object>();
		
		DateUtil dateUtil = new DateUtil();
		
		String dueDate = dateUtil.getCurrentDate("yyyy-MM-dd", "Asia/Seoul");
		
		List<TodoBean> todoList = this.todoService.searchTodoByDueDate(dueDate);
		
		result.put("dueTodoCount", todoList.size());
		
		return result;
	}
	
	@RequestMapping(value="/weekly", method=RequestMethod.GET)
	public String weeklyTodo(Model model) {
		List<List<TodoBean>> weekly = this.todoService.searchWeeklyTodo(false, 0);
		
		DateUtil dateUtil = new DateUtil();
		
		String currentDate = dateUtil.getCurrentDate("yyyy-MM-dd", "Asia/Seoul");
		
		model.addAttribute("year", currentDate.split("-")[0]);
		model.addAttribute("month", currentDate.split("-")[1]);
		model.addAttribute("day", currentDate.split("-")[2]);
		
		model.addAttribute("weekly", weekly);
		
		return "todo";
	}
	
	@RequestMapping(value="/duetodolist", method=RequestMethod.GET)
	public String dueTodoList(Model model) {
		DateUtil dateUtil = new DateUtil();
		
		String currentDate = dateUtil.getCurrentDate("yyyy-MM-dd", "Asia/Seoul");
		
		List<TodoBean> dueTodoList = this.todoService.searchTodoByDueDate(currentDate);
		
		model.addAttribute("duetodolist", dueTodoList);
		
		return "duetodo";
	}
}
