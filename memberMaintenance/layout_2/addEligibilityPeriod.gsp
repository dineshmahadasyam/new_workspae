<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#memberIdSelectList [disabled] {
	color: #933;
}
</style>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />

<g:set var="appContext" bean="grailsApplication"/>

<title><g:message code="default.show.label" args="[entityName]" /></title>


<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">
<style type="text/css">
</style>


<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		jQuery.validator.setDefaults({
			ignore: [],			
			debug : true,
			success : "valid"
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
					'eligHistory.0.privacyOn' : {
						required : "Please select a value for Privacy On"
					}			
				}

			})
		});

	});
</script>

<style type="text /css">#report changed {
	color: blue;
}

#report {
	border-collapse: collapse;
}

#report div {
	background: #C7DDEE
}

#report h4 {
	margin: 0px;
	padding: 0px;
}

#report img {
	float: right;
}

#report ul {
	margin: 10px 0 10px 40px;
	padding: 0px;
}

#report td {none repeat-x scroll center left;
	color: #000;
	padding: 2px 15px;
}

#report tr.hideme {
	background: #C7DDEE none repeat-x scroll center left;
	color: #000;
	padding: 7px 15px;
}

#report td.clickme td {
	background: #fffff repeat-x scroll center left;
	cursor: pointer;
}

#report div.arrow {
	background: transparent url(arrows.png) no-repeat scroll 0px -16px;
	width: 16px;
	height: 16px;
	display: block;
}

#report div.up {
	background-position: 0px 0px;
}

#tdFormElement td {
	align: left
}

#tdnoWrap td {
	white-space: nowrap
}
</style>

<script>
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/list")
	}
	var grpInnerWindow
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if (grpInnerWindow) {
			grpInnerWindow.close()
		}
	}

	function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds,
			assocFieldCdoName, updateFields, updateFieldsCdoName) {
		var htmlElementValue
		var assocHTMLElementsValue = ""
		htmlElementValue = document.getElementById(idName).value
		//alert (assocFieldIds)
		if (assocFieldIds) {
			if (assocFieldIds.indexOf('|') == -1) {
				if (document.getElementById(assocFieldIds)
						&& document.getElementById(assocFieldIds).value != "undefined") {
					assocHTMLElementsValue = document
							.getElementById(assocFieldIds).value
				}
			} else {
				var nameArray = assocFieldIds.split("|")
				for ( var i = 0; i < nameArray.length; i++) {
					if (document.getElementById(nameArray[i])
							&& document.getElementById(nameArray[i]).value != "undefined") {
						//		alert (document.getElementById(nameArray[i]).value)
						assocHTMLElementsValue += document
								.getElementById(nameArray[i]).value
								+ "|"
					}
				}
			}
		}
		//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
		var appName = "${appContext.metadata['app.name']}";
		var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName="
				+ idName
				+ "&htmlElementValue="
				+ htmlElementValue
				+ "&cdoClassName="
				+ cdoClassName
				+ "&cdoClassAttributeName="
				+ cdoClassAttributeName
				+ (assocFieldIds ? "&assocFields=" + assocFieldIds : "")
				+ (assocFieldCdoName ? "&assocFieldCdoName="
						+ assocFieldCdoName : "")
				+ (assocHTMLElementsValue ? "&assocFieldValue="
						+ assocHTMLElementsValue : "")
				+ (updateFieldsCdoName ? "&updateFieldsCdoName="
						+ updateFieldsCdoName : "")
				+ (updateFields ? "&updateFields=" + updateFields : "")
				+ "&offset=0"
		if (!innerWindowClosed) {
			grpInnerWindow.setUrl(urlValue)
		} else {
			innerWindowClosed = false;
			grpInnerWindow = $.window({
				showModal : true,
				title : "Lookup",
				bookmarkable : false,
				minimizable : false,
				maximizable : false,
				width : 900,
				height : 350,
				scrollable : false,
				url : urlValue,
				onClose : function(wnd) { // a callback function while user click close button
					innerWindowClosed = true;
				}
			});
		}
	}
