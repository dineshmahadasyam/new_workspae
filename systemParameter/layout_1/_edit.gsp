<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'systemParameter.label', default: 'System Parameter')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<script type="text/javascript"> 
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/systemParameter/search"/>')			
			}
		</script>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
		
	</head>
	<g:form action="update" id="editForm" name="editForm">
		<div id="edit-systemParameter" class="content scaffold-edit" role="main">
			<fieldset class="systemParameter">
				<div id="fms_content_header">
			        <div class="fms_content_header_note">
			          	<a href="${createLink(uri: '/sysMaint/list')}">System Maintenance</a> / 
			          	<a href="${createLink(uri: '/systemParameter/search')}">systemParameter</a> /
			          	<g:message code="default.edit.label" args="[entityName]" />
			        </div>
			        <div class="fms_content_title">
			          	<h1>System Parameter</h1>
			        </div>
				</div>
				
				<!-- START - Tabs -->
		        	<div id="fms_content_tabs" class="fms_tab_action">
		          		<ul>
				            <li><a class="list" href="<g:createLinkTo dir="/benefitPackage/search"/>">Benefit Package</a></li>
				            <li><a class="list" href="<g:createLinkTo dir="/configurationSwitch/search"/>">Configuration Switch</a></li>
				            <li><a class="list" href="<g:createLinkTo dir="/companyMaster/search"/>">Company</a></li>
				            <li><a class="list" href="<g:createLinkTo dir="/generalLedger/search"/>">G/L Reference</a></li>
				            <li><a class="list" href="<g:createLinkTo dir="/languageMaintenance/search"/>">Language Maintenance</a></li>
				            <li><a class="list" href="<g:createLinkTo dir="/lineOfBusiness/search"/>">Line of Business</a></li>
				            <li class="fms_tab_action_sub">
		              			<button class="fms_tab_action_sub_trigger" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
		              			<ul>
					                <li><a class="active" href="<g:createLinkTo dir="/systemParameter/search"/>">Parameter</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/planMaintenance/search"/>">Plan</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/providerTypeMaintenance/search"/>">Provider Type</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/reasonCodeMaintenance/search"/>">Reason</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/riderMaintenance/search"/>">Rider</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/systemCodes/search"/>">System Codes</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/taxReportingEntity/search"/>">Tax Reporting Entity</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/tradingPartnerMaintenance/search"/>">Trading Partner</a></li>
					                <li><a class="list" href="<g:createLinkTo dir="/userDefinedFields/search"/>">User Defined Fields</a></li> 
					                <li><a class="list" href="<g:createLinkTo dir="/about/search"/>">About</a></li>                                            
		              			</ul>
		            		</li>
		          		</ul>
		    			<div id="mobile_tabs_select"></div>
					</div>
		      	<!-- END - Tabs -->
			</fieldset>
					
			<g:form method="post" >
				<fieldset class="form">
					<g:render template="form" model="[editType: 'edit']"/>
				</fieldset>
			</g:form> 
		</div>
	</g:form>
</html>
		