<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>

<meta name="layout" content="main">

<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="memberMaintenance"/>
		
<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_ADD_ELIGIBILITY.equals(currentPage)?true:false}" />
<g:set var="appContext" bean="grailsApplication"/>
<title><g:message code="default.show.label" args="[entityName]" /></title>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		jQuery.validator.setDefaults({
			ignore: ":hidden",	
			debug : true,
		
		});

		$(function() {
			$("#editForm").validate({
				submitHandler : function(form) {
					if ($(form).valid())
						form.submit();
					return false; // prevent normal form posting
				},
				errorLabelContainer : "#errorDisplay",
				wrapper : "li",
				rules : {
					'eligHistory.0.effectiveDate' : {
						required : true
					},
					'eligHistory.0.eligStatus' : {
						required : true
					},
					'eligHistory.0.benefitStartDate' : {
						required : true
					},
					'eligHistory.0.relationshipCode' : {
						required : true
					},
					'eligHistory.0.groupId' : {
						required : true
					},
					'eligHistory.0.planCode' : {
						required : true
					},
					'eligHistory.0.lineOfBusiness' : {
						required : true
					},
					'eligHistory.0.privacyOn' : {
						required : true
					}
				   },
				messages : {
					'eligHistory.0.effectiveDate' : {
						required : "Please select a Effective Date"
					},
					'eligHistory.0.eligStatus' : {
						required : "Please select a Eligibility Status"
					},
					'eligHistory.0.benefitStartDate' : {
						required : "Please select a Benefit Start Date"
					},
					'eligHistory.0.relationshipCode' : {
						required : "Please select a Relationship Code"
					},
					'eligHistory.0.groupId' : {
						required : "Please enter a Group Id"
					},
					'eligHistory.0.planCode' : {
						required : "Please enter a Plan Code."
					},
					'eligHistory.0.lineOfBusiness' : {
						required : "Please enter a Line Of Business."
					},
					'eligHistory.0.privacyOn' : {
						required : "Please select a value for Privacy On"
					}			
				}

			})
		});

	});
</script>
<script>
	function closeForm() {
		var subscriberId = "${params.susbcriberId}";
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/show?subscriberId="
				+ subscriberId + "&editType=DETAIL");
	//	window.location.assign("/"+appName+"/memberMaintenance/list")
	
	}
	var grpInnerWindow
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if (grpInnerWindow) {
			grpInnerWindow.close()
		}
	}
</script>
<script type="text/javascript">

	$(document).ready(function() {

		 $('.btnSaveLis').hide();
         // $('.btnResetddress').hide();  
         $('.btnResetddressAlert').hide();  


         $('.tablesorter').delegate('.btnEditAddress, .btnResetddress', 'click' ,function(){
             var parentTR = $(this).closest('tr');
             $(parentTR).find('.btnEditAddress').toggle();
             $(parentTR).find('.btnSaveLis').toggle();
             $(parentTR).find('.btnResetddressAlert').toggle();
             $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
             $('#NewAddress').prop('disabled', function(i, v) { return !v; });


             // $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
            //  return false;
           });

         $('.tablesorter').delegate('.btnSaveLis', 'click' ,function(){
             $('#editForm').submit();
           });
         
           
           $( ".btnResetddress" ).click(function() {             
             $('.btnEditAddress').show();
             $('.btnSaveLis').hide();
             $('.btnResetddressAlert').hide();
             $('.tablesorter-childRow').find('td').hide();
              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
             // return false;
           });


           $( "#EffectiveDate, #TermDate, #EffectiveDate2, #TermDate2" ).datepicker({
               numberOfMonths: 1,
               showOn: "button",
               buttonText: "<i class='fa fa-calendar'></i>",
             });

             $('.btnResetddressAlert').click(function(e){ 
               $('#WarningAlert').modal('show');
             });

             $('#WarningAlert').modal({
               backdrop: 'static',
               show: false
             });
	});

