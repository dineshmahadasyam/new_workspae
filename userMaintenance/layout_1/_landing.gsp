<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="userMaintenance"/>
	</head>
	
	<!-- START - FMS Content -->
	<div id="fms_content">
		<!-- START - FMS Content Header -->
		<div id="fms_content_header">
        	<div class="fms_content_header_note">
          		<a href="/FMSAdminConsole/userMaintenance/landing">Security Maintenance</a>
        	</div>

			<div class="fms_content_title">
          		<h1>Security Maintenance</h1>
          	</div>
      	</div>
      	<!-- START - FMS Content Header -->
      	
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
		    	<li><a class="list" href="<g:createLinkTo dir="/userMaintenance/list"/>">User Security</a></li>
				<li><a class="list" href="<g:createLinkTo dir="/fieldLevelMaintenance/search"/>">Field Level Security</a></li>
				<li><a class="list" href="<g:createLinkTo dir="/userMaintenance/search"/>">Function Description</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
	</div>
	<!-- END - FMS Content -->
</html>