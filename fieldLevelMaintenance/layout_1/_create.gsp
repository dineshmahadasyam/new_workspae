<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="userMaintenance"/>		
		<g:set var="entityName" value="${message(code: 'secColMaster.label', default: 'FieldLevelMaintenance')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<script>
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/search"/>')			
			}
		</script>
	</head>
	
	<g:form action="save" id="editForm" name="editForm">
		<div id="create-secColMaster" class="content scaffold-create" role="main">
			<fieldset class="secColMaster">
				<div id="fms_content_header">
		        	<div class="fms_content_header_note">
		        		<a href="/FMSAdminConsole/userMaintenance/landing">Security Maintenance</a> / 
		          		<a href="/FMSAdminConsole/fieldLevelMaintenance/search"/> Field Level Maintenance</a> / 
		          		Create Field Level Security Master (${params.sfldlId})
		        	</div>		
			
					<div class="fms_content_title">
		          		<h1>Create Field Level Security Master</h1>
		          	</div> 
				</div>
				<g:form action="save" >
					<fieldset class="form">
						<g:render template="secColMasterForm"/>
					</fieldset>
				</g:form>
			</fieldset>
		</div>
	</g:form>
</html>
