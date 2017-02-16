<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<style>
<!--
.currencyinput {
    border: 1px inset #ccc; 
}
.currencyinput input {
    border: 0;
    width:120px;
}
.percentinput {
    border: 1px inset #ccc; 
}
.percentinput input {
    border: 0;
    width:120px;
}
-->
</style>

<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>

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
		//CQ 56593 fix Fixed
	});	//]]>
</script>
<script>
   function enabledisableamount(selectedObject){
		var rateoveridetype=selectedObject+'.rateOverrideType';
		var amountobject=selectedObject+'.rateOverride'
		var rateoveridetypeVal =document.getElementById(rateoveridetype).value;
			
		if(rateoveridetypeVal=='D') 	{
		   document.getElementById(amountobject).value="0.00";		
		   document.getElementById(amountobject).disabled=true;
		   var orgAmtVar = selectedObject + '.rateOverridehidden';
		   var orgAmt = document.getElementById(orgAmtVar).value;
				  
		} else{
		  document.getElementById(amountobject).disabled=false;
		  var orgAmtVar = selectedObject + '.rateOverridehidden';
		  var orgAmt = document.getElementById(orgAmtVar).value;
		  document.getElementById(amountobject).value = orgAmt;	
		}
	}

	var addRowClicked = false
	function cloneRow() {

		var divObjSrc = document.getElementById('newMemberEligibility')
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
			divObjDest.innerHTML = "&nbsp;"
			var divObj = document.getElementById('addAddressDiv')
			divObj.style.display = "block"
			var resetButton = document.getElementById("resetButton")
			resetButton.click()
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
					"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
					"Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj)
			} else {

			}
		}
	}

	function addEligibilityPeriod() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		var memberDBID = selectObj.options[selectObj.selectedIndex].value
		var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
		
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/memberMaintenance/addMemberBilling?subscriberId="
				+ subscriberId + "&editType=BILLING&memberDBID="+memberDBID+"&personNumber="+personNumber);
	}

	$(function(){
		    $(".amtNumeric").numeric({});
		    $(".qhpMask").mask("99999aa999999999");		
		})
	$(document).ready(function(){
	 var x = document.getElementsByClassName("amtNumeric");
     var i;
     for (i = 0; i < x.length; i++) {
    	 if(x[i].value==''){
         x[i].value="0.00";
    	 }
     }
});	
	
</script>

Member Billing Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="BILLING" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<table>
	<tr>
		<td><select id="memberIdSelectList" name="memberIdlist"
			onChange="showAddress(this)"
			size="${ memberMasterMap.keySet().size() +2}" style="width: 100%;;background-color: #C7DDEE;">
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
				<input type="hidden"  id="${subscriberMember.subscriberID}:${memberDBID }" 
				name="${subscriberMember.subscriberID}:${memberDBID }" value="${ member.personNumber }"/>
		</g:each>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<div id="addAddressDiv" style="display: none">
			</div>
		</td>
		<td>
			<div id="releaseSelect" style="display: none">
				<input type="button" value="Enable Member Selection"
					class="load" name="enableMemberSelection" onClick="releaseMemberSelection()">
			</div>
		</td>
	</tr>
