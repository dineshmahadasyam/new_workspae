<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'secColMaster.label', default: 'LineOfBusiness')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
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
	</head>
	<body>
			<a href="#create-secColMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
			<div id="create-secColMaster" class="content scaffold-create" role="main">
				<h1 style="color: #48802C">Create Field Level Security Master
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspSFLDL</h1>
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
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="secColMasterForm" model="${[updatable : true] }"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<div style="align:right;display:inline" >
						<input type="Reset" class="reset" value="Reset" />
						<input type="button" class="close" value="Close" onClick="closeForm()"/>
					</div>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
