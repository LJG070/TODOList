package com.studyveloper.todolist.vo;

public class TodoVO {
	private int todoNumber;
	private String title;
	private String contents;
	private int importancy;
	private String performDate;
	private boolean completed;
	private String dueDate;
	
	public TodoVO() {
		
	}
	
	public TodoVO(String title, String contents, int importancy, 
			String performDate, boolean completed, String dueDate) {
		this.title = title;
		this.contents = contents;
		this.importancy = importancy;
		this.performDate = performDate;
		this.completed = completed;
		this.dueDate = dueDate;
	}
	
	public int getTodoNumber() {
		return todoNumber;
	}
	
	public void setTodoNumber(int todoNumber) {
		this.todoNumber = todoNumber;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContents() {
		return contents;
	}
	
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public int getImportancy() {
		return importancy;
	}
	
	public void setImportancy(int importancy) {
		this.importancy = importancy;
	}
	
	public String getPerformDate() {
		return performDate;
	}
	
	public void setPerformDate(String performDate) {
		this.performDate = performDate;
	}
	
	public boolean isCompleted() {
		return completed;
	}
	
	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
	
	public String getDueDate() {
		return dueDate;
	}
	
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
		
	}

	@Override
	public String toString() {
		return "TodoVO [todoNumber=" + todoNumber + ", title=" + title + ", contents=" + contents + ", importancy="
				+ importancy + ", performDate=" + performDate + ", completed=" + completed + ", dueDate=" + dueDate
				+ "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TodoVO other = (TodoVO) obj;
		if (completed != other.completed)
			return false;
		if (contents == null) {
			if (other.contents != null)
				return false;
		} else if (!contents.equals(other.contents))
			return false;
		if (dueDate == null) {
			if (other.dueDate != null)
				return false;
		} else if (!dueDate.equals(other.dueDate))
			return false;
		if (importancy != other.importancy)
			return false;
		if (performDate == null) {
			if (other.performDate != null)
				return false;
		} else if (!performDate.equals(other.performDate))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}
}
