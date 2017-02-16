<%@ page import="com.perotsystems.diamond.bom.Address"%>
<%@ page import="com.perotsystems.diamond.bom.MemberAddress"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>

<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			//CQ 56593 fix started
		   
			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});		
		
		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});
		//CQ 56593 fix fixed

	});//]]>

	$(function($){
		   $(".SSNAddress").mask("?999-99-9999");
		   $(".maskZip").mask("99999?-9999");
		   $(".maskPhoneNumber").mask("?999-999-9999")
		  
		})
		

		
</script>
<script>
var addRowClicked = false
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newMemberAddress')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = true;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display="block"
		addRowClicked = true
	}
	var previousDivObj
	function releaseMemberSelection() {
		var result = confirm("Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ", "Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			var selectObj = document.getElementById("memberIdSelectList")
			selectObj.disabled = false;
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display="none"
			var divObjDest = document.getElementById('addGroupPlaceHolder')
			divObjDest.innerHTML = "&nbsp;"
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
			hiddenObj.value=selectedValue			
			if (addressDivObj  != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display="none"
				}
				addressDivObj.style.display = "block"
				addAddressDivObj.style.display = "block"
				previousDivObj = addressDivObj
			} else {
				addAddressDivObj.style.display = "none"
			}
		} else {
			var result = confirm("Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ", "Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj) 
			} else {
				
			}
		}
	}

	function addAddress() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		var memberDBID = selectObj.options[selectObj.selectedIndex].value
		var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
		
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/memberMaintenance/addMemberAddress?subscriberId="
				+ subscriberId + "&editType=DETAIL&memberDBID="+memberDBID+"&personNumber="+personNumber);
	}
	</script>
	
Member Addresses Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="ADDRESS" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<table>
	<tr>
		<td><select id="memberIdSelectList" name="memberIdlist"
			onChange="showAddress(this)"
			size="${ memberMasterMap.keySet().size() +2}" style="width: 100%;background-color: #C7DDEE;">
				<option value="dummy">-- Select a Member --</option>
				<g:each in="${memberMasterMap.keySet() }" status="idCount"
					var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
					<option value="${memberDBID }"
						${"01".equals( member.personNumber )?'selected':'' }>
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
		<g:each in="${memberMasterMap.keySet() }" status="idCount"
			var="memberDBID">
			<% SimpleMember member = memberMasterMap.get(memberDBID) %>
			<input type="hidden" id="${subscriberMember.subscriberID}:${memberDBID }" 
			name="${subscriberMember.subscriberID}:${memberDBID }" value="${ member.personNumber }"/>
		</g:each>
		
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div id="addAddressDiv" style="display: none">
			<g:checkURIAuthorization uri="/memberMaintenance/addMemberAddress">
				<input type="button" name="addAddressButton" class="load" value="Add Address"  onClick="addAddress()">
			</g:checkURIAuthorization>
			</div>
		</td>
		<td>
			<div id="releaseSelect" style="display: none">
				<input type="button" name="enableMemberSelection" value="Enable Member Selection"
					onClick="releaseMemberSelection()">
			</div>
		</td>
	</tr>
</table>
<br />
<div id="dummy" style="display: none">&nbsp;</div>

