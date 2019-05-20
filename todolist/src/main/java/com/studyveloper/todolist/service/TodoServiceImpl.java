package com.studyveloper.todolist.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.studyveloper.todolist.bean.TodoBean;
import com.studyveloper.todolist.bean.TodoBeanUtil;
import com.studyveloper.todolist.dao.TodoDao;
import com.studyveloper.todolist.util.DateUtil;
import com.studyveloper.todolist.vo.TodoVO;

@Service
public class TodoServiceImpl implements TodoService{
	@Autowired
	private TodoDao todoDao;
	
	public TodoServiceImpl() {}
	
	public TodoServiceImpl(TodoDao todoDao) {
		this.todoDao = todoDao;
	}
	
	public void setTodoDao(TodoDao todoDao) {
		this.todoDao = todoDao;
	}
	
	@Override
	public boolean registerTodo(TodoBean todo) {
		// TODO Auto-generated method stub
		
		boolean result = this.todoDao.addTodo(TodoBeanUtil.beanToVO(todo));
		
		return result;
	}

	@Override
	public boolean modifyTodo(int todoNumber, TodoBean todo) {
		// TODO Auto-generated method stub
		
		boolean result = this.todoDao.modifyTodo(todoNumber, TodoBeanUtil.beanToVO(todo));
		
		return result;
	}

	@Override
	public boolean deleteTodo(List<Integer> todoNumbers) {
		// TODO Auto-generated method stub
		if(todoNumbers.size() == 1) {
			return this.todoDao.deleteTodo(todoNumbers.get(0));
		}
		
		return this.todoDao.deleteTodo(todoNumbers);
	}

	@Override
	public List<TodoBean> searchTodoByPerformDate(String performDate, Integer term) {
		// TODO Auto-generated method stub
		List<TodoBean> todoList = new ArrayList<TodoBean>();
		List<TodoVO> result;
		
		if(term == null || term < 0) {
			result = this.todoDao.searchTodoByPerformDate(performDate);
		} else {
			result = this.todoDao.searchTodoByPerformDate(performDate, term);
		}
		
		if(result == null) return null;
		
		for(TodoVO element : result) {
			todoList.add(TodoBeanUtil.voToBean(element));
		}
		
		return todoList;
	}

	@Override
	public List<TodoBean> searchTodoByImportancy(String performDate, int importancy, Integer term) {
		// TODO Auto-generated method stub
		List<TodoBean> todoList = new ArrayList<TodoBean>();
		List<TodoVO> result;
		
		if(term == null || term < 0) {
			result = this.todoDao.searchTodoByImportancy(performDate, importancy);
		} else {
			result = this.todoDao.searchTodoByImportancy(performDate, importancy, term);
		}
		
		if(result == null) return null;
		
		for(TodoVO element : result) {
			todoList.add(TodoBeanUtil.voToBean(element));
		}
		
		return todoList;
	}
	
	public List<TodoBean> getAllTodo(){
		List<TodoBean> todoList = new ArrayList<TodoBean>();
		List<TodoVO> result = new ArrayList<TodoVO>();
		
		result = this.todoDao.getAllTodo();
		
		if(result == null) return null;
		
		for(TodoVO element : result) {
			todoList.add(TodoBeanUtil.voToBean(element));
		}
		
		return todoList;
	}
	
	@Override
	public List<TodoBean> searchCompletedTodo(String date, boolean completed, Integer term) {
		// TODO Auto-generated method stub
		List<TodoBean> todoList = new ArrayList<TodoBean>();
		List<TodoVO> result = new ArrayList<TodoVO>();

		result = this.todoDao.searchCompletedTodo(date, completed, term);
		
		if(result == null) return null;
		
		for(TodoVO element : result) {
			todoList.add(TodoBeanUtil.voToBean(element));
		}
		
		return todoList;
	}

	@Override
	public List<TodoBean> searchTodoByDueDate(String dueDate) {
		// TODO Auto-generated method stub
		List<TodoBean> todoList = new ArrayList<TodoBean>();
		List<TodoVO> result;
		
		result = this.todoDao.searchTodoByDueDate(dueDate);
		
		if(result == null) return null;
		
		for(TodoVO element : result) {
			todoList.add(TodoBeanUtil.voToBean(element));
		}
		
		return todoList;
	}
	
	public List<List<TodoBean>> searchWeeklyTodo(boolean completed, Integer term){
		List<List<TodoBean>> weeklyTodoList = new ArrayList<List<TodoBean>>();
		
		DateUtil dateUtil = new DateUtil();
		
		for(int i = 0; i < 7; ++i) {
			String date = dateUtil.getDate("yyyy-MM-dd", "Asia/Seoul", i);
			
			List<TodoBean> result = this.searchCompletedTodo(date, completed, term);
			
			weeklyTodoList.add(result);
		}
		
		return weeklyTodoList;
	}
}
