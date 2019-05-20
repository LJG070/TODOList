<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.yellow-amber.min.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/dialog-polyfill.css" />
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  <script src="/resources/js/dialog-polyfill.js"></script>
  <title>TodoList</title>
  <style>
  	#add-btn {
  		z-index : 1000;
  		position : fixed;
  		bottom : 3rem;
  		right : 3rem;
  	}
  </style>
</head>
<body>
  <div class="mdl-layout mdl-js-layout">

    <header class="layout-transparent mdl-layout__header">
      <div class="mdl-layout__header-row">
        <span class="mdl-layout__title">TodoList</span>
        <div class="mdl-layout-spacer"></div>
        <div class="mdl-badge mdl-badge--overlap" id="due-todo" data-badge="">
        <button type="button" id="demo-menu-lower-right" 
        class="mdl-button mdl-js-button mdl-button--icon"
        id="due-todo-btn">
              <i class="material-icons">notifications</i>
            </button>
            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect" for="demo-menu-lower-right" id="todo-importancy-ul">
              <li class="mdl-menu__item" id="notify-due-count"></li>
            </ul>
       </div>
      </div>
    </header>

    <div class="mdl-layout__drawer">
        <nav class="mdl-navigation">
          <a class="mdl-navigation__link" href="/duetodolist" style="text-align:center;"><h5>마 감 목 록</h5></a>
          <a class="mdl-navigation__link" href="/" style="text-align:center;"><h5>  오   늘  </h5></a>
          <a class="mdl-navigation__link" href="/weekly" style="text-align:center;"><h5>  1  주  일</h5></a>
        </nav>
    </div>

    <main class="mdl-layout__content">
      <div class="mdl-grid">
        <div class="mdl-cell mdl-cell--12-col">
        </div>
      </div>
      	<c:choose>
      		<c:when test="${empty todoList}">
      			<div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col" name="todo">
	          <div class="mdl-card__title">
	            <h2 class="mdl-card__title-text">만료된 Todo가 없습니다</h2>
	          </div>
	          <div class="mdl-card__supporting-text">
	            	열심히 Todo를 하셨군요!  
	          </div>
	          <div class="mdl-card__actions mdl-card--border"></div>
	        	</div>
      		</c:when>
      	</c:choose>
		<c:forEach items="${dueTodoList}" var="todo" varStatus="number">
	        <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col" name="todo">
	       		<input type="hidden" id="todo-number-hidden" value="${todo.todoNumber}"></input>
	        	<input type="hidden" id="todo-importancy-hidden" value="${todo.importancy}"></input>
	        	<input type="hidden" id="todo-performdate-hidden" value="${todo.performDate}"></input>
	        	<input type="hidden" id="todo-duedate-hidden" value="${todo.dueDate}"></input>
	          <div class="mdl-card__title">
	            <h2 class="mdl-card__title-text" id="todo-title-hidden">${todo.title}</h2>
	          </div>
	          <div class="mdl-card__supporting-text" id="todo-contents-hidden">
	            ${todo.contents}
	          </div>
	          <div class="mdl-card__actions mdl-card--border">
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" id="delete-btn">  삭  제  </a>
	          </div>
	          <div class="mdl-card__menu">
			    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect" id="complete-btn">
			      <i class="material-icons">check_circle</i>
			    </button>
			  </div>
	        </div>
        </c:forEach>
    </main>
</div>

</body>

<script  type="text/javascript">
  var path = window.location.pathname;

	$.ajax({ 
		type: 'GET',
		url: '/duetodo' , 
		success: function(data) {
			$('#due-todo').attr('data-badge', data.dueTodoCount);
			$('#notify-due-count').text('총 ' + data.dueTodoCount + '건의 만료된 Todo가 있습니다');
		}
	});
  
	$('#notify-due-count').on('click', function(){
		location.href="/duetodolist";
	});
	
  $('[name=todo]').each(function(){
    var target = $(this);
    var todoNumber = $(this).find('#todo-number-hidden').val();
    var title = $(this).find('#todo-title-hidden').text().trim();
    var contents = $(this).find('#todo-contents-hidden').text().trim();
    var importancy = $(this).find('#todo-importancy-hidden').val();
    var importancyList = $('#todo-importancy-ul').find('li:eq('+ importancy+')');
    var importancyText =$(importancyList).text();
    var performDate = $(this).find('#todo-performdate-hidden').val();
    var dueDate = $(this).find('#todo-duedate-hidden').val();
    var completed = false;
    
    //삭제 버튼 클릭시
    $(this).find('#delete-btn').on('click', function(){
    	var data = new Object();
    	data.todoNumber = todoNumber;
    	var jsonData = JSON.stringify(data);
    	$.ajax({ 
    		type: 'POST',
    		url: '/deletetodo' , 
    		dataType : 'json' ,
    		contentType : 'application/json', 
    		data : jsonData,
    		success: function(data) {
    			if(data.flag == true){
    				alert('삭제하였습니다!');
    				} else {
    					alert('삭제에 실패하였습니다!');
    				}
    			}
    		});
    	
        $(target).remove();
    });
    
    //완료 버튼 클릭시
    $(this).find('#complete-btn').on('click', function(){
    	$('#path').val(path);
    	$('#todo-number-form').val(todoNumber);
    	$('#todo-title').val(title);
    	$('#todo-contents').val(contents);
    	$('#todo-importancy').val(importancy);
    	$('#todo-importancy-text').val(importancyText);
    	$('#todo-performdate').val(performDate);
    	$('#todo-duedate').val(dueDate);
    	$('#todo-completed').val(true);
    	$('#todo-form').attr('action', '/modifytodo');
    	$('#todo-form').submit();
    });
  });
</script>
</html>
