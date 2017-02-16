<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>

		<%-- Main menu select --%>
		<meta name="navSelector" content="maint"/>
		<%-- Child menu select --%>
		<meta name="navChildSelector" content="memberMaintenance"/>
		
		<g:set var="appContext" bean="grailsApplication"/>
		

	</head>
       
   <div id="fms_content">  
		
	<g:form action="update" id="editForm" name="editForm">
	
        <g:hiddenField name="memberDBID"
				value="${memberMasterInstance?.memberDBID}" />
				
		
				
			<g:if test="${request.getParameter('editType')== null  | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
			<g:render template="showGspValidations" />
				<fieldset class="memberMasterForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Master Record for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Master Record</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			
			<g:if test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
			
				<fieldset class="memberEligibilityHistoryForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Eligibility Details for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Eligibility Details</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberEligibilityHistory" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'ADDRESS'.equals(request.getParameter('editType'))}">
				<fieldset class="groupAddressForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Addresses for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Addresses</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
				      
					<g:render template="memberAddressForm" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BILLING'.equals(request.getParameter('editType'))}">
				<fieldset class="groupBillingForm">
				<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Billing for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Billing</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberBillingForm" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY'.equals(request.getParameter('editType'))}">
				<fieldset class="memberBeneficiaryForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Beneficiary Management for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Beneficiary Management</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberBeneficiaryForm" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY_ALLOCATION'.equals(request.getParameter('editType'))}">
				<fieldset class="beneficiaryAllocation">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Beneficiary Allocation for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Beneficiary Allocation</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="beneficiaryAllocation" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'MEDICARE_ENROLLMENT_INFO'.equals(request.getParameter('editType'))}">
				<fieldset class="MEMMCValidation">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Medicare Enrollment Information for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Medicare Enrollment Information</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberMedicareEnrollInfo" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'MEMMC_LIS_INFO'.equals(request.getParameter('editType'))}">
				<fieldset class="memberLisForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / MEMMC LIS Info for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>MEMMC LIS Info</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="memberLisForm" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>	
			<g:if
				test="${request.getParameter('editType') && 'MMR_PMT_DTL'.equals(request.getParameter('editType'))}">
				<fieldset class="memberLisForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / CMS MMR Payment Detail for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>CMS MMR Payment Detail</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				        <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${subscriberMember.subscriberID}" params="${[subscriberId: subscriberMember.subscriberID, personNumber: subscriberMember.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
				            <li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>
				      <%-- END - Tabs --%>
					<g:render template="cmsMmrPaymentDetail" />
					<g:render template="showGspValidations" />
				</fieldset>
			</g:if>	
  
          </g:form>

	</div> 
	
	
<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>

</html>	