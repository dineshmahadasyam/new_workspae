<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberLisInfo"%>
                 
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript">
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

	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {

			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

	});
		
</script>
<script>
var addRowClicked = false
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newMemberLisInfo')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addLisInfoDiv')
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
			var divObj = document.getElementById('addLisInfoDiv')
			divObj.style.display = "block"
			var formObj = document.getElementById('editForm')
			formObj.reset()
		} 
	}
	function showLisInfo(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")		
		if (!addRowClicked) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var lisInfoDivObj = document.getElementById(selectedValue)
			var addLisInfoDivObj = document.getElementById("addLisInfoDiv")
			hiddenObj.value=selectedValue			
			if (lisInfoDivObj  != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display="none"
				}
				lisInfoDivObj.style.display = "block"
				addLisInfoDivObj.style.display = "block"
				previousDivObj = lisInfoDivObj
			} 
		} 
	}

	function addLisInfo() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		var memberDBID = selectObj.options[selectObj.selectedIndex].value
		var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
		
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/memberMaintenance/addLisInfo?subscriberId="
				+ subscriberId + "&editType=DETAIL&memberDBID="+memberDBID+"&personNumber="+personNumber);
	}
	</script>
	
Member MEMMC LIS Info Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="MEMMC_LIS_INFO" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<table>
	<tr>
		<td><select id="memberIdSelectList" name="memberIdlist"
			onChange="showLisInfo(this)"
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
						
						<g:if test="${member.firstName }">
							${member.firstName }
						</g:if>
						<g:if test="${member.lastName }">
							${member.lastName }
						</g:if>
					</option>
				</g:each>
		</select>
		<g:each in="${memberMasterMap.keySet() }" status="idCount"	var="memberDBID">
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
			<div id="addLisInfoDiv" style="display:block">
			<g:checkURIAuthorization uri="/memberMaintenance/addLisInfo">
				<input type="button" name="addLisButton" class="load" value="Add LIS"  onClick="addLisInfo()">				
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

