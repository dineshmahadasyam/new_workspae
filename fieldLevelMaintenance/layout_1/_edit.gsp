<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="userMaintenance"/>		
		<g:set var="entityName" value="${message(code: 'secColMaster.label', default: 'Master Record')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/search"/>')			
		}
		</script>	
	</head>
			
	<div id="fms_content">
		<div id="fms_content_header">
        	<div class="fms_content_header_note">
        		<a href="/FMSAdminConsole/userMaintenance/landing">Security Maintenance</a> / 
          		<a href="/FMSAdminConsole/fieldLevelMaintenance/search"> Field Level Security</a> / 
          		<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
          			Detail Record for Field Level Security (${params.sfldlId})
          		</g:if>
          		<g:else>
          			Master Record for Field Level Security (${params.sfldlId})
          		</g:else>
        	</div>		
	
			<div class="fms_content_title">
				<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
	          		<h1>Edit Field Level Security Detail</h1>
	          	</g:if>
	          	<g:else>
	          		<h1>Edit Field Level Security Master</h1>
	          	</g:else>
          	</div>
		</div>
       
        <!-- START - Tabs -->
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
					<li><g:link class="list" action="show" 
							params="${[sfldlId:request.getParameter('sfldlId'), editType :'MASTER']}">Master Record</g:link></li>
					<li><g:link class="active" action="show"
						    params="${[sfldlId:request.getParameter('sfldlId'), editType :'DETAIL']}">Detail Records</g:link></li>
				</g:if>
				<g:else>
					<li><g:link class="active" action="show"
							params="${[sfldlId:request.getParameter('sfldlId'), editType :'MASTER']}">Master Record</g:link></li>
					<li><g:link class="list" action="show"
						    params="${[sfldlId:request.getParameter('sfldlId'), editType :'DETAIL']}">Detail Records</g:link></li>
				</g:else>
			</ul>
		</div>
      	<!-- END - Tabs -->
	
		<div id="edit-secColMaster" class="content scaffold-edit" role="main">
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
			</form>
		</div>
	</div>
</html>
