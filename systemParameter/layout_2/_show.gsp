<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'systemParameter.label', default: 'SystemParameter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
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
	<body>
		<a href="#show-systemParameter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="show-systemParameter" class="content scaffold-show" role="main">
			<h1 style="color: #48802C"><g:message code="default.show.label" args="[entityName]" /></h1>
			<div class="right-corner" align="center">PARAM</div>	
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list systemParameter">
			
				<g:if test="${systemParameterInstance?.parameterId}">
				<li class="fieldcontain">
					<span id="parameterId-label" class="property-label"><g:message code="systemParameter.parameterId.label" default="Parameter Id" /></span>
					
						<span class="property-value" aria-labelledby="parameterId-label"><g:fieldValue bean="${systemParameterInstance}" field="parameterId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParameterInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="systemParameter.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${systemParameterInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParameterInstance?.parameter1}">
				<li class="fieldcontain">
					<span id="parameter1-label" class="property-label"><g:message code="systemParameter.parameter1.label" default="Parameter1" /></span>
					
						<span class="property-value" aria-labelledby="parameter1-label"><g:fieldValue bean="${systemParameterInstance}" field="parameter1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParameterInstance?.parameter2}">
				<li class="fieldcontain">
					<span id="parameter2-label" class="property-label"><g:message code="systemParameter.parameter2.label" default="Parameter2" /></span>
					
						<span class="property-value" aria-labelledby="parameter2-label"><g:fieldValue bean="${systemParameterInstance}" field="parameter2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${systemParameterInstance?.parameter3}">
				<li class="fieldcontain">
					<span id="parameter3-label" class="property-label"><g:message code="systemParameter.parameter3.label" default="Parameter3" /></span>
					
						<span class="property-value" aria-labelledby="parameter3-label"><g:fieldValue bean="${systemParameterInstance}" field="parameter3"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<div style="align:right;display:inline" >
						<input type="Reset" class="reset" value="Reset" />
						<input type="button" class="close" value="Close" onClick="closeForm()"/>
					</div>
				
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
