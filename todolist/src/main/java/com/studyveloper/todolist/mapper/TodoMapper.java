package com.studyveloper.todolist.mapper;

import java.util.List;
import java.util.Map;

import com.studyveloper.todolist.vo.TodoVO;

public interface TodoMapper {
	public int addTodo(TodoVO todoVO);
	public TodoVO afterInsertTodo();
	public int modifyTodo(Map<String, Object> map);
	public int deleteTodo(int todoNumber);
	public int deleteTodoList(List<Integer> todoNumbers);
	public int deleteAllTodo();
	public TodoVO searchTodo(int todoNumber);
	public List<TodoVO> searchTodoList(List<Integer> todoNumbers);
	public List<TodoVO> searchTodoByPerformDate(Map<String, Object> map);
	public List<TodoVO> searchTodoByImportancy(Map<String, Object> map);
	public List<TodoVO> searchCompletedTodo(Map<String, Object> map);
	public List<TodoVO> searchTodoByDueDate(String dueDate);
	public List<TodoVO> getAllTodo();
	public void resetKey();
}
