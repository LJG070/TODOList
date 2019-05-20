<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
  <link rel="stylesheet" type="text/css" href="./dist/dialog-polyfill.css" />
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  <script src="./dist/dialog-polyfill.js"></script>
  <title>TodoList</title>
</head>
<body>
  <div class="mdl-layout mdl-js-layout">

    <header class="mdl-layout__header">
      <div class="mdl-layout__header-row">
        <span class="mdl-layout__title">TodoList</span>
      </div>
    </header>

    <div class="mdl-layout__drawer">
        <nav class="mdl-navigation">
          <a class="mdl-navigation__link" href="#" style="text-align:center;"><h5>마 감 목 록</h5></a>
          <a class="mdl-navigation__link" href="/todolist" style="text-align:center;"><h5>  오   늘  </h5></a>
          <a class="mdl-navigation__link" href="#" style="text-align:center;"><h5>  1  주  일</h5></a>
        </nav>
    </div>

    <main class="mdl-layout__content">
      <div class="mdl-grid">

        <div class="mdl-cell mdl-cell--12-col">
          <p>${year}년  ${month}월 ${day}일<p>
            <button id="show-dialog" type="button" class="mdl-button">Show Dialog</button>
        </div>
      </div>
		<c:forEach items="${todoList}" var="todo" varStatus="number">
	        <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col" name="todo">
	          <div class="mdl-card__title">
	            <h2 class="mdl-card__title-text">${todo.title}</h2>
	          </div>
	          <div class="mdl-card__supporting-text">
	            ${todo.contents}
	          </div>
	          <div class="mdl-card__actions mdl-card--border">
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" href="#">추 가</a>
	            <a class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" href="#" id="cancel-btn">취 소 </a>
	          </div>
	        </div>
        </c:forEach>
    </main>
</div>

    <dialog class="mdl-dialog mdl-cell--4-col" id="add-todo" style="z-index:100000;">
      <h4 class="mdl-dialog__title "> Todo 추가하기</h4>
      <div class="mdl-dialog__content">
        <form action="#">
          <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <input class="mdl-textfield__input" type="text" id="todo-title">
            <label class="mdl-textfield__label" for="todo-title">Title</label>
          </div>
          <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <textarea class="mdl-textfield__input" type="text" rows= "10" id="todo-contents" ></textarea>
            <label class="mdl-textfield__label" for="todo-contents">Contents</label>
          </div>
          <div class="mdl-cell--12-col">
            <span>중요도<span>
            <button id="demo-menu-lower-right" class="mdl-button mdl-js-button mdl-button--icon" style="margin-left:auto;">
              <i class="material-icons">more_vert</i>
            </button>
            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect" for="demo-menu-lower-right" id="todo-importancy">
              <li class="mdl-menu__item">Some Action</li>
              <li class="mdl-menu__item">Another Action</li>
              <li class="mdl-menu__item">Disabled Action</li>
              <li class="mdl-menu__item">Yet Another Action</li>
            </ul>
          </div>
          <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="text" id="todo-performdate" placeholder="수행날짜" autocomplete="false">
          </div>
          <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="text" id="todo-duedate" placeholder="마감날짜" autocomplete="false">
          </div>
        </form>
      </div>
      <div class="mdl-dialog__actions">
        <button type="button" class="mdl-button">추 가</button>
        <button type="button" class="mdl-button close" id="close-btn">취 소</button>
      </div>
    </dialog>
</body>

<script  type="text/javascript">
  var dialog = document.querySelector('dialog');
  var showDialogButton = document.querySelector('#show-dialog');

  if (! dialog.showModal) {
    dialogPolyfill.registerDialog(dialog);
  }

  showDialogButton.addEventListener('click', function() {
    dialog.show();
  });

  dialog.querySelector('#close-btn').addEventListener('click', function() {
    var todoTitle = document.querySelector('#todo-title').value;
    var todoContents = document.querySelector('#todo-contents').value;
    dialog.close();
  });

  $('[name=todo]').each(function(){
    var target = $(this);
    var todoIndex = $(this).index();
    $(this).find("#cancel-btn").on('click', function(){
        $(target).remove();
    });
  });

  $('#todo-importancy').find('li').on('click', function(){
    alert($(this).index());
  });

    $('#todo-performdate').datepicker({
      dateFormat: 'yy-mm-dd',
      minDate: 0
    });

    $('#todo-duedate').datepicker({
      dateFormat: 'yy-mm-dd',
      minDate: 0
    });
</script>
</html>
