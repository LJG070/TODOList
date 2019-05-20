package com.studyveloper.todolist.bean;

import com.studyveloper.todolist.vo.TodoVO;

public class TodoBeanUtil {
	public static TodoVO beanToVO(TodoBean todoBean) {
		TodoVO todoVO = new TodoVO();
		
		todoVO.setTodoNumber(todoBean.getTodoNumber());
		todoVO.setTitle(todoBean.getTitle());
		todoVO.setContents(todoBean.getContents());
		todoVO.setPerformDate(todoBean.getPerformDate());
		todoVO.setImportancy(todoBean.getImportancy());
		todoVO.setCompleted(todoBean.isCompleted());
		todoVO.setDueDate(todoBean.getDueDate());
		
		return todoVO;
	}
	
	public static TodoBean voToBean(TodoVO todoVO) {
		TodoBean todoBean = new TodoBean();
		
		todoBean.setTodoNumber(todoVO.getTodoNumber());
		todoBean.setTitle(todoVO.getTitle());
		todoBean.setContents(todoVO.getContents());
		todoBean.setPerformDate(todoVO.getPerformDate());
		todoBean.setImportancy(todoVO.getImportancy());
		todoBean.setCompleted(todoVO.isCompleted());
		todoBean.setDueDate(todoVO.getDueDate());
		
		return todoBean;
	}
}
