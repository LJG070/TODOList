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
        <button type="button" id="notification-menu-lower-right" 
        class="mdl-button mdl-js-button mdl-button--icon">
              <i class="material-icons">notifications</i>
            </button>
            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect" for="notification-menu-lower-right">
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
      <c:choose>
      <c:when test="${empty weekly}">
      <div class="mdl-grid">
        <div class="mdl-cell mdl-cell--12-col">
          <p><h3>${year}년  ${month}월  ${day}일</h3><p>
        </div>
      </div>
      	<c:choose>
      		<c:when test="${empty todoList}">
      			<div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col" name="todo">
	          <div class="mdl-card__title">
	            <h2 class="mdl-card__title-text">Todo가 현재 없습니다</h2>
	          </div>
	          <div class="mdl-card__supporting-text">
	            	오늘 하실 Todo를 작성해주세요
	          </div>
	          <div class="mdl-card__actions mdl-card--border"></div>
	        	</div>
      		</c:when>
      	</c:choose>
		<c:forEach items="${todoList}" var="todo" varStatus="number">
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
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" id="modify-btn"> 수  정  </a>
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" id="delete-btn">  삭  제  </a>
	          </div>
	          <div class="mdl-card__menu">
			    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect" id="complete-btn">
			      <i class="material-icons">check_circle</i>
			    </button>
			  </div>
	        </div>
        </c:forEach>
        </c:when>
        
        <c:otherwise>
        <c:forEach items="${weekly}" var="weeklytodolist" varStatus="number">
            <div class="mdl-grid">
        		<div class="mdl-cell mdl-cell--12-col">
          			<p><h3>${year}년  ${month}월  ${day+ number.index}일</h3><p>
        		</div>
      		</div>
      		
      		<c:choose>
      			<c:when test="${empty weeklytodolist}">
      				<div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col" name="todo">
	          			<div class="mdl-card__title">
	            			<h2 class="mdl-card__title-text">Todo가 현재 없습니다</h2>
	          			</div>
	          			<div class="mdl-card__supporting-text">
	            			Todo를 작성해주세요
	          			</div>
	          		<div class="mdl-card__actions mdl-card--border"></div>
	        		</div>
      			</c:when>
      		</c:choose>
        	<c:forEach items="${weeklytodolist}" var = "todo" varStatus="days">
		
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
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" id="modify-btn"> 수  정  </a>
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" id="delete-btn">  삭  제  </a>
	          </div>
	           <div class="mdl-card__menu">
			    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect" id="complete-btn">
			      <i class="material-icons">check_circle</i>
			    </button>
			  </div>
	        </div>
        </c:forEach>
        </c:forEach>
        </c:otherwise>
        </c:choose>
    </main>
    
    <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored"
    		id="add-btn">
  		<i class="material-icons">add</i>
	</button>
</div>


    <dialog class="mdl-dialog mdl-cell--4-col" id="add-todo" style="z-index:100000;">
      <h4 class="mdl-dialog__title" id="dialog-title"> Todo 추가하기</h4>
      <form action="/addtodo" id="todo-form" method="post" autocomplete="off">
      <input id="path" type="hidden" name="path"></input>
      <input id="todo-completed" type="hidden" name="completed"></input>
      <div class="mdl-dialog__content">
      	<input type="hidden" type="number" name="todoNumber" id="todo-number-form" value=""></input>
          <div class="mdl-textfield mdl-js-textfield">
          <label class="mdl-textfield__label" for="todo-title">Title</label>
            <input class="mdl-textfield__input" type="text" id="todo-title" name="title" placeholder="title"></input>
          </div>
          <div class="mdl-textfield mdl-js-textfield">
          <label class="mdl-textfield__label" for="todo-contents">Contents</label>
            <textarea class="mdl-textfield__input" type="text" rows= "10" id="todo-contents" name="contents" placeholder="contents"></textarea>
            
          </div>
          <div class="mdl-cell--12-col">
            <span>중요도</span>
            <div class="mdl-textfield mdl-js-textfield">
				<input disabled class="mdl-textfield__input" type="text" id="todo-importancy-text" value="  없  음  "></input>
				<input type="hidden" id="todo-importancy" name= "importancy" value="0"></input>
			</div>
            <button type="button" id="importancy-menu-lower-right" class="mdl-button mdl-js-button mdl-button--icon">
              <i class="material-icons">more_vert</i>
            </button>
            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect" for="importancy-menu-lower-right" id="todo-importancy-ul">
              <li class="mdl-menu__item"> 없  음  </li>
              <li class="mdl-menu__item"> 낮  음  </li>
              <li class="mdl-menu__item"> 보  통  </li>
              <li class="mdl-menu__item"> 높  음  </li>
            </ul>
          </div>
          <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type=text id="todo-performdate" placeholder="수행날짜" name="performDate" readonly="readonly">
          </div>
          <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="text" id="todo-duedate" placeholder="마감날짜" name="dueDate" readonly="readonly">
          </div>
      </div>
      <div class="mdl-dialog__actions">
        <button type="submit" class="mdl-button">확 인</button>
        <button type="button" class="mdl-button close" id="close-btn">취 소</button>
      </div>
      </form>
    </dialog>
</body>

<script  type="text/javascript">
  var dialog = document.querySelector('dialog');
  var showDialogButton = $('#add-btn');
  var path = window.location.pathname;
  
  if (! dialog.showModal) {
    dialogPolyfill.registerDialog(dialog);
  }

  $(showDialogButton).on('click', function() {
	  $('#todo-form').attr('action', '/addtodo');
	  $('#path').val(path);
	  $('#dialog-title').text(' Todo 추가하기 ');
	  dialog.show();
  });

  dialog.querySelector('#close-btn').addEventListener('click', function() {
    $('#todo-title').val(' ');
    $('#todo-contents').val(' ');
    $('#todo-importancy').val('0');
    $('#todo-importancy-text').val(' 없  음  ');
    $('#todo-performdate').val(' ');
    $('#todo-duedate').val(' ');
    dialog.close();
  });

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
    
    //수정 버튼 클릭시
    $(this).find('#modify-btn').on('click', function(){
    	$('#path').val(path);
    	$('#dialog-title').text(' Todo 수정하기 ');
    	$('#todo-number-form').val(todoNumber);
    	$('#todo-title').val(title);
    	$('#todo-contents').val(contents);
    	$('#todo-importancy').val(importancy);
    	$('#todo-importancy-text').val(importancyText);
    	$('#todo-performdate').val(performDate);
    	$('#todo-duedate').val(dueDate);
    	$('#todo-form').attr('action', '/modifytodo');
    	dialog.show();
    })
    
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

  $('#todo-importancy-ul').find('li').on('click', function(){
	var importancy = $(this).index();
	var importancyString = $(this).text();
	$('#todo-importancy-text').val(importancyString);
	$('#todo-importancy').val(importancy);
  });

    $('#todo-performdate').datepicker({
      dateFormat: 'yy-mm-dd',
      minDate: 0
    });

    var dueDatePicker = $('#todo-duedate').datepicker({
      dateFormat: 'yy-mm-dd',
      minDate: 0
    });
</script>
</html>
