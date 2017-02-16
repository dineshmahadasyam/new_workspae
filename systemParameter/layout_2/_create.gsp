<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'systemParameter.label', default: 'SystemParameter')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	<style>
		.topics table {margin-bottom : 0em}
		.topics tr { line-height: 0px;  padding:0; padding-left: 0; padding-right:0}
		.topics td { line-height: 0px; padding:0; padding-left: 0; padding-right:0 }
		.fieldcontain label {width:10%;}
		.fieldcontain  {margin-top:0px}
		</style>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/systemParameter/search"/>')			
		}
		</script>
		<style>
			div.right-corner {
			    position: absolute;
			    top: 0px;
			    right: 0;
			    margin-right: 40px;
			    font:normal normal 21pt / 1 Tahoma;
			    color: #48802C;
			}
		</style>	
	</head>
	
	</head>
	<body>
		<a href="#create-systemParameter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<%--
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		 --%>
		
		
		<div id="create-systemParameter" class="content scaffold-create" role="main">
		<h1 style="color: #48802C"><g:message code="default.create.label" args="[entityName]" /></h1>
		<div class="right-corner" align="center">PARAM</div>	
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${systemParameterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${systemParameterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
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