<g:each in="${lisInfoMap.keySet() }" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>Select</th>

				<th>LIS Start Date</th>
				<th>LIS End Date</th>
				<th>LIS Subsidy Level</th>
				
			</tr>
			<g:each in="${ lisInfoMap.get(memberDBID)}" status="i" var="lisInfo">
				<input type="hidden" name="seq_lis_id_${i}"	value="${lisInfo.seqLisInfo}">
				<input type="hidden" name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.iterationCount" value="${lisInfo.seqLisInfo}">

				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td class="clickme"><input type="radio" name="lisId" value="${lisInfo.seqMembId}"></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd" date="${lisInfo.lisStartDate}" /></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd" date="${lisInfo.lisEndDate}" /></td>
					<td class="clickme">${lisInfo.lisSubsidyLevel}</td>
				</tr>
				<tr class="hideme" id="rowToClone2">
					<td colspan="11">
						<div class="divContent">
							<table class="report1" border="0">
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisStartDate', 'error')} ">
											<label for="lisStartDate"> <g:message
													code="lisInfo.lisStartDate.label"
													default="LIS Start Date :" />
												<span class="required-indicator">*</span>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:securejqDatePicker 
											tableName="MEMBER_LIS_INFO" attributeName="lisStartDate"
											dateElementId="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisStartDate" 
											dateElementName="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisStartDates" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisStartDate != null ? lisInfo?.lisStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: lisInfo?.lisStartDate)}"/>
									</td>
									
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisEndDate', 'error')} ">
											<label for="lisEndDate"> <g:message
													code="lisInfo.lisEndDate.label"
													default="LIS End Date :" />
												<span class="required-indicator">*</span>																							
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:securejqDatePicker 
											tableName="MEMBER_LIS_INFO" attributeName="lisEndDate"
											dateElementId="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisEndDate" 
											dateElementName="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisEndDate" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisEndDate != null ? lisInfo?.lisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: lisInfo?.lisEndDate)}"/>
									</td>
							</tr>
								<tr>																									
									<td class="tdnoWrap">
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisSubsidyLevel', 'error')} ">
											<label for="lisInfo.lisSubsidyLevel"> <g:message
													code="lisInfo.lisSubsidyLevel.label"
													default="LIS Subsidy Level :" />	
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="6"
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisSubsidyLevel" 
											tableName="MEMBER_LIS_INFO" attributeName="lisSubsidyLevel" 
											value="${formatNumber(number: lisInfo?.lisSubsidyLevel, format: '###,##0.00')}" 										
											class="amtNumeric"
											title="Calculated value as per TRR business"></g:secureTextField>
									</td>
									
									<td class="tdWrapCondition">
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.lisCopayCategory', 'error')} ">
											<label for="lisCopayCategory"> <g:message
													code="lisInfo.lisCopayCategory.label"
													default="LIS Copay Category:" />	
												<span class="required-indicator">*</span>										
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureComboBox
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisCopayCategory" 
											tableName="MEMBER_LIS_INFO" attributeName="lisCopayCategory" value="${lisInfo.lisCopayCategory}"
											from="${['0': 'None, not low-income', '1': 'High', '2': 'Low', 
												'3': '$0 Full duals that are institutionalized', '4': '15%', '5': 'Unknown']}" 
											optionValue="value" optionKey="key">
										</g:secureComboBox>
									</td>
									
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
										colspan="2">
										<g:secureComboBox
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisSourceCode" 
											tableName="MEMBER_LIS_INFO" attributeName="lisSourceCode" value="${lisInfo.lisSourceCode}"
											from="${['A': 'Approved SSA Applicant', 'D': 'Deemed eligible by CMS', 'B': 'BAE']}" 
											optionValue="value" optionKey="key">
										</g:secureComboBox>
									</td>																			
									
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.enrolleeTypeFlag', 'error')} ">
											<label for="enrolleeTypeFlag"> <g:message
													code="lisInfo.enrolleeTypeFlag.label"
													default="Enrollee Type Flag :" />	
												<span class="required-indicator">*</span>										
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureComboBox
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.enrolleeTypeFlag" 
											tableName="MEMBER_LIS_INFO" attributeName="enrolleeTypeFlag" value="${lisInfo.enrolleeTypeFlag}"
											from="${['C': 'Current PBP Enrollee', 'P': 'Prospective PBP Enrollee', 'Y': 'Previous PBP Enrollee']}" 
											optionValue="value" optionKey="key">
										</g:secureComboBox>
									</td>
									
								</tr>
								<tr>																								
									<td class="tdnoWrap">
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.partdLisEnrSubsidy', 'error')} ">
											<label for="lisInfo.partdLisEnrSubsidy"> <g:message
													code="lisInfo.partdLisEnrSubsidy.label"
													default="Part D Enr Subsidy :" />
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="24"
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.partdLisEnrSubsidy" 
											tableName="MEMBER_LIS_INFO" attributeName="partdLisEnrSubsidy" 
											value="${formatNumber(number: lisInfo?.partdLisEnrSubsidy, format: '###,##0.00')}" 		
											class="amtNumeric"
											title="Part D late enrollment penalty subsidy amount"></g:secureTextField>
									</td>
									
									<td class="tdnoWrap">
										<div
											class="fieldcontain ${hasErrors(bean: lisInfo, field: 'lisInfo.partdLisSubsidy', 'error')} ">
											<label for="lisInfo.partdLisSubsidy"> <g:message
													code="lisInfo.partdLisSubsidy.label"
													default="Part D LIS Subsidy :" />
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2">
										<g:secureTextField maxlength="24"
											name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.partdLisSubsidy" 
											tableName="MEMBER_LIS_INFO" attributeName="partdLisSubsidy"
											value="${formatNumber(number: lisInfo?.partdLisSubsidy, format: '###,##0.00')}" 
											class="amtNumeric"
											title="Low Income Part D premium subsidy amount"></g:secureTextField>
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
	showLisInfo(memberSelectObject)
</script>