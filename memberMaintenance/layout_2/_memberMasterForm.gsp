<%@ page import="com.perotsystems.diamond.bom.Member"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.States"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<%@ page import="com.perotsystems.diamond.bom.Language"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistoryExtn"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberMaster"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupMaster"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.AgentMaster"%>
<%@ page import="com.perotsystems.diamond.bom.GroupContactPerson"%>

<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script>
	var addRowClicked = false
	function cloneRow() {

		var divObjSrc = document.getElementById('newMemberMaster')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = true;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display = "block"
		addRowClicked = true
	}
	var previousDivObj
	function releaseMemberSelection() {
		var result = confirm(
				"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
				"Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			var selectObj = document.getElementById("memberIdSelectList")
			selectObj.disabled = false;
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display = "none"
			var divObjDest = document.getElementById('addGroupPlaceHolder')
			divObjDest.innerHTML = "&nbsp;<b>gone</b>"
			var divObj = document.getElementById('addAddressDiv')
			divObj.style.display = "block"
			var formObj = document.getElementById('editForm')
			formObj.reset()
		}
	}
	function showAddress(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")
		if (!addRowClicked) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var addressDivObj = document.getElementById(selectedValue)
			var addAddressDivObj = document.getElementById("addAddressDiv")
			hiddenObj.value = selectedValue
			if (addressDivObj != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display = "none"
				}
				addressDivObj.style.display = "block"
				addAddressDivObj.style.display = "block"
				previousDivObj = addressDivObj
			} else {
				addAddressDivObj.style.display = "none"
			}
		} else {
			var result = confirm(
					"Navigating to a new Member would result in the loss of data, Please confirm ",
					"Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj)
			} else {

			}
		}
	}

	function addDependant() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/addDependant?subscriberID="
				+ subscriberId + "&editType=MASTER");
	}

	$(function($){
	   $(".SSNMember").mask("?999-99-9999");
	   $(".ZIPMember").mask("99999?-9999");
	})
	
	
</script>
<script type="text/javascript">
function displayAddressMessage(){
	alert ("To populate primary address fields, complete and save this member master page. Then under the 'Addresses' tab, add a primary address with an appropriate effective date.");
}
</script>

<input type="hidden" name="editType" value="MASTER" />
Member Master Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<table>
	<tr>
		<td>
			<% def personNumber = (params.personNumber) ? params.personNumber : "01" %>
			<select id="memberIdSelectList" name="memberIdlist"
			onChange="showAddress(this)"
			size="${ memberMasterMap.keySet().size() +2}"
			style="width: 100%; background-color: #C7DDEE;">
				<option value="dummy">-- Select a Member --</option>
				<g:each in="${memberMasterMap.keySet() }" status="idCount"
					var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
					<option value="${memberDBID }"
						${personNumber.equals( member.personNumber )?'selected':'' }>
						<g:if test="${member.personNumber }">
							${ member.personNumber }
						</g:if>
						-
						<g:if test="${member.firstName }">
							${member.firstName }
						</g:if>
						<g:if test="${member.lastName }">
							${member.lastName }
						</g:if>
					</option>
				</g:each>
		</select>
		</td>
	</tr>
	<tr>
	
	<g:if test="${subscriberMember?.memberDBID }">
		<td>
		<g:checkURIAuthorization uri="/memberMaintenance/addDependant">
		<input type="button" class="load" value="Add Dependent"
			onClick="addDependant()" />
		</g:checkURIAuthorization>	
		</td>
			</g:if>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div id="addAddressDiv"></div>
		</td>
		<td>
			<div id="releaseSelect" style="display: none">
				<input type="button" value="Enable Member Selection"
					onClick="releaseMemberSelection()" name="enableMember">
			</div>
		</td>
	</tr>
</table>
<br />