<g:each in="${memberAddressMap.keySet() }" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>Select</th>

				<th>Effective Date</th>
				<th>Term Date</th>
				<th>Address Type</th>
				<th>Last Name</th>
				<th>Address Line1</th>
				<th>City</th>
				<th>County</th>
				<th>State</th>
				<th>Zip Code</th>
				<th>Country</th>
			</tr>
			<g:each in="${ memberAddressMap.get(memberDBID)}" status="i"
				var="address">
				<input type="hidden" name="seq_address_id_${i}"
					value="${address.seqMembAddress}">
				<input type="hidden"
					name="address.${memberDBID }.${address.seqMembAddress}.iterationCount"
					value="${address.seqMembAddress}">

				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td><input type="radio" name="addressId"
						class="selectradio" value="${address.seqMembAddress}" ></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${address.effectiveDate}" /></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${address.termDate}" /></td>
					<td class="clickme">
						${address.addressType}
					</td>
					<td class="clickme">
						${address.lastName}
					</td>
					<td class="clickme">
						${address.address1}
					</td>
					<td class="clickme">
						${address.city}
					</td>
					<td class="clickme">
						${address.county}
					</td>
					<td class="clickme">
						${address.state}
					</td>
					<td class="clickme">
						<g:if test="${address?.zip?.length() > 5}" >${address?.zip.with {length()? getAt(0..4):''}}-${address?.zip.with {length()? getAt(5..length()-1):''}}</g:if>
						<g:elseif test="${address?.zip?.length() == 5}">${address?.zip.with {length()? getAt(0..4):''}}</g:elseif>
						<g:else></g:else>
					</td>
					<td class="clickme">
						${address.country}
					</td>
				</tr>
				<tr class="hideme" id="rowToClone2">
					<td colspan="11">
						<div class="divContent">
							<table class="report1" border="0">
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.addressType', 'error')} ">
											<label for="addressType"> <g:message
													code="address.addressType.label"
													default="Address Type :" />
										<span
										class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureSystemCodeToken
											tableName="MEMBER_ADDRESS" attributeName="addressType"
											systemCodeType="ADDRESSTYPE" languageId="0"
											htmlElelmentId="address.${memberDBID}.${address.seqMembAddress}.addressType"
											blankValue="Address Type" 
											defaultValue="${address?.addressType}" 
											value="${address?.addressType}"
											width="50px">
											</g:secureSystemCodeToken>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.billingAddress', 'error')} ">
											<label for="billingAddress"> <g:message
													code="subscriberMember.billingAddress.label"
													default="Billing Address :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureComboBox
											name="address.${memberDBID }.${address.seqMembAddress}.billingAddress" 
											tableName="MEMBER_ADDRESS" attributeName="billingAddress" value="${address.billingAddress}"
											from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key">
										</g:secureComboBox>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.contactPref', 'error')} ">
											<label for="contactPref"> <g:message
													code="subscriberMember.contactPref.label"
													default="Contact Pref :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										
										<g:secureDiamondDataWindowDetail columnName="contact_pref" dwName="dw_memba_de" languageId="0"
											htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.contactPref"
											defaultValue="${address?.contactPref}" blankValue="Contact Pref"
											name="address.${memberDBID }.${address.seqMembAddress}.contactPref" 
											tableName="MEMBER_ADDRESS" attributeName="contactPref" value="${address?.contactPref}"									
										/>	
									</td>
									<td class="tdFormElement" colspan="3"></td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.effectiveDate', 'error')} ">
											<label for="effectiveDate"> <g:message
													code="subscriberMember.effectiveDate.label"
													default="Effective Date :" />
										<span
										class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureGrailsDatePicker
											name="address.${memberDBID }.${address.seqMembAddress}.effectiveDate"  
											tableName="MEMBER_ADDRESS" attributeName="effectiveDate" precision="day" noSelection="['':'']"
											value="${address?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
									</td>
									<td class="tdFormElement" colspan="3"></td>
								</tr>
								
								
								
								<tr>

									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.termDate', 'error')} ">
											<label for="termDate"> <g:message
													code="subscriberMember.termDate.label" default="Term Date :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<g:secureGrailsDatePicker
											name="address.${memberDBID }.${address.seqMembAddress}.termDate"  
											tableName="MEMBER_ADDRESS" attributeName="termDate" precision="day" noSelection="['':'']"
											value="${address?.termDate}" default="none"></g:secureGrailsDatePicker>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.termReason', 'error')} ">
											<label for="termReason"> <g:message
													code="subscriberMember.termReason.label"
													default="Term Reason :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="5"
											name="address.${memberDBID }.${address.seqMembAddress}.termReason" 
											tableName="MEMBER_ADDRESS" attributeName="termReason" 
											value="${address?.termReason}"></g:secureTextField>
										<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
											src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('address.${memberDBID }.${address.seqMembAddress}.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode')">
									</td>
								</tr>
								<tr><td class="tdnoWrap" colspan="11"><hr></td></tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.lastName', 'error')} ">
											<label for="lastName"> <g:message
													code="subscriberMember.lastName.label" default="Last Name :" />
											<span class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.lastName" 
											tableName="MEMBER_ADDRESS" attributeName="lastName" class="RemoveSpecialChars"
											value="${address?.lastName}"></g:secureTextField>
									</td>
									<td class="tdFormElement" colspan="3"></td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.firstName', 'error')} ">
											<label for="firstName"> <g:message
													code="subscriberMember.firstName.label"
													default="First Name:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.firstName" 
											tableName="MEMBER_ADDRESS" attributeName="firstName" class="RemoveSpecialChars"
											value="${address?.firstName}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.middleName', 'error')} ">
											<label for="middleName"> <g:message
													code="subscriberMember.middleName.label" default="Middle:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="25"
											name="address.${memberDBID }.${address.seqMembAddress}.middleName" 
											tableName="MEMBER_ADDRESS" attributeName="middleName" class="RemoveSpecialChars"
											value="${address?.middleName}"></g:secureTextField>
										</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.address1', 'error')} ">
											<label for="address1"> <g:message
													code="subscriberMember.address1.label" default="Address 1:" />
										<span
										class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.address1" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine1" 
											value="${address?.address1}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.address2', 'error')} ">
											<label for="address2"> <g:message
													code="subscriberMember.address2.label" default="Address 2:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.address2" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine2" 
											value="${address?.address2}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine3', 'error')} ">
											<label for="addressLine3"> <g:message
													code="subscriberMember.addressLine3.label" default="Address 3:" />
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.addressLine3" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine3" 
											value="${address?.addressLine3}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine4', 'error')} ">
											<label for="addressLine4"> <g:message
													code="subscriberMember.addressLine4.label" default="Address 4:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.addressLine4" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine4" 
											value="${address?.addressLine4}"></g:secureTextField>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine5', 'error')} ">
											<label for="addressLine5"> <g:message
													code="subscriberMember.addressLine5.label" default="Address 5:" />
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.addressLine5" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine5" 
											value="${address?.addressLine5}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine6', 'error')} ">
											<label for="addressLine6"> <g:message
													code="subscriberMember.addressLine6.label" default="Address 6:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="60"
											name="address.${memberDBID }.${address.seqMembAddress}.addressLine6" 
											tableName="MEMBER_ADDRESS" attributeName="addressLine6" 
											value="${address?.addressLine6}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.city', 'error')} ">
											<label for="city"> <g:message
													code="subscriberMember.city.label" default="City :" />
										<span
										class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="30"
											name="address.${memberDBID }.${address.seqMembAddress}.city" 
											tableName="MEMBER_ADDRESS" attributeName="city" 
											value="${address?.city}" class="RemoveSpecialChars"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.state', 'error')} ">
											<label for="groupState"> <g:message
													code="subscriberMember.groupState.label" default="State :" />
										<span
										class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureComboBox
											name="address.${memberDBID }.${address.seqMembAddress}.state" optionKey="stateCode"
											tableName="MEMBER_ADDRESS" attributeName="state" 
											optionValue="stateName" id="state.name" from="${states}"
											noSelection="['':'-- Select a State --']"
											value="${address?.state}">
										</g:secureComboBox>
									</td>
								</tr>
								<tr>

									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.county', 'error')} ">
											<label for="county"> <g:message
													code="subscriberMember.county.label" default="County :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="30"
											name="address.${memberDBID }.${address.seqMembAddress}.county" 
											tableName="MEMBER_ADDRESS" attributeName="county" 
											value="${address?.county}"></g:secureTextField>
										</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.country', 'error')} ">
											<label for="country"> <g:message
													code="subscriberMember.country.label" default="Country :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="30"
											name="address.${memberDBID }.${address.seqMembAddress}.country" 
											tableName="MEMBER_ADDRESS" attributeName="country" 
											value="${address?.country}"></g:secureTextField>
									</td>
								</tr>

								<tr>
									<td>&nbsp;</td>
									<td colspan="2">&nbsp;</td>
									<td class="tdWrapCondition">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.countrySubdivisionCode', 'error')} ">
											<label for="countrySubdivisionCode"> <g:message
													code="subscriberMember.countrySubdivisionCode.label"
													default="Country Sub Division Code :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="3"
											name="address.${memberDBID }.${address.seqMembAddress}.countrySubdivisionCode" 
											tableName="MEMBER_ADDRESS" attributeName="countrySubdivisionCode" 
											value="${address?.countrySubdivisionCode}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.zip', 'error')} ">
											<label for="zipCode"> <g:message
													code="subscriberMember.zipCode.label" default="Zip Code :" />
													<span
												class="required-indicator">*</span>

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="10"
											name="address.${memberDBID }.${address.seqMembAddress}.zip" 
											tableName="MEMBER_ADDRESS" attributeName="zipCode" class="maskZip"
											value="${address?.zip}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.email', 'error')} ">
											<label for="email"> <g:message
													code="subscriberMember.email.label" default="Email Id :"
													style="width:50%" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="80"
											name="address.${memberDBID }.${address.seqMembAddress}.email" 
											tableName="MEMBER_ADDRESS" attributeName="email" 
											value="${address?.email}"></g:secureTextField>
									</td>
								</tr>
								<tr><td class="tdnoWrap" colspan="11"><hr></td></tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.homePhone', 'error')} ">
											<label for="homePhone"> <g:message
													code="subscriberMember.homePhone.label"
													default="Home Phone :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.homePhone" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="homePhoneNumber" 
											value="${address?.homePhone}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.mobilePhone', 'error')} ">
											<label for="mobilePhone"> <g:message
													code="subscriberMember.mobilePhone.label"
													default="Mobile Phone :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.mobilePhone" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="mobilePhone" 
											value="${address?.mobilePhone}"></g:secureTextField>
									</td>
								</tr>

								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.businessPhone', 'error')} ">
											<label for="businessPhone"> <g:message
													code="subscriberMember.businessPhone.label"
													default="Business Phone :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.businessPhone" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="busPhoneNumber" 
											value="${address?.businessPhone}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.beeperNumber', 'error')} ">
											<label for="beeperNumber"> <g:message
													code="subscriberMember.beeperNumber.label"
													default="Beeper Number :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.beeperNumber" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="beeperNumber" 
											value="${address?.beeperNumber}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.alternatePhone', 'error')} ">
											<label for="alternatePhone"> <g:message
													code="subscriberMember.alternatePhone.label"
													default="Alternate Phone :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.alternatePhone" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="alternatePhone" 
											value="${address?.alternatePhone}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.faxNumber', 'error')} ">
											<label for="faxNumber"> <g:message
													code="subscriberMember.faxNumber.label"
													default="Fax Number :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.faxNumber" class="maskPhoneNumber"  
											tableName="MEMBER_ADDRESS" attributeName="fax" 
											value="${address?.faxNumber}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.telephoneNumber', 'error')} ">
											<label for="telephoneNumber"> <g:message
													code="subscriberMember.telephoneNumber.label"
													default="Telephone :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.telephoneNumber" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="telephoneNumber" 
											value="${address?.telephoneNumber}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.telephoneNumberEx', 'error')} ">
											<label for="telephoneNumberEx"> <g:message
													code="subscriberMember.telephoneNumberEx.label"
													default="Tel Ext :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="40"
											name="address.${memberDBID }.${address.seqMembAddress}.telephoneNumberEx" class="maskPhoneNumber" 
											tableName="MEMBER_ADDRESS" attributeName="telephoneExtension" 
											value="${address?.telephoneNumberEx}"></g:secureTextField>
									</td>
								</tr>
								<tr><td class="tdnoWrap" colspan="11"><hr></td></tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.prefixName', 'error')} ">
											<label for="prefixName"> <g:message
													code="subscriberMember.prefixName.label" default="Prefix :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureCdoSelectBox 
											cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
											tableName="MEMBER_ADDRESS" attributeName="prefixName"
											cdoAttributeWhereValue="S"
											cdoAttributeWhere="titleType"
											cdoAttributeSelect="contactTitle"
											cdoAttributeSelectDesc="description"
											languageId="0"
											htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.prefixName"
											defaultValue="${address?.prefixName}"
											value="${address?.prefixName}"
											blankValue="Prefix" 
											width="150px">
										</g:secureCdoSelectBox>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.suffixName', 'error')} ">
											<label for="suffixName"> <g:message
													code="subscriberMember.suffixName.label" default="Suffix :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureCdoSelectBox 
											cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
											tableName="MEMBER_ADDRESS" attributeName="suffixName"
											cdoAttributeWhereValue="F"
											cdoAttributeWhere="titleType"
											cdoAttributeSelect="contactTitle"
											cdoAttributeSelectDesc="description"
											languageId="0"
											htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.suffixName"
											defaultValue="${address?.suffixName}"
											value="${address?.suffixName}"
											blankValue="Suffix" 
											width="150px">
										</g:secureCdoSelectBox>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.socialSecurityNumber', 'error')} ">
											<label for="socialSecurityNumber"> <g:message
													code="subscriberMember.socialSecurityNumber.label"
													default="SSN :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="11"
											name="address.${memberDBID }.${address.seqMembAddress}.socialSecurityNumber" 
											tableName="MEMBER_ADDRESS" attributeName="socialSecurityNumber" class="SSNAddress"
											value="${address?.socialSecurityNumber}"></g:secureTextField>
									</td>
									<td class="tdFormElement" colspan="3"></td>
								</tr>
								<tr><td class="tdnoWrap" colspan="11"><hr></td></tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.employeridNumber', 'error')} ">
											<label for="employeridNumber"> <g:message
													code="subscriberMember.employeridNumber.label"
													default="Emp ID Number:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="80"
											name="address.${memberDBID }.${address.seqMembAddress}.employeridNumber"
											tableName="MEMBER_ADDRESS" attributeName="employerIdNumber" 
											value="${address?.employeridNumber}"></g:secureTextField>
									</td>
									<td class="tdWrapCondition">
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.nationalIndividNumber', 'error')} ">
											<label for="nationalIndividNumber"> <g:message
													code="subscriberMember.nationalIndividNumber.label"
													default="Nat. Ind. ID Number:" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="80"
											name="address.${memberDBID }.${address.seqMembAddress}.nationalIndividNumber"
											tableName="MEMBER_ADDRESS" attributeName="nationalIndivIdNumber" 
											value="${address?.nationalIndividNumber}"></g:secureTextField>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryRelationShip', 'error')} ">
											<label for="beneficiaryRelationShip"> <g:message
													code="subscriberMember.beneficiaryRelationShip.label"
													default="Ben Rel Code :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="1"
											name="address.${memberDBID }.${address.seqMembAddress}.beneficiaryRelationShip" 
											tableName="MEMBER_ADDRESS" attributeName="beneficiaryRelCode" 
											value="${address?.beneficiaryRelationShip}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryGender', 'error')} ">
											<label for="beneficiaryGender"> <g:message
													code="subscriberMember.beneficiaryGender.label"
													default="Ben Gender :" />

											</label>
											</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureDiamondDataWindowDetail columnName="gender" dwName="dw_edied_de" languageId="0"
											htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.beneficiaryGender"
											defaultValue="${address?.beneficiaryGender}" blankValue="Benificiary Gender"
											name="address.${memberDBID }.${address.seqMembAddress}.beneficiaryGender" 
											tableName="MEMBER_ADDRESS" attributeName="beneficiaryGender" value="${address?.beneficiaryGender}"									
										/>	
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryDOB', 'error')} ">
											<label for="beneficiaryDOB"> <g:message
													code="subscriberMember.beneficiaryDOB.label"
													default="Ben DOB :" />

											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<g:secureGrailsDatePicker
											name="address.${memberDBID }.${address.seqMembAddress}.beneficiaryDOB" 
											tableName="MEMBER_ADDRESS" attributeName="beneficiaryDob" precision="day" noSelection="['':'']"
											value="${address?.beneficiaryDOB}" default="none">
										</g:secureGrailsDatePicker>
									</td>
									<td class="tdFormElement" colspan="3"></td>
								</tr>
								<tr><td class="tdnoWrap" colspan="11"><hr></td></tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined1', 'error')} ">
											<label for="userDefined1"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_1_t" defaultText="User Defined 1:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="30"
											name="address.${memberDBID }.${address.seqMembAddress}.userDefined1" 
											tableName="MEMBER_ADDRESS" attributeName="memAddrUserDefined1" 
											value="${address?.userDefined1}"></g:secureTextField>
									</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate1', 'error')} ">
											<label for="userDate1"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_1_t" defaultText="User Date 1:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<g:secureGrailsDatePicker
											name="address.${memberDBID }.${address.seqMembAddress}.userDate1" 
											tableName="MEMBER_ADDRESS" attributeName="memAddrUserDate1" precision="day" noSelection="['':'']"
											value="${address?.userDate1}" default="none">
										</g:secureGrailsDatePicker>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined2', 'error')} ">
											<label for="userDefined2"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_2_t" defaultText="User Defined 2:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="30"
											name="address.${memberDBID }.${address.seqMembAddress}.userDefined2" 
											tableName="MEMBER_ADDRESS" attributeName="memAddrUserDefined2" 
											value="${address?.userDefined2}"></g:secureTextField>
										</td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate2', 'error')} ">
											<label for="userDate2"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_2_t" defaultText="User Date 2:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<g:secureGrailsDatePicker
											name="address.${memberDBID }.${address.seqMembAddress}.userDate2" 
											tableName="MEMBER_ADDRESS" attributeName="memAddrUserDate2" precision="day" noSelection="['':'']"
											value="${address?.userDate2}" default="none">
										</g:secureGrailsDatePicker>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</g:each>
		</table>
	</div>
</g:each>
<div id="addGroupPlaceHolder"></div>

<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>