<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#memberIdSelectList [disabled] {
	color: #933;
}

label {
	white-space: nowrap;
}
</style>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />

<g:set var="appContext" bean="grailsApplication" />

<title><g:message code="default.show.label" args="[entityName]" /></title>


<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<link rel="stylesheet"	href="${resource(dir: 'css', file: 'member_pages.css')}"	type="text/css">

<script type="text/javascript"	src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript"	src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript"	src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

<script type="text/javascript"	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
<script type="text/javascript"	src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
<script type="text/javascript"	src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>

<script type="text/javascript"> 


$(document).ready(function() { 	

	$(function(){
	    $(".numeric").numeric({});
	});
	
	$(function(){
		$(".alphanum").alphanum();
	});

	$(function(){
	    $(".amtNumeric").numeric({});
	    $(".qhpMask").mask("99999aa999999999");		
	});
	
jQuery.validator.setDefaults({
	  debug: true,
		ignore: [],		  
	  success: "valid"
	});

$(function() {		
		$("#editForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
			rules : {
					 'lisInfo.0.lisStartDate' : {
						required : true
					},
					'lisInfo.0.lisEndDate' : {
						required : true
					},
					'lisInfo.0.lisCopayCategory' : {
						required : true					
					},
					'lisInfo.0.lisSourceCode' : {
						required : true		
					},
					'lisInfo.0.enrolleeTypeFlag' : {
						required : true		
					}									
									
		},
			messages : {
				'lisInfo.0.lisStartDate' : {
					required : "Please select LIS Start Date"
				},
				'lisInfo.0.lisEndDate' : {
					required : "Please select LIS End Date"
				},
				'lisInfo.0.lisCopayCategory' : {
					required : "Please select LIS Copay Category"
				},
				'lisInfo.0.lisSourceCode' : {
					required : "Please select LIS Source Code"
				},
				'lisInfo.0.enrolleeTypeFlag' : {
					required : "Please select Enrollee Type Flag"
				}
							
			} 			 
		})
	});

	}); // end of function ready

	$(function(){
	    $(".numeric").numeric({});
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
					id="${params.susbcriberId}"
					params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" 
					params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Information</g:link></li>					
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="show-memberMaster" class="content scaffold-show" role="main">
		&nbsp;
		<h1 style="color: #48802C">
			Add MEMMC LIS to Member :
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
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveLisInfo" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
			<input type="hidden" name="personNumber"
				value="${params.personNumber}" />
			<input type="hidden" name="subscriberId"
				value="${params.susbcriberId }" />

			<table>
				<tr>
					<td>
						<table border="0" id="report">
							<tr class="showme">
								<td colspan="13">
									<div class="divContent">
										<table class="report1" border="0" style="table-layout: fixed;">
											<tr>																															
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisStartDate', 'error')} ">
														<label for="lisStartDate"> <g:message
																code="lisInfo.lisStartDate.label"
																default="LIS Start Date :" /> 
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>												  
												<td class="tdFormElement" colspan="2"><fmsui:jqDatePicker
														dateElementId="lisInfo.0.lisStartDate"
														dateElementName="lisInfo.0.lisStartDate"
														mandatory="mandatory"
														datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${
															(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisStartDate != null 
															? lisInfo?.lisStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'"
														dateElementValue="${formatDate(format:'MM/dd/yyyy', date: lisInfo?.lisStartDate)}" 
														precision="day" />

												</td>
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisEndDate', 'error')} ">
														<label for="lisEndDate"> <g:message
																code="lisInfo.lisEndDate.label"
																default="LIS End Date :" /> 
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2"><fmsui:jqDatePicker
														dateElementId="lisInfo.0.lisEndDate"
														dateElementName="lisInfo.0.lisEndDate"
														mandatory="mandatory"
														datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${
															(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisEndDate != null 
															? lisInfo?.lisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'"
														dateElementValue="${formatDate(format:'MM/dd/yyyy', date: lisInfo?.lisEndDate)}" 
														precision="day"/>

												</td>	
											</tr>											
											<tr>
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisSubsidyLevel', 'error')} ">
														<label for="lisSubsidyLevel"> <g:message
																code="lisInfo.lisSubsidyLevel.label"
																default="LIS Subsidy Level :" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2"><g:textField
														name="lisInfo.0.lisSubsidyLevel" maxlength="6"
														value="${lisInfo?.lisSubsidyLevel}" class="numeric"
														title="Calculated value as per TRR business"/></td>
												
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisCopayCategory', 'error')} ">
														<label for="lisCopayCategory"> <g:message
																code="lisInfo.lisCopayCategory.label"
																default="LIS Copay Category :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><select name="lisInfo.0.lisCopayCategory">													
													<option value="0" ${lisInfo.lisCopayCategory.equals('0') ? 'selected':'' }>None, not low-income</option>
													<option value="1" ${lisInfo.lisCopayCategory.equals('1') ? 'selected':'' }>High</option>
													<option value="2" ${lisInfo.lisCopayCategory.equals('2') ? 'selected':'' }>Low</option>
													<option value="3" ${lisInfo.lisCopayCategory.equals('3') ? 'selected':'' }>$0 Full duals that are institutionalized</option>
													<option value="4" ${lisInfo.lisCopayCategory.equals('4') ? 'selected':'' }>15%</option>
													<option value="5" ${lisInfo.lisCopayCategory.equals('0') ? 'selected':'' }>Unknown</option>													
												</select></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisSourceCode', 'error')} ">
														<label for="lisSourceCode"> <g:message
																code="lisInfo.lisSourceCode.label"
																default="LIS Source Code :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><select name="lisInfo.0.lisSourceCode">
													<option value="A" ${lisInfo.lisSourceCode.equals('A') ? 'selected':'' }>Approved SSA Applicant</option>
													<option value="D" ${lisInfo.lisSourceCode.equals('D') ? 'selected':'' }>Deemed eligible by CMS</option>
													<option value="B" ${lisInfo.lisSourceCode.equals('B') ? 'selected':'' }>BAE</option>																										
												</select></td>												
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.enrolleeTypeFlag', 'error')} ">
														<label for="enrolleeTypeFlag"> <g:message
																code="lisInfo.enrolleeTypeFlag.label"
																default="LIS Enrollee Type Flag :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><select name="lisInfo.0.enrolleeTypeFlag">
													<option value="C" ${lisInfo.enrolleeTypeFlag.equals('C') ? 'selected':'' }>Current PBP Enrollee</option>
													<option value="P" ${lisInfo.enrolleeTypeFlag.equals('P') ? 'selected':'' }>Prospective PBP Enrollee</option>
													<option value="Y" ${lisInfo.enrolleeTypeFlag.equals('Y') ? 'selected':'' }>Previous PBP Enrollee</option>																										
												</select></td>
											</tr>														
											<tr>
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.partdLisEnrSubsidy', 'error')} ">
														<label for="partdLisEnrSubsidy"> <g:message
																code="lisInfo.partdLisEnrSubsidy.label"
																default="Part D Enr Subsidy :" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2"><g:textField
														name="lisInfo.0.partdLisEnrSubsidy" maxlength="19"
														value="${lisInfo?.partdLisEnrSubsidy}" class="numeric"
														title="Part D late enrollment penalty subsidy amount"/></td>
												
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.partdLisSubsidy', 'error')} ">
														<label for="partdLisSubsidy"> <g:message
																code="lisInfo.partdLisSubsidy.label"
																default="Part D LIS Subsidy :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2"><g:textField
														name="lisInfo.0.partdLisSubsidy" maxlength="19"
														value="${lisInfo?.partdLisSubsidy}" class="numeric"
														title="Low Income Part D premium subsidy amount"/></td>
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
				<g:actionSubmit class="save" action="saveLisInfo"
					value="${message(code: 'default.button.update.label', default: 'List')}" />
				<input type="Reset" class="reset" value="Reset" id="resetButton" />
				<input type="button" name="close" value="Close" class="close"
					onClick="closeForm()">
			</fieldset>
		</g:form>
	</div>

	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>

</body>
</html>