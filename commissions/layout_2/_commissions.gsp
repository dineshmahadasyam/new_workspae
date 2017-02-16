<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'planMaster.label', default: 'PlanMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		
		<title>Commissions</title>
	</head>
<body>
	<div class="nav" role="navigation">
		<ul>
			<li style="font: 10pt Tahoma, arial, helvetica, sans-serif;"><g:link class="list" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
			<li style="font: 10pt Tahoma, arial, helvetica, sans-serif;"><g:link class="list" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
			<li><a style="font: 10pt Tahoma, arial, helvetica, sans-serif; width:255px;" class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
		</ul>
	</div>
</body>
</html>