</table>
<br />
<div id="dummy">&nbsp;</div>
<g:each in="${memberEligHistoryMap.keySet()}" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>Select</th>
				<th>Effective Date</th>
				<th>End Date</th>
				<th>Elig Status</th>
				<th>Group ID</th>
				<th>Plan Code</th>
				<th>Riders</th>
				<th>PCP ID</th>
			</tr>
			<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
				var="eligibilityHistoryVar">
				<input type="hidden" name="seq_prem_id_${i}"
					value="${eligibilityHistoryVar.seqEligHist }">
				<input type="hidden"
					name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount"
					value="${eligibilityHistoryVar.seqEligHist }">
				<input type="hidden"
					name="billingHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount"
					value="${eligibilityHistoryVar.seqEligHist }">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td><input type="radio"
						name="premiumMasterRadio_${i}" class="selectradio"></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.effectiveDate}" /></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.termDate}" /></td>
					<td class="clickme">
						${eligibilityHistoryVar.eligStatus }
					</td>
					<td class="clickme">
						 ${eligibilityHistoryVar.groupId}  <%-- fix for DIA00047450 --%>
					</td>
					<td class="clickme">
						${eligibilityHistoryVar.planCode}
					</td>
					<td class="clickme">
					<%-- fix for DIA00047450 --%>
						<g:if test="${eligibilityHistoryVar.riderCode1}">, ${eligibilityHistoryVar.riderCode1}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode2}">, ${eligibilityHistoryVar.riderCode2}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode3}">, ${eligibilityHistoryVar.riderCode3}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode4}">, ${eligibilityHistoryVar.riderCode4}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode5}">, ${eligibilityHistoryVar.riderCode5}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode6}">, ${eligibilityHistoryVar.riderCode6}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode7}">, ${eligibilityHistoryVar.riderCode7}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode8}">, ${eligibilityHistoryVar.riderCode8}</g:if>
						
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr class="hideme">
					<td colspan="9">
						<div class="divContent">
							<table>
								<tr>
									<td>
										<table border="0">
											<tr>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="rateOverrideType"> <g:message
																code="eligHistory.rateOverrideType.label"
																default="Override Type:" />
														</label>
													</div>
												</td>
												<td colspan="1">
													<div class="fieldcontain">														
													<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverrideType" onchange="enabledisableamount('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}')"
															tableName="MEMBER_ELIG_HISTORY" attributeName="rateOverrideType" value="${eligibilityHistoryVar.rateOverrideType}"
															from="${['A':'Add to Amount', 'D': 'Rate Determinant Override', 'R': 'Replacement Amount']}" optionValue="value" optionKey="key">
													</g:secureComboBox>
													
													<script type="text/javascript">
													    enabledisableamount('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}');
													</script>
													</div>
												</td>	
																														
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="rateOverride"> <g:message
																code="eligHistory.rateOverride.label"
																default="Amount:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<span class="currencyinput">$
														<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverride" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="rateOverride"
																value="${formatNumber(number: eligibilityHistoryVar?.rateOverride, format: '###,##0.00')}"></g:secureTextField>
																
												    <script type="text/javascript">
														enabledisableamount('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}')
												    </script>
													</span>
													</div>
													<input type="hidden" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverridehidden" value="${formatNumber(number: eligibilityHistoryVar?.rateOverride, format: '###,##0.00')}"/>
												</td>
												
											</tr>
											
											<tr>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="familySizeOverride"> <g:message
																code="eligHistory.familySizeOverride.label"
																default="Subscriber Rating Family Size:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.familySizeOverride" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="familySizeOverride" value="${eligibilityHistoryVar.familySizeOverride}"
															from="${1..100}" noSelection="['':'-Family Size-']">
														</g:secureComboBox>
													</div>
												</td>
												
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="spouseFlagOverride"> <g:message
																code="eligHistory.spouseFlagOverride.label"
																default="Subscriber Rating Spouse Flag:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.spouseFlagOverride" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="spouseFlagOverride" value="${eligibilityHistoryVar.spouseFlagOverride}"
															from="${['':'', 'Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key">
														</g:secureComboBox>
													</div>
												</td>
												
											</tr>
											
											<tr>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="covInsuranceLnCode"> <g:message
																code="billingHistory.covInsuranceLnCode.label"
																default="Insurance Line Code:" />
														</label>
													</div>
												</td>

												<g:each in="${memberBillingMap.get(memberDBID)}" status="j" var="billingHistoryVar">
													<g:if test="${billingHistoryVar.seqEligHist.equals(eligibilityHistoryVar.seqEligHist)}">
														<td>
															<div class="fieldcontain">
																<g:secureTextField maxlength="3"
																	name="billingHistory.${memberDBID }.${billingHistoryVar?.seqEligHist}.covInsuranceLnCode" 
																	tableName="MEMBER_ELIG_SBMT" attributeName="covInsuranceLnCode" 
																	value="${billingHistoryVar?.covInsuranceLnCode}"></g:secureTextField>
															</div>
														</td>
														
														<td class="tdFormElement" style="white-space: nowrap">
															<div class="fieldcontain">
																<label for="spouseFlagOverride"> <g:message
																		code="billingHistory.covLevelCode.label"
																		default="Coverage Level Code:" />
																</label>
															</div>
														</td>
														<td>
															<div class="fieldcontain">
																<g:secureTextField maxlength="3"
																	name="billingHistory.${memberDBID }.${billingHistoryVar?.seqEligHist}.covLevelCode" 
																	tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
																	value="${billingHistoryVar?.covLevelCode}"></g:secureTextField>
															</div>
														</td>
													</g:if>
												</g:each>
											</tr>
											
											<tr>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="smbAmount"> <g:message
																code="eligHistory.smbAmount.label"
																default="SMB Amount:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.smbAmount" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="smbAmount" 
																value="${formatNumber(number: eligibilityHistoryVar?.smbAmount, format: '###,##0.00')}"></g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="totalPremium"> <g:message
																code="eligHistory.totalPremium.label"
																default="Total Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.totalPremium" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="totalPremium" 
																value="${formatNumber(number: eligibilityHistoryVar?.totalPremium, format: '###,##0.00')}"></g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="assignedQhpId"> <g:message
																code="eligHistory.assignedQhpId.label"
																default="Assigned QHP ID :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="16" class="qhpMask"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.assignedQhpId" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="assignedQhpId" 
																value="${eligibilityHistoryVar?.assignedQhpId}" 
																title="Assigned Qualified Health Plan Identifier. Format #####XX######### where ## is a number and XX is a character."></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="totalResAmt"> <g:message
																code="eligHistory.totalResAmt.label"
																default="Total Responsibility Amount:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.totalResAmt" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="totalResAmt" 
																value="${formatNumber(number: eligibilityHistoryVar?.totalResAmt, format: '###,##0.00')}"
																title="Total Responsibility Amount"></g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="stateWrapPrem"> <g:message
																code="eligHistory.stateWrapPrem.label"
																default="State Wrap Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<span class="currencyinput">$
														<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.stateWrapPrem" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="stateWrapPrem" 
																value="${formatNumber(number: eligibilityHistoryVar?.stateWrapPrem, format: '###,##0.00')}"></g:secureTextField>
													</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="stateWrapCsr"> <g:message
																code="eligHistory.stateWrapCsr.label"
																default="State WRAP CSR:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField type="text" class="amtNumeric" maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.stateWrapCsr" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="stateWrapCsr" 
																value="${formatNumber(number: eligibilityHistoryVar?.stateWrapCsr, format: '###,##0.00')}"></g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="fedAptcPrem"> <g:message
																code="eligHistory.fedAptcPrem.label"
																default="Fed APTC Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField type="text" class="amtNumeric" 
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.fedAptcPrem" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="fedAptcPrem" 
																value="${formatNumber(number: eligibilityHistoryVar?.fedAptcPrem, format: '###,##0.00')}"></g:secureTextField>
														</span>	
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="fedAptcCsr"> <g:message
																code="eligHistory.fedAptcCsr.label"
																default="Fed APTC CSR:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.fedAptcCsr" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="fedAptcCsr" 
																value="${formatNumber(number: eligibilityHistoryVar?.fedAptcCsr, format: '###,##0.00')}" ></g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="famTotalPremium"> <g:message
																code="eligHistory.famTotalPremium.label"
																default="Fam Total Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famTotalPremium" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="famTotalPremium" 
																value="${formatNumber(number: eligibilityHistoryVar?.famTotalPremium, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="famFedAptcPrem"> <g:message
																code="eligHistory.famFedAptcPrem.label"
																default="Fam Fed APTC Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famFedAptcPrem" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="famFedAptcPrem" 
																value="${formatNumber(number: eligibilityHistoryVar?.famFedAptcPrem, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="famStateWrapPrem"> <g:message
																code="eligHistory.famStateWrapPrem.label"
																default="Fam State WRAP Premium:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famStateWrapPrem" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="famStateWrapPrem" 
																value="${formatNumber(number: eligibilityHistoryVar?.famStateWrapPrem, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="userRate1"> <g:message
																code="eligHistory.userRate1.label"
																default="User Rate 1:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate1" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="userRate1" 
																value="${formatNumber(number: eligibilityHistoryVar?.userRate1, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="userRate2"> <g:message
																code="eligHistory.userRate2.label"
																default="User Rate 2:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate2" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="userRate2" 
																value="${formatNumber(number: eligibilityHistoryVar?.userRate2, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="userRate3"> <g:message
																code="eligHistory.userRate3.label"
																default="User Rate 3:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate3" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="userRate3" 
																value="${formatNumber(number: eligibilityHistoryVar?.userRate3, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="rateAdjustmentFactor"> <g:message
																code="eligHistory.rateAdjustmentFactor.label"
																default="Rate Adjust Factor:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="percentinput">
															<g:secureTextField maxlength="20"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateAdjustmentFactor" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="rateAdjustmentFactor" 
																value="${formatNumber(number: eligibilityHistoryVar?.rateAdjustmentFactor, format: '##0.00')}" >
															</g:secureTextField>%
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="ffmRatingArea"> <g:message
																code="eligHistory.ffmRatingArea.label"
																default="FFM Rating Area:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
															<g:secureTextField maxlength="20"
																name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.ffmRatingArea" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="ffmRatingArea" 
																value="${eligibilityHistoryVar?.ffmRatingArea}" >
															</g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="otherPmtAmt"> <g:message
																code="eligHistory.otherPmtAmt.label"
																default="Other Payment Amount:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.otherPmtAmt" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="otherPmtAmt" 
																value="${formatNumber(number: eligibilityHistoryVar?.otherPmtAmt, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="otherPmtAmt2"> <g:message
																code="eligHistory.otherPmtAmt2.label"
																default="Other Payment Amount 2:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.otherPmtAmt2" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="otherPmtAmt2" 
																value="${formatNumber(number: eligibilityHistoryVar?.otherPmtAmt2, format: '###,##0.00')}" >
															</g:secureTextField>
														</span>
													</div>
												</td>
											</tr>
											
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="coverageAmount"> <g:message
																code="eligHistory.coverageAmount.label"
																default="Life Coverage Amount :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<span class="currencyinput">$
															<g:secureTextField maxlength="20" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.coverageAmount" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="coverageAmount" 
																value="${formatNumber(number: eligibilityHistoryVar?.coverageAmount, format: '###,##0.00')}" 
																title="This field stores the coverage amount for Life Insurance.">
															</g:secureTextField>
														</span>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="aboveGiaApprovalInd"> 
														<g:message code="eligHistory.aboveGiaApprovalInd.label" default="Above GIA Approval Indicator:" />
														<span class="required-indicator">*</span>
														</label>
													</div>
												</td>

												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.aboveGiaApprovalInd" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="aboveGiaApprovalInd" value="${eligibilityHistoryVar.aboveGiaApprovalInd}"
															from="${['N':'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="This field determines whether approval has been received for Life coverage above the GIA">
														</g:secureComboBox>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div class="fieldcontain">
														<label for="tobaccoUse"> 
														<g:message code="eligHistory.tobaccoUse.label" default="Tobacco Use:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.tobaccoUse" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="tobaccoUse" value="${eligibilityHistoryVar.tobaccoUse}"
															from="${['':'','N':'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="This field determines whether member is a tobacco user or not">
														</g:secureComboBox>
													</div>
												</td>
											</tr>
										</table>
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