<%@ page import="com.perotsystems.diamond.dao.cdo.Beneficiary" %>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.States" %>

<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<style type="text/css">
.deleteButton {
	-moz-box-shadow:inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow:inset -1px 1px 7px 0px #ffffff;
	box-shadow:inset -1px 1px 7px 0px #ffffff;
	background-color:#ededed;
	-moz-border-radius:15px;
	-webkit-border-radius:15px;
	border-radius:10px;
	border:1px solid #999999;
	display:inline-block;
	color:#404040;
	font-family:arial;
	font-size:16px;
	font-weight:normal;
	padding:5px 24px;
	text-decoration:none;
	text-shadow:1px 0px 13px #ffffff;
}.deleteButton:hover {
	background-color:#dfdfdf;
}.deleteButton:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>

<script type="text/javascript">

	function clearSearchCriteria() {
			var elements = document.getElementsByTagName("input");
			var firstText = true;
			for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    elements[ii].value = "";
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
				 }
			  }
			  if (elements[ii].type == "radio") {
				    elements[ii].checked = false;
			  }
			}
			var elements = document.getElementsByTagName("select");
			for (var ii=0; ii < elements.length; ii++) {
			    elements[ii].selectedIndex = 0;
			}
		}
	
	$(window).load(function() {
		
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

		$(".bSSN").mask("?999-99-9999");
		$(".bZipCode").mask("99999?-9999");	
		$(".bTaxID").mask("?99-9999999");
		
	});

	var addRowClicked = false
	var previousDivObj

	function showBeneficiary(selectedObj) 
	{		
			var hiddenObj = document.getElementById("editMemberDBID")		
			if (!addRowClicked) {
				var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
				var beneficiaryDivObj = document.getElementById(selectedValue)
				var addBeneficiaryDivObj = document.getElementById("addBeneficiaryDiv")
				hiddenObj.value=selectedValue			
				if (beneficiaryDivObj  != null) {
					if (previousDivObj != null) {
						previousDivObj.style.display="none"
					}
					beneficiaryDivObj.style.display = "block"
					addBeneficiaryDivObj.style.display = "block"
					previousDivObj = beneficiaryDivObj
				} 
			} 
	}
	

	function addBeneficiary() 
	{
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		
		if (selectObj.selectedIndex == 01)
		{
			var memberDBID = selectObj.options[selectObj.selectedIndex].value
			var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
			var appName = "${appContext.metadata['app.name']}";
	
			window.location.assign("/"+appName+"/memberMaintenance/addMemberBeneficiary?subscriberId="
					+ subscriberId + "&editType=BENEFICIARY&memberDBID="+memberDBID+"&personNumber="+personNumber);
		}
		else
		{
			alert("You may add beneficiaries for subscribers only.");
		}
	}

	function showSSNMessage() {
		alert ("Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.");
	}

	function deleteButton(seqId)
	{
	    document.getElementById('benefSeqId').value = seqId
	    document.getElementById('benefSubsId').value = "${subscriberMember.subscriberID}";

	    var memberBenefAllocList = '${memberBenefAllocList}';
	    var memberBenefAllocListArray =[];
		
		//split and trim the array items
	    $.each(memberBenefAllocList.split(","), function(){
	    	memberBenefAllocListArray.push($.trim(this));
	    });

	    if(memberBenefAllocListArray.indexOf(seqId.toString()) > -1)
		{
	    	alert("To delete this beneficiary, You must first go to the Beneficiary Allocation screen and remove the beneficiary.");
	    	return false;
	    }
	    else
		{
	    	if (confirm("Are you sure you want to delete this Beneficiary?") == true) 
			 {
		    	return true;
		     } 
		    else 
			{
		    	return false;
		    }
		}
	}

	
</script>
	
Member Beneficiary Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="BENEFICIARY" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<table>
	<tr>
		<td><select id="memberIdSelectList" name="memberIdlist" 
			size="${ memberMasterMap.keySet().size() +2}" style="width: 100%;background-color: #C7DDEE;">
				<option value="dummy">-- Select a Member --</option>
				<g:each in="${memberMasterMap.keySet() }" status="idCount" var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
					<option value="${memberDBID}"
						<g:if test="${"01".equals(member.personNumber)}">
							selected="${true}"
						</g:if>
						<g:else>
							readonly="${true}" 
						</g:else> >
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
		<g:each in="${memberMasterMap.keySet() }" status="idCount" var="memberDBID">
			<% SimpleMember member = memberMasterMap.get(memberDBID) %>
			<input type="hidden" id="${subscriberMember.subscriberID}:${memberDBID }" 
			name="${subscriberMember.subscriberID}:${memberDBID }" value="${member.personNumber}"/>
		</g:each>
		
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div id="addBeneficiaryDiv" style="display:block">
			<g:checkURIAuthorization uri="/memberMaintenance/addMemberBeneficiary">
				<input type="button" name="addBeneficiaryButton" class="load" value="Add Beneficiary"  onClick="addBeneficiary()">
			</g:checkURIAuthorization>
			</div>
		</td>
	</tr>
