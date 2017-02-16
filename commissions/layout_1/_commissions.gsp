<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="searchJobs"/>
	</head>
	
	<!-- START - FMS Content -->
	<div id="fms_content">
		<!-- START - FMS Content Header -->
		<div id="fms_content_header">
        	<div class="fms_content_header_note">
          		<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / Search Jobs
        	</div>

			<div class="fms_content_title">
          		<h1>Search Jobs</h1>
          	</div>
      	</div>
      	<!-- START - FMS Content Header -->
      	
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<li><g:link class="list" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
				<li><g:link class="list" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
				<li><a class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
	</div>
	<!-- END - FMS Content -->
</html>