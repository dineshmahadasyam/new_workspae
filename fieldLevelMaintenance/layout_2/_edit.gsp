<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'secColMaster.label', default: 'Field Level Security Master')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<style>
		.topics table {margin-bottom : 0em}
		.topics tr { line-height: 0px;  padding:0; padding-left: 0; padding-right:0}
		.topics td { line-height: 0px; padding:0; padding-left: 0; padding-right:0 }
		.fieldcontain label {width:30%;}
		.fieldcontain  {margin-top:0px}
		</style>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/search"/>')			
		}
		</script>	
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>	
	</head>
	<body>
		<a href="#edit-secColMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="show"
					params="${[sfldlId:request.getParameter('sfldlId'), editType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="show"
					params="${[sfldlId:request.getParameter('sfldlId'), editType :'DETAIL']}">Detail Records</g:link></li>
	</ul>
	</div>
		<div id="edit-secColMaster" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${secColMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${secColMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:if test="${errors}">
			<ul class="errors" role="alert">
				<g:each in="${errors}" var="error">
				<li> ${ error}</li>
				</g:each>
			</ul>
			</g:if>
			<g:if test="${messages}">
			<ul class="message" role="alert">
				<g:each in="${messages}" var="message">
				<li> ${ message}</li>
				</g:each>
			</ul>
			</g:if>
			
			<form method="post" id="editForm">
			<fieldset class="form">
				<g:if
					test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
					<g:render template="secColDetailForm" />

				</g:if>
				<g:else>
					<g:render template="secColMasterForm"
						model="${ [updatable : false]}" />
				</g:else>
			</fieldset>
			<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" id="saveButton" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:if test="${params.editType.equals('MASTER') }">					
						<g:actionSubmit class="delete" action="delete" id="deleteButton" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
					</g:if>					
					<div style="align:right;display:inline" >
						<input type="button" class="close" value="Close" onClick="closeForm()"/>
					</div>
				</fieldset>
			</form>
		</div>
	</body>
</html>
