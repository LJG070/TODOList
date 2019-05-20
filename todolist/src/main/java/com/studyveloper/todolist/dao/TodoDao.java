package com.studyveloper.todolist.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.studyveloper.todolist.mapper.TodoMapper;
import com.studyveloper.todolist.vo.TodoVO;

public interface TodoDao {
	public boolean addTodo(TodoVO todoVO);
	public boolean modifyTodo(int todoNumber, TodoVO todoVO);
	public boolean deleteTodo(int todoNumber);
	public boolean deleteTodo(List<Integer> todoNumbers);
	public TodoVO searchTodo(int todoNumber);
	public List<TodoVO> searchTodo(List<Integer> todoNumbers);
	public List<TodoVO> searchTodoByPerformDate(String performDate);
	public List<TodoVO> searchTodoByPerformDate(String performDate, int term);
	public List<TodoVO> searchTodoByImportancy(String performDate, int importancy);
	public List<TodoVO> searchTodoByImportancy(String performDate, int importancy, int term);
	public List<TodoVO> searchCompletedTodo(String performDate, boolean completed, int term);
	public List<TodoVO> searchTodoByDueDate(String dueDate);
	public void deleteAllTodo();
	public List<TodoVO> getAllTodo();
}