</script>
</head>
<body>
	<a href="#show-memberMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'BILLING']}">Billing</g:link></li>
		</ul>
		<ul>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Information</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="show-memberMaster" class="content scaffold-show" role="main">
		&nbsp;
		<h1 style="color: #48802C">
			Add Eligibility Period to Member :
			${params.susbcriberId }
			Person Number :
			${ params.personNumber }
		</h1>
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
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveEligibilityPeriod" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}"/>
			<input type="hidden" name="personNumber"
				value="${params.personNumber}" />
			<input type="hidden" name="subscriberId"
				value="${params.susbcriberId }" />
			<table>
				<tr>
					<td>
						<table border="1" id="report">

							<tr class="showme">
								<td colspan="13">
									<div class="divContent">
										<table class="report1">
											<tr>
												<td>
													<!-- Start Eligibility record Dynamic Content -->
													<table border="0">
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div class="fieldcontain">
																	<label for="effectiveDate"> <g:message
																			code="eligHistory.effectiveDate.label"
																			default="Effective Date :" /> <span
																		class="required-indicator">*</span>
																	</label>
																</div>
															</td>
															<td colspan="2">
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="eligHistory.0.effectiveDate" 
																		dateElementName="eligHistory.0.effectiveDate" mandatory="mandatory" 
																		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.effectiveDate != null ? eligibilityHistoryVar?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.effectiveDate)}"/> 
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'termDate', 'error')} required">
																	<label for="termDate"> <g:message
																			code="eligHistory.termDate.label"
																			default="Term Date :" />
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="eligHistory.0.termDate" 
																		dateElementName="eligHistory.0.termDate" 
																		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.termDate != null ? eligibilityHistoryVar?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.termDate)}"/>
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'termReason', 'error')} ">
																	<label for="termReason"> <g:message
																			code="eligHistory.termReason.label"
																			default="Term Reason :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="5"
																		name="eligHistory.0.termReason"
																		value="${eligibilityHistoryVar?.termReason}" />
																	<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'dateOfDeath', 'error')} required">
																	<label for="dateOfDeath"> <g:message
																			code="eligHistory.dateOfDeath.label" default="DOD :" />
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="eligHistory.0.dateOfDeath" 
																		dateElementName="eligHistory.0.dateOfDeath" 
																		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.dateOfDeath != null ? eligibilityHistoryVar?.dateOfDeath.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100', maxDate:0" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.dateOfDeath)}"/>
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'eligStatus', 'error')} ">
																	<label for="eligStatus"> <g:message
																			code="eligHistory.eligStatus.label"
																			default="Elig Status :" /> <span
																		class="required-indicator">*</span>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<select name="eligHistory.0.eligStatus">
																		<option value="N"
																			${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.eligStatus) ? 'selected':'' }>No</option>
																		<option value="Y"
																			${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.eligStatus) ? 'selected':'' }>Yes</option>
																	</select>
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'voidEligFlag', 'error')} ">
																	<label for="voidEligFlag"> <g:message
																			code="eligHistory.voidEligFlag.label"
																			default="Void Elig :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<select name="eligHistory.0.voidEligFlag">
																		<option value="N"
																			${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.voidEligFlag) ? 'selected':'' }>No</option>
																		<option value="Y"
																			${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.voidEligFlag) ? 'selected':'' }>Yes</option>
																	</select>
																</div>
															</td>

														</tr>
														<tr>

															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'recordStatus', 'error')} ">
																	<label for="recordStatus"> <g:message
																			code="eligHistory.recordStatus.label"
																			default="Record Sts :" />

																	</label>
																</div>
															</td>

															<td>
																<div class="fieldcontain">
																	<g:textField name="eligHistory.0.recordStatus"
																		value="${eligibilityHistoryVar?.recordStatus}"
																		maxlength="15" />
																</div>
															</td>

															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'benefitStartDate', 'error')} required">
																	<label for="benefitStartDate"> <g:message
																			code="eligHistory.benefitStartDate.label"
																			default="Benefit Start Date :" /> <span
																		class="required-indicator">*</span>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="eligHistory.0.benefitStartDate" 
																		dateElementName="eligHistory.0.benefitStartDate" mandatory="mandatory" disabled = "${ MultiPlanEnabled ? ("01".equals(params?.personNumber) ? "false" : "true") : false}"
																		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.benefitStartDate != null ? eligibilityHistoryVar?.benefitStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.benefitStartDate)}"/>
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'relationshipCode', 'error')} ">
																	<label for="relationshipCode"> <g:message
																			code="eligHistory.relationshipCode.label"
																			default="RelationShip Code :" /> <span
																		class="required-indicator">*</span>

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:getDiamondDataWindowDetail
																		columnName="relationship_code" dwName="dw_ccont_melig"
																		languageId="0"
																		htmlElelmentId="eligHistory.0.relationshipCode"
																		defaultValue="${eligibilityHistoryVar?.relationshipCode}"
																		blankValue="Relationship Code" />
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: memberEligHistoryExtnList, field: 'benefitEndDate', 'error')} ">
																	<label for="benefitEndDate"> <g:message
																			code="memberEligHistoryExtnList.benefitEndDate.label"
																			default="Benefit End Date :" />
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="memberEligHistoryExtnList.benefitEndDate" 
																			dateElementName="memberEligHistoryExtnList.benefitEndDate" mandatory="mandatory"  disabled = "${ MultiPlanEnabled ? ("01".equals(params?.personNumber) ? "false" : "true") : false}"
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (memberEligHistoryExtnList?.benefitEndDate != null ? memberEligHistoryExtnList?.benefitEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberEligHistoryExtnList?.benefitEndDate)}"
																			title = "Enter date for members end of eligibility"/>
																</div>
															</td>
														</tr>
													<tr>
														<td class="tdFormElement" style="white-space: nowrap">
															<div
																class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'exchangeMemberId', 'error')} ">
																<label for="exchangeMemberId"> <g:message
																		code="eligHistory.0.label"
																		default="Exchange Member Id :" /> 
																</label>
															</div>
														</td>
														<td>
															<div class="fieldcontain">		
																<g:textField
																	name="eligHistory.0.exchangeMemberId"
																	value="${eligibilityHistoryVar?.exchangeMemberId}"
																	maxlength="50" />										
															</div>
														</td>
														<td class="tdFormElement" style="white-space: nowrap">
															<div
																class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'exchangeAssignedPolicyNo', 'error')} ">
																<label for="exchangeAssignedPolicyNo"> <g:message
																		code="eligHistory.exchangeAssignedPolicyNo.label"
																		default="Exchange Assigned Policy No :" /> 
																</label>
															</div>
														</td>
														<td>
															<div class="fieldcontain">
															<g:textField
																	name="eligHistory.0.exchangeAssignedPolicyNo"
																	value="${eligibilityHistoryVar?.exchangeAssignedPolicyNo}"
																	maxlength="50" title="Exchange Assigned Policy Number" />
															</div>
														</td>
													</tr>
													<tr><td class="tdFormElement" style="white-space: nowrap" colspan="4"><hr></td></tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'groupId', 'error')} ">
																	<label for="groupId"> <g:message
																			code="eligHistory.groupId.label" default="Group Id :" />
																		<span class="required-indicator">*</span>

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<input type="hidden" name="eligHistory.0.seqGroupId"
																		id="eligHistory.0.seqGroupId"
																		value="${eligibilityHistoryVar?.seqGroupId}" />
																	<g:textField maxlength="50"
																		name="eligHistory.0.groupId"
																		value="${eligibilityHistoryVar?.groupId}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'eligHistory.0.seqGroupId', 'seqGroupId' )">
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'subsidizedFlag', 'error')} ">
																	<label for="subsidizedFlag"> <g:message
																			code="eligHistory.subsidizedFlag.label" default="Subsidized Flag :" />
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<select
																		name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.subsidizedFlag">
																		<option value="N"
																			${eligibilityHistoryVar.subsidizedFlag.equals('N') ? 'selected':'' }>No</option>
																		<option value="Y"
																			${eligibilityHistoryVar.subsidizedFlag.equals('Y') ? 'selected':'' }>Yes</option>
																	</select>
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'planCode', 'error')} ">
																	<label for="planCode"> <g:message
																			code="eligHistory.planCode.label"
																			default="Plan Code :" /> <span
																		class="required-indicator">*</span>

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="50"
																		name="eligHistory.0.planCode"
																		value="${eligibilityHistoryVar?.planCode}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.planCode', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId','seqGroupId')">
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lineOfBusiness', 'error')} ">
																	<label for="lineOfBusiness"> <g:message
																			code="eligHistory.lineOfBusiness.label"
																			default="Line Of Business :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="3"
																		name="eligHistory.0.lineOfBusiness"
																		value="${eligibilityHistoryVar?.lineOfBusiness}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.lineOfBusiness', 'com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster','lineOfBusiness')">
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: memberEligSbmtMap, field: 'covLevelCode:', 'error')} ">
																	<label for="covLevelCode"> <g:message
																			code="memberEligSbmtMap.covLevelCode.label"
																			default="Coverage Level:" />
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="3" style="width:30px"
																		name="memberEligSbmtMap.covLevelCode"
																		value="${memberEligSbmtMap?.covLevelCode}" title ="Enter a 3-character coverage level code"/>
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'privacyOn', 'error')} ">
																	<label for="privacyOn"> <g:message
																			code="eligHistory.privacyOn.label"
																			default="Privacy On :" /> <span
																		class="required-indicator">*</span>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<select name="eligHistory.0.privacyOn">
																		<option value=""></option>
																		<option value="Y"
																			${eligibilityHistoryVar && 'Y'.equals(eligibilityHistoryVar.privacyOn) ? 'selected':'' }>Yes</option>
																		<option value="N"
																			${eligibilityHistoryVar && 'N'.equals(eligibilityHistoryVar.privacyOn) ? 'selected':'' }>No</option>
																	</select>

																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'dentalLob', 'error')} ">
																	<label for="riders"> <g:message
																			code="eligHistory.dentalLob.label" default="Riders :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<table border="0">
																		<tr>
																			<td style="padding-left:0px"><input type="hidden" id="RiderRecordType" name="RiderRecordType"
																				value="R" /> <g:textField
																					name="eligHistory.0.riderCode1"
																					value="${eligibilityHistoryVar?.riderCode1}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode1', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode2"
																					value="${eligibilityHistoryVar?.riderCode2}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode2', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode3"
																					value="${eligibilityHistoryVar?.riderCode3}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode3', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode4"
																					value="${eligibilityHistoryVar?.riderCode4}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode4', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																		</tr>
																		<tr>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode5"
																					value="${eligibilityHistoryVar?.riderCode5}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode5', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode6"
																					value="${eligibilityHistoryVar?.riderCode6}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode6', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode7"
																					value="${eligibilityHistoryVar?.riderCode7}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode7', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																			<td style="padding-left:0px"><g:textField name="eligHistory.0.riderCode8"
																					value="${eligibilityHistoryVar?.riderCode8}"
																					maxlength="2" size="2" style="width:15px" /> <img
																				width="25" height="25"
																				style="float: none; vertical-align: bottom"
																				class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																				onclick="lookup('eligHistory.0.riderCode8', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.0.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																			</td>
																		</tr>
																	</table>
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'dentalLob', 'error')} ">
																	<label for="dentalLob"> <g:message
																			code="eligHistory.dentalLob.label"
																			default="Rider Contract Type :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode1"
																		value="${eligibilityHistoryVar?.riderContractTypeCode1}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode2"
																		value="${eligibilityHistoryVar?.riderContractTypeCode2}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode3"
																		value="${eligibilityHistoryVar?.riderContractTypeCode3}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode4"
																		value="${eligibilityHistoryVar?.riderContractTypeCode4}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode5"
																		value="${eligibilityHistoryVar?.riderContractTypeCode5}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode6"
																		value="${eligibilityHistoryVar?.riderContractTypeCode6}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode7"
																		value="${eligibilityHistoryVar?.riderContractTypeCode7}"
																		maxlength="2" size="2" style="width:15px" />
																	<g:textField
																		name="eligHistory.0.riderContractTypeCode8"
																		value="${eligibilityHistoryVar?.riderContractTypeCode8}"
																		maxlength="2" size="2" style="width:15px" />
																</div>
															</td>
														</tr>
														
														<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'issuerSubscriberId', 'error')} ">
														<label for="issuerSubscriberId"> <g:message
																code="eligHistory.issuerSubscriberId.label" default="Issuer Subscriber Id :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">	
														<g:textField maxlength="50"
															name="eligHistory.0.issuerSubscriberId"
															value="${eligibilityHistoryVar?.issuerSubscriberId}" maxlength="50"/>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.0.issuerSubscriberId', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerSubscriberId')">																	 
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'rateType', 'error')} ">
														<label for="rateType"> <g:message
																code="eligHistory.rateType.label" default="Rate Type :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<input type="hidden" id="systemCodeType" 
														name="systemCodeType" value="RATETYPE"/>														
													
														<g:textField maxlength="50"
															name="eligHistory.0.rateType"
															value="${eligibilityHistoryVar?.rateType}" maxlength="10"/>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.0.rateType', 'com.perotsystems.diamond.dao.cdo.SystemCodes','systemCode','systemCodeType', 'systemCodeType',null ,null )">																	 
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'issuerGroupNumber', 'error')} ">
														<label for="issuerGroupNumber"> <g:message
																code="eligHistory.issuerGroupNumber.label" default="Issuer Group Number :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">																									
														<g:textField maxlength="50"
															name="eligHistory.0.issuerGroupNumber"
															value="${eligibilityHistoryVar?.issuerGroupNumber}" maxlength="30"/>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.0.issuerGroupNumber', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerGroupNumber')">																	 
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'issuerPolicyNumber', 'error')} ">
														<label for="issuerPolicyNumber"> <g:message
																code="eligHistory.issuerPolicyNumber.label" default="Issuer Policy Number :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">						
														<g:textField maxlength="50"
															name="eligHistory.0.issuerPolicyNumber"
															value="${eligibilityHistoryVar?.issuerPolicyNumber}" maxlength="50"/>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.0.issuerPolicyNumber', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerPolicyNumber')">																	 
													</div>
												</td>
											</tr>
																						<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'issuerMemberId', 'error')} ">
														<label for="issuerMemberId"> <g:message
																code="eligHistory.issuerMemberId.label" default="Issuer Member Id :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">	
														<g:textField maxlength="50"
															name="eligHistory.0.issuerMemberId"
															value="${eligibilityHistoryVar?.issuerMemberId}" maxlength="50"/>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.0.issuerMemberId', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerMemberId')">																	 
													</div>
												</td>
											</tr>
													<tr><td class="tdFormElement" style="white-space: nowrap" colspan="4"><hr></td></tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'siteCode', 'error')} ">
																	<label for="siteCode"> <g:message
																			code="eligHistory.siteCode.label"
																			default="Site Code :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="12"
																		name="eligHistory.0.siteCode"
																		value="${eligibilityHistoryVar?.siteCode}" />
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'panelId', 'error')} ">
																	<label for="panelId"> <g:message
																			code="eligHistory.panelId.label" default="Panel Id :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="3" name="eligHistory.0.panelId"
																		value="${eligibilityHistoryVar?.panelId}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.panelId', 'com.perotsystems.diamond.dao.cdo.GroupPanel','panelId', 'eligHistory.0.seqGroupId', 'seqGroupId',  null, null)">	
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'ipaId', 'error')} ">
																	<label for="ipaId"> <g:message
																			code="eligHistory.ipaId.label" default="IPA Id :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<input type="hidden" name="ipaLevelCode" id="ipaLevelCode" value="1"/>																
																	<g:textField name="eligHistory.0.ipaId"
																		value="${eligibilityHistoryVar?.ipaId}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.ipaId', 'com.perotsystems.diamond.dao.cdo.IpaMaster','ipaId', 'ipaLevelCode', 'levelCode',  null, null)">
																</div>
															</td>

														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'PCPID', 'error')} ">
																	<label for="PCPID"> <g:message
																			code="eligHistory.PCPID.label" default="PCP ID :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<input type="hidden" name="providerContractType" id="providerContractType" value="P"/>
																	<g:textField name="eligHistory.0.seqProvId" value="${eligibilityHistoryVar?.seqProvId }" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.seqProvId', 'com.perotsystems.diamond.dao.cdo.ProvContract','seqProvId', 'eligHistory.0.lineOfBusiness|providerContractType', 'lineOfBusiness|contractType',  null, null)">
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'pcpChangeReason', 'error')} ">
																	<label for="pcpChangeReason"> <g:message
																			code="eligHistory.pcpChangeReason.label"
																			default="PCP Change Reason :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<input type="hidden" name="PCPReasonType" id="PCPReasonType" value="PC"/>
																	<g:textField maxlength="5"
																		name="eligHistory.0.pcpChangeReason"
																		value="${eligibilityHistoryVar?.pcpChangeReason}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.pcpChangeReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'PCPReasonType', 'reasonCodeType',  null, null)">
																</div>
															</td>

														</tr>
													<tr><td class="tdFormElement" style="white-space: nowrap" colspan="4"><hr></td></tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'medicareStatusFlg', 'error')} ">
																	<label for="medicareStatusFlg"> <g:message
																			code="eligHistory.medicareStatusFlg.label"
																			default="Medicare Status Flag :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="12"
																		name="eligHistory.0.medicareStatusFlg"
																		value="${eligibilityHistoryVar?.medicareStatusFlg}" />
																</div>
															</td>
														</tr>
													<tr><td class="tdFormElement" style="white-space: nowrap" colspan="4"><hr></td></tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'subscDept', 'error')} ">
																	<label for="subscDept"> <g:message
																			code="eligHistory.subscDept.label"
																			default="Subscriber Dept :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="20"
																		name="eligHistory.0.subscDept"
																		value="${eligibilityHistoryVar?.subscDept}" />
																	<img width="25" height="25"
																		style="float: none; vertical-align: bottom"
																		class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.0.subscDept', 'com.perotsystems.diamond.dao.cdo.GroupDepartment','deptNumber', 'eligHistory.0.seqGroupId', 'seqGroupId', null, null)">
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'subscLocation', 'error')} ">
																	<label for="subscLocation"> <g:message
																			code="eligHistory.subscLocation.label"
																			default="Location :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">																
																	<g:getSystemCodeToken
																		systemCodeType="MELIGLOC" languageId="0"
																		htmlElelmentId="eligHistory.0.subscLocation"
																		blankValue="Location" 
																		defaultValue="${eligibilityHistoryVar?.subscLocation}" 
																		width="150px"/>
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'hireDate', 'error')} ">
																	<label for="hireDate"> <g:message
																			code="eligHistory.hireDate.label"
																			default="Hire Date :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<fmsui:jqDatePicker dateElementId="eligHistory.0.hireDate" 
																		dateElementName="eligHistory.0.hireDate" 
																		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.hireDate != null ? eligibilityHistoryVar?.hireDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.hireDate)}"/>

																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'csIndicator', 'error')} ">
																	<label for="csIndicator"> <g:message
																			code="eligHistory.csIndicator.label"
																			default="CS Indicator :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:getSystemCodeToken
																		systemCodeType="MEMCSIND" languageId="0"
																		htmlElelmentId="eligHistory.0.csIndicator"
																		blankValue="CS Indicator" 
																		defaultValue="${eligibilityHistoryVar?.csIndicator}" 
																		width="150px"/>
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'prospectivePremiumAmt', 'error')} ">
																	<label for="prospectivePremiumAmt"> <g:message
																			code="eligHistory.prospectivePremiumAmt.label"
																			default="Prospective Premium Amt :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="18"
																		name="eligHistory.0.prospectivePremiumAmt"
																		value="${eligibilityHistoryVar?.prospectivePremiumAmt}" />
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined1', 'error')} ">
																	<label for="userDefined1"> 
																		<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"/>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="30"
																		name="eligHistory.0.userDefined1"
																		value="${eligibilityHistoryVar?.userDefined1}" />
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'memberClass1', 'error')} ">
																	<label for="memberClass1"> <g:message
																			code="eligHistory.memberClass1.label"
																			default="Member Class1 :" />

																	</label>
																</div>
															</td>

															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="5"
																		name="eligHistory.0.memberClass1"
																		value="${eligibilityHistoryVar?.memberClass1}" />
																</div>
															</td>
														</tr>
														<tr>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'memberClass2', 'error')} ">
																	<label for="memberClass2"> <g:message
																			code="eligHistory.memberClass2.label"
																			default="Member Class2 :" />

																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="5"
																		name="eligHistory.0.memberClass2"
																		value="${eligibilityHistoryVar?.memberClass2}" />
																</div>
															</td>
														</tr>
														<tr>

															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined2', 'error')} ">
																	<label for="userDefined2"> 
																		<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"/>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="30"
																		name="eligHistory.0.userDefined2"
																		value="${eligibilityHistoryVar?.userDefined2}" />
																</div>
															</td>
															<td class="tdFormElement" style="white-space: nowrap">
																<div
																	class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined3', 'error')} ">
																	<label for="userDefined3"> 
																		<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"/>
																	</label>
																</div>
															</td>
															<td>
																<div class="fieldcontain">
																	<g:textField maxlength="30"
																		name="eligHistory.0.userDefined3"
																		value="${eligibilityHistoryVar?.userDefined3}" />
																</div>
															</td>
														</tr>
													</table> <!-- End Eligiblity record Dynamic Content -->
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveEligibilityPeriod"
					value="${message(code: 'default.button.update.label', default: 'List')}" />
				<input type="Reset" class="reset" value="reset" id="resetButton" />
				<input type="button" class="close" name="close" value="Close"
					onClick="closeForm()">
			</fieldset>
		</g:form>
	</div>

	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>

</body>
</html>