<div id="dummy" style="display: none">&nbsp;</div>
<g:each in="${memberMasterMap.values() }" status="idCount"
	var="memberMaster">
	<div id="${memberMaster.memberDBID }" style="display: none">
		<input type="hidden" name="seq_master_id_${i}"
			value="${memberMaster.memberDBID }"> 
		<input type="hidden"
			name="memberMaster.${memberMaster.memberDBID }.iterationCount"
			value="${memberMaster.memberDBID }">
		<table  border="0">
			<tr>
				<td>
					<table  border="0" style="vertical-align: middle; text-align: middle">
						<tr>
							<td style="white-space: nowrap;">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'subscriberID', 'error')} required ">
									
									<label for="subscriberID"> <g:message
											code="memberMaster.subscriberID.label"
											default="Subscriber Id: " />											
									</label> <input type="hidden" name="memberDBID"
										value="${memberMaster?.memberDBID}" />
										</div>
									</td>
									
									<td colspan="2">
									<g:if test="${ subscriberMember.subscriberID}">
										<input type="hidden" name="subscriberID"
											value="${subscriberMember.subscriberID}" />
											
										<g:secureTextField maxlength="50" size="60" disabled="disabled" style="margin-right: 5px;"
											name="memberMaster.${ memberMaster?.memberDBID }.subscriberID"
											tableName="MEMBER_MASTER" attributeName="subscriberId" 
											value="${memberMaster.subscriberID}"></g:secureTextField>
									</g:if>
									<g:else>
										<g:secureTextField maxlength="50" size="60"style="margin-right: 5px;"
											name="memberMaster.${ memberMaster?.memberDBID }.subscriberID"
											tableName="MEMBER_MASTER" attributeName="subscriberID" 
											value="${request.getParameter('subscriberID')}"
											onChange="document.getElementById('subscriberID').value=this.value"></g:secureTextField>
									</g:else>
							</td>

							<td style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'personNumber', 'error')} required">
									<label for="personNumber"> <g:message
											code="memberMaster.groupLevel.label" default="Person Number:" />
										<span class="required-indicator">*</span>
									</label>	
									</div>
									</td>
									<td>
									<input type="hidden" name="memberMaster.${ memberMaster?.memberDBID }.personNumber"
										value="${memberMaster.personNumber}" />									
									<g:secureTextField type="text" disabled="disabled"
										name="memberMaster.${ memberMaster?.memberDBID }.personNumber" 
										tableName="MEMBER_MASTER" attributeName="personNumber" 
										value="${memberMaster.personNumber}"></g:secureTextField>
							</td>
						</tr>
						<tr>
							<td  style="white-space: nowrap" >

								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'lastName', 'error')} ">
									<label for="parent"> <g:message
											code="memberMaster.lastName.label" default="Last Name:  " title="last Name"/>
										<span class="required-indicator">*</span>
									</label>
								</div>
								</td>
								<td colspan="4">
									<g:secureTextField maxlength="60" size="60" style="margin-right: 5px;"
										name="memberMaster.${ memberMaster?.memberDBID }.lastName" class="RemoveSpecialChars"
										tableName="MEMBER_MASTER" attributeName="lastName" 
										value="${memberMaster.lastName}" title="last Name"></g:secureTextField>	
							</td>
						</tr>
						<tr>
							<td  style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'firstName', 'error')}  ">
									<label for="firstName"> <g:message
											code="memberMaster.firstName.label" default="First Name: " />
									</label>
									</div>
								</td>
								<td colspan="4">
									<g:secureTextField maxlength="35" size="60" style="margin-right: 5px;"
										name="memberMaster.${ memberMaster?.memberDBID }.firstName"  class="RemoveSpecialChars"
										tableName="MEMBER_MASTER" attributeName="firstName" 
										value="${memberMaster.firstName}" title="first Name"></g:secureTextField>
							</td>
						</tr>
						<tr>
							<td  style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'middleInitial', 'error')} ">
									<label for="middleInitial"> <g:message
											code="memberMaster.middleInitial.label"
											default="Middle Name: " />

									</label>
								</div>
								</td>
								<td colspan="2">
									<g:secureTextField maxlength="25" size="60"  style="margin-right: 5px;"
										name="memberMaster.${ memberMaster?.memberDBID }.middleInitial" class="RemoveSpecialChars"
										tableName="MEMBER_MASTER" attributeName="middleInitial" 
										value="${memberMaster.middleInitial}"></g:secureTextField>
							</td>

							<td  style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'namePrefix', 'error')} ">
									<label for="namePrefix"> <g:message
											code="memberMaster.namePrefix.label" default="Salutation: " />

									</label>
									</div>
									</td>
									<td>
									<g:secureCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
										tableName="MEMBER_MASTER" attributeName="middleInitial" 
										cdoAttributeWhereValue="S"
										cdoAttributeWhere="titleType"
										cdoAttributeSelect="contactTitle"
										cdoAttributeSelectDesc="description"
										languageId="0"
										htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.prefixName"
										defaultValue="${memberMaster?.primaryMemberAddress?.prefixName}"
										blankValue="Salutation" 
										width="150px"
										disable="${!elementsEnabled?"disabled":""}">
									</g:secureCdoSelectBox>
							</td>							
							</tr>
							<tr>
							<td  style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'dob', 'error')} ">
									<label for="dob"> <g:message
											code="memberMaster.dob.label" default="DOB : " /> <span
										class="required-indicator">*</span>
									</label>
								</div>
								</td>
								<td colspan="2">							
									<g:secureGrailsDatePicker
										name="memberMaster.${ memberMaster?.memberDBID }.dob" 
										tableName="MEMBER_MASTER" attributeName="dateOfBirth" precision="day" noSelection="['':'']"
										value="${memberMaster?.dob}" default="none"></g:secureGrailsDatePicker>
							   </td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'gender', 'error')} ">
									<label for="gender"> <g:message
											code="memberMaster.gender.label" default="Gender : " /> <span
										class="required-indicator">*</span>
									</label>									
									</div>
								</td>
								<td>
									<g:secureDiamondDataWindowDetail columnName="gender" dwName="dw_edied_de" languageId="0"
										htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.gender"
										defaultValue="${memberMaster?.gender}" blankValue="Gender"
										name="memberMaster.${ memberMaster?.memberDBID }.gender" 
										tableName="MEMBER_MASTER" attributeName="gender" value="${memberMaster?.gender}"
									/>	
							</td>
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'HIX Effectuation', 'error')} ">
									<label for="hixEffectuation"> <g:message
											code="memberMaster.hixEffectuation.label" default="HIX Effectuation : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField maxlength="1" size="30"
										name="memberMaster.${ memberMaster?.memberDBID }.hixEffectuation" 
										tableName="MEMBER_MASTER" attributeName="hixEffectuation" 
										value="${memberMaster.hixEffectuation}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'medicaidNo', 'error')} ">
									<label for="medicaidNo"> <g:message
											code="memberMaster.medicaidNo.label" default="Medicaid No : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField maxlength="50" size="30"
										name="memberMaster.${ memberMaster?.memberDBID }.medicaidNo" 
										tableName="MEMBER_MASTER" attributeName="medicaidNo" 
										value="${memberMaster.medicaidNo}"></g:secureTextField>
							</td>									
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'socialSecurityNumber', 'error')} ">
									<label for="socialSecurityNumber"> <g:message
											code="memberMaster.socialSecurityNumber.label" default="SSN : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField maxlength="11" size="30"
										name="memberMaster.${ memberMaster?.memberDBID }.socialSecurityNumber" class="SSNMember"
										tableName="MEMBER_MASTER" attributeName="socialSecNo" 
										value="${memberMaster.socialSecurityNumber}"></g:secureTextField>
							</td>
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'employmentStatusCode', 'error')} ">
									<label for="employmentStatusCode"> <g:message
											code="memberMaster.employmentStatusCode.label" default="Employment Status : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureSystemCodeToken
										systemCodeType="EMPSTAT" languageId="0"
										tableName="MEMBER_MASTER" attributeName="employmentStatusCode" 
										htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.employmentStatusCode"
										blankValue="Status" 
										defaultValue="${memberMaster?.employmentStatusCode}" 
										width="150px">
									</g:secureSystemCodeToken>	
							</td>						
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster?.language, field: 'code', 'error')} ">
									<label for="code"> <g:message
											code="memberMaster.code.label" default="Primary Language : " />
									</label>									
								</div>
							</td>
							<td>
								<g:secureTextField size="30"  maxlength="5"
									name="memberMaster.${ memberMaster?.memberDBID }.language.code" 
									tableName="MEMBER_MASTER" attributeName="languageCode" 
									value="${memberMaster?.language?.code}"></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('memberMaster.${ memberMaster?.memberDBID }.language.code', 'com.perotsystems.diamond.bom.Language','code')">
							</td>
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'maritalStatus', 'error')} ">
									<label for="maritalStatus"> <g:message
											code="memberMaster.maritalStatus.label" default="Marital Status : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureDiamondDataWindowDetail columnName="marital_status" dwName="dw_membr_identification" languageId="0"
										htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.maritalStatus"
										defaultValue="${memberMaster?.maritalStatus}" blankValue="Status"
										name="memberMaster.${ memberMaster?.memberDBID }.maritalStatus" 
										tableName="MEMBER_MASTER" attributeName="maritalStatus" value="${memberMaster?.maritalStatus}"
									/>
							</td>	
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined1', 'error')} ">
									<label for="userDefined1"> <g:message
											code="memberMaster.userDefined1.label" default="User Defined 1 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined1" 
										tableName="MEMBER_MASTER" attributeName="userDefined1" 
										value="${memberMaster?.userDefined1}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDate1', 'error')} ">
									<label for="userDate1"> <g:message
											code="memberMaster.userDate1.label" default="User Date 1 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureGrailsDatePicker maxlength="5"
										name="memberMaster.${ memberMaster?.memberDBID }.userDate1" 
										tableName="MEMBER_MASTER" attributeName="userDate1" precision="day" noSelection="['':'']"
										value="${memberMaster?.userDate1}" default="none"></g:secureGrailsDatePicker>
							</td>	
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined2', 'error')} ">
									<label for="userDefined2"> <g:message
											code="memberMaster.userDefined2.label" default="User Defined 2 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined2" 
										tableName="MEMBER_MASTER" attributeName="userDefined2" 
										value="${memberMaster?.userDefined2}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDate2', 'error')} ">
									<label for="userDate2"> <g:message
											code="memberMaster.userDate2.label" default="User Date 2 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureGrailsDatePicker maxlength="5"
										name="memberMaster.${ memberMaster?.memberDBID }.userDate2" 
										tableName="MEMBER_MASTER" attributeName="userDate2" precision="day" noSelection="['':'']"
										value="${memberMaster?.userDate2}" default="none"></g:secureGrailsDatePicker>
							</td>	
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined3', 'error')} ">
									<label for="userDefined3"> <g:message
											code="memberMaster.userDefined3.label" default="User Defined 3 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined3" 
										tableName="MEMBER_MASTER" attributeName="userDefined3" 
										value="${memberMaster?.userDefined3}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDate3', 'error')} ">
									<label for="userDate3"> <g:message
											code="memberMaster.userDate3.label" default="User Date 3 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureGrailsDatePicker maxlength="5"
										name="memberMaster.${ memberMaster?.memberDBID }.userDate3" 
										tableName="MEMBER_MASTER" attributeName="userDate3" precision="day" noSelection="['':'']"
										value="${memberMaster?.userDate3}" default="none"></g:secureGrailsDatePicker>
							</td>	
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined4', 'error')} ">
									<label for="userDefined4"> <g:message
											code="memberMaster.userDefined4.label" default="User Defined 4 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined4" 
										tableName="MEMBER_MASTER" attributeName="userDefined4" 
										value="${memberMaster?.userDefined4}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined5', 'error')} ">
									<label for="userDefined5"> <g:message
											code="memberMaster.userDefined5.label" default="User Defined 5 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined5" 
										tableName="MEMBER_MASTER" attributeName="userDefined5" 
										value="${memberMaster?.userDefined5}"></g:secureTextField>
							</td>		
						</tr>
						<tr>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined6', 'error')} ">
									<label for="userDefined6"> <g:message
											code="memberMaster.userDefined6.label" default="User Defined 6 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined6" 
										tableName="MEMBER_MASTER" attributeName="userDefined6" 
										value="${memberMaster?.userDefined6}"></g:secureTextField>
							</td>	
							<td></td>
							<td style="white-space: nowrap" >
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster, field: 'userDefined7', 'error')} ">
									<label for="userDefined7"> <g:message
											code="memberMaster.userDefined7.label" default="User Defined 7 : " />
									</label>									
									</div>
								</td>
								<td>
									<g:secureTextField size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined7" 
										tableName="MEMBER_MASTER" attributeName="userDefined7" 
										value="${memberMaster?.userDefined7}"></g:secureTextField>
							</td>		
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3">
					<h4>
						Contact Information - Primary Address
						<h4>
							<hr>
				</td>
			</tr>
			<tr>
				<td>
					<table  border="0">
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'address1', 'error')} ">
									<label for="address1" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.address1.label" default="Address1 :" onClick="displayAddressMessage()"/>				

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField maxlength="60"
											name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address1" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine1" 
											value="${memberMaster?.primaryMemberAddress?.address1}" disabled="disabled"></g:secureTextField>							
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'address2', 'error')} ">
									<label for="address2" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.address2.label" default="Address2 :" 
											onclick="displayAddressMessage()"/>

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address2"
										tableName="MEMBER_ADDRESS" attributeName="addressLine2" 
										value="${memberMaster?.primaryMemberAddress?.address2}"
										maxlength="60" disabled="disabled" />

							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'city', 'error')} ">
									<label for="city" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.city.label" default="City :" />

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField  
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.city"
										tableName="MEMBER_ADDRESS" attributeName="city" 
										value="${memberMaster?.primaryMemberAddress?.city}"
										maxlength="30" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'state', 'error')} ">
									<label for="memberState" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.memberState.label" default="State :" />
											<span class="required-indicator">*</span>

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureComboBox
											name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.state" optionKey="stateCode"
											tableName="MEMBER_ADDRESS" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${memberMaster.primaryMemberAddress?.state}" disabled="disabled" onClick="displayAddressMessage()">
										</g:secureComboBox>

							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'zip', 'error')} ">
									<label for="zipCode" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.zipCode.label" default="Zip Code :" />

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.zip" class="ZIPMember"
										tableName="MEMBER_ADDRESS" attributeName="zipCode" class="maskZip"
										value="${memberMaster?.primaryMemberAddress?.zip}"
										maxlength="11" disabled="disabled" />
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'county', 'error')} ">
									<label for="county" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.county.label" default="County :" />

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.county"
										tableName="MEMBER_ADDRESS" attributeName="county" 
										value="${memberMaster?.primaryMemberAddress?.county}"
										maxlength="30" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean:memberMaster.primaryMemberAddress, field: 'country', 'error')} ">
									<label for="country" onclick="displayAddressMessage()"> <g:message
											code="memberMaster.country.label" default="Country :" />

									</label>
									</div>
									</td>
									<td onclick="displayAddressMessage()">
									<g:secureTextField
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address1"
										tableName="MEMBER_ADDRESS" attributeName="country" 
										value="${memberMaster?.primaryMemberAddress?.country}"
										maxlength="30" disabled="disabled"/>
								</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<h4>
						Current Eligibility
						<h4>
							<hr>
							<%MemberEligHistory eligibilityHistoryVar = currentMemberEligibilityHistory.get(memberMaster.memberDBID)
							if(dependentFlag && dependentEligibilityHistory != null) eligibilityHistoryVar = dependentEligibilityHistory
							%>
				</td>
			</tr>
			
						<tr>
							<td> 
								<table  border="0">
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
										<td colspan="3">
											<div class="fieldcontain">
												<g:secureGrailsDatePicker mandatory="mandatory"
													name="eligHistory.${memberMaster?.memberDBID }.effectiveDate" disabled="${!elementsEnabled?"true":"false"}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="effectiveDate" precision="day" noSelection="['':'']"
													value="${eligibilityHistoryVar?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'termDate', 'error')} required">
												<label for="termDate"> <g:message
														code="eligHistory.termDate.label" default="Term Date :" />
													<span class="required-indicator"></span>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureGrailsDatePicker 
													name="eligHistory.${memberMaster?.memberDBID }.termDate" disabled="${!elementsEnabled?"true":"false"}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="termDate" precision="day" noSelection="['':'']"
													value="${eligibilityHistoryVar?.termDate}" default="none"></g:secureGrailsDatePicker>
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
												<g:secureTextField maxlength="5"
													name="eligHistory.${memberMaster.memberDBID }.termReason" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="termReason" 
													value="${eligibilityHistoryVar?.termReason}" disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode')">
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
												<g:secureGrailsDatePicker 
													name="eligHistory.${memberMaster?.memberDBID }.dateOfDeath" disabled="${!elementsEnabled?"true":"false"}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="dateOfDeath" precision="day" noSelection="['':'']"
													value="${eligibilityHistoryVar?.dateOfDeath}" default="none"></g:secureGrailsDatePicker>
											</div>
										</td>
										<td colspan="2"></td>
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
												<g:secureComboBox disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.eligStatus" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="eligStatus" value="${eligibilityHistoryVar?.eligStatus}"
													from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key">
												</g:secureComboBox>			
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
												<g:secureComboBox disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.voidEligFlag" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="voidEligFlag" value="${eligibilityHistoryVar?.voidEligFlag}"
													from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key">
												</g:secureComboBox>	
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
												<g:secureTextField maxlength="15"
													name="eligHistory.${memberMaster.memberDBID }.recordStatus" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="recordStatus" 
													value="${eligibilityHistoryVar?.recordStatus}" 
													disabled="${!elementsEnabled?"true":"false"}"></g:secureTextField>
											</div>
										</td>

										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'benefitStartDate', 'error')} required">
												<label for="benefitStartDate"> <g:message
														code="eligHistory.benefitStartDate.label"
														default="Benefit Start Date :" /> 
														<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureGrailsDatePicker mandatory="mandatory" 
													name="eligHistory.${memberMaster?.memberDBID }.benefitStartDate" disabled="${!elementsEnabled?"true":"false"}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="benefitStartDate" precision="day" noSelection="['':'']"
													value="${eligibilityHistoryVar?.benefitStartDate}" default="none"></g:secureGrailsDatePicker>
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
												<g:secureDiamondDataWindowDetail columnName="relationship_code_fms" dwName="dw_ccont_melig" languageId="0"
													htmlElelmentId="eligHistory.${memberMaster.memberDBID }.relationshipCode"
													defaultValue="${eligibilityHistoryVar?.relationshipCode}" blankValue="Relationship Code"
													name="eligHistory.${memberMaster.memberDBID }.relationshipCode" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="relationshipCode" 
													disable="${!elementsEnabled?"disabled":""}"
													value="${eligibilityHistoryVar?.relationshipCode}">
												</g:secureDiamondDataWindowDetail>	
											</div>
										</td>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: memberEligHistoryExtnList, field: 'benefitEndDate', 'error')} ">
												<label for="benefitEndDate"> <g:message
														code="memberEligHistoryExtnList.benefitEndDate.label"
														default="Benefit End Date :"/>

												</label>
											</div>
										</td>
											<g:if test="${eligibilityHistoryVar?.seqEligHist != null}">
												<td>
													<div class="fieldcontain">
														<g:secureGrailsDatePicker 
															name="memberEligHistoryExtnList.benefitEndDate" disabled="${!elementsEnabled?"true":(MultiPlanEnabled ? (dependentFlag ? "true" : "false") : "false")}"
															tableName="MEMBER_ELIG_HISTORY_EXTN" attributeName="benefitEndDate" precision="day" noSelection="['':'']"
															value="${memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate}" default="none"
															title = "Enter date for members end of eligibility"></g:secureGrailsDatePicker>
													</div>
												</td>
											</g:if>
											<g:else>
												<td>
												<div class="fieldcontain">
													<g:secureGrailsDatePicker 
															name="memberEligHistoryExtnList.benefitEndDate" disabled="${!elementsEnabled?"true":(MultiPlanEnabled ? (dependentFlag ? "true" : "false") : "false")}"
															tableName="MEMBER_ELIG_HISTORY_EXTN" attributeName="benefitEndDate" precision="day" noSelection="['':'']" mandatory="mandatory"
															value="${currentEligHistoryExtn?.benefitEndDate}" default="none"
															title = "Enter date for members end of eligibility"></g:secureGrailsDatePicker>
												</div>
												</td>
											</g:else>
										
									</tr>

								<tr><td colspan="4"><hr></td></tr>

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
												<input type="hidden" name="eligHistory.${memberMaster.memberDBID }.seqGroupId"
													id="eligHistory.${memberMaster.memberDBID }.seqGroupId"
													value="${eligibilityHistoryVar?.seqGroupId}" />
													
												<g:secureTextField maxlength="50" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.groupId" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="groupId" 
													value="${eligibilityHistoryVar?.groupId}"></g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'eligHistory.${memberMaster.memberDBID }.seqGroupId', 'seqGroupId' )">
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
													<g:secureComboBox
														name="eligHistory.${memberMaster.memberDBID }.subsidizedFlag"  disabled="${!elementsEnabled?"true":"false"}"
														tableName="MEMBER_ELIG_HISTORY" attributeName="subsidizedFlag" value="${eligibilityHistoryVar?.subsidizedFlag}"
														from="${['N': 'No' , 'Y': 'Yes']}" optionValue="value" optionKey="key">
													</g:secureComboBox>
												</div>
										</td>
										
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'planCode', 'error')} ">
												<label for="planCode"> <g:message
														code="eligHistory.planCode.label" default="Plan Code :" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="50" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.planCode" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="planCode" 
													value="${eligibilityHistoryVar?.planCode}"></g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.planCode', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId','seqGroupId')">
											</div>
										</td>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lineOfBusiness', 'error')} ">
												<label for="lineOfBusiness"> <g:message
														code="eligHistory.lineOfBusiness.label"
														default="Line Of Business :" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.lineOfBusiness" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="lineOfBusiness" 
													value="${eligibilityHistoryVar?.lineOfBusiness}"></g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.lineOfBusiness', 'com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster','lineOfBusiness')">
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
										<g:if test="${eligibilityHistoryVar?.seqEligHist != null}">
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
													name="memberEligSbmtMap.covLevelCode" 
													tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
													value="${memberEligSbmtMap?.get(eligibilityHistoryVar?.seqEligHist)?.covLevelCode}"
													title ="Enter a 3-character coverage level code"></g:secureTextField>
											</div>
										</td>
										</g:if>
										<g:else>
										<td>
											<div class="fieldcontain">
											<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
													name="memberEligSbmtMap.covLevelCode" 
													tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
													value="${currentEligSbmt?.covLevelCode}"
													title ="Enter a 3-character coverage level code"></g:secureTextField>
											</div>
										</td>
										</g:else>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'privacyOn', 'error')} ">
												<label for="privacyOn"> <g:message
														code="eligHistory.privacyOn.label" default="Privacy On :" />
													<span class="required-indicator">*</span>
												</label>
												
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureComboBox
													name="eligHistory.${memberMaster.memberDBID }.privacyOn"  disabled="${!elementsEnabled?"true":"false"}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="privacyOn" value="${eligibilityHistoryVar?.privacyOn}"
													from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key">
												</g:secureComboBox>
											</div>
										</td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'riders', 'error')} ">
												<label for="riders"> <g:message
														code="eligHistory.dentalLob.label" default="Riders :" />

												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain" style="padding-left:0px">
												<input type="hidden" id="RiderRecordType" name="RiderRecordType" value="R" />
												<table border="0">
													<tr>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode1" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode1" 
																value="${eligibilityHistoryVar?.riderCode1}">
															</g:secureTextField> 
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode1', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode2" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode2" 
																value="${eligibilityHistoryVar?.riderCode2}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode2', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode3" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode3" 
																value="${eligibilityHistoryVar?.riderCode3}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode3', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode4" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode4" 
																value="${eligibilityHistoryVar?.riderCode4}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode4', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
													</tr>
													<tr>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode5" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode5" 
																value="${eligibilityHistoryVar?.riderCode5}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode5', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode6" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode6" 
																value="${eligibilityHistoryVar?.riderCode6}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode6', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode7" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode7" 
																value="${eligibilityHistoryVar?.riderCode7}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode7', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
														</td>
														<td style="padding-left: 0px">
															<g:secureTextField maxlength="2" size="2" style="width:15px"
																name="eligHistory.${memberMaster.memberDBID }.riderCode8" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode8" 
																value="${eligibilityHistoryVar?.riderCode8}">
															</g:secureTextField>
															<img
																width="25" height="25"
																style="float: none; vertical-align: bottom"
																class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
																onclick="lookup('eligHistory.${memberMaster.memberDBID }.riderCode8', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
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
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode1" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode1" 
													value="${eligibilityHistoryVar?.riderContractTypeCode1}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode2" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode2" 
													value="${eligibilityHistoryVar?.riderContractTypeCode2}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField> 
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode3" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode3" 
													value="${eligibilityHistoryVar?.riderContractTypeCode3}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode4" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode4" 
													value="${eligibilityHistoryVar?.riderContractTypeCode4}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode5" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode5"
													value="${eligibilityHistoryVar?.riderContractTypeCode5}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode6" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode6" 
													value="${eligibilityHistoryVar?.riderContractTypeCode6}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode7" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode7" 
													value="${eligibilityHistoryVar?.riderContractTypeCode7}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<g:secureTextField maxlength="2" size="2" style="width:15px"
													name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode8" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode8" 
													value="${eligibilityHistoryVar?.riderContractTypeCode8}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
											</div>
										</td>
									</tr>

								<tr><td colspan="4"><hr></td></tr>

									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'siteCode', 'error')} ">
												<label for="siteCode"> <g:message
														code="eligHistory.siteCode.label" default="Site Code :" />

												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="12" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.siteCode" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="siteCode" 
													value="${eligibilityHistoryVar?.siteCode}"></g:secureTextField>
												<img width="25" height="25" style="float: none; vertical-align: bottom" class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.siteCode', 'com.perotsystems.diamond.dao.cdo.SiteCodeMaster','siteCode')">

											</div>
										</td>
										<td colspan="2"></td>
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
												<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.panelId" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="panelId" 
													value="${eligibilityHistoryVar?.panelId}"></g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.panelId', 'com.perotsystems.diamond.dao.cdo.GroupPanel','panelId', 'eligHistory.${memberMaster.memberDBID }.seqGroupId', 'seqGroupId',  null, null)">	
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
												<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
													name="eligHistory.${memberMaster.memberDBID }.ipaId" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="ipaId" 
													value="${eligibilityHistoryVar?.ipaId}"></g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.ipaId', 'com.perotsystems.diamond.dao.cdo.IpaMaster','ipaId', 'ipaLevelCode', 'levelCode',  null, null)">
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
												<%-- <input type="hidden" name="providerContractType" id="providerContractType" value="P"/>
												<g:textField name="eligHistory.${memberMaster.memberDBID }.seqProvId" value="${eligibilityHistoryVar?.seqProvId }" disabled="${!elementsEnabled?"true":"false"}" />
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.seqProvId', 'com.perotsystems.diamond.dao.cdo.ProvContract','seqProvId', 'eligHistory.${memberMaster.memberDBID }.lineOfBusiness|providerContractType', 'lineOfBusiness|contractType',  null, null)">	--%>
												<g:hiddenField name="eligHistory.${memberMaster.memberDBID }.seqProvId" value="${eligibilityHistoryVar?.seqProvId }" disabled="${!elementsEnabled?"true":"false"}"/>
												<%boolean exists = false %>
												<g:if test="${eligibilityHistoryVar?.seqProvId}">
													<g:each in="${provIdList}" var="provId">
														<g:if test="${provId.seqProvId.equals(eligibilityHistoryVar?.seqProvId)}">
															<g:secureTextField  readonly="readonly"
																name="providerId" value="${provId.providerId}"
																tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" 
																style="color:#848484;" onclick="PCPIdfieldClickMessage()">
															</g:secureTextField>
															<%exists = true%>
														</g:if>
													</g:each>
												</g:if>
												<g:if test="${exists == false}">
													<g:secureTextField  readonly="readonly"
														name="providerId"  value=""
														tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" 
														style="color:#848484;" onclick="PCPIdfieldClickMessage()">
													</g:secureTextField>
												</g:if>		
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('providerId', 'com.perotsystems.diamond.dao.cdo.ProvMaster','providerId',null, null, 'eligHistory.${memberMaster.memberDBID }.seqProvId', 'seqProvId' );">										
											</div>
										</td>
										<td colspan="2"></td>
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
												<g:secureTextField maxlength="5"
													name="eligHistory.${memberMaster.memberDBID }.pcpChangeReason" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="pcpChangeReason" 
													value="${eligibilityHistoryVar?.pcpChangeReason}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.pcpChangeReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'PCPReasonType', 'reasonCodeType',  null, null)">																	 
											</div>
										</td>
										<td colspan="2"></td>

									</tr>
								<tr><td colspan="4"><hr></td></tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap" width="26%">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'medicareStatusFlg', 'error')} ">
												<label for="medicareStatusFlg"> <g:message
														code="eligHistory.medicareStatusFlg.label"
														default="Medicare Status Flag :" />
												</label>
											</div>
										</td>
										<td width="30%">
											<div class="fieldcontain">
												<g:secureTextField maxlength="12"
													name="eligHistory.${memberMaster.memberDBID }.medicareStatusFlg" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="medicareStatusFlg" 
													value="${eligibilityHistoryVar?.medicareStatusFlg}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
											</div>
										</td>
										<td width="42%" colspan="2"></td>
									</tr>
								<tr><td colspan="4"><hr></td></tr>
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
												<g:secureTextField maxlength="20"
													name="eligHistory.${memberMaster.memberDBID }.subscDept" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="subscDept" 
													value="${eligibilityHistoryVar?.subscDept}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.subscDept', 'com.perotsystems.diamond.dao.cdo.GroupDepartment','deptNumber', 'eligHistory.${memberMaster.memberDBID }.seqGroupId', 'seqGroupId', null, null)">
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
												<g:secureSystemCodeToken
													systemCodeType="MELIGLOC" languageId="0"
													tableName="MEMBER_ELIG_HISTORY" attributeName="subscLocation" 
													htmlElelmentId="eligHistory.${memberMaster.memberDBID }.subscLocation"
													blankValue="Location" 
													defaultValue="${eligibilityHistoryVar?.subscLocation}" 
													width="150px" disable="${!elementsEnabled?"disabled":""}">
												</g:secureSystemCodeToken>	
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'hireDate', 'error')} ">
												<label for="hireDate"> <g:message
														code="eligHistory.hireDate.label" default="Hire Date :" />

												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">	
												<g:secureGrailsDatePicker 
													name="eligHistory.${ memberMaster?.memberDBID }.hireDate" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="hireDate" precision="day" noSelection="['':'']"
													value="${eligibilityHistoryVar?.hireDate}" default="none" disabled="${!elementsEnabled?"true":"false"}">
												</g:secureGrailsDatePicker>											 
											</div>
										</td>
										<td colspan="2"></td>
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
												<g:secureSystemCodeToken
													systemCodeType="MEMCSIND" languageId="0"
													tableName="MEMBER_ELIG_HISTORY" attributeName="csIndicator" 
													htmlElelmentId="eligHistory.${memberMaster.memberDBID }.csIndicator"
													blankValue="CS Indicator" 
													defaultValue="${eligibilityHistoryVar?.csIndicator}" 
													width="150px" disable="${!elementsEnabled?"disabled":""}">
												</g:secureSystemCodeToken>
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
												<g:secureTextField maxlength="18"
													name="eligHistory.${memberMaster.memberDBID }.prospectivePremiumAmt" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="prospectivePremiumAmt" 
													value="${eligibilityHistoryVar?.prospectivePremiumAmt}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined1', 'error')} ">
												<label for="userDefined1">
													<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"/>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="30"
													name="ligHistory.${memberMaster.memberDBID }.userDefined1" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined1" 
													value="${eligibilityHistoryVar?.userDefined1}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
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
												<input type="hidden" id="classificationTypeM1" name="classificationTypeM1" value="M1" />
												<g:secureTextField maxlength="5"
													name="ligHistory.${memberMaster.memberDBID }.memberClass1" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass1" 
													value="${eligibilityHistoryVar?.memberClass1}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.memberClass1', 'com.perotsystems.diamond.dao.cdo.ClassificationCodeMaster','classificationCode', 'classificationTypeM1','classificationType', null, null)">
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
												 <input type="hidden" id="classificationTypeM2" name="classificationTypeM2" value="M2" />
												 <g:secureTextField maxlength="5"
													name="ligHistory.${memberMaster.memberDBID }.memberClass2" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass2" 
													value="${eligibilityHistoryVar?.memberClass2}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
												<img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('eligHistory.${memberMaster.memberDBID }.memberClass2', 'com.perotsystems.diamond.dao.cdo.ClassificationCodeMaster','classificationCode','classificationTypeM2','classificationType', null, null)">
											</div>
										</td>
										<td colspan="2"></td>
									</tr>
									<tr>

										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined2', 'error')} ">
												<label for="userDefined2"> 
													<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"/>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="30"
													name="ligHistory.${memberMaster.memberDBID }.userDefined2" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined2" 
													value="${eligibilityHistoryVar?.userDefined2}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
											</div>
										</td>
										<td class="tdFormElement" style="white-space: nowrap">
											<div
												class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined3', 'error')} ">
												<label for="userDefined3"> 
													<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"/>
												</label>
											</div>
										</td>
										<td>
											<div class="fieldcontain">
												<g:secureTextField maxlength="30"
													name="ligHistory.${memberMaster.memberDBID }.userDefined3" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined3" 
													value="${eligibilityHistoryVar?.userDefined3}"
													disabled="${!elementsEnabled?"true":"false"}">
												</g:secureTextField>
											</div>
										</td>
									</tr>
					</table>
				</td>
			</tr>
            <tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<g:if test="${memberMaster.insertDate}">
			<tr>
				<td colspan="3">
					<h4>
						Employer Information
						<h4>
							<hr>
							<%GroupMaster groupMasterVar = memberMasterGroupMasterMap.get(memberMaster.memberDBID)%>
							<%AgentMaster agentMasterVar = memberMasterAgentDetails.get(memberMaster.memberDBID)%>
							<%GroupContactPerson groupContactPersonVar = memberMasterContactMap.get(memberMaster.memberDBID)%>
				</td>
			</tr>
			
			<tr>
				<td>
					<table  border="0">
						<tr>
							<td class="tdFormElement" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean: groupMasterVar, field: 'groupName1', 'error')} ">
									<label for="groupName1"> <g:message
											code="groupMaster.groupName1.label"
											default="Employer Name :" />

									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="groupMaster.${memberMaster.memberDBID }.groupName1"
										value="${groupMasterVar?.groupName1}" disabled="disabled"
										/>
								</div>
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean:groupContactPersonVar, field: 'contactName', 'error')} ">
									<label for="contactName"> 
										<g:message code="groupContact.contactName.label" default="Employer Contact :"/>
									</label>
								</div>
							</td>
							
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="groupContact.${memberMaster.memberDBID }.contactName"
										value="${groupContactPersonVar?.contactName}" disabled="disabled"
										/>
								</div>
							</td>
							<%-- <td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean:groupMasterVar, field: 'nationalEmployerId', 'error')} ">
									<label for="nationalEmployerId"> 
										<g:message code="groupMaster.nationalEmployerId.label" default="Customer ID :" />
									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="groupMaster.${memberMaster.memberDBID }.nationalEmployerId"
										value="${groupMasterVar?.nationalEmployerId}" disabled="disabled"
										/>
								</div>
							</td> --%>
							<td class="tdFormElement" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'hireDate', 'error')} ">
									<label for="hireDate"> 
										<g:message code="eligHistory.hireDate.label" default="Date Created :" />
									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<%-- <g:datePicker name="" precision="day" noSelection="['':'']" disabled="disabled" value="${memberMaster.insertDate}" default="none" /> --%>
									 <fmsui:jqDatePicker dateElementId="memberMaster.${ memberMaster?.memberDBID }.insertDate"
										dateElementName="memberMaster.${ memberMaster?.memberDBID }.insertDate" disabled="true"
										datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().getAt(Calendar.YEAR) - 100) - (memberMaster?.insertDate != null ? memberMaster?.insertDate.getAt(Calendar.YEAR):Calendar.getInstance().getAt(Calendar.YEAR))}:100', maxDate:0"
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.insertDate)}"/> 
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean:agentMasterVar, field: 'firstName', 'error')} ">
									<label for="address1"> 
										<g:message code="agentMaster.firstName.label" default="Broker First Name :"/>				
									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="agentMaster.${memberMaster.memberDBID }.firstName"
										value="${agentMasterVar?.firstName}" disabled="disabled"/>
								</div>

							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean:agentMasterVar, field: 'lastName', 'error')} ">
									<label for="address1"> 
										<g:message code="agentMaster.lastName.label" default="Broker Last Name :"/>				
									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="agentMaster.${memberMaster.memberDBID }.lastName"
										value="${agentMasterVar?.lastName}" disabled="disabled"/>
								</div>

							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean:agentMasterVar, field: 'licenseNo', 'error')} ">
									<label for="licenseNo"> 
										<g:message code="agentMaster.licenseNo.label" default="Broker License Number :" />
									</label>
								</div>
							</td>
							<td>
								<div class="fieldcontain">
									<g:textField maxlength="18"
										name="agentMaster.${memberMaster.memberDBID }.licenseNo"
										value="${agentMasterVar?.licenseNo}" disabled="disabled"/>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			</g:if>
		</table>
		<div id="addGroupPlaceHolder">&nbsp;</div>
	</div>
</g:each>
<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>