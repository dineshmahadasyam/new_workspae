<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistoryExtn"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="appContext" bean="grailsApplication"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});
		$(".alphaNumOnly").alphanum({
		});
		
		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});

	});//]]>
</script>
<script>
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

                window.location.assign("/"+appName+"/memberMaintenance/addEligibilityPeriod?subscriberId="
                                + subscriberId + "&editType=DETAIL&memberDBID="+memberDBID+"&personNumber="+personNumber);
	}
	
</script>
Member Eligibility History Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="DETAIL" />
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
				<g:checkURIAuthorization uri="/memberMaintenance/addEligibilityPeriod">
				<input type="button" value="Add Eligibility Period" name="addEligibilityPeriod1"
					class="load" onClick="addEligibilityPeriod()">
				</g:checkURIAuthorization>
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
<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
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
				<th>Benefit Start Date</th>
				<th>Benefit End Date</th>
				<th>Product Type</th>
			</tr>
			<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
				var="eligibilityHistoryVar">
				<input type="hidden" name="seq_prem_id_${i}"
					value="${eligibilityHistoryVar.seqEligHist }">
					
				<input type="hidden" name="memberEligHistoryExtnList.${eligibilityHistoryVar.seqEligHist}.seqEligHist"
					value="${eligibilityHistoryVar?.seqEligHist}">	
				<input type="hidden" name="memberEligHistoryExtnList.${eligibilityHistoryVar.seqEligHist}.iterationCount"
					value="${(eligibilityHistoryVar?.seqEligHist)}">
				<input type="hidden" name="memberEligSbmtMap.${eligibilityHistoryVar.seqEligHist}.seqEligHist"
					value="${eligibilityHistoryVar?.seqEligHist}">
				<input type="hidden" name="memberEligSbmtMap.${eligibilityHistoryVar.seqEligHist}.iterationCount"
					value="${(eligibilityHistoryVar?.seqEligHist)}">
				<input type="hidden" name="memberEligSbmtMap.${eligibilityHistoryVar.seqEligHist}.seqMembId"
					value="${memberDBID}">
					
				<input type="hidden"
					name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount"
					value="${eligibilityHistoryVar.seqEligHist }">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td><input type="radio"
						name="premiumMasterRadio_${i}" class="selectradio"></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.effectiveDate}" /></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.termDate}" /></td>
					<td class="clickme">
						${eligibilityHistoryVar.eligStatus}
					</td>
					<td class="clickme">
						${eligibilityHistoryVar.groupId}
					</td>
					<td class="clickme">
						${eligibilityHistoryVar.planCode}
					</td>
					<td class="clickme">
						<g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.benefitStartDate}" />
					</td>
					<td class="clickme">
						<g:formatDate format="yyyy-MM-dd" date="${memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate}" />
					</td>
					<td class="clickme">
						${productTypesMap?.get(eligibilityHistoryVar.planCode)}
					</td>
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
														<label for="effectiveDate"> <g:message
																code="eligHistory.effectiveDate.label"
																default="Effective Date :" /> <span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td colspan="2">
													<div class="fieldcontain">
														<g:secureGrailsDatePicker 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.effectiveDate" 
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
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureGrailsDatePicker
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termDate" 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termReason" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="termReason" 
															value="${eligibilityHistoryVar?.termReason}" ></g:secureTextField>
														<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
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
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dateOfDeath" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="dateOfDeath" precision="day" noSelection="['':'']"
															value="${eligibilityHistoryVar?.dateOfDeath}" default="none"></g:secureGrailsDatePicker>
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
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.eligStatus" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="eligStatus" value="${eligibilityHistoryVar.eligStatus}"
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
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.voidEligFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="voidEligFlag" value="${eligibilityHistoryVar.voidEligFlag}"
															from="${['N': 'No' , 'Y': 'Yes']}" optionValue="value" optionKey="key">
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

												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="15"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.recordStatus" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="recordStatus" 
															value="${eligibilityHistoryVar?.recordStatus}" ></g:secureTextField>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureGrailsDatePicker
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.benefitStartDate"  
															disabled="${ MultiPlanEnabled ? ("01".equals(eligibilityHistoryVar?.personNumber) ? "false" : "true") : false}"
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">														
														<g:secureDiamondDataWindowDetail columnName="relationship_code" dwName="dw_ccont_melig" languageId="0"
															htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.relationshipCode"
															defaultValue="${eligibilityHistoryVar?.relationshipCode}" blankValue="Relationship Code"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.relationshipCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="relationshipCode" value="${eligibilityHistoryVar?.relationshipCode}"									
														/>	
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
													
														<g:secureGrailsDatePicker
															name="memberEligHistoryExtnList.${eligibilityHistoryVar.seqEligHist}.benefitEndDate" 
															disabled="${ MultiPlanEnabled ? ("01".equals(eligibilityHistoryVar?.personNumber) ? "false" : "true") : false}"
															tableName="MEMBER_ELIG_HISTORY_EXTN" attributeName="benefitEndDate" precision="day" noSelection="['':'']"
															value="${memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate}" default="none"
															title = "Enter date for members end of eligibility"></g:secureGrailsDatePicker>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'exchangeMemberId', 'error')} ">
														<label for="exchangeMemberId"> <g:message
																code="eligHistory.exchangeMemberId.label"
																default="Exchange Member Id :" /> 
														</label>
													</div>
												</td>
												<td style="white-space: nowrap">
													<div class="fieldcontain">		
														<g:secureTextField maxlength="50"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.exchangeMemberId" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="exchangeMemberId" 
																value="${eligibilityHistoryVar?.exchangeMemberId}"></g:secureTextField>									
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">			
														<g:secureTextField maxlength="50" class="alphaNumOnly"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.exchangeAssignedPolicyNo" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="exchangeAssignedPolicyNo" 
																value="${eligibilityHistoryVar?.exchangeAssignedPolicyNo}"
																title="Exchange Assigned Policy Number"></g:secureTextField>								
													</div>
												</td>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<input type="hidden" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId" 
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId" value="${eligibilityHistoryVar.seqGroupId}"/>														
													
														<g:secureTextField maxlength="50"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.groupId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="groupId" 
															value="${eligibilityHistoryVar?.groupId}"></g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId', 'seqGroupId' )">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.subsidizedFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="subsidizedFlag" value="${eligibilityHistoryVar.subsidizedFlag}"
															from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key">
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<input type="hidden" id="planRecordType" name="planRecordType" value="P"/>
														<g:secureTextField maxlength="50"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.planCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="planCode" 
															value="${eligibilityHistoryVar?.planCode}" ></g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.planCode', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|planRecordType','seqGroupId|recordType', null, null)">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="3"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lineOfBusiness" 
															value="${eligibilityHistoryVar?.lineOfBusiness}"></g:secureTextField>	
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness', 'com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster','lineOfBusiness')">
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: memberEligSbmtMap, field: 'covLevelCode', 'error')} ">
														<label for="covLevelCode"> <g:message
																code="memberEligSbmtMap.covLevelCode.label" default="Coverage Level:" />
														</label>
													</div>
												</td>
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="3"
															name="memberEligSbmtMap.${eligibilityHistoryVar.seqEligHist}.covLevelCode" 
															tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
															value="${memberEligSbmtMap?.get(eligibilityHistoryVar?.seqEligHist)?.covLevelCode}"
															title ="Enter a 3-character coverage level code"></g:secureTextField>	
													</div>
												</td>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.privacyOn" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="privacyOn" value="${eligibilityHistoryVar.privacyOn}"
															from="${['':'', 'Y':'Yes', 'N':'No']}" optionValue="value" optionKey="key">
														</g:secureComboBox>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<table border="0">
															<tr>
																<td>
																<input type="hidden" id="RiderRecordType" name="RiderRecordType" value="R"/>																
																<g:secureTextField maxlength="2" size="2" style="width:15px"
																	name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1" 
																	tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode1" 
																	value="${eligibilityHistoryVar?.riderCode1}"></g:secureTextField>
																<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																	src="${resource(dir: 'images', file: 'Search-icon.png')}"
																	onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																																		
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode2" 
																		value="${eligibilityHistoryVar?.riderCode2}"></g:secureTextField>																		
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode3" 
																		value="${eligibilityHistoryVar?.riderCode3}"></g:secureTextField>
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode4" 
																		value="${eligibilityHistoryVar?.riderCode4}"></g:secureTextField>
																	<img
																		width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
															</tr>
															<tr>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode5" 
																		value="${eligibilityHistoryVar?.riderCode5}"></g:secureTextField>
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode6" 
																		value="${eligibilityHistoryVar?.riderCode6}"></g:secureTextField>
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode7" 
																		value="${eligibilityHistoryVar?.riderCode7}"></g:secureTextField>
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
																</td>
																<td>
																	<g:secureTextField maxlength="2" size="2" style="width:15px"
																		name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8" 
																		tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode8" 
																		value="${eligibilityHistoryVar?.riderCode8}"></g:secureTextField> 
																	<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
																		src="${resource(dir: 'images', file: 'Search-icon.png')}"
																		onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType','seqGroupId|recordType', null, null)">
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode1" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode1" 
															value="${eligibilityHistoryVar?.riderContractTypeCode1}"></g:secureTextField> 
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode2" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode2" 
															value="${eligibilityHistoryVar?.riderContractTypeCode2}"></g:secureTextField> 
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode3" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode3" 
															value="${eligibilityHistoryVar?.riderContractTypeCode3}"></g:secureTextField>
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode4" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode4" 
															value="${eligibilityHistoryVar?.riderContractTypeCode4}"></g:secureTextField>
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode5" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode5" 
															value="${eligibilityHistoryVar?.riderContractTypeCode5}"></g:secureTextField>
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode6" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode6" 
															value="${eligibilityHistoryVar?.riderContractTypeCode6}"></g:secureTextField>
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode7" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode7" 
															value="${eligibilityHistoryVar?.riderContractTypeCode7}"></g:secureTextField>
														<g:secureTextField maxlength="2" size="2" style="width:15px"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode8" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode8" 
															value="${eligibilityHistoryVar?.riderContractTypeCode8}"></g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'issuerSubscriberId', 'error')} ">
														<label for="issuerSubscriberId"> <g:message
																code="eligHistory.issuerSubscriberId.label" default="Issuer Subscriber Id :" />
														</label>
													</div>
												</td>
												<td style="white-space: nowrap">
													<div class="fieldcontain">	
														<g:secureTextField maxlength="50" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerSubscriberId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="issuerSubscriberId" 
															value="${eligibilityHistoryVar?.issuerSubscriberId}"></g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerSubscriberId', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerSubscriberId')">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<input type="hidden" id="systemCodeType" 
														name="systemCodeType" value="RATETYPE"/>															
														<g:secureTextField maxlength="10" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateType" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="rateType" 
															value="${eligibilityHistoryVar?.rateType}"></g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateType', 'com.perotsystems.diamond.dao.cdo.SystemCodes','systemCode','systemCodeType', 'systemCodeType',null ,null )">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">	
														<g:secureTextField maxlength="30" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerGroupNumber" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="issuerGroupNumber" 
															value="${eligibilityHistoryVar?.issuerGroupNumber}"></g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerGroupNumber', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerGroupNumber')">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="50" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerPolicyNumber" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="issuerPolicyNumber" 
															value="${eligibilityHistoryVar?.issuerPolicyNumber}">
														</g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerPolicyNumber', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerPolicyNumber')">																	 
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">	
														<g:secureTextField maxlength="50" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerMemberId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="issuerMemberId" 
															value="${eligibilityHistoryVar?.issuerMemberId}">
														</g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerMemberId', 'com.perotsystems.diamond.dao.cdo.MemberEligHistory','issuerMemberId')">																	 
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
														<g:secureTextField maxlength="12" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.siteCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="siteCode" 
															value="${eligibilityHistoryVar?.siteCode}">
														</g:secureTextField>
													</div>
												</td>
												<td></td>
												<td></td>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="3" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.panelId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="panelId" 
															value="${eligibilityHistoryVar?.panelId}">
														</g:secureTextField>
														<img width="25" height="25"
															style="float: none; vertical-align: bottom"
															class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.panelId', 'com.perotsystems.diamond.dao.cdo.GroupPanel','panelId', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId', 'seqGroupId',  null, null)">	

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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<input type="hidden" name="ipaLevelCode" id="ipaLevelCode" value="1"/>
														<g:secureTextField 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ipaId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="ipaId" 
															value="${eligibilityHistoryVar?.ipaId}">
														</g:secureTextField>
														<img width="25" height="25"
															style="float: none; vertical-align: bottom"
															class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ipaId', 'com.perotsystems.diamond.dao.cdo.IpaMaster','ipaId', 'ipaLevelCode', 'levelCode',  null, null)">
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
																										
														<g:hiddenField name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqProvId" value="${eligibilityHistoryVar?.seqProvId }"/>
									
														<g:if test="${eligibilityHistoryVar?.seqProvId}">
															<g:each in="${provIdList}" var="provId">
																<g:if test="${provId.seqProvId.equals(eligibilityHistoryVar?.seqProvId)}">
																<g:secureTextField  readonly="readonly"
																	name="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId" 
																	tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" 
																	value="${provId.providerId}"
																	style="color:#848484;" onclick="PCPIdfieldClickMessage()">
																</g:secureTextField>
																</g:if>
															</g:each>
														</g:if>
														<g:else>
															<g:secureTextField  readonly="readonly"
																name="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" 
																value=""
																style="color:#848484;" onclick="PCPIdfieldClickMessage()">
															</g:secureTextField>
														</g:else>	
														<img width="25" height="25"
															style="float: none; vertical-align: bottom"
															class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId', 'com.perotsystems.diamond.dao.cdo.ProvMaster','providerId',null, null,'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqProvId', 'seqProvId' );">													
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<input type="hidden" name="PCPReasonType" id="PCPReasonType" value="PC"/>
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="pcpChangeReason" 
															value="${eligibilityHistoryVar?.pcpChangeReason}">
														</g:secureTextField>
													<img width="25" height="25"
														style="float: none; vertical-align: bottom"
														class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
														onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'PCPReasonType', 'reasonCodeType',  null, null)">
													</div>
												</td>

											</tr>
											<tr><td colspan="4"><hr></td></tr>
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
														<g:secureTextField maxlength="12"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicareStatusFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="medicareStatusFlg" 
															value="${eligibilityHistoryVar?.medicareStatusFlg}">
														</g:secureTextField>
													</div>
												</td>
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
												<td style="white-space: nowrap">
													<div class="fieldcontain">
														<g:secureTextField maxlength="20"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscDept" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="subscDept" 
															value="${eligibilityHistoryVar?.subscDept}">
														</g:secureTextField>
														<img width="25" height="25"
															style="float: none; vertical-align: bottom"
															class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscDept', 'com.perotsystems.diamond.dao.cdo.GroupDepartment','deptNumber', 'eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId', 'seqGroupId', null, null)">
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
															htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscLocation"
															blankValue="Location" 
															defaultValue="${eligibilityHistoryVar?.subscLocation}" 
															width="150px">
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
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.hireDate" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="hireDate" precision="day" noSelection="['':'']"
															value="${eligibilityHistoryVar?.hireDate}" default="none">
														</g:secureGrailsDatePicker>
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
														<g:secureSystemCodeToken
															systemCodeType="MEMCSIND" languageId="0"
															tableName="MEMBER_ELIG_HISTORY" attributeName="csIndicator" 
															htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.csIndicator"
															blankValue="CS Indicator" 
															defaultValue="${eligibilityHistoryVar?.csIndicator}" 
															width="150px">
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
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.prospectivePremiumAmt" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="prospectivePremiumAmt" 
															value="${eligibilityHistoryVar?.prospectivePremiumAmt}">
														</g:secureTextField>
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
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined1" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined1" 
															value="${eligibilityHistoryVar?.userDefined1}">
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
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass1" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass1" 
															value="${eligibilityHistoryVar?.memberClass1}">
														</g:secureTextField>
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
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass2" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass2" 
															value="${eligibilityHistoryVar?.memberClass2}">
														</g:secureTextField>
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
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined2" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined2" 
															value="${eligibilityHistoryVar?.userDefined2}">
														</g:secureTextField>
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
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined3" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined3" 
															value="${eligibilityHistoryVar?.userDefined3}">
														</g:secureTextField>
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