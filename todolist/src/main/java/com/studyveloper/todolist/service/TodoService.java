package com.studyveloper.todolist.service;

import java.util.List;

import com.studyveloper.todolist.bean.TodoBean;

public interface TodoService {
	public boolean registerTodo(TodoBean todo);
	public boolean modifyTodo(int todoNumber, TodoBean todo);
	public boolean deleteTodo(List<Integer> todoNumbers);
	public List<TodoBean> searchTodoByPerformDate(String performDate, Integer term);
	public List<TodoBean> searchTodoByImportancy(String performDate, int importancy, Integer term);
	public List<TodoBean> searchCompletedTodo(String date, boolean completed, Integer term);
	public List<TodoBean> searchTodoByDueDate(String dueDate);
	public List<List<TodoBean>> searchWeeklyTodo(boolean completed, Integer term);
}