</script>	
</head>
<body>
  <div id="fms_content">
  
      <div id="fms_content_header">
      <div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / 
	      		<g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'DETAIL']}">Eligibility Details</g:link>
	      		
	      			/Add Eligibility Details to Member : ${params.susbcriberId } Person Number :${ params.personNumber }
	  		</div>
    	
  
  		<div class="fms_content_title">
    		<h1>Add Eligibility Details</h1>
  		</div>
	</div> 
	
		<%-- START - Tabs --%>
        <div id="fms_content_tabs">
          	<ul>
	            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${params.susbcriberId}" params="${[subscriberId: params.susbcriberId, personNumber: params.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MASTER']}">Master Record</g:link></li>
	            <li><g:link class="active" action="show" id="${params.susbcriberId}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BILLING']}">Billing</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
          	</ul>
          	<div id="mobile_tabs_select"></div>
        </div>
      	<%-- END - Tabs --%>
   <div id="fms_content_body">
   	<div class="right-corner" align="right">MELIG</div>
	<div class="fms_required_legend fms_required">= required</div> 
   <div class="fms_form_border">
    	<div class="fms_form_body fms_form_border">
	
	<%-- Error messages start--%>
	<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>${error}</li>
				</g:each>
			</ul>
			</g:if>
<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
<g:form action="saveEligibilityPeriod" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}"/>
			<input type="hidden" name="personNumber"
				value="${params.personNumber}" />
			<input type="hidden" name="subscriberId"
				value="${params.susbcriberId }" />
	
  			 <!-- START - WIDGET: General Information -->
      			<div id="widgetGeneral" class="fms_widget">       
					<fieldset class="no_border">
						<legend><h2>Add Eligibility Details</h2></legend>
							<div class="fms_form_layout_2column">                  
                      
								<div class="fms_form_column fms_very_long_labels">
									<label class="control-label fms_required" for="effectiveDate" id="effectiveDate_label">
										<g:message code="eligHistory.effectiveDate.label" default="Effective Date :" />
									</label>
									<div class="fms_form_input">
								<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
                        					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: eligibilityHistoryVar?.effectiveDate)}" 
                        					dateElementId="eligHistory.0.effectiveDate" dateElementName="eligHistory.0.effectiveDate"
                                           	ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
                                           	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           	showIconDefault="${isShowCalendarIcon}"
                                           	title="Effective Date of the Eligibility Record"/> 
										<div class="fms_form_error" id="effectiveDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>
					 
					 
									<label class="control-label " for="dateOfDeath" id="dateOfDeath_label">
										<g:message code="eligHistory.dateOfDeath.label" default="DOD :" />
									</label>                              
									<div class="fms_form_input">
									<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+0',
											maxDate:0, numberOfMonths: 1" 
                        					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: eligibilityHistoryVar?.dateOfDeath)}" 
                        					dateElementId="eligHistory.0.dateOfDeath" dateElementName="eligHistory.0.dateOfDeath"
                                           ariaAttributes="aria-labelledby='DOD_label' aria-describedby='DOD_error' aria-required='false'" 
                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           showIconDefault="${isShowCalendarIcon}"
                                           title="Date of Death of the Member"/> 
											<div class="fms_form_error" id="dateOfDeath_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
						 
									<label class="control-label fms_required" id="eligStatus" for="eligStatus">
										<g:message code="eligHistory.eligStatus.label" default="Elig Status :" />
									</label>
									<div class="fms_form_input">
										<select name="eligHistory.0.eligStatus" class="form-control" title="Eligibility status of the Member">
											<option value="N" ${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.eligStatus) ? 'selected':'' }>No</option>
											<option value="Y" ${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.eligStatus) ? 'selected':'' }>Yes</option>
										</select>
										<div class="fms_form_error" id="eligStatus_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
       			
       							 
       							 	 
									<label class="control-label" for="recordStatus" id="recordStatus">
										<g:message code="eligHistory.recordStatus.label" default="Record Sts :" />
									</label>
									<div class="fms_form_input">
										<g:textField name="eligHistory.0.recordStatus" Class="form-control"
										value="${eligibilityHistoryVar?.recordStatus}"
										maxlength="15" title="Status of the Member Record"/>
										<div class="fms_form_error" id="recordStatus_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>		
                              
									<label class="control-label fms_required" id="relationshipCode_label" for="relationshipCode">
									<g:message code="eligHistory.relationshipCode.label" default="RelationShip Code :" />
									</label>
									<div class="fms_form_input">
										<g:getDiamondDataWindowDetail
											columnName="relationship_code" dwName="dw_ccont_melig"
											languageId="0" cssClass="form-control"
											htmlElelmentId="eligHistory.0.relationshipCode"
											defaultValue="${eligibilityHistoryVar?.relationshipCode}"
											blankValue="Relationship Code" 
											title="Members Relationship to the Insured"/>
										<div class="fms_form_error" id="relationshipCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>	
									
									 
									<label class="control-label  fms_required" id="groupId_label" for="groupId">
										<g:message code="eligHistory.groupId.label" default="Group Id :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<input type="hidden" name="eligHistory.0.seqGroupId"
											id="eligHistory.0.seqGroupId" value="${eligibilityHistoryVar?.seqGroupId}"/>
										<g:textField 
											maxlength="50"
											class="form-control" 
											name="eligHistory.0.groupId"
											value="${eligibilityHistoryVar?.groupId}" 
											title="The Group Number the member is associated to"/>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.0.groupId"
                                                lookupElementName="eligHistory.0.groupId" 
                                                lookupElementValue="${eligibilityHistoryVar?.groupId}"
                                                lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
                                                lookupCDOClassAttribute="groupId"
                                                htmlElementsToUpdate="eligHistory.0.seqGroupId"
						   						htmlElementsToUpdateCDOProperty="seqGroupId"/>						
                                                
										
									   	<div class="fms_form_error" id="groupId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>					
					
					
									<label class="control-label  fms_required" id="planCode_label" for="planCode">
										<g:message code="eligHistory.planCode.label" default="Plan Code :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:textField 
										maxlength="50"
										Class="form-control"
										name="eligHistory.0.planCode"
										value="${eligibilityHistoryVar?.planCode}" 
										title="The Plan the member is associated to"/>
										<fmsui:cdoLookup 
											lookupElementId="eligHistory.0.planCode"
                                            lookupElementName="eligHistory.0.planCode" 
                                            lookupElementValue="${eligibilityHistoryVar?.planCode}"
                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
                                            lookupCDOClassAttribute="planRiderCode"
                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|PlanRecordType"
						   					htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
										
									   	<div class="fms_form_error" id="planCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div> 
                                
                                
									<label class="control-label" for="covLevelCode" id="covLevelCode_label">
										<g:message code="memberEligSbmtMap.covLevelCode.label" default="Coverage Level:" />
									</label>
									<div class="fms_form_input">
										 <g:textField 
										 	maxlength="3"
											Class="form-control"
											name="memberEligSbmtMap.covLevelCode"
											value="${memberEligSbmtMap?.covLevelCode}" title ="Enter a 3-character coverage level code"/>
									   	<div class="fms_form_error" id="covLevelCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
						  
									<!-- <label class="control-label" id="riders_label" for="riders">
						<g:message code="eligHistory.dentalLob.label" default="Riders :" />
					</label>
					<div class="fms_form_input">
						<input value="Riders" type="text" class="form-control" id="riders"
							aria-labelledby="riders_label" aria-describedby="riders_error"
							aria-required="false" />
						<div class="fms_form_error" id="riders_error"></div>
					</div>  -->
							<label class="control-label" id="riders_label" for="riders">
								<g:message code="eligHistory.dentalLob.label" default="Riders :" />
							</label>
							<div class="fms_form_input fms_multiple_sm">
								<div class="row sm-margin-bottom">
										<div class="col-xs-4">
											<input type="hidden" id="RiderRecordType" name="RiderRecordType" value="R" class="form-control"/>
											<input type="hidden" id="PlanRecordType" name="PlanRecordType" value="P" class="form-control"/>
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode1"
												aria-labelledby="riderCode1_label"
												aria-describedby="riderCode1_error" aria-required="false"
												name="eligHistory.0.riderCode1"
												value="${eligibilityHistoryVar?.riderCode1}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode1"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.0.riderCode1"
	                                           	lookupElementName="eligHistory.0.riderCode1" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode1}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode1_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode2"
												aria-labelledby="riderCode2_label"
												aria-describedby="riderCode2_error" aria-required="false"
												name="eligHistory.0.riderCode2"
												value="${eligibilityHistoryVar?.riderCode2}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode2"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.0.riderCode2"
	                                           	lookupElementName="eligHistory.0.riderCode2" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode2}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode2_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode3"
												aria-labelledby="riderCode3_label"
												aria-describedby="riderCode3_error" aria-required="false"
												name="eligHistory.0.riderCode3"
												value="${eligibilityHistoryVar?.riderCode3}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode3"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode3"
		                                            lookupElementName="eligHistory.0.riderCode3" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode3}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode3_error"></div>
										</div>
										</div>
										<div class="row sm-margin-bottom">
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode4"
												aria-labelledby="riderCode4_label"
												aria-describedby="riderCode4_error" aria-required="false"
												name="eligHistory.0.riderCode4"
												value="${eligibilityHistoryVar?.riderCode4}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode4"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode4"
		                                            lookupElementName="eligHistory.0.riderCode4" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode4}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode4_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode5"
												aria-labelledby="riderCode5_label"
												aria-describedby="riderCode5_error" aria-required="false"
												name="eligHistory.0.riderCode5"
												value="${eligibilityHistoryVar?.riderCode5}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode5"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode5"
		                                            lookupElementName="eligHistory.0.riderCode5" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode5}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode5_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode6"
												aria-labelledby="riderCode6_label"
												aria-describedby="riderCode6_error" aria-required="false"
												name="eligHistory.0.riderCode6"
												value="${eligibilityHistoryVar?.riderCode6}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode6"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode6"
		                                            lookupElementName="eligHistory.0.riderCode6" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode6}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode6_error"></div>
										</div>
										</div>
										<div class="row sm-margin-bottom">
											<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.0.riderCode7"
												aria-labelledby="riderCode7_label"
												aria-describedby="riderCode7_error" aria-required="false"
												name="eligHistory.0.riderCode7"
												value="${eligibilityHistoryVar?.riderCode7}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode7"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode7"
		                                            lookupElementName="eligHistory.0.riderCode7" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode7}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode7_error"></div>
										</div>
											<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2"  class="form-control" id="eligHistory.0.riderCode8"
												aria-labelledby="riderCode8_label"
												aria-describedby="riderCode8_error" aria-required="false"
												name="eligHistory.0.riderCode8"
												value="${eligibilityHistoryVar?.riderCode8}"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode8"
												title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.riderCode8"
		                                            lookupElementName="eligHistory.0.riderCode8" 
		                                            lookupElementValue="${eligibilityHistoryVar?.riderCode8}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
		                                            lookupCDOClassAttribute="planRiderCode"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId|RiderRecordType"
													htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode8_error"></div>
										</div>
									</div>
								</div>								
									<label class="control-label" id="issuerSubscriberId_label" for="issuerSubscriberId">
										<g:message code="eligHistory.issuerSubscriberId.label" default="Issuer Subscriber Id :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:textField 
											maxlength="50"
										   	Class="form-control"
											name="eligHistory.0.issuerSubscriberId"
											value="${eligibilityHistoryVar?.issuerSubscriberId}"
											title="Issuer's Subscriber ID for the Member"/>
											<fmsui:cdoLookup 
											lookupElementId="eligHistory.0.issuerSubscriberId"
                                            lookupElementName="eligHistory.0.issuerSubscriberId" 
                                            lookupElementValue="${eligibilityHistoryVar?.issuerSubscriberId}"
                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
                                            lookupCDOClassAttribute="issuerSubscriberId"/>
										
									   	<div class="fms_form_error" id="issuerSubscriberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div> 
                                
									<label class="control-label " id="issuerMemberId_label" for="issuerMemberId">
										<g:message code="eligHistory.issuerMemberId.label" default="Issuer Member Id :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:textField 
										 maxlength="50"
										Class="form-control"
										name="eligHistory.0.issuerMemberId"
										value="${eligibilityHistoryVar?.issuerMemberId}" 
										title="Issuer's Member ID for the Member"/>
										<fmsui:cdoLookup 
											lookupElementId="eligHistory.0.issuerMemberId"
                                            lookupElementName="eligHistory.0.issuerMemberId" 
                                            lookupElementValue="${eligibilityHistoryVar?.issuerMemberId}"
                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
                                            lookupCDOClassAttribute="issuerMemberId"/>
										
									   	<div class="fms_form_error" id="issuerMemberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
                         
									</div>
				
								
									<label class="control-label " id="issuerGroupNumber_label" for="issuerGroupNumber">
										<g:message code="eligHistory.issuerGroupNumber.label" default="Issuer Group Number :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
											<g:textField 
											maxlength="50"
											name="eligHistory.0.issuerGroupNumber" Class="form-control"
											value="${eligibilityHistoryVar?.issuerGroupNumber}" 
											title="Issuer's Group ID for the Member"/>
											<fmsui:cdoLookup 
											lookupElementId="eligHistory.0.issuerGroupNumber"
                                            lookupElementName="eligHistory.0.issuerGroupNumber" 
                                            lookupElementValue="${eligibilityHistoryVar?.issuerGroupNumber}"
                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
                                            lookupCDOClassAttribute="issuerGroupNumber"/>
											
											<div class="fms_form_error" id="issuerGroupNumber_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

    
									</div>
                       
									<label class="control-label" for="exchangeAssignedPolicyNo" id="exchangeAssignedPolicyNo">
										<g:message code="eligHistory.exchangeAssignedPolicyNo.label" default="Exchange Assigned Policy No :" />
									</label>
									<div class="fms_form_input">
										<g:textField
											maxlength="50"
											name="eligHistory.0.exchangeAssignedPolicyNo"
											Class="form-control"
											value="${eligibilityHistoryVar?.exchangeAssignedPolicyNo}"
											title="Exchange Assigned Policy Number" />
											<div class="fms_form_error" id="exchangeAssignedPolicyNo_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>
                     
									<label class="control-label" for="siteCode" id="siteCode">
										<g:message code="eligHistory.siteCode.label" default="Site Code :" />
									</label>
									<div class="fms_form_input">
											<g:textField 
											maxlength="12"
											Class="form-control"
											name="eligHistory.0.siteCode"
											value="${eligibilityHistoryVar?.siteCode}" 
											title="A user assigned code where the primary care physician practices"/>
											<div class="fms_form_error" id="siteCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
                        
                                    
									<label class="control-label" id="ipaId_label" for="ipaId">
										<g:message code="eligHistory.ipaId.label" default="IPA Id :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
									<input type="hidden" name="ipaLevelCode" id="ipaLevelCode" value="1"/>																
											<g:textField 
												name="eligHistory.0.ipaId"
												Class="form-control"
												value="${eligibilityHistoryVar?.ipaId}" 
												title="Provider IPA associated with this Member"/>
												<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.ipaId"
		                                            lookupElementName="eligHistory.0.ipaId" 
		                                            lookupElementValue="${eligibilityHistoryVar?.ipaId}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.IpaMaster"
		                                            lookupCDOClassAttribute="ipaId"
		                                            htmlElementsToAddToQuery="ipaLevelCode"
							   						htmlElementsToAddToQueryCDOProperty="levelCode"/>
												
											<div class="fms_form_error" id="ipaId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
                         
                         
									<label class="control-label" id="pcpChangeReason_label" for="pcpChangeReason">
										<g:message code="eligHistory.pcpChangeReason.label" default="PCP Change Reason :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
									<input type="hidden" name="PCPReasonType" id="PCPReasonType" value="PC"/>
										<g:secureTextField 
										maxlength="5" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="pcpChangeReason" Class="form-control"
										value="${eligibilityHistoryVar?.pcpChangeReason}"
										title="The reason the Primary Care Physician was changed">
										</g:secureTextField>
										<fmsui:cdoLookup 
													lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason"
		                                            lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason" 
		                                            lookupElementValue="${eligibilityHistoryVar?.pcpChangeReason}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
		                                            lookupCDOClassAttribute="reasonCode"
		                                            htmlElementsToAddToQuery="PCPReasonType"
							   						htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
										
											<div class="fms_form_error" id="pcpChangeReason_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
					
									<label class="control-label" id="subscDept_label" for="subscDept">
										<g:message code="eligHistory.subscDept.label" default="Subscriber Dept :" />
									</label>
				
									<div class="fms_form_input fms_has_feedback">
											<g:textField 
											maxlength="20"
											Class="form-control"
											name="eligHistory.0.subscDept"
											value="${eligibilityHistoryVar?.subscDept}" 
											title="Subscriber Department"/>
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.subscDept"
		                                            lookupElementName="eligHistory.0.subscDept" 
		                                            lookupElementValue="${eligibilityHistoryVar?.subscDept}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupDepartment"
		                                            lookupCDOClassAttribute="deptNumber"/>
											
											<div class="fms_form_error" id="subscDept_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
                     
									<label class="control-label " for="hireDate" id="hireDate_label">
										<g:message code="eligHistory.hireDate.label" default="Hire Date :" />
									</label>                              
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"                         					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: eligibilityHistoryVar?.hireDate)}" 
                        					dateElementId="eligHistory.0.hireDate" dateElementName="eligHistory.0.hireDate"
                                          	ariaAttributes="aria-labelledby='hireDate_label' aria-describedby='hireDate_error' aria-required='false'" 
                                           	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           	showIconDefault="${isShowCalendarIcon}"
                                           	title="The Date the Member was hired"/> 
										<div class="fms_form_error" id="hireDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>
						
									<label class="control-label" for="prospectivePremiumAmt" id="prospectivePremiumAmt">
										<g:message code="eligHistory.prospectivePremiumAmt.label" default="Prospective Premium Amt :" />
									</label>
									<div class="fms_form_input">
										 <g:textField 
											maxlength="18" Class="form-control"
											name="eligHistory.0.prospectivePremiumAmt"
											value="${eligibilityHistoryVar?.prospectivePremiumAmt}" 
											title="Prospective Premium Amount anticipated"/>
										<div class="fms_form_error" id="prospectivePremiumAmt_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
										
									</div>
                    
                    		
                     
                     
									<label class="control-label" for="memberClass1" id="memberClass1">
										<g:message code="eligHistory.memberClass1.label" default="Member Class1 :" />
									</label>
									<div class="fms_form_input">
										 <g:textField
											maxlength="5" Class="form-control"
											id="eligHistory.0.memberClass1"
											name="eligHistory.0.memberClass1"
											value="${eligibilityHistoryVar?.memberClass1}" 
											title="Member's home facility and market"/>
										<div class="fms_form_error" id="memberClass1_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
                  
									<label class="control-label" for="memberClass2" id="memberClass2">
										<g:message code="eligHistory.memberClass2.label" default="Member Class2 :" />
									</label>
									<div class="fms_form_input">
										   <g:textField 
											maxlength="5" Class="form-control"
											id="eligHistory.0.memberClass2"
											name="eligHistory.0.memberClass2"
											value="${eligibilityHistoryVar?.memberClass2}" 
											title="Member's home facility and market"/>
										<div class="fms_form_error" id="memberClass2_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
				
								</div>
		
				
								<!-- RIGHT SIDE OF THE CODE -->
									<div class="fms_form_column fms_very_long_labels">
										<label class="control-label " for="termDate" id="termDate_label">
											<g:message code="eligHistory.termDate.label" default="Term Date :" />
										</label>                              
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"                         					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: eligibilityHistoryVar?.termDate)}" 
                        					dateElementId="eligHistory.0.termDate" dateElementName="eligHistory.0.termDate"
                                           	ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
                                           	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           	showIconDefault="${isShowCalendarIcon}"
                                           	title="Termination Date of the Eligibility Record"/> 
											<div class="fms_form_error" id="termDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>
			
									<label class="control-label" id="termReason_label" for="termReason">
										<g:message code="eligHistory.termReason.label" default="Term Reason :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										   <g:textField 
												 maxlength="5" Class="form-control"
												name="eligHistory.0.termReason"
												value="${eligibilityHistoryVar?.termReason}" 
												title="Reason for the Member Termination"/>
												<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.termReason"
		                                            lookupElementName="eligHistory.0.termReason" 
		                                            lookupElementValue="${eligibilityHistoryVar?.termReason}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
		                                            lookupCDOClassAttribute="reasonCode"/>
											
											<div class="fms_form_error" id="termReason_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
     
									<label class="control-label" id="voidEligFlag_label" for="voidEligFlag">
										<g:message code="eligHistory.voidEligFlag.label"  default="Void Elig :" />
									</label>
									<div class="fms_form_input">
										<select name="eligHistory.0.voidEligFlag" Class="form-control" title="To Void the eligiblity, choose Y else choose N">
											<option value="N"${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.voidEligFlag) ? 'selected':'' }>No</option>
											<option value="Y"${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.voidEligFlag) ? 'selected':'' }>Yes</option>
										</select>  
										<div class="fms_form_error" id="voidEligFlag_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
									
	
									<label class="control-label fms_required" for="benefitStartDate" id="benefitStartDate_label">
										<g:message code="eligHistory.benefitStartDate.label" default="Benefit Start Date :" />
									</label>                              
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											disabled = "${ MultiPlanEnabled ? ("01".equals(params?.personNumber) ? "false" : "true") : false}"
											title="Benefit Start Date for the Member"
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"                         					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: eligibilityHistoryVar?.benefitStartDate)}" 
                        					dateElementId="eligHistory.0.benefitStartDate" dateElementName="eligHistory.0.benefitStartDate"
                                          	ariaAttributes="aria-labelledby='benefitStartDate_label' aria-describedby='benefitStartDate_error' aria-required='false'" 
                                           	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           	showIconDefault="${isShowCalendarIcon}"/> 
										<div class="fms_form_error" id="benefitStartDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>

									</div>
		
			
									<label class="control-label" id="benefitEndDate_label" for="benefitEndDate">
										<g:message code="memberEligHistoryExtnList.benefitEndDate.label" default="Benefit End Date :" />
									</label>
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1"                         					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: memberEligHistoryExtnList?.benefitEndDate)}" 
                        					dateElementId="memberEligHistoryExtnList.benefitEndDate" 
                        					dateElementName="memberEligHistoryExtnList.benefitEndDate"
                        					mandatory="mandatory"  disabled = "${ MultiPlanEnabled ? ("01".equals(params?.personNumber) ? "false" : "true") : false}"
                                           	ariaAttributes="aria-labelledby='benefitEndDate_label' aria-describedby='benefitEndDate_error' aria-required='false'" 
                                           	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           	showIconDefault="${isShowCalendarIcon}"
                                           	title = "Benefit End Date for the Member"/> 							
										<div class="fms_form_error" id="benefitEndDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
			
									<label class="control-label" id="subsidizedFlag_label" for="subsidizedFlag">
										<g:message code="eligHistory.subsidizedFlag.label" default="Subsidized Flag :" />
									</label>
									<div class="fms_form_input">
										<select
											name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.subsidizedFlag" Class="form-control"
											title="If the member is subsidized choose Y else choose N">
											<option value="N"${eligibilityHistoryVar.subsidizedFlag.equals('N') ? 'selected':'' }>No</option>
											<option value="Y"${eligibilityHistoryVar.subsidizedFlag.equals('Y') ? 'selected':'' }>Yes</option>
										</select>
										<div class="fms_form_error" id="subsidizedFlag_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
	
   
   
  									 <label class="control-label fms_required" id="privacyOn_label" for="privacyOn">
									<g:message code="eligHistory.privacyOn.label" default="Privacy On :" />
									 </label>
									<div class="fms_form_input">
										<select name="eligHistory.0.privacyOn" id="privacyOn" Class="form-control" 
											title="To restrict sharing of correspondence, choose Y else choose N">
											<option value=""></option>
											<option value="Y"${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.privacyOn) ? 'selected':'' }>Yes</option>
											<option value="N"${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.privacyOn) ? 'selected':'' }>No</option>
										</select>
										<div class="fms_form_error" id="privacyOn_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
										
									</div>
									
									<label class="control-label fms_required" id="lineOfBusiness_label" for="lineOfBusiness">
									<g:message code="eligHistory.lineOfBusiness.label" default="Line Of Business :" />
									</label>
								<div class="fms_form_input fms_has_feedback">
									<g:textField maxlength="3"
									name="eligHistory.0.lineOfBusiness"
									Class="form-control"
									value="${eligibilityHistoryVar?.lineOfBusiness}"
									title="Line of Business for the Member"/>
									<fmsui:cdoLookup 
														lookupElementId="eligHistory.0.lineOfBusiness"
			                                            lookupElementName="eligHistory.0.lineOfBusiness" 
			                                            lookupElementValue="${eligibilityHistoryVar?.lineOfBusiness}"
			                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster"
			                                            lookupCDOClassAttribute="lineOfBusiness"/>
									
									<div class="fms_form_error" id="lineOfBusiness_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
						
								</div>
	
									<label class="control-label" id="dentalLob_label"for="dentalLob">
										<g:message code="eligHistory.dentalLob.label" default="Rider Contract Type :" />
									</label>
									<div class="fms_form_input fms_multiple_sm">
										<div class="row sm-margin-bottom">
												<div class="col-xs-4">
													<g:textField
														id="dentalLob" aria-labelledby="dentalLob_label"
														aria-describedby="dentalLob_error" aria-required="false" class="form-control"
														maxlength="2" size="2" 
														name="eligHistory.0.riderContractTypeCode1"
														value="${eligibilityHistoryVar?.riderContractTypeCode1}" 
														title="Rider's Contract Type"/>
												</div>
												<div class="col-xs-4">
													<g:textField
														id="dentalLob" aria-labelledby="dentalLob_label"
														aria-describedby="dentalLob_error" aria-required="false" class="form-control"
														maxlength="2" size="2" 
														name="eligHistory.0.riderContractTypeCode2"
														value="${eligibilityHistoryVar?.riderContractTypeCode2}"
														title="Rider's Contract Type"/>
												</div>
												
												<div class="col-xs-4">
													<g:textField
														id="dentalLob" aria-labelledby="dentalLob_label"
														aria-describedby="dentalLob_error" aria-required="false" class="form-control"
														maxlength="2" size="2" 
														name="eligHistory.0.riderContractTypeCode3"
														value="${eligibilityHistoryVar?.riderContractTypeCode3}" 
														title="Rider's Contract Type"/>
													
												</div>
												</div>
												<div class="row sm-margin-bottom">
												<div class="col-xs-4">
													<g:textField
														id="dentalLob" aria-labelledby="dentalLob_label"
														aria-describedby="dentalLob_error" aria-required="false" class="form-control"
														maxlength="2" size="2" 
														name="eligHistory.0.riderContractTypeCode4"
														value="${eligibilityHistoryVar?.riderContractTypeCode4}" 
														title="Rider's Contract Type"/>
												</div>

														<div class="col-xs-4">
															<g:textField
																id="dentalLob" aria-labelledby="dentalLob_label"
																aria-describedby="dentalLob_error" aria-required="false" class="form-control"
																maxlength="2" size="2" 
																name="eligHistory.0.riderContractTypeCode5"
																value="${eligibilityHistoryVar?.riderContractTypeCode5}" 
																title="Rider's Contract Type"/>
														</div>
														<div class="col-xs-4">
															<g:textField
																id="dentalLob" aria-labelledby="dentalLob_label"
																aria-describedby="dentalLob_error" aria-required="false" class="form-control"
																maxlength="2" size="2"
																name="eligHistory.0.riderContractTypeCode6"
																value="${eligibilityHistoryVar?.riderContractTypeCode6}" 
																title="Rider's Contract Type"/>
														</div>
														</div>
														<div class="row sm-margin-bottom">
														<div class="col-xs-4">
															<g:textField
																id="dentalLob" aria-labelledby="dentalLob_label"
																aria-describedby="dentalLob_error" aria-required="false" class="form-control"
																maxlength="2" size="2"
																name="eligHistory.0.riderContractTypeCode7"
																value="${eligibilityHistoryVar?.riderContractTypeCode7}" 
																title="Rider's Contract Type"/>
														</div>
														
														<div class="col-xs-4">
															<g:textField
															id="dentalLob" aria-labelledby="dentalLob_label"
															aria-describedby="dentalLob_error" aria-required="false" class="form-control"
															maxlength="2" size="2"
															name="eligHistory.0.riderContractTypeCode8"
															value="${eligibilityHistoryVar?.riderContractTypeCode8}"
															title="Rider's Contract Type"/>
														</div>
															<div class="fms_form_error" id="Rider_Contact_Type_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
													</div>
												</div>
							
							<label class="control-label" id="issuerPolicyNumber_label" for="issuerPolicyNumber">
										<g:message code="eligHistory.issuerPolicyNumber.label" default="Issuer Policy Number :" />
							</label>
							<div class="fms_form_input fms_has_feedback">
								<g:textField
									 maxlength="50"
									Class="form-control"
									name="eligHistory.0.issuerPolicyNumber"
									value="${eligibilityHistoryVar?.issuerPolicyNumber}" 
									title="Issuer's Policy Number"/>
									
									<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.issuerPolicyNumber"
		                                            lookupElementName="eligHistory.0.issuerPolicyNumber" 
		                                            lookupElementValue="${eligibilityHistoryVar?.issuerPolicyNumber}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
		                                            lookupCDOClassAttribute="issuerPolicyNumber"/>
								
								<div class="fms_form_error" id="issuerPolicyNumber_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
							
							
							<label class="control-label" id="rateType_label" for="rateType">
								<g:message code="eligHistory.rateType.label" default="Rate Type :" />
							</label>
							<div class="fms_form_input fms_has_feedback">
																				
													
									<g:textField maxlength="50"
									name="eligHistory.0.rateType"
									Class="form-control"
									value="${eligibilityHistoryVar?.rateType}" 
									title="Rate type that determines the rate"/>
									<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.rateType"
		                                            lookupElementName="eligHistory.0.rateType" 
		                                            lookupElementValue="${eligibilityHistoryVar?.rateType}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
		                                            lookupCDOClassAttribute="systemCode"/>
									
									<div class="fms_form_error" id="rateType_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
								
							<label class="control-label" for="exchangeMemberId" id="exchangeMemberId">
								<g:message code="eligHistory.0.label" default="Exchange Member Id :" />
							</label>
							<div class="fms_form_input">
								<g:textField
									name="eligHistory.0.exchangeMemberId"
									Class="form-control"
									value="${eligibilityHistoryVar?.exchangeMemberId}"
									maxlength="50" 
									title="Exchange Member Identifier for the Member"/>									
								<div class="fms_form_error" id="exchangeMemberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									
							</div>
								
							<label class="control-label " id="panelId_label" for="panelId">
								<g:message code="eligHistory.panelId.label" default="Panel Id :" />
							</label>
							<div class="fms_form_input fms_has_feedback">
										<g:textField maxlength="3" 
											Class="form-control"
											name="eligHistory.0.panelId"
											value="${eligibilityHistoryVar?.panelId}" 
											title="Provider panel associated with this Member's Provider"/>
											
											<fmsui:cdoLookup 
													lookupElementId="eligHistory.0.panelId"
		                                            lookupElementName="eligHistory.0.panelId" 
		                                            lookupElementValue="${eligibilityHistoryVar?.panelId}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupPanel"
		                                            lookupCDOClassAttribute="panelId"
		                                            htmlElementsToAddToQuery="eligHistory.0.seqGroupId"
							   						htmlElementsToAddToQueryCDOProperty="seqGroupId"/>
										
										<div class="fms_form_error" id="panelId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div> 
								 
       							 
								 
							<label class="control-label" id="PCPID_label" for="PCPID">
								<g:message code="eligHistory.PCPID.label" default="PCP ID :" />
							</label>
							<div class="fms_form_input fms_has_feedback">
								<input type="hidden" name="providerContractType" id="providerContractType" value="P"/>
									<g:textField name="eligHistory.0.seqProvId" Class="form-control"
									 value="${eligibilityHistoryVar?.seqProvId }" 
									 title="Primary Care Physician of the Member"/>
									 
									 <fmsui:cdoLookup 
													lookupElementId="eligHistory.0.seqProvId"
		                                            lookupElementName="eligHistory.0.seqProvId" 
		                                            lookupElementValue="${eligibilityHistoryVar?.seqProvId}"
		                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ProvContract"
		                                            lookupCDOClassAttribute="seqProvId"/>
										
											<div class="fms_form_error" id="PCPID_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
								
								
								
							<label class="control-label" for="medicareStatusFlg" id="medicareStatusFlg">
								<g:message code="eligHistory.medicareStatusFlg.label" default="Medicare Status Flag :" />
							</label>
							<div class="fms_form_input">
										<g:textField maxlength="12"
											name="eligHistory.0.medicareStatusFlg"
											Class="form-control"
											value="${eligibilityHistoryVar?.medicareStatusFlg}" />
										<div class="fms_form_error" id="medicareStatusFlg_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
							  
							  
		
							<label class="control-label" id="subscLocation_label" for="subscLocation">
								<g:message code="eligHistory.subscLocation.label" default="Location :" />
							</label>
							<div class="fms_form_input">
								<g:getSystemCodeToken
									systemCodeType="MELIGLOC" languageId="0"
									cssClass="form-control"
									htmlElelmentId="eligHistory.0.subscLocation"
									blankValue="Location" 
									defaultValue="${eligibilityHistoryVar?.subscLocation}" 
									/>
									<div class="fms_form_error" id="subscLocation_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
												   
							</div>
								 
								 
	
							<label class="control-label" id="csIndicator_label" for="csIndicator">
								<g:message code="eligHistory.csIndicator.label" default="CS Indicator :" />
							</label>
							<div class="fms_form_input">
								<g:getSystemCodeToken
									systemCodeType="MEMCSIND" languageId="0"
									cssClass="form-control"
									htmlElelmentId="eligHistory.0.csIndicator"
									blankValue="CS Indicator" 
									defaultValue="${eligibilityHistoryVar?.csIndicator}" 
									title="Indicates if information for this member should be confidential or is sensitive"/>
								<div class="fms_form_error" id="csIndicator_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
											
							</div>
								 
								 
								 
							<label class="control-label" for="userDefined1" id="userDefined1">
								<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"/>
							</label>
							<div class="fms_form_input">
								<g:textField maxlength="30"
									Class="form-control"
									name="eligHistory.0.userDefined1"
									value="${eligibilityHistoryVar?.userDefined1}" />
								<div class="fms_form_error" id="userDefined1_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
							  
							<label class="control-label" for="userDefined2" id="userDefined2">
								<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"/>
							</label>
							<div class="fms_form_input">
										<g:textField maxlength="30"
											Class="form-control"
											name="eligHistory.0.userDefined2"
											Class="form-control"
											value="${eligibilityHistoryVar?.userDefined2}" />
								<div class="fms_form_error" id="userDefined2_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
							 
							<label class="control-label" for="userDefined2" id="userDefined2">
								<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"/>
							</label>
							<div class="fms_form_input">
								<g:textField maxlength="30"
									Class="form-control"
									name="eligHistory.0.userDefined3"
									value="${eligibilityHistoryVar?.userDefined3}" />
								<div class="fms_form_error" id="userDefined3_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							</div>
						</div>
					</fieldset>
				</div>
            <div class="fms_form_button">
				   	<g:actionSubmit  class="btn btn-primary" action="saveEligibilityPeriod" value="${message(code: 'default.button.save.label', default: 'Save')}" />
					<input type="Reset" class="btn btn-default" value="Reset" id="resetButton" />
					<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
			</div>
		</g:form>
</div> 
</div>
</div>
</div>

</html>