</table>
<br />
<div id="dummy" style="display:none">&nbsp;</div>

<g:hiddenField name="benefSeqId" id="benefSeqId" value="" />
<g:hiddenField name="benefSubsId" id="benefSubsId" value ="" />

<g:each in="${memberBeneficiaryMap.keySet()}" status="idCount" var="memberDBID">
	<div id="${memberDBID}" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>Select</th>
				<th>Name</th>
				<th>Beneficiary Category</th>
				<th>Date of Birth</th>
			</tr>
			<g:each in="${memberBeneficiaryMap.get(memberDBID)}" status="i" var="beneficiary">
				<input type="hidden" name="seq_Bfciary_id_${i}" value="${beneficiary.seqBfciaryId}">
				<input type="hidden" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.iterationCount" value="${beneficiary.seqBfciaryId}">
				
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td class="clickme">
						<input type="radio" name="beneficiaryId" value="${beneficiary.seqBfciaryId}">
					</td>
					<td class="clickme">
						${beneficiary.bfciaryName}
					</td>
					<td class="clickme">
						<g:if test="${"P".equals(beneficiary?.bfciaryCategory)}">Person</g:if>
						<g:if test="${"T".equals(beneficiary?.bfciaryCategory)}">Trust</g:if>
						<g:if test="${"E".equals(beneficiary?.bfciaryCategory)}">Estate</g:if>
						<g:if test="${"O".equals(beneficiary?.bfciaryCategory)}">Organization</g:if>
					</td>
					<td class="clickme">
						<g:formatDate format="MM/dd/yyyy" date="${beneficiary.dateOfBirth}" />
					</td>
				</tr>
				<tr class="hideme" id="rowToClone2">
					<td colspan="13">
						<div class="divContent">
							<table class="report1" border="0" style="table-layout:fixed;">
								<g:if test="${"P".equals(beneficiary?.bfciaryCategory)}">
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
												<label for="bfciaryCategory"> 
													<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category :" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">											
												<g:secureSystemCodeToken
															systemCodeType="BFCIARY_CAT" languageId="0"
															tableName="BENEFICIARY" attributeName="bfciaryCategory" 
															htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
															blankValue="Beneficiary Type" 
															defaultValue="${beneficiary?.bfciaryCategory}" 
															title="The Beneficiary Category" 
															disable="true"
															width="250px">
														</g:secureSystemCodeToken>
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
												<label for="bfciaryName">
													<g:message code="beneficiary.bfciaryName.label" default="Name:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											
                                        <g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName" maxlength="180"
												tableName="BENEFICIARY" attributeName="lastName"
												readonly="readonly" style="width:50%" onkeydown="event.preventDefault()"
												value="${beneficiary.bfciaryName }" tabindex="-1"
												title="Beneficiary Name as entered in Firstname, Middle Initial, Lastname, Suffix" >
												</g:secureTextField>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'relationshipCode', 'error')} ">
												<label for="relationshipCode"> 
													<g:message code="beneficiary.relationshipCode.label" default="Relationship Code:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<div class="fieldcontain">									
													
												    <g:secureSystemCodeToken
															systemCodeType="BFCIARY_REL" languageId="0"
															tableName="BENEFICIARY" attributeName="relationshipCode" 
															htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.relationshipCode"
															blankValue="Relationship Code" 
															defaultValue="${beneficiary?.relationshipCode}" 
															width="150px">
														</g:secureSystemCodeToken>
																									 	
													
											</div>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
												<label for="firstName"> 
													<g:message code="beneficiary.firstName.label" default="First Name:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">											
                                        <g:secureTextField  
   							                    name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
   							                    tableName="BENEFICIARY" attributeName="firstName"
												maxlength="60" style="width:50%"
												value="${beneficiary.firstName}"
												title="The First Name of the Person" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.middleInitial', 'error')} ">
												<label for="middleInitial"> <g:message
														code="beneficiary.middleInitial.label"
														default="Middle Initial:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureTextField 
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.middleInitial"
												tableName="BENEFICIARY" attributeName="middleInitial"
												maxlength="35" style="width:50%"
												value="${beneficiary.middleInitial }"
												title="The Middle Initial of the Person" >
												</g:secureTextField>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
												<label for="lastName"> 
													<g:message code="beneficiary.lastName.label" default="Last Name:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
												<g:secureTextField 
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"												
												tableName="BENEFICIARY" attributeName="lastName"
												maxlength="60" style="width:50%"
												value="${beneficiary.lastName }"
												title="The Last Name of the Person" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.suffix', 'error')} ">
												<label for="suffix">
													<g:message code="beneficiary.suffix.label" default="Suffix:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureCdoSelectBox 
											cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
											tableName="BENEFICIARY" attributeName="suffix"
											cdoAttributeWhereValue="F"
											cdoAttributeWhere="titleType"
											cdoAttributeSelect="contactTitle"
											cdoAttributeSelectDesc="description"
											languageId="0"
											htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.suffix"
											defaultValue="${beneficiary?.suffix}"
											value="${beneficiary?.suffix}"
											blankValue="Suffix" 
											width="150px">
										</g:secureCdoSelectBox>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.socialSecNo', 'error')} ">
												<label for="socialSecNo"> 
													<g:message code="beneficiary.socialSecNo.label" default="SSN:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
													<g:secureTextField
														name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.socialSecNo"
														tableName="BENEFICIARY" attributeName="socialSecNo"
														class="bSSN" style="width:50%" maxlength="11"
														value="${beneficiary?.socialSecNo}"
														title="The Social Security Number (SSN) of the Person" >
														</g:secureTextField>
													<img width="15" height="15" src="${resource(dir: 'images', file: 'help.gif')}" 
													title="Click to see why we ask for SSN" style="float:none;vertical-align:middle"
													onclick="showSSNMessage();">
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.dateOfBirth', 'error')} ">
												<label for="dateOfBirth"> 
													<g:message code="beneficiary.dateOfBirth.label" default="Date of Birth:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureGrailsDatePicker
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.dateOfBirth"
												tableName="BENEFICIARY" attributeName="dateOfBirth" precision="day" noSelection="['':'']"
												value="${beneficiary?.dateOfBirth}" default="none">
												</g:secureGrailsDatePicker>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.gender', 'error')} ">
												<label for="beneficiaryGender"> 
													<g:message code="beneficiary.gender.label" default="Gender:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureDiamondDataWindowDetail
												columnName="gender" dwName="dw_edied_de" languageId="0"
												htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.gender"
												defaultValue="${beneficiary?.gender}" blankValue="Gender" width="150px"
												title="The Gender of the Person"
												tableName="BENEFICIARY" attributeName="gender" value="${beneficiary?.gender}">
												</g:secureDiamondDataWindowDetail>
																								
										</td>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="6">Person Address
											<hr />
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
												<label for="addressLine1"> 
													<g:message code="beneficiary.addressLine1.label" default="Address 1:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											 <g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
												tableName="BENEFICIARY" attributeName="addressLine1"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine1 }"
												title="The Address of the Person" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
												<label for="addressLine2"> 
													<g:message code="beneficiary.addressLine2.label" default="Address 2:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											 <g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
												tableName="BENEFICIARY" attributeName="addressLine2"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine2 }"
												title="The Address of the Person (the Suite, the Building, the Floor etc.)" >
												</g:secureTextField>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
												<label for="city"> 
													<g:message code="beneficiary.city.label" default="City:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureTextField 
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
												tableName="BENEFICIARY" attributeName="city"
												maxlength="30" style="width:50%"
												value="${beneficiary.city}" title="The City of the Person" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
												<label for="benState"> 
													<g:message code="beneficiary.benState.label" default="State:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureComboBox
											name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
											tableName="BENEFICIARY" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${beneficiary?.state}">
										</g:secureComboBox>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
												<label for="zipCode"> 
													<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
											    tableName="BENEFICIARY" attributeName="zipCode" class="bZipCode"
												class="bZipCode" maxlength="10" style="width:50%"
												value="${beneficiary?.zipCode}"
												title="The Zip Code of the Person" >
												</g:secureTextField>	
												
										</td>
										<td class="tdnoWrap">
											<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
												<label for="country"> 
													<g:message code="beneficiary.country.label" default="Country:" /> 
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">												
										<g:secureTextField maxlength="30"
											name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
											style="width:50%" readonly="readonly" 
											tableName="BENEFICIARY" attributeName="country" 
											title="The Country of the Person" maxlength="30" value="USA" 
											value="${beneficiary?.country}"></g:secureTextField>
												
										</td>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan ="2">
											<g:actionSubmit class="deleteButton"
											action="delete" value="Delete"
											onclick="return deleteButton(${beneficiary?.seqBfciaryId});" />			
										</td>
									</tr>
								</g:if>
								<g:if test="${"T".equals(beneficiary?.bfciaryCategory)}">
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
												<label for="bfciaryCategory"> <g:message
														code="beneficiary.bfciaryCategory.label"
														default="Beneficiary Category:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										
										<g:secureSystemCodeToken
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
												blankValue="Beneficiary Category"
												tableName="BENEFICIARY" attributeName="bfciaryCategory"
												defaultValue="${beneficiary?.bfciaryCategory}" width="250px"
												value="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" 
												disable="true" >
												</g:secureSystemCodeToken>
												
										</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
												<label for="bfciaryName"> <g:message
														code="beneficiary.bfciaryName.label" default="Trust Name:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
												style="width:50%" value="${beneficiary.bfciaryName }" maxlength="180"
												tableName="BENEFICIARY" attributeName="bfciaryName"
												value="${beneficiary?.bfciaryName}"
												title="The Name of the Trust" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
												<label for="firstName"> <g:message
														code="beneficiary.firstName.label"
														default="Trustee First Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
												tableName="BENEFICIARY" attributeName="firstName"
												maxlength="60" style="width:50%"
												value="${beneficiary.firstName}"
												title="The First Name of the Trustee" >
												</g:secureTextField>
												
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
												<label for="lastName"> <g:message
														code="beneficiary.lastName.label"
														default="Trustee Last Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
												tableName="BENEFICIARY" attributeName="lastName"
												maxlength="60" style="width:50%"
												value="${beneficiary.lastName }"
												title="The Last Name of the Trustee" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.trustDate', 'error')} ">
												<label for="trustDate"> <g:message
														code="beneficiary.trustDate.label" default="Trust Date:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
                                         <g:secureGrailsDatePicker
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.trustDate"
												mandatory="mandatory"
												tableName="BENEFICIARY" attributeName="trustDate" precision="day" noSelection="['':'']"
                                                value="${beneficiary?.trustDate}" default="none" >
												</g:secureGrailsDatePicker>
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.taxId', 'error')} ">
												<label for="taxId"> <g:message
														code="beneficiary.taxId.label" default="Tax ID:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										
										<g:secureTextField name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId" tableName="BENEFICIARY" attributeName="taxId"	maxlength="10" style="width:50%" class="bTaxID" value="${beneficiary.taxId}" title="The Tax ID of the Trustee" > </g:secureTextField>
												</td>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="6">Trustee Address
											<hr />
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
												<label for="addressLine1"> <g:message
														code="beneficiary.addressLine1.label" default="Address 1:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
												tableName="BENEFICIARY" attributeName="addressLine1"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine1 }"
												title="The Address of the Trustee" >
												</g:secureTextField>
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
												<label for="addressLine2"> <g:message
														code="beneficiary.addressLine2.label" default="Address 2:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
												tableName="BENEFICIARY" attributeName="addressLine2"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine2 }"
												title="The Address of the Trustee" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
												<label for="city"> <g:message
														code="beneficiary.city.label" default="City:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
												tableName="BENEFICIARY" attributeName="city"
												maxlength="30" style="width:50%"
												value="${beneficiary.city }" title="The City of the Trustee" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
												<label for="benState"> <g:message
														code="beneficiary.benState.label" default="State:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">										
											<g:secureComboBox
											name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
											tableName="BENEFICIARY" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${beneficiary?.state}">
										</g:secureComboBox>
											
											</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
												<label for="zipCode"> <g:message
														code="beneficiary.zipCode.label" default="Zip Code:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
											    tableName="BENEFICIARY" attributeName="zipCode" class="maskZip"
												class="bZipCode" maxlength="10" style="width:50%"
												value="${beneficiary?.zipCode}"
												title="The Zip Code of the Trustee" >
												</g:secureTextField>
												
													
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
												<label for="country"> <g:message
														code="beneficiary.country.label" default="Country:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField  name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
												style="width:50%" readonly="readonly" 
												tableName="BENEFICIARY" attributeName="country"
												value="${beneficiary?.country}"
												title="The Country of the Trustee" maxlength="30" value="USA" >
												</g:secureTextField>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan ="2">
											<g:actionSubmit class="deleteButton"
											action="delete" value="Delete"
											onclick="return deleteButton(${beneficiary?.seqBfciaryId});" />			
										</td>
									</tr>
								</g:if>
								<g:if test="${"E".equals(beneficiary?.bfciaryCategory)}">
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
												<label for="bfciaryCategory"> <g:message
														code="beneficiary.bfciaryCategory.label"
														default="Beneficiary Category:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
									    <g:secureSystemCodeToken
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
												blankValue="Beneficiary Category"
												tableName="BENEFICIARY" attributeName="bfciaryCategory"
												defaultValue="${beneficiary?.bfciaryCategory}" width="250px"
												value="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" 
												disable="true" >
												</g:secureSystemCodeToken>
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
												<label for="bfciaryName"> <g:message
														code="beneficiary.bfciaryName.label"
														default="Estate Name:" /> <span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
												style="width:50%" value="${beneficiary.bfciaryName }" maxlength="180"
												tableName="BENEFICIARY" attributeName="bfciaryName"
												value="${beneficiary?.bfciaryName}"
												title="The Name of the Estate" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
												<label for="firstName"> <g:message
														code="beneficiary.firstName.label"
														default="Executor First Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">												
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
												tableName="BENEFICIARY" attributeName="firstName"
												maxlength="60" style="width:50%"
												value="${beneficiary.firstName}"
												title="The First Name of the Executor" >
												</g:secureTextField>
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
												<label for="lastName"> <g:message
														code="beneficiary.lastName.label"
														default="Executor Last Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
												tableName="BENEFICIARY" attributeName="lastName"
												maxlength="60" style="width:50%"
												value="${beneficiary.lastName }"
												title="The Last Name of the Executor" >
												</g:secureTextField>
										
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="6">Executor Address
											<hr />
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
												<label for="addressLine1"> <g:message
														code="beneficiary.addressLine1.label" default="Address 1:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
												tableName="BENEFICIARY" attributeName="addressLine1"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine1 }"
												title="The Address of the Executor" >
												</g:secureTextField>			
												
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
												<label for="addressLine2"> <g:message
														code="beneficiary.addressLine2.label" default="Address 2:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">										
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
												tableName="BENEFICIARY" attributeName="addressLine2"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine2 }"
												title="The Address of the Executor" >
												</g:secureTextField>		
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
												<label for="city"> <g:message
														code="beneficiary.city.label" default="City:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
												tableName="BENEFICIARY" attributeName="city"
												maxlength="30" style="width:50%"
												value="${beneficiary.city }" title="The City of the Executor" >
												</g:secureTextField>												
									   </td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
												<label for="benState"> <g:message
														code="beneficiary.benState.label" default="State:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">	
										<g:secureComboBox
											name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
											tableName="BENEFICIARY" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${beneficiary?.state}">
										</g:secureComboBox>
											
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
												<label for="zipCode"> <g:message
														code="beneficiary.zipCode.label" default="Zip Code:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">										
									    <g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
											    tableName="BENEFICIARY" attributeName="zipCode" class="bZipCode"
												class="bZipCode" maxlength="10" style="width:50%"
												value="${beneficiary?.zipCode}"
												title="The Zip Code of the Executor" >
												</g:secureTextField>	
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
												<label for="country"> <g:message
														code="beneficiary.country.label" default="Country:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
											<g:secureTextField  name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
												style="width:50%" readonly="readonly" 
												tableName="BENEFICIARY" attributeName="country"
												value="${beneficiary?.country}"
												title="The Country of the Executor" maxlength="30" value="USA" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan ="2">
											<g:actionSubmit class="deleteButton"
											action="delete" value="Delete"
											onclick="return deleteButton(${beneficiary?.seqBfciaryId});" />			
										</td>
									</tr>
								</g:if>
								<g:if test="${"O".equals(beneficiary?.bfciaryCategory)}">
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
												<label for="bfciaryCategory"> <g:message
														code="beneficiary.bfciaryCategory.label"
														default="Beneficiary Category:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureSystemCodeToken
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
												blankValue="Beneficiary Category"
												tableName="BENEFICIARY" attributeName="bfciaryCategory"
												defaultValue="${beneficiary?.bfciaryCategory}" width="250px"
												value="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" 
												disable="true" >
												</g:secureSystemCodeToken>
										</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
												<label for="bfciaryName"> <g:message
														code="beneficiary.bfciaryName.label"
														default="Organization Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
												style="width:50%" value="${beneficiary.bfciaryName }" maxlength="180"
												tableName="BENEFICIARY" attributeName="bfciaryName"
												value="${beneficiary?.bfciaryName}"
												title="The Name of the Organization" >
												</g:secureTextField>
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
												<label for="firstName"> <g:message
														code="beneficiary.firstName.label"
														default="Contact First Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
												tableName="BENEFICIARY" attributeName="firstName"
												maxlength="60" style="width:50%"
												value="${beneficiary.firstName}"
												title="The First Name of the Organization Contact Person" >
												</g:secureTextField>
										</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
												<label for="lastName"> <g:message
														code="beneficiary.lastName.label"
														default="Contact Last Name:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
												tableName="BENEFICIARY" attributeName="lastName"
												maxlength="60" style="width:50%"
												value="${beneficiary.lastName }"
												title="The Last Name of the Organization Contact Person" >
												</g:secureTextField>
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.taxId', 'error')} ">
												<label for="taxId"> <g:message
														code="beneficiary.taxId.label" default="Tax ID:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId"
												tableName="BENEFICIARY" attributeName="taxId"
												maxlength="10" style="width:50%" class="bTaxID"
												value="${beneficiary.taxId}"
												title="The Tax ID of the Organization" >
												</g:secureTextField>
										</td>
									</tr>

									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="6">Organization Address
											<hr />
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
												<label for="addressLine1"> <g:message
														code="beneficiary.addressLine1.label" default="Address 1:" />
													<span class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
									    <g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
												tableName="BENEFICIARY" attributeName="addressLine1"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine1 }"
												title="The Address of the Organization" >
												</g:secureTextField>	
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
												<label for="addressLine2"> <g:message
														code="beneficiary.addressLine2.label" default="Address 2:" />
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">												
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
												tableName="BENEFICIARY" attributeName="addressLine2"
												maxlength="60" style="width:50%"
												value="${beneficiary.addressLine2 }"
												title="Additional Organization Address information" >
												</g:secureTextField>	
												</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
												<label for="city"> <g:message
														code="beneficiary.city.label" default="City:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
												tableName="BENEFICIARY" attributeName="city"
												maxlength="30" style="width:50%"
												value="${beneficiary.city }" title="The City of the Organization" >
												</g:secureTextField>	
													
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
												<label for="benState"> <g:message
														code="beneficiary.benState.label" default="State:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">										
										<g:secureComboBox
											name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
											tableName="BENEFICIARY" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${beneficiary?.state}">
										</g:secureComboBox>		
										</td>
									</tr>
									<tr>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
												<label for="zipCode"> <g:message
														code="beneficiary.zipCode.label" default="Zip Code:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">												
										<g:secureTextField
												name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
											    tableName="BENEFICIARY" attributeName="zipCode" class="bZipCode"
												class="bZipCode" maxlength="10" style="width:50%"
												value="${beneficiary?.zipCode}"
												title="The Zip Code of the Organization" >
												</g:secureTextField>			
												
												</td>
										<td class="tdnoWrap">
											<div
												class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
												<label for="country"> <g:message
														code="beneficiary.country.label" default="Country:" /> <span
													class="required-indicator">*</span>
												</label>
											</div>
										</td>
										<td class="tdFormElement" colspan="2">
										<g:secureTextField  name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
												style="width:50%" readonly="readonly" 
												tableName="BENEFICIARY" attributeName="country"
												value="${beneficiary?.country}"
												title="The Country of the Organization" maxlength="30" value="USA" >
												</g:secureTextField>	
												
												</td>
									</tr>
									<tr>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td colspan ="2">
											<g:actionSubmit class="deleteButton" action="delete" value="Delete"
											onclick="return deleteButton(${beneficiary?.seqBfciaryId});" />			
										</td>
									</tr>
								</g:if>
							</table>
						</div>
					</td>
				</tr>
			</g:each>
		</table>
	</div>
</g:each>

<div id="addBeneficiaryPlaceHolder"></div>

<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showBeneficiary(memberSelectObject)
</script>