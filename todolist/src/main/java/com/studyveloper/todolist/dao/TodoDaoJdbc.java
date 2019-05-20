package com.studyveloper.todolist.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.studyveloper.todolist.mapper.TodoMapper;
import com.studyveloper.todolist.vo.TodoVO;

@Repository
public class TodoDaoJdbc implements TodoDao{
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	public TodoDaoJdbc() {
		
	}
	
	public TodoDaoJdbc(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	@Override
	public boolean addTodo(TodoVO todoVO) {
		TransactionStatus status = 
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
				
		try {
			int result = todoMapper.addTodo(todoVO);
			
			TodoVO todo = null;
			
			if(result == 1) {  todo = todoMapper.afterInsertTodo();}
			
			if(todoVO.equals(todo)) {
				this.transactionManager.commit(status);
				return true;
			} else {
				this.transactionManager.rollback(status);
			}
			
		} catch(RuntimeException e) {
			this.transactionManager.rollback(status);
		}
		
		return false;
	}
	
	@Override
	public boolean modifyTodo(int todoNumber, TodoVO todoVO) {
		TransactionStatus status = 
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("todo", todoVO);
			map.put("todoNumber", todoNumber);
			
			int result = todoMapper.modifyTodo(map);
			
			TodoVO updatedTodo = todoMapper.searchTodo(todoNumber);
			
			if(result == 1 && todoVO.equals(updatedTodo)) {
				this.transactionManager.commit(status);
				return true;
			} else {
				this.transactionManager.rollback(status);
			}
		} catch(RuntimeException e) {
			this.transactionManager.rollback(status);
		}
		return false;
	}
	
	@Override
	public boolean deleteTodo(int todoNumber) {
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);

		int result = todoMapper.deleteTodo(todoNumber);
		
		if(result == 1) { return true; }
		
		return false;
	}
	
	@Override
	public boolean deleteTodo(List<Integer> todoNumbers) {
		TransactionStatus status = 
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		try {
			int result = todoMapper.deleteTodoList(todoNumbers);
			
			if(result == todoNumbers.size()) {
				this.transactionManager.commit(status);
				return true; 
			} else {
				this.transactionManager.rollback(status);
			}
		} catch(RuntimeException e) {
			this.transactionManager.rollback(status);
		}
		
		return false;
	}
	
	@Override
	public TodoVO searchTodo(int todoNumber) {
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);

		TodoVO todo = todoMapper.searchTodo(todoNumber);
		
		return todo;
	}
	
	@Override
	public List<TodoVO> searchTodo(List<Integer> todoNumbers){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);

		List<TodoVO> todoList = todoMapper.searchTodoList(todoNumbers);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchTodoByPerformDate(String performDate) {
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("performDate", performDate);
		
		List<TodoVO> todoList = todoMapper.searchTodoByPerformDate(map);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchTodoByPerformDate(String performDate, int term){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("performDate", performDate);
		map.put("term", term);
		
		List<TodoVO> todoList = todoMapper.searchTodoByPerformDate(map);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchTodoByImportancy(String performDate, int importancy){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("performDate", performDate);
		map.put("importancy", importancy);
		
		List<TodoVO> todoList = todoMapper.searchTodoByImportancy(map);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchTodoByImportancy(String performDate, int importancy, int term){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("performDate", performDate);
		map.put("importancy", importancy);
		map.put("term", term);
		
		List<TodoVO> todoList = todoMapper.searchTodoByImportancy(map);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchCompletedTodo(String performDate, boolean completed, int term){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("performDate", performDate);
		map.put("completed", completed);
		map.put("term", term);
		
		List<TodoVO> todoList = todoMapper.searchCompletedTodo(map);
		
		return todoList;
	}
	
	@Override
	public List<TodoVO> searchTodoByDueDate(String dueDate){
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		List<TodoVO> todoList = todoMapper.searchTodoByDueDate(dueDate);
		
		return todoList;
	}
	
	@Override
	public void deleteAllTodo() {
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		todoMapper.deleteAllTodo();
		todoMapper.resetKey();
	}
	
	@Override
	public List<TodoVO> getAllTodo() {
		TodoMapper todoMapper = this.sqlSession.getMapper(TodoMapper.class);
		
		return todoMapper.getAllTodo();
	}
}
