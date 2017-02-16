<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

Member Medicare Enrollment Information Records for Member Id (${subscriberMember.subscriberID})
<br></br>
<input type="hidden" name="editType" value="MEDICARE_ENROLLMENT_INFO" />
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
<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
		<table border="1" id="report">
			<tr class="head">
				<th>Select</th>
				<th>Effective Date</th>
				<th>Term Date</th>
				<th>M</th>
				<th>D</th>
				<th>H</th>
				<th>I</th>
				<th>E</th>
				<th>Wa</th>
				<th>W</th>
				<th>P</th>
				<th>Part A</th>
				<th>Part B</th>
			</tr>
			<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
				var="eligibilityHistoryVar">
				<input type="hidden" name="seq_prem_id_${i}"
					value="${eligibilityHistoryVar.seqEligHist }">
				<input type="hidden"
					name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount"
					value="${eligibilityHistoryVar.seqEligHist }">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td class="clickme"><input type="radio"
						name="premiumMasterRadio"></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.effectiveDate}" /></td>
					<td class="clickme"><g:formatDate format="yyyy-MM-dd"
							date="${eligibilityHistoryVar.termDate}" /></td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareMedicaidFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareDisableFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareHospiceFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareInstitutionalFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareEsrdFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.mcareWorkingAgedFlag}</td>
					<td class="clickme">
						${eligibilityHistoryVar.entMcareWelfareFlg}</td>
					<td class="clickme">
						${eligibilityHistoryVar.entMcarePipdcgFactor}</td>
					<td class="clickme">
						${eligibilityHistoryVar.entMcarePartAFlg}</td>
					<td class="clickme">
						${eligibilityHistoryVar.entMcarePartBFlg}</td>
				</tr>
				<tr class="hideme">
					<td colspan="13">
						<div class="divContent">
							<table>
								<tr>
									<td>										
										<table border="0">
										<tr><td colspan="4"><h4>Entitlement Information</h4><hr></td></tr>										
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareMedicaidFlag', 'error')} ">
														<label for="mcareMedicaidFlag"> <g:message
																code="eligHistory.mcareMedicaidFlag.label"
																default="Medicaid :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareMedicaidFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareMedicaidFlag" 
															value="${eligibilityHistoryVar.mcareMedicaidFlag}"
															readonly="readonly">
															</g:secureTextField>												
																											
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareDisableFlag', 'error')} ">
														<label for="mcareDisableFlag"> <g:message
																code="eligHistory.mcareDisableFlag.label"
																default="Disabled :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareDisableFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareDisableFlag" 
															value="${eligibilityHistoryVar.mcareDisableFlag}"
															readonly="readonly">
															</g:secureTextField>																
																											
													</div>
												</td>
												</tr>
												<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareHospiceFlag', 'error')} ">
														<label for="mcareHospiceFlag"> <g:message
																code="eligHistory.mcareHospiceFlag.label"
																default="Hospice :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareHospiceFlag"  
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareHospiceFlag" 
															value="${eligibilityHistoryVar.mcareHospiceFlag}"
															readonly="readonly">
															</g:secureTextField>
																											
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareInstitutionalFlag', 'error')} ">
														<label for="mcareInstitutionalFlag"> <g:message
																code="eligHistory.mcareInstitutionalFlag.label"
																default="Institutional :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareInstitutionalFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareInstitutionalFlag" 
															value="${eligibilityHistoryVar.mcareInstitutionalFlag}"
															readonly="readonly">
															</g:secureTextField>					
																										
													</div>
												</td>
											</tr>
											<tr>												
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareNhcFlag', 'error')} ">
														<label for="mcareNhcFlag"> <g:message
																code="eligHistory.mcareNhcFlag.label"
																default="NHC :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareNhcFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareNhcFlag" 
															value="${eligibilityHistoryVar.mcareNhcFlag}"
															readonly="readonly" 
															title="Nursing Home Candidate">
															</g:secureTextField>															
																								
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareEsrdFlag', 'error')} ">
														<label for="mcareEsrdFlag"> <g:message
																code="eligHistory.mcareEsrdFlag.label"
																default="ESRD :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareEsrdFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareEsrdFlag" 
															value="${eligibilityHistoryVar.mcareEsrdFlag}"
															readonly="readonly" 
															title="End State Renal Disease">
															</g:secureTextField>															
																											
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareWorkingAgedFlag', 'error')} ">
														<label for="mcareWorkingAgedFlag"> <g:message
																code="eligHistory.mcareWorkingAgedFlag.label"
																default="Working Aged :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:secureTextField maxlength="2" type="text"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareWorkingAgedFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareWorkingAgedFlag" 
															value="${eligibilityHistoryVar.mcareWorkingAgedFlag}"
															readonly="readonly">
															</g:secureTextField>																
																											
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'entMcareWelfareFlg', 'error')} ">
														<label for="entMcareWelfareFlg"> <g:message
																code="eligHistory.entMcareWelfareFlg.label"
																default="Welfare :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcareWelfareFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcareWelfareFlg" value="${eligibilityHistoryVar.entMcareWelfareFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member Currently on Welfare">
														</g:secureComboBox>														
													</div>
												</td>
												
											</tr>
											<tr>
											<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'entMcarePipdcgFactor', 'error')} ">
														<label for="entMcarePipdcgFactor"> <g:message
																code="eligHistory.entMcarePipdcgFactor.label"
																default="PIP-DCG :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="2" type="text" class="numeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePipdcgFactor" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePipdcgFactor" 
															value="${formatNumber(number: eligibilityHistoryVar?.entMcarePipdcgFactor, format: '###,##0')}" 
															title="Member is under PIP DCG care"></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'entMcarePartAFlg', 'error')} ">
														<label for="entMcarePartAFlg"> <g:message
																code="eligHistory.entMcarePartAFlg.label"
																default="Part A :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePartAFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePartAFlg" value="${eligibilityHistoryVar.entMcarePartAFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member is under Part A coverage">
														</g:secureComboBox>														
													</div>
												</td>
												</tr>
												<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'entMcarePartBFlg', 'error')} ">
														<label for="entMcarePartBFlg"> <g:message
																code="eligHistory.entMcarePartBFlg.label"
																default="Part B :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePartBFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePartBFlg" value="${eligibilityHistoryVar.entMcarePartBFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member is under Part B coverage">
														</g:secureComboBox>														
													</div>
												</td>
													<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'medicarePartAEffectDate', 'error')} ">
														<label for="medicarePartAEffectDate"> <g:message
																code="eligHistory.medicarePartAEffectDate.label"
																default="Medicare Part A Eff Dt :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="medicarePartAEffectDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.medicarePartAEffectDate != null ? eligibilityHistoryVar?.medicarePartAEffectDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.medicarePartAEffectDate)}"
															title = "Effective Date when Part A Coverage began"/>
													</div>
												</td>
											</tr>
										
											<tr>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'medicarePartBEnrollDate', 'error')} ">
														<label for="medicarePartBEnrollDate"> <g:message
																code="eligHistory.medicarePartBEnrollDate.label"
																default="Medicare Part B Enrl Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="medicarePartBEnrollDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartBEnrollDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartBEnrollDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.medicarePartBEnrollDate != null ? eligibilityHistoryVar?.medicarePartBEnrollDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.medicarePartBEnrollDate)}"
															title = "Effective Date when Part B Coverage began"/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcarePartABTermDate', 'error')} ">
														<label for="mcarePartABTermDate"> <g:message
																code="eligHistory.mcarePartABTermDate.label"
																default="Medicare Part A, B Term Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
																tableName="MEMBER_ELIG_HISTORY" attributeName="mcarePartABTermDate"
																dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcarePartABTermDate" 
																dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcarePartABTermDate" 
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.mcarePartABTermDate != null ? eligibilityHistoryVar?.mcarePartABTermDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.mcarePartABTermDate)}"
																title = "Term Dt of Medicare Part A and Part B"/>															
													</div>
												</td>
											</tr>
											<tr>
												
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'revisedEndDate', 'error')} ">
														<label for="revisedEndDate"> <g:message
																code="eligHistory.revisedEndDate.label"
																default="Revised End Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
																tableName="MEMBER_ELIG_HISTORY" attributeName="revisedEndDate"
																dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.revisedEndDate" 
																dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.revisedEndDate" 
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.revisedEndDate != null ? eligibilityHistoryVar?.revisedEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.revisedEndDate)}"
																title = "New end date when Gap enrollment is accepted"/>	
													</div>
												</td>
											
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'dialysisEndDate', 'error')} ">
														<label for="dialysisEndDate"> <g:message
																code="eligHistory.dialysisEndDate.label"
																default="Dialysis End Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="dialysisEndDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dialysisEndDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dialysisEndDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.dialysisEndDate != null ? eligibilityHistoryVar?.dialysisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.dialysisEndDate)}"
															title = "End Dt of Dialysis Period"/>	
													</div>
												</td>
												</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'endDate', 'error')} ">
														<label for="endDate"> <g:message
																code="eligHistory.endDate.label"
																default="End Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="endDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.endDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.endDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.endDate != null ? eligibilityHistoryVar?.endDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.endDate)}"
															title = "End Dt on the gap enrollment transaction"/>	
													</div>
												</td>
											</tr>
										<tr><td colspan="4">
										</br>
										</td></tr>	
										<tr><td colspan="4"><h4>Demographics</h4><hr></td></tr>
										<tr>
											<td class="tdFormElement" style="white-space: nowrap">
												<div
													class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareStateCode', 'error')} ">
													<label for="mcareStateCode"> <g:message
															code="eligHistory.mcareStateCode.label"
															default="CMS State Cd :" />
													</label>
												</div>
											</td>
											<td>
												<div class="fieldcontain">
													<g:secureTextField maxlength="2"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareStateCode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="mcareStateCode" 
														value="${eligibilityHistoryVar?.mcareStateCode}"
														readonly="readonly" 
														title="State Code">
													</g:secureTextField>																
												</div>
											</td>
											<td class="tdFormElement" style="white-space: nowrap">
												<div
													class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mcareCountyCode', 'error')} ">
													<label for="mcareCountyCode"> <g:message
															code="eligHistory.mcareCountyCode.label"
															default="CMS County Cd :" />
													</label>
												</div>
											</td>
											<td>
												<div class="fieldcontain">
													<g:secureTextField maxlength="3"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareCountyCode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="mcareCountyCode" 
														value="${eligibilityHistoryVar?.mcareCountyCode}"
														readonly="readonly"
														title="County Code">
													</g:secureTextField>																
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdFormElement" style="white-space: nowrap">
												<div
													class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'geocode', 'error')} ">
													<label for="geocode"> <g:message
															code="eligHistory.geocode.label"
															default="Geo Code :" />
														<span class="required-indicator">*</span>
													</label>
												</div>
											</td>
											<td>
												<div class="fieldcontain">
													<g:secureTextField maxlength="5"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.geocode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="geocode" 
														value="${eligibilityHistoryVar?.geocode}"
														title="CMS assigned Geo code for county">
													</g:secureTextField>																
												</div>
											</td>
											<td class="tdFormElement" style="white-space: nowrap">
												<div
													class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'pbp', 'error')} ">
													<label for="pbp"> <g:message
															code="eligHistory.pbp.label"
															default="PBP :" />
														<span class="required-indicator">*</span>
													</label>
												</div>
											</td>
											<td>
												<div class="fieldcontain">
													<g:secureTextField maxlength="3"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbp" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="pbp" 
														value="${eligibilityHistoryVar?.pbp}"
														title="Plan Benefit Package assigned by CMS"
														>
													</g:secureTextField>																
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdFormElement" style="white-space: nowrap">
												<div
													class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'pbpSegmentNumber', 'error')} ">
													<label for="pbpSegmentNumber"> <g:message
															code="eligHistory.pbpSegmentNumber.label"
															default="PBP Segment ID :" />
														<span class="required-indicator">*</span>
													</label>
												</div>
											</td>
											<td>
												<div class="fieldcontain">
													<g:secureTextField maxlength="3"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpSegmentNumber" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="pbpSegmentNumber" 
														value="${eligibilityHistoryVar?.pbpSegmentNumber}"
														title="PBP by geographic boundaries. Needed for outbound MMA Transaction file">
													</g:secureTextField>																
												</div>
											</td>
											<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'longTermInstFlag', 'error')} ">
														<label for="longTermInstFlag"> <g:message
																code="eligHistory.longTermInstFlag.label"
																default="L T Inst  Flag :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.longTermInstFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="longTermInstFlag" value="${eligibilityHistoryVar.longTermInstFlag}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member choice in an institution for long term">
														</g:secureComboBox>														
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'overrideFlag', 'error')} ">
														<label for="overrideFlag"> <g:message
																code="eligHistory.overrideFlag.label"
																default="Override Flag :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.overrideFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="overrideFlag" value="${eligibilityHistoryVar.overrideFlag}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Flag indicates to bypass edit for a member">
														</g:secureComboBox>														
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'pbpAcknowledgeIndicator', 'error')} ">
														<label for="pbpAcknowledgeIndicator"> <g:message
																code="eligHistory.pbpAcknowledgeIndicator.label"
																default="PBP Acknowl Ind :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpAcknowledgeIndicator" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="pbpAcknowledgeIndicator" 
															value="${eligibilityHistoryVar?.pbpAcknowledgeIndicator}"
															title="Indicates that the member has acknowledged a PBP change.">
														</g:secureTextField>																
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'pbpEffectiveDate', 'error')} ">
														<label for="pbpEffectiveDate"> <g:message
																code="eligHistory.pbpEffectiveDate.label"
																default="PBP Eff Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="pbpEffectiveDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpEffectiveDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpEffectiveDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.pbpEffectiveDate != null ? eligibilityHistoryVar?.pbpEffectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.pbpEffectiveDate)}"
															title = "Date the member acknowledged or signed."/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'oldPlanBenefitPackageId', 'error')} ">
														<label for="oldPlanBenefitPackageId"> <g:message
																code="eligHistory.oldPlanBenefitPackageId.label"
																default="Prior PBP :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="3"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.oldPlanBenefitPackageId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="oldPlanBenefitPackageId" 
															value="${eligibilityHistoryVar?.oldPlanBenefitPackageId}"
															title="Prior PBP number; present only when transaction type code is 71">
														</g:secureTextField>																
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'riskAdjusterFactorA', 'error')} ">
														<label for="riskAdjusterFactorA"> <g:message
																code="eligHistory.riskAdjusterFactorA.label"
																default="Risk Adj Factor A :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="7" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riskAdjusterFactorA" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riskAdjusterFactorA" 
																value="${formatNumber(number: eligibilityHistoryVar?.riskAdjusterFactorA, format: '###,##0.0000')}" 
																title="Risk adjuster factor for Part A"></g:secureTextField>												
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'riskAdjusterFactorB', 'error')} ">
														<label for="riskAdjusterFactorB"> <g:message
																code="eligHistory.riskAdjusterFactorB.label"
																default="Risk Adj Factor B :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="7" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riskAdjusterFactorB" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riskAdjusterFactorB" 
																value="${formatNumber(number: eligibilityHistoryVar?.riskAdjusterFactorB, format: '###,##0.0000')}" 
																title="Risk adjuster factor for Part B"></g:secureTextField>												
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'appReceivedDate', 'error')} ">
														<label for="appReceivedDate"> <g:message
																code="eligHistory.appReceivedDate.label"
																default="CMS Application Dt :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="appReceivedDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.appReceivedDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.appReceivedDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.appReceivedDate != null ? eligibilityHistoryVar?.appReceivedDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.appReceivedDate)}"
															title = "Application Received Dt"/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'outOfAreaFlag', 'error')} ">
														<label for="outOfAreaFlag"> <g:message
																code="eligHistory.outOfAreaFlag.label"
																default="Out of Area :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.outOfAreaFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="outOfAreaFlag" 
															value="${eligibilityHistoryVar?.outOfAreaFlag}"
															title="MMCS Data file ended with position 133.">
														</g:secureTextField>																
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'residenceScc', 'error')} ">
														<label for="residenceScc"> <g:message
																code="eligHistory.residenceScc.label"
																default="Residence SCC :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.residenceScc" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="residenceScc" 
															value="${eligibilityHistoryVar?.residenceScc}"
															title="Beneficiary Residence State and County Code">
														</g:secureTextField>																
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'ssaDistrictOfficeNumber', 'error')} ">
														<label for="ssaDistrictOfficeNumber"> <g:message
																code="eligHistory.ssaDistrictOfficeNumber.label"
																default="SSA District Office :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="3"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ssaDistrictOfficeNumber" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="ssaDistrictOfficeNumber" 
															value="${eligibilityHistoryVar?.ssaDistrictOfficeNumber}"
															title="Originating SSA district Office code">
														</g:secureTextField>																
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'cmsDisenrollmentReasonCode', 'error')} ">
														<label for="cmsDisenrollmentReasonCode"> <g:message
																code="eligHistory.cmsDisenrollmentReasonCode.label"
																default="CMS Disenrl Rsn Code:" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="2"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.cmsDisenrollmentReasonCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="cmsDisenrollmentReasonCode" 
															value="${eligibilityHistoryVar?.cmsDisenrollmentReasonCode}"
															title="CMS Disenrollment Reason Code">
														</g:secureTextField>																
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'sourceCode', 'error')} ">
														<label for="sourceCode"> <g:message
																code="eligHistory.sourceCode.label"
																default="TX Source ID :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.sourceCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="sourceCode" 
															value="${eligibilityHistoryVar?.sourceCode}" 
															title="Transaction Source Identifier">
														</g:secureTextField>	
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'uiInitiatedChange', 'error')} ">
														<label for="uiInitiatedChange"> <g:message
																code="eligHistory.uiInitiatedChange.label"
																default="UI Initiated :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiInitiatedChange" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="uiInitiatedChange" value="${eligibilityHistoryVar.uiInitiatedChange}"
															from="${['':'', '0': '0', '1':'1']}" optionValue="value" optionKey="key"
															title="0=Transaction intiated from other than UI, 1=UI Initiated Transaction">
														</g:secureComboBox>														
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'uiUserDate', 'error')} ">
														<label for="uiUserDate"> <g:message
																code="eligHistory.uiUserDate.label"
																default="UI User Date :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="uiUserDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.uiUserDate != null ? eligibilityHistoryVar?.uiUserDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.uiUserDate)}"
															title = "Date Identifying Information Changed by UI User"/>
														<script type="text/javascript">
															setDefaultDate('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserDate');
														</script>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'attemptedEnrollEffDt', 'error')} ">
														<label for="attemptedEnrollEffDt"> <g:message
																code="eligHistory.attemptedEnrollEffDt.label"
																default="Attempted Enroll Eff Dt :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="attemptedEnrollEffDt"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.attemptedEnrollEffDt" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.attemptedEnrollEffDt" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.attemptedEnrollEffDt != null ? eligibilityHistoryVar?.attemptedEnrollEffDt.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.attemptedEnrollEffDt)}"
															title = "The effective date of an enrollment transaction that was submitted but rejected."/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'applicationDateIndicator', 'error')} ">
														<label for="applicationDateIndicator"> <g:message
																code="eligHistory.applicationDateIndicator.label"
																default="Application Date Ind :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.applicationDateIndicator" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="applicationDateIndicator" value="${eligibilityHistoryVar.applicationDateIndicator}"
															from="${['':'', 'Y':'Y']}" optionValue="value" optionKey="key"
															title="The application date associated with a UI submitted enrollment has a system generated default value.">
														</g:secureComboBox>														
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'uiUserOrgDesignation', 'error')} ">
														<label for="uiUserOrgDesignation"> <g:message
																code="eligHistory.uiUserOrgDesignation.label"
																default="UI User Org :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserOrgDesignation" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="uiUserOrgDesignation" value="${eligibilityHistoryVar.uiUserOrgDesignation}"
															from="${['02':'Regional Office', '03': 'Central Office', ' ': 'Not UI transaction']}" optionValue="value" optionKey="key">
														</g:secureComboBox>														
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'cmsProcTimestamp', 'error')} ">
														<label for="cmsProcTimestamp"> <g:message
																code="eligHistory.cmsProcTimestamp.label"
																default="CMS Process Time stamp :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="15"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.cmsProcTimestamp" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="cmsProcTimestamp" 
															value="${eligibilityHistoryVar?.cmsProcTimestamp}"
															title="Format: HH.MM.SS.SSSSSS">
														</g:secureTextField>																
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'prevPartDContractPbp', 'error')} ">
														<label for="prevPartDContractPbp"> <g:message
																code="eligHistory.prevPartDContractPbp.label"
																default="Previous Contract/PBP :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="3"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.prevPartDContractPbp" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="prevPartDContractPbp" 
															value="${eligibilityHistoryVar?.prevPartDContractPbp}"
															title="CCCCCPPP Format CCCCC = Contract Number PPP = Plan Benefit Package (PBP) Number">
														</g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'trrTransDate', 'error')} ">
														<label for="trrTransDate"> <g:message
																code="eligHistory.trrTransDate.label"
																default="TRR Tran Date :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="trrTransDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.trrTransDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.trrTransDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.trrTransDate != null ? eligibilityHistoryVar?.trrTransDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.trrTransDate)}"/>
													</div>
												</td>
											</tr>
										<tr><td colspan="4">
										</br>
										</td></tr>
										<tr><td colspan="4"><h4>Part C/D Information</h4><hr></td></tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'priorCommercialOverride', 'error')} ">
														<label for="priorCommercialOverride"> <g:message
																code="eligHistory.priorCommercialOverride.label"
																default="Prior Commercial Override :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1" class="alphanum"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.priorCommercialOverride" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="priorCommercialOverride" 
															value="${eligibilityHistoryVar?.priorCommercialOverride}">
														</g:secureTextField>																
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'employerSubsidyOverride', 'error')} ">
														<label for="employerSubsidyOverride"> <g:message
																code="eligHistory.employerSubsidyOverride.label"
																default="Employer Subsidy Override :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.employerSubsidyOverride" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="employerSubsidyOverride" 
															value="${eligibilityHistoryVar?.employerSubsidyOverride}">
														</g:secureTextField>															
													</div>
												</td>
												
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lateEnrollStartDate', 'error')} ">
														<label for="lateEnrollStartDate"> <g:message
																code="eligHistory.lateEnrollStartDate.label"
																default="Late Enrl start Dt :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollStartDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStartDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStartDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.lateEnrollStartDate != null ? eligibilityHistoryVar?.lateEnrollStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStartDate)}"
															title = "The begin dt of the late enrollment penalty period"/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'sourceCode', 'error')} ">
														<label for="sourceCode"> <g:message
																code="eligHistory.sourceCode.label"
																default="Enroll Source :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.electionPeriod" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="electionPeriod" 
															value="${eligibilityHistoryVar?.electionPeriod}"
															title="Transaction Source Identifier">		
														</g:secureTextField>											
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'creditableCovFlag', 'error')} ">
														<label for="creditableCovFlag"> <g:message
																code="eligHistory.creditableCovFlag.label"
																default="Creditable Cov :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.creditableCovFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="creditableCovFlag" 
															value="${eligibilityHistoryVar?.creditableCovFlag}">
														</g:secureTextField>															
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lateEnrollStopDate', 'error')} ">
														<label for="lateEnrollStopDate"> <g:message
																code="eligHistory.lateEnrollStopDate.label"
																default="Late Enrl Stop Dt :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollStopDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStopDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStopDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.lateEnrollStopDate != null ? eligibilityHistoryVar?.lateEnrollStopDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStopDate)}"
															title = "End dt of Late enrollment Penalty Period"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'electionCode', 'error')} ">
														<label for="electionCode"> <g:message
																code="eligHistory.electionCode.label"
																default="Election Type :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.electionCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="electionCode" 
															value="${eligibilityHistoryVar?.electionCode}"
															title="Election code for enrollment">
														</g:secureTextField>																
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'eghpIndicator', 'error')} ">
														<label for="eghpIndicator"> <g:message
																code="eligHistory.eghpIndicator.label"
																default="EGHP :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.eghpIndicator" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="eghpIndicator" value="${eligibilityHistoryVar.eghpIndicator}"
															from="${['Y': 'EGHP', 'N': 'Not EGHP',' ':'No change']}" optionValue="value" optionKey="key">
														</g:secureComboBox>														
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'thirdPartyId', 'error')} ">
														<label for="thirdPartyId"> <g:message
																code="eligHistory.thirdPartyId.label"
																default="Third Party Partner ID :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="12"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="thirdPartyId" 
															value="${eligibilityHistoryVar?.thirdPartyId}"
															title="Third Party billing entity for split billing">
														</g:secureTextField>
														<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId', 'com.perotsystems.diamond.dao.cdo.ThirdParty','thirdPartyId')">															
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'electionCode', 'error')} ">
														<label for="electionCode"> <g:message
																code="eligHistory.electionCode.label"
																default="Auto Enroll Opt-out :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="1"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDOptOutFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partDOptOutFlag" 
															value="${eligibilityHistoryVar?.partDOptOutFlag}">
														</g:secureTextField>															
													</div>
												</td>
											
											</tr>
											<tr>
												
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'newLisCostShareSubsidy', 'error')} ">
														<label for="newLisCostShareSubsidy"> <g:message
																code="eligHistory.newLisCostShareSubsidy.label"
																default="New LICSS :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.newLisCostShareSubsidy" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="newLisCostShareSubsidy" value="${eligibilityHistoryVar.newLisCostShareSubsidy}"
															from="${['':'', '1': 'High', '2': 'Low', '3': '0', '4': '15%']}" optionValue="value" optionKey="key"
															title="Part D low-income subsidy status(copay level)">
														</g:secureComboBox>														
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'surveyYear', 'error')} ">
														<label for="surveyYear"> <g:message
																code="eligHistory.surveyYear.label"
																default="Survey Year :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="surveyYear"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.surveyYear" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.surveyYear" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.surveyYear != null ? eligibilityHistoryVar?.surveyYear.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.surveyYear)}"
															title = "Field will be used to submit data to CMS via the MMA Transaction type 85"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'premiumWithholdOption', 'error')} ">
														<label for="premiumWithholdOption"> <g:message
																code="eligHistory.premiumWithholdOption.label"
																default="Premium Withhold Option :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.premiumWithholdOption" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="premiumWithholdOption" value="${eligibilityHistoryVar.premiumWithholdOption}"
															from="${['':'', 'D': 'Direct Self-Pay', 'S': 'Deduct from SSA benefits', 'R': 'Deduct from RRB benefits', 'O': 'Deduct from OPM benefits' , 'N': 'No premium applicable']}" 
															optionValue="value" optionKey="key"
															title="Premium Payment Option(Part-C and D)">
														</g:secureComboBox>																
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'uncoveredMonths', 'error')} ">
														<label for="uncoveredMonths"> <g:message
																code="eligHistory.uncoveredMonths.label"
																default="Uncov Months :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="3" type="text" class="numeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uncoveredMonths" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="uncoveredMonths" 
																value="${formatNumber(number: eligibilityHistoryVar?.uncoveredMonths, format: '###,##0')}" 
																title="Count of Total Months without drug coverage."></g:secureTextField>												
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mspStatusFlag', 'error')} ">
														<label for="mspStatusFlag"> <g:message
																code="eligHistory.mspStatusFlag.label"
																default="MSP Status Flag :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mspStatusFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mspStatusFlag" value="${eligibilityHistoryVar.mspStatusFlag}"
															from="${['': 'Null', 'P': 'Medicare Primary payor', 'S': 'Medicare Secondary payor', 'N': 'Non-respondent beneficiary']}" 
															optionValue="value" optionKey="key"
															title="Medicare as Primary/secondary Payor">
														</g:secureComboBox>														
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'contractNumber', 'error')} ">
														<label for="contractNumber"> <g:message
																code="eligHistory.contractNumber.label"
																default="CMS Contract No :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="5"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.contractNumber" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="contractNumber" 
															value="${eligibilityHistoryVar?.contractNumber}" 
															title="Plan Contract Number"></g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lateEnrollPct', 'error')} ">
														<label for="lateEnrollPct"> <g:message
																code="eligHistory.lateEnrollPct.label"
																default="Late Enrl Pct :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="6" type="text" class="amtNumeric"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollPct" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollPct" 
																value="${formatNumber(number: eligibilityHistoryVar?.lateEnrollPct, format: '###,##0.0000')}" 
																title="The CMS Late Enrollment Percent"></g:secureTextField>												
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'mmpOptOutFlag', 'error')} ">
														<label for="mmpOptOutFlag"> <g:message
																code="eligHistory.mmpOptOutFlag.label"
																default="MMP-Opt out Flag :" />
															<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mmpOptOutFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mmpOptOutFlag" value="${eligibilityHistoryVar.mmpOptOutFlag}"
															from="${['':'', 'Y': 'Yes', 'N': 'No']}" 
															optionValue="value" optionKey="key"
															title="Member doesn't want passive enrollment">
														</g:secureComboBox>														
													</div>
												</td>
											</tr>
										<tr><td colspan="4">
										</br>
										</td></tr>
										<tr><td colspan="4"><h4>Premium Rate Information</h4><hr></td></tr>
										
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'partCBeneficiaryPremium', 'error')} ">
														<label for="partCBeneficiaryPremium"> <g:message
																code="eligHistory.partCBeneficiaryPremium.label" default="Part C Benificiary Prem :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partCBeneficiaryPremium" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partCBeneficiaryPremium" 
															value="${formatNumber(number: eligibilityHistoryVar?.partCBeneficiaryPremium, format: '###,##0.00')}" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'partDBeneficiaryPremium', 'error')} ">
														<label for="partDBeneficiaryPremium"> <g:message
																code="eligHistory.partDBeneficiaryPremium.label" default="Part D Benificiary Prem :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDBeneficiaryPremium" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partDBeneficiaryPremium" 
															value="${formatNumber(number: eligibilityHistoryVar?.partDBeneficiaryPremium, format: '###,##0.00')}" ></g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'partDEnrollWaivePenalty', 'error')} ">
														<label for="partDEnrollWaivePenalty"> <g:message
																code="eligHistory.partDEnrollWaivePenalty.label" default="Part D Late Enrollment Penalty Waive :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDEnrollWaivePenalty" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partDEnrollWaivePenalty" 
															value="${formatNumber(number: eligibilityHistoryVar?.partDEnrollWaivePenalty, format: '###,##0.00')}" ></g:secureTextField>																	 
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'partDEnrollLatePenalty', 'error')} ">
														<label for="partDEnrollLatePenalty"> <g:message
																code="eligHistory.partDEnrollLatePenalty.label" default="Part D Late Enroll Penalty :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDEnrollLatePenalty" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partDEnrollLatePenalty" 
															value="${formatNumber(number: eligibilityHistoryVar?.partDEnrollLatePenalty, format: '###,##0.00')}" 
															title="Calculated Part D late enrollment penalty"></g:secureTextField>																	 
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lowIncomePremiumSubsidy', 'error')} ">
														<label for="lowIncomePremiumSubsidy"> <g:message
																code="eligHistory.lowIncomePremiumSubsidy.label"
																default="Low Income Prem Subsidy Change Dt :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
													<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lowIncomePremiumSubsidy"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomePremiumSubsidy" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomePremiumSubsidy" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.lowIncomePremiumSubsidy != null ? eligibilityHistoryVar?.lowIncomePremiumSubsidy.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lowIncomePremiumSubsidy)}"/>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'newLisSubsidy', 'error')} ">
														<label for="newLisSubsidy"> <g:message
																code="eligHistory.newLisSubsidy.label"
																default="New LIS Premium :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.newLisSubsidy" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="newLisSubsidy" 
															value="${formatNumber(number: eligibilityHistoryVar?.newLisSubsidy, format: '###,##0.00')}" 
															title="ZZZZZZZZ9.99 Format; Part D low-income premium Amount"></g:secureTextField>													
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'correctPartDPrem', 'error')} ">
														<label for="correctPartDPrem"> <g:message
																code="eligHistory.correctPartDPrem.label" default="Correct Part D Premium Rate :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.correctPartDPrem" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="correctPartDPrem" 
															value="${formatNumber(number: eligibilityHistoryVar?.correctPartDPrem, format: '###,##0.00')}" 
															title="ZZZZZZZZ9.99 Format amount reported by HPMS"></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'deMinimisDiff', 'error')} ">
														<label for="deMinimisDiff"> <g:message
																code="eligHistory.deMinimisDiff.label" default="De Minimis Differential :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.deMinimisDiff" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="deMinimisDiff" 
															value="${formatNumber(number: eligibilityHistoryVar?.deMinimisDiff, format: '###,##0.00')}" 
															title="Part D de minimis Plans"></g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'partCModPremAmount', 'error')} ">
														<label for="partCModPremAmount"> <g:message
																code="eligHistory.partCModPremAmount.label"
																default="Modified Part C Premium :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="24" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partCModPremAmount" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="partCModPremAmount" 
															value="${formatNumber(number: eligibilityHistoryVar?.partCModPremAmount, format: '###,##0.00')}" 
															title="Part C premium amount reported by HPMS"></g:secureTextField>
													</div>
												</td>
											</tr>
										<tr><td colspan="4">
										</br>
										</td></tr>
									<tr><td colspan="4"><h4>MEMMC Pharmacy</h4><hr></td></tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'rxBin', 'error')} ">
														<label for="rxBin"> <g:message
																code="eligHistory.rxBin.label" default="RX BIN :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="6"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxBin" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="rxBin" 
															value="${eligibilityHistoryVar?.rxBin}"
															title="Card issuer identifier or bank identifying number">
														</g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'rxPcn', 'error')} ">
														<label for="rxPcn"> <g:message
																code="eligHistory.rxPcn.label" default="RX PCN :" />
																<span class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="10"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxPcn" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="rxPcn" 
															value="${eligibilityHistoryVar?.rxPcn}"
															title="Number assigned by processor or 9999999999 if not known"
															onchange="">
														</g:secureTextField>
														<script type="text/javascript">
	   														setDefault('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxPcn');
														</script>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'rxId', 'error')} ">
														<label for="rxId"> <g:message
																code="eligHistory.rxId.label" default="RX ID :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="20"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="rxId" 
															value="${eligibilityHistoryVar?.rxId}"
															title="Part D plan's ID number for beneficiary. Needed for outbound MMA Transaction file.">
														</g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'rxGroup', 'error')} ">
														<label for="rxGroup"> <g:message
																code="eligHistory.rxGroup.label" default="RX Group :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="15"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxGroup" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="rxGroup" 
															value="${eligibilityHistoryVar?.rxGroup}">
														</g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'secondaryRxIndicator', 'error')} ">
														<label for="secondaryRxIndicator"> <g:message
																code="eligHistory.secondaryRxIndicator.label" default="Secondary Rx :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureComboBox
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxIndicator" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxIndicator" value="${eligibilityHistoryVar.secondaryRxIndicator}"
															from="${['Y': 'Beneficiary has secondary drug insurance', 'N': 'Beneficiary does not have secondary drug insurance available' , '': 'Do not know whether beneficiary has secondary drug insurance']}" 
															optionValue="value" optionKey="key" title="Secondary Drug Insurance">
														</g:secureComboBox>		
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'secondaryRxGroup', 'error')} ">
														<label for="secondaryRxGroup"> <g:message
																code="eligHistory.secondaryRxGroup.label" default="Secondary Rx Group ID :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="15"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxGroup" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxGroup" 
															value="${eligibilityHistoryVar?.secondaryRxGroup}"
															title="Secondary Insurance plan's Group ID number">
														</g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'secondaryRxBin', 'error')} ">
														<label for="secondaryRxBin"> <g:message
																code="eligHistory.secondaryRxBin.label" default="Secondary Rx BIN :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="6"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxBin" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxBin" 
															value="${eligibilityHistoryVar?.secondaryRxBin}">
														</g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'secondaryRxPcn', 'error')} ">
														<label for="secondaryRxPcn"> <g:message
																code="eligHistory.secondaryRxPcn.label" default="Secondary RX PCN :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="10"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxPcn" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxPcn" 
															value="${eligibilityHistoryVar?.secondaryRxPcn}">
														</g:secureTextField>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'secondaryRxId', 'error')} ">
														<label for="secondaryRxId"> <g:message
																code="eligHistory.secondaryRxId.label" default="Secondary RX ID :" />

														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="20"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxId" 
															value="${eligibilityHistoryVar?.secondaryRxId}"
															title="Secondary Drug Insurance Plan ID">
														</g:secureTextField>
													</div>
												</td>
											</tr>
										<tr><td colspan="4">
										</br>
										</td></tr>
								<tr><td colspan="4"><h4>Medicare User Defined Fields</h4><hr></td></tr>
										<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'lowIncomeSubsidyLevel', 'error')} ">
														<label for="lowIncomeSubsidyLevel"> <g:message
																code="eligHistory.lowIncomeSubsidyLevel.label"
																default="Subsidy Lvl :" /> 
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="6" type="text" class="amtNumeric"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomeSubsidyLevel" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lowIncomeSubsidyLevel" 
															value="${formatNumber(number: eligibilityHistoryVar?.lowIncomeSubsidyLevel, format: '###,##0.0000')}"
															title="CMS assigned Part D Subsidy low-income level" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'caeUserDate1', 'error')} ">
														<label for="caeUserDate1"> <g:message
																code="eligHistory.caeUserDate1.label"
																default="User Date 1 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="caeUserDate1"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate1" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate1" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.caeUserDate1 != null ? eligibilityHistoryVar?.caeUserDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStopDate)}"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined4', 'error')} ">
														<label for="userDefined4"> <g:message
																code="eligHistory.userDefined4.label"
																default="User Def 4 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined4" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined4" 
															value="${eligibilityHistoryVar?.userDefined4}" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'caeUserDate2', 'error')} ">
														<label for="caeUserDate2"> <g:message
																code="eligHistory.caeUserDate2.label"
																default="User Date 2 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="caeUserDate2"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate2" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate2" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.caeUserDate2 != null ? eligibilityHistoryVar?.caeUserDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.caeUserDate2)}"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined5', 'error')} ">
														<label for="userDefined5"> <g:message
																code="eligHistory.userDefined5.label"
																default="User Def 5 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined5" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined5" 
															value="${eligibilityHistoryVar?.userDefined5}" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDate4', 'error')} ">
														<label for="userDate4"> <g:message
																code="eligHistory.userDate4.label"
																default="User Date 4 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate4"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate4" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate4" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.userDate4 != null ? eligibilityHistoryVar?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate4)}"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined6', 'error')} ">
														<label for="userDefined6"> <g:message
																code="eligHistory.userDefined6.label"
																default="User Def 6 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="30"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined6" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined6" 
															value="${eligibilityHistoryVar?.userDefined6}" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDate5', 'error')} ">
														<label for="userDate5"> <g:message
																code="eligHistory.userDate5.label"
																default="User Date 5 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate5"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate5" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate5" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.userDate5 != null ? eligibilityHistoryVar?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate5)}"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDefined7', 'error')} ">
														<label for="userDefined7"> <g:message
																code="eligHistory.userDefined7.label"
																default="User Def 7 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:secureTextField maxlength="50"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined7" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined7" 
															value="${eligibilityHistoryVar?.userDefined7}" ></g:secureTextField>
													</div>
												</td>
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDate6', 'error')} ">
														<label for="userDate6"> <g:message
																code="eligHistory.userDate6.label"
																default="User Date 6 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate6"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate6" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate6" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.userDate6 != null ? eligibilityHistoryVar?.userDate6.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate6)}"/>
													</div>
												</td>
											</tr>
											<tr>												
												<td class="tdFormElement" style="white-space: nowrap">
													<div
														class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'userDate7', 'error')} ">
														<label for="userDate7"> <g:message
																code="eligHistory.userDate7.label"
																default="User Date 7 :" />
														</label>
													</div>
												</td>
												<td>
													<div class="fieldcontain">
														<g:securejqDatePicker 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate7"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate7" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate7" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.userDate7 != null ? eligibilityHistoryVar?.userDate7.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate7)}"/>
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