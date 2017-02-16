<div class="fms_form_layout_2column">                  
	       <div class="fms_form_column fms_long_labels">

                <label for="effectiveDate"class="control-label fms_required" id="effectiveDate_label" > 
                      <g:message code="eligHistory.effectiveDate.label" default="Effective Date :" />
                </label>

                <div class="fms_form_input">                                                                                                                                                                                                  
                      <g:securejqDatePickerUIUX 
                                      tableName="MEMBER_ELIG_HISTORY" attributeName="effectiveDate" 
                                      dateElementId="eligHistory.${memberMaster?.memberDBID }.effectiveDate" 
                                      dateElementName="eligHistory.${memberMaster?.memberDBID }.effectiveDate" 
                                      datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100',	maxDate:'+10y'" 
                                      dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.effectiveDate)}"
                                      ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
                                      classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker'"
                                      showIconDefault="${isShowCalendarIcon}"/>
                      <div class="fms_form_error" id="effectiveDate_error"></div>
                </div>   


				<label for="dateOfDeath" class="control-label" id="dateOfDeath_label" > 
						<g:message code="eligHistory.dateOfDeath.label" default="DOD :" />
				</label>
				<div class="fms_form_input">                                                                                                                                                                                                  
						<g:securejqDatePickerUIUX 
								tableName="MEMBER_ELIG_HISTORY" attributeName="dateOfDeath" 
								dateElementId="eligHistory.${memberMaster?.memberDBID }.dateOfDeath" 
								dateElementName="eligHistory.${memberMaster?.memberDBID }.dateOfDeath" 
								datePickerOptions="changeMonth:true, changeYear:true, yearRange: '${((eligibilityHistoryVar?.dateOfDeath != null ? 
								eligibilityHistoryVar?.dateOfDeath.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:+0', 
								maxDate:0, numberOfMonths: 1" 
								dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.dateOfDeath)}"
								ariaAttributes="aria-labelledby='dateOfDeath_label' aria-describedby='dateOfDeath_error' aria-required='false'" 
								classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
								showIconDefault="${isShowCalendarIcon}"/>
						<div class="fms_form_error" id="dateOfDeath_error"></div>
				</div> 
					
	                  <label class="control-label fms_required" id="eligStatus_label" for="eligStatus">
	                  	<g:message code="eligHistory.eligStatus.label" default="Elig Status :" />
	                  </label>
	                  <div class="fms_form_input">
	                    <g:secureComboBox class="form-control" disabled="${!elementsEnabled?"true":"false"}"
										name="eligHistory.${memberMaster.memberDBID }.eligStatus" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="eligStatus" value="${eligibilityHistoryVar?.eligStatus}"
										from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
										id="eligStatus"
										aria-labelledby="eligStatus_label"
										aria-describedby="eligStatus_error"
										aria-required="false">
						</g:secureComboBox>	
	                    <div class="fms_form_error" id="eligStatus_error"></div>
	                  </div>					


					<label class="control-label" id="recordStatus_label" for="recordStatus">
						<g:message code="eligHistory.recordStatus.label"  default="Record Sts :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="recordStatus" aria-labelledby="recordStatus_label" aria-describedby="recordStatus_error" 
											aria-required="false" maxlength="15"
											name="eligHistory.${memberMaster.memberDBID }.recordStatus" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="recordStatus" 
											value="${eligibilityHistoryVar?.recordStatus}" 
											disabled="${!elementsEnabled?"true":"false"}"></g:secureTextField>
						<div class="fms_form_error" id="recordStatus_error"></div>
					</div>
						
					<div class="fieldcontain ${hasErrors(bean: eligibilityHistoryVar, field: 'relationshipCode', 'error')} ">
	                  <label class="control-label fms_required" id="relationshipCode_label" for="relationshipCode">
	                  	<g:message code="eligHistory.relationshipCode.label" default="RelationShip Code :" />
	                  </label>
	                </div>  
	                  <div class="fms_form_input">
	                    	<g:secureDiamondDataWindowDetail columnName="relationship_code_fms" 
	                    							dwName="dw_ccont_melig" languageId="0"
													cssClass="form-control"
													htmlElelmentId="eligHistory.${memberMaster.memberDBID }.relationshipCode"
													defaultValue="${eligibilityHistoryVar?.relationshipCode}" blankValue="Relationship Code"
													name="eligHistory.${memberMaster.memberDBID}.relationshipCode" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="relationshipCode" 
													value="${eligibilityHistoryVar?.relationshipCode}"
													id="relationshipCode"
													disable="${!elementsEnabled?"disabled":""}"
													aria-labelledby="relationshipCode_label"
													aria-describedby="relationshipCode_error"
													aria-required="false">
							</g:secureDiamondDataWindowDetail>	
	                    <div class="fms_form_error" id="relationshipCode_error"></div>
	                  </div>

					<label class="control-label fms_required" id="groupId_label" for="groupId">
						<g:message code="eligHistory.groupId.label" default="Group Id :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
					<input class="form-control" type="hidden" name="eligHistory.${memberMaster.memberDBID }.seqGroupId"
						id="eligHistory.${memberMaster.memberDBID }.seqGroupId"
						value="${eligibilityHistoryVar?.seqGroupId}" />
						
					<g:secureTextField class="form-control" maxlength="50" disabled="${!elementsEnabled?"true":"false"}"
						name="eligHistory.${memberMaster.memberDBID }.groupId" 
						id="eligHistory.${memberMaster.memberDBID }.groupId"
						tableName="MEMBER_ELIG_HISTORY" attributeName="groupId" 
						value="${eligibilityHistoryVar?.groupId}"></g:secureTextField>
					<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.groupId"
						   lookupElementName="eligHistory.${memberMaster.memberDBID }.groupId" 
						   lookupElementValue="${eligibilityHistoryVar?.groupId}"
						   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
						   lookupCDOClassAttribute="groupId"
						   htmlElementsToUpdate="eligHistory.${memberMaster.memberDBID }.seqGroupId"
						   htmlElementsToUpdateCDOProperty="seqGroupId"/>						
						<div class="fms_form_error" id="groupId_error"></div>
					</div>

					<label class="control-label fms_required" id="planCode_label" for="planCode">
						<g:message code="eligHistory.planCode.label" default="Plan Code :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
					<input type="hidden" id="dummyabc" name="dummyabc" value="" />
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.planCode" 
							disabled="${!elementsEnabled?"true":"false"}" maxlength="50"
							name="eligHistory.${memberMaster.memberDBID }.planCode" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="planCode" 
							value="${eligibilityHistoryVar?.planCode}"></g:secureTextField>
							<button type="button" id="eligHistory.${memberMaster.memberDBID }.planCode"
								class="btn fms_btn_icon btn-sm fms_form_control_feedback"
								title="Click to do full search."
								onclick="lookupplanId('eligHistory.${memberMaster.memberDBID }.groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', 'eligHistory.${memberMaster.memberDBID }.planCode','dummyabc')">
								<i class="glyphicon glyphicon-search"></i>
							</button>
							<button id="GroupIdAlertInfo" type="button"
								class="btn fms_btn_icon btn-sm groupIdAlertInfo"
								title="Click to reset plan form." data-target="#SearchAlertModalInfo">
								<span class="glyphicon glyphicon-repeat"></span>
							</button>
							<button id="GroupIdAlert" type="button"
								class="btn fms_btn_icon btn-sm groupIdAlert"
								title="Click to reset plan form." data-target="#SearchAlertModal">
								<span class="glyphicon glyphicon-repeat"></span>
							</button>
						<div class="fms_form_error" id="planCode_error"></div>
					</div>

					<label class="control-label" id="covLevelCode_label" for="covLevelCode">
						<g:message code="memberEligSbmtMap.covLevelCode.label" default="Coverage Level:" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="covLevelCode" aria-labelledby="covLevelCode_label" aria-describedby="covLevelCode_error" aria-required="false"
											maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
											name="memberEligSbmtMap.covLevelCode" 
											tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
											value="${memberEligSbmtMap?.get(eligibilityHistoryVar?.seqEligHist)?.covLevelCode}"
											title ="Enter a 3-character coverage level code"></g:secureTextField>						
						<div class="fms_form_error" id="covLevelCode_error"></div>
					</div>


							<label class="control-label" id="riders_label" for="riders">
								<g:message code="eligHistory.dentalLob.label" default="Riders :" />
							</label>
							<div class="fms_form_input fms_multiple_sm">
								<div class="row sm-margin-bottom">
									<div class="col-xs-4">
											<input type="hidden" id="RiderRecordType" name="RiderRecordType" value="R" class="form-control"/>
											<input type="hidden" id="PlanRecordType" name="PlanRecordType" value="P" class="form-control"/>
											<g:secureTextField maxlength="2" size="2" class="form-control" name="eligHistory.${memberMaster.memberDBID }.riderCode1" 
												id="eligHistory.${memberMaster.memberDBID }.riderCode1"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode1"
												value="${eligibilityHistoryVar?.riderCode1}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode1"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode1" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode1}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode1_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode2"
												aria-labelledby="riderCode2_label"
												aria-describedby="riderCode2_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode2"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode2"
												value="${eligibilityHistoryVar?.riderCode2}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode2"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode2" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode2}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode2_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode3"
												aria-labelledby="riderCode3_label"
												aria-describedby="riderCode3_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode3"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode3"
												value="${eligibilityHistoryVar?.riderCode3}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode3"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode3" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode3}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode3_error"></div>
										</div>
										</div>
										
										<div class="row sm-margin-bottom">
											<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode4"
												aria-labelledby="riderCode4_label"
												aria-describedby="riderCode4_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode4"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode4"
												value="${eligibilityHistoryVar?.riderCode4}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode4"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode4" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode4}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode4_error"></div>
										</div>

											<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode5"
												aria-labelledby="riderCode5_label"
												aria-describedby="riderCode5_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode5"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode5"
												value="${eligibilityHistoryVar?.riderCode5}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode5"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode5" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode5}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode5_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode6"
												aria-labelledby="riderCode6_label"
												aria-describedby="riderCode6_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode6"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode6"
												value="${eligibilityHistoryVar?.riderCode6}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode6"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode6" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode6}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode6_error"></div>
										</div>
										</div>
										<div class="row sm-margin-bottom">
											<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode7"
												aria-labelledby="riderCode8_label"
												aria-describedby="riderCode8_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode7"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode7"
												value="${eligibilityHistoryVar?.riderCode7}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode7"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode7" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode7}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode7_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField maxlength="2" size="2" class="form-control" id="eligHistory.${memberMaster.memberDBID }.riderCode8"
												aria-labelledby="riderCode8_label"
												aria-describedby="riderCode8_error" aria-required="false"
												name="eligHistory.${memberMaster.memberDBID }.riderCode8"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode8"
												value="${eligibilityHistoryVar?.riderCode8}" disabled="${!elementsEnabled?"true":"false"}">
											</g:secureTextField>
											<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.riderCode8"
												   lookupElementName="eligHistory.${memberMaster.memberDBID }.riderCode8" 
												   lookupElementValue="${eligibilityHistoryVar?.riderCode8}"
												   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
												   lookupCDOClassAttribute="planRiderCode"
												   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId|RiderRecordType"
												   htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											<div class="fms_form_error" id="riderCode8_error"></div>
										</div>
								</div>
							</div>
					<label class="control-label" id="siteCode_label" for="siteCode">
						<g:message code="eligHistory.siteCode.label" default="Site Code :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.siteCode" 
											maxlength="12" disabled="${!elementsEnabled?"true":"false"}"
											name="eligHistory.${memberMaster.memberDBID }.siteCode" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="siteCode" 
											value="${eligibilityHistoryVar?.siteCode}"></g:secureTextField>
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.siteCode"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.siteCode" 
							   lookupElementValue="${eligibilityHistoryVar?.siteCode}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SiteCodeMaster"
							   lookupCDOClassAttribute="siteCode"/>
						<div class="fms_form_error" id="siteCode_error"></div>
					</div>


					<label class="control-label" id="ipaId_label" for="ipaId">
						<g:message code="eligHistory.ipaId.label" default="IPA Id :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<input type="hidden" name="ipaLevelCode" id="ipaLevelCode" value="1"/>
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.ipaId"
							maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
							name="eligHistory.${memberMaster.memberDBID }.ipaId" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="ipaId" 
							value="${eligibilityHistoryVar?.ipaId}"></g:secureTextField>	
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.ipaId"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.ipaId" 
							   lookupElementValue="${eligibilityHistoryVar?.ipaId}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.IpaMaster"
							   lookupCDOClassAttribute="ipaId"
							   htmlElementsToAddToQuery="ipaLevelCode"
							   htmlElementsToAddToQueryCDOProperty="levelCode"/>
						<div class="fms_form_error" id="ipaId_error"></div>
					</div>


					<label class="control-label" id="pcpChangeReason_label" for="pcpChangeReason">
						<g:message code="eligHistory.pcpChangeReason.label" default="PCP Change Reason :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<input type="hidden" name="PCPReasonType" id="PCPReasonType" value="PC"/>
						<g:secureTextField maxlength="5" name="eligHistory.${memberMaster.memberDBID }.pcpChangeReason"
										id="eligHistory.${memberMaster.memberDBID }.pcpChangeReason" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="pcpChangeReason" 
										value="${eligibilityHistoryVar?.pcpChangeReason}"
										disabled="${!elementsEnabled?"true":"false"}"
										class="form-control"></g:secureTextField>
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.pcpChangeReason"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.pcpChangeReason" 
							   lookupElementValue="${eligibilityHistoryVar?.pcpChangeReason}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
							   lookupCDOClassAttribute="pcpChangeReason"
							   htmlElementsToAddToQuery="PCPReasonType"
							   htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
						<div class="fms_form_error" id="pcpChangeReason_error"></div>
					</div>

					<label class="control-label" id="subscDept_label" for="subscDept">
						<g:message code="eligHistory.subscDept.label" default="Subscriber Dept :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField maxlength="20"
							name="eligHistory.${memberMaster.memberDBID }.subscDept" 
							id="eligHistory.${memberMaster.memberDBID }.subscDept" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="subscDept" 
							value="${eligibilityHistoryVar?.subscDept}"
							disabled="${!elementsEnabled?"true":"false"}" class="form-control">
						</g:secureTextField>							
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.subscDept"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.subscDept" 
							   lookupElementValue="${eligibilityHistoryVar?.subscDept}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupDepartment"
							   lookupCDOClassAttribute="deptNumber"
							   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId"
							   htmlElementsToAddToQueryCDOProperty="seqGroupId"/>
						<div class="fms_form_error" id="subscDept_error"></div>
					</div>


					<label for="hireDate" class="control-label" id="hireDate_label" > 
							<g:message code="eligHistory.hireDate.label" default="Hire Date : " />
					</label>
					<div class="fms_form_input">                                                                                                                                                                                                  
							<g:securejqDatePickerUIUX 
									tableName="MEMBER_ELIG_HISTORY" attributeName="hireDate" 
									dateElementId="eligHistory.${ memberMaster?.memberDBID }.hireDate" 
									dateElementName="eligHistory.${ memberMaster?.memberDBID }.hireDate" 
									datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.hireDate)}"
									ariaAttributes="aria-labelledby='hireDate_label' aria-describedby='hireDate_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/>
							<div class="fms_form_error" id="hireDate_error"></div>
					</div> 

					<label class="control-label" id="prospectivePremiumAmt_label" for="prospectivePremiumAmt">
						<g:message code="eligHistory.prospectivePremiumAmt.label" default="Prospective Prem Amt :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="prospectivePremiumAmt" aria-labelledby="prospectivePremiumAmt_label" aria-describedby="prospectivePremiumAmt_error" aria-required="false" 
											maxlength="18"
											name="eligHistory.${memberMaster.memberDBID }.prospectivePremiumAmt" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="prospectivePremiumAmt" 
											value="${eligibilityHistoryVar?.prospectivePremiumAmt}"
											disabled="${!elementsEnabled?"true":"false"}">
						</g:secureTextField>						
						<div class="fms_form_error" id="prospectivePremiumAmt_error"></div>
					</div>


					<label class="control-label" id="memberClass1_label" for="memberClass1">
						<g:message code="eligHistory.memberClass1.label" default="Member Class1 :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
					<input type="hidden" id="classificationTypeM1" name="classificationTypeM1" value="M1" />
						<g:secureTextField maxlength="5"
							name="eligHistory.${memberMaster.memberDBID }.memberClass1" 
							id="eligHistory.${memberMaster.memberDBID }.memberClass1" 							
							tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass1" 
							value="${eligibilityHistoryVar?.memberClass1}"
							disabled="${!elementsEnabled?"true":"false"}" class="form-control">
						</g:secureTextField>							
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.memberClass1"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.memberClass1" 
							   lookupElementValue="${eligibilityHistoryVar?.memberClass1}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ClassificationCodeMaster"
							   lookupCDOClassAttribute="classificationCode"
							   htmlElementsToAddToQuery="classificationTypeM1"
							   htmlElementsToAddToQueryCDOProperty="classificationType"/>
						<div class="fms_form_error" id="memberClass1_error"></div>
					</div>

					<label class="control-label" id="memberClass2_label" for="memberClass2">
						<g:message code="eligHistory.memberClass2.label" default="Member Class2 :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
					<input type="hidden" id="classificationTypeM2" name="classificationTypeM2" value="M2" />
						 <g:secureTextField maxlength="5"
							name="eligHistory.${memberMaster.memberDBID }.memberClass2" 
							id="eligHistory.${memberMaster.memberDBID }.memberClass2"
							tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass2" 
							value="${eligibilityHistoryVar?.memberClass2}"
							disabled="${!elementsEnabled?"true":"false"}" class="form-control"
							aria-labelledby="memberClass2_label"
							aria-describedby="memberClass2_error" aria-required="false">
						</g:secureTextField>							
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.memberClass2"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.memberClass2" 
							   lookupElementValue="${eligibilityHistoryVar?.memberClass2}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ClassificationCodeMaster"
							   lookupCDOClassAttribute="classificationCode"
							   htmlElementsToAddToQuery="classificationTypeM2"
							   htmlElementsToAddToQueryCDOProperty="classificationType"/>
						<div class="fms_form_error" id="memberClass2_error"></div>
					</div>


				</div>
	            <div class="fms_form_column fms_long_labels">


				<label for="termDate" class="control-label" id="termDate_label" > 
						<g:message code="eligHistory.termDate.label" default="Term Date : " />
				</label>
				<div class="fms_form_input">                                                                                                                                                                                                  
						<g:securejqDatePickerUIUX 
								tableName="MEMBER_ELIG_HISTORY" attributeName="termDate" 
								dateElementId="eligHistory.${memberMaster?.memberDBID }.termDate" 
								dateElementName="eligHistory.${memberMaster?.memberDBID }.termDate" 
								datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
								dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.termDate)}"
								ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
								classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
								showIconDefault="${isShowCalendarIcon}"/>
						<div class="fms_form_error" id="termDate_error"></div>
				</div>
					
					<label class="control-label" id="termReason_label" for="termReason">
						<g:message code="eligHistory.termReason.label" default="Term Reason :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField class="form-control" maxlength="5"
							name="eligHistory.${memberMaster.memberDBID }.termReason"
							id="eligHistory.${memberMaster.memberDBID }.termReason"  
							tableName="MEMBER_ELIG_HISTORY" attributeName="termReason" 
							value="${eligibilityHistoryVar?.termReason}" disabled="${!elementsEnabled?"true":"false"}">
						</g:secureTextField>						
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.termReason"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.termReason" 
							   lookupElementValue="${eligibilityHistoryVar?.termReason}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
							   lookupCDOClassAttribute="reasonCode"/>
						<div class="fms_form_error" id="termReason_error"></div>
					</div>					

					<label class="control-label" id="voidEligFlag_label" for="voidEligFlag">
						<g:message code="eligHistory.voidEligFlag.label"  default="Void Elig :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox disabled="${!elementsEnabled?"true":"false"}"
							name="eligHistory.${memberMaster.memberDBID }.voidEligFlag" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="voidEligFlag" value="${eligibilityHistoryVar?.voidEligFlag}"
							from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
							class="form-control" id="voidEligFlag" aria-labelledby="voidEligFlag_label" aria-describedby="voidEligFlag_error" aria-required="false">
						</g:secureComboBox>	
						<div class="fms_form_error" id="voidEligFlag_error"></div>
					</div>
					
					<label for="benefitStartDate" class="control-label fms_required" id="benefitStartDate_label" > 
							<g:message code="eligHistory.benefitStartDate.label" default="Benefit Start Date :" />
					</label>
					<div class="fms_form_input">                                                                                                                                                                                                  
							<g:securejqDatePickerUIUX 
									tableName="MEMBER_ELIG_HISTORY" attributeName="benefitStartDate" 
									dateElementId="eligHistory.${memberMaster?.memberDBID }.benefitStartDate" 
									dateElementName="eligHistory.${memberMaster?.memberDBID }.benefitStartDate" 
									datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.benefitStartDate)}"
									ariaAttributes="aria-labelledby='benefitStartDate_label' aria-describedby='benefitStartDate_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/>
							<div class="fms_form_error" id="benefitStartDate_error"></div>
					</div>
										
					
					<label class="control-label" id="benefitEndDate_label" for="benefitEndDate">
						<g:message code="memberEligHistoryExtnList.benefitEndDate.label" default="Benefit End Date :"/>
					</label>
					<div class="fms_form_input">
							<g:securejqDatePickerUIUX 
									tableName="MEMBER_ELIG_HISTORY_EXTN" attributeName="benefitEndDate" 
									dateElementId="memberEligHistoryExtnList.benefitEndDate" 
									dateElementName="memberEligHistoryExtnList.benefitEndDate" 
									datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate)}"
									ariaAttributes="aria-labelledby='benefitEndDate_label' aria-describedby='benefitEndDate_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/>									
						<div class="fms_form_error" id="benefitEndDate_error"></div>
					</div>
					
					<label class="control-label" id="subsidizedFlag_label" for="subsidizedFlag">
						<g:message code="eligHistory.subsidizedFlag.label" default="Subsidized Flag :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox class="form-control" id="subsidizedFlag" aria-labelledby="subsidizedFlag_label" aria-describedby="subsidizedFlag_error" aria-required="false"
							name="eligHistory.${memberMaster.memberDBID }.subsidizedFlag"  disabled="${!elementsEnabled?"true":"false"}"
							tableName="MEMBER_ELIG_HISTORY" attributeName="subsidizedFlag" value="${eligibilityHistoryVar?.subsidizedFlag}"
							from="${['N': 'No' , 'Y': 'Yes']}" optionValue="value" optionKey="key">
						</g:secureComboBox>
						<div class="fms_form_error" id="subsidizedFlag_error"></div>
					</div>

					<label class="control-label fms_required" id="lineOfBusiness_label" for="lineOfBusiness">
						<g:message code="eligHistory.lineOfBusiness.label" default="Line Of Business :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField class="form-control" maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
								name="eligHistory.${memberMaster.memberDBID }.lineOfBusiness" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="lineOfBusiness" 
								value="${eligibilityHistoryVar?.lineOfBusiness}"></g:secureTextField>								
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.lineOfBusiness"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.lineOfBusiness" 
							   lookupElementValue="${eligibilityHistoryVar?.lineOfBusiness}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster"
							   lookupCDOClassAttribute="lineOfBusiness" />
						<div class="fms_form_error" id="lineOfBusiness_error"></div>
					</div>

					<label class="control-label fms_required" id="privacyOn_label" for="privacyOn">
						<g:message code="eligHistory.privacyOn.label" default="Privacy On :" />
					</label>
					<div class="fms_form_input">
						<g:secureComboBox
								class="form-control" name="eligHistory.${memberMaster.memberDBID }.privacyOn"  disabled="${!elementsEnabled?"true":"false"}"
								tableName="MEMBER_ELIG_HISTORY" attributeName="privacyOn" value="${eligibilityHistoryVar?.privacyOn}"
								from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key"
								id="privacyOn" aria-labelledby="privacyOn_label" aria-describedby="privacyOn_error" aria-required="false">
						</g:secureComboBox>
						<div class="fms_form_error" id="privacyOn_error"></div>
					</div>

					<label class="control-label" id="dentalLob_label" for="dentalLob">
					<g:message code="eligHistory.dentalLob.label" default="Rider Contract Type :" />
					</label>
					<div class="fms_form_input fms_multiple_sm">
						<div class="row sm-margin-bottom">
							<div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode1"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode1" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode1" 
								value="${eligibilityHistoryVar?.riderContractTypeCode1}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						    <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode2"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode2" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode2" 
								value="${eligibilityHistoryVar?.riderContractTypeCode2}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						   <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode3"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode3" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode3" 
								value="${eligibilityHistoryVar?.riderContractTypeCode3}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						    </div>
						    <div class="row sm-margin-bottom">
						    <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode4"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode4" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode4" 
								value="${eligibilityHistoryVar?.riderContractTypeCode4}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						     <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode5"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode5" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode5"
								value="${eligibilityHistoryVar?.riderContractTypeCode5}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						    <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode6"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode6" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode6" 
								value="${eligibilityHistoryVar?.riderContractTypeCode6}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						    </div>
						    <div class="row sm-margin-bottom">
						    <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode7"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode7" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode7" 
								value="${eligibilityHistoryVar?.riderContractTypeCode7}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						      <div class="col-xs-4">
							<g:secureTextField 
								id="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode8"
								class="form-control" aria-labelledby="dentalLob_label"
								aria-describedby="dentalLob_error" aria-required="false"
								maxlength="2" size="2"
								name="eligHistory.${memberMaster.memberDBID }.riderContractTypeCode8" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode8" 
								value="${eligibilityHistoryVar?.riderContractTypeCode8}"
								disabled="${!elementsEnabled?"true":"false"}">
							</g:secureTextField>
						    </div>
						</div>
					</div>
					
					<label class="control-label" id="panelId_label" for="panelId">
						<g:message code="eligHistory.panelId.label" default="Panel Id :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField maxlength="3" disabled="${!elementsEnabled?"true":"false"}"
							name="eligHistory.${memberMaster.memberDBID }.panelId" 
							id="eligHistory.${memberMaster.memberDBID }.panelId" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="panelId" 
							value="${eligibilityHistoryVar?.panelId}" class="form-control"></g:secureTextField>							
						<fmsui:cdoLookup lookupElementId="eligHistory.${memberMaster.memberDBID }.panelId"
							   lookupElementName="eligHistory.${memberMaster.memberDBID }.panelId" 
							   lookupElementValue="${eligibilityHistoryVar?.panelId}"
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupPanel"
							   lookupCDOClassAttribute="panelId"
							   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqGroupId"
							   htmlElementsToAddToQueryCDOProperty="seqGroupId"/>
						<div class="fms_form_error" id="panelId_error"></div>
					</div>

					<label class="control-label" id="PCPID_label" for="PCPID">
						<g:message code="eligHistory.PCPID.label" default="PCP ID :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:hiddenField name="eligHistory.${memberMaster.memberDBID }.seqProvId" value="${eligibilityHistoryVar?.seqProvId }" disabled="${!elementsEnabled?"true":"false"}"/>
						<%boolean exists = false %>
						<g:if test="${eligibilityHistoryVar?.seqProvId}">
							<g:each in="${provIdList}" var="provId">
								<g:if test="${provId.seqProvId.equals(eligibilityHistoryVar?.seqProvId)}">
									<g:secureTextField  class="form-control" aria-labelledby="PCPID_label" aria-describedby="PCPID_error"
													aria-required="false" readonly="readonly"
													name="providerId" value="${provId.providerId}"
													tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId">
									</g:secureTextField>
									<%exists = true%>
								</g:if>
							</g:each>
						</g:if>
						<g:if test="${exists == false}">
							<g:secureTextField  class="form-control" aria-labelledby="PCPID_label" aria-describedby="PCPID_error"
												aria-required="false" readonly="readonly"
												name="providerId"  value=""
												tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" >
							</g:secureTextField>
						</g:if>	
						
						<fmsui:cdoLookup lookupElementId="providerId"
							   lookupElementName="providerId" 
							   lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ProvMaster"
							   lookupCDOClassAttribute="providerId"
							   htmlElementsToAddToQuery="eligHistory.${memberMaster.memberDBID }.seqProvId"
							   htmlElementsToAddToQueryCDOProperty="seqProvId" />
							   
						<div class="fms_form_error" id="PCPID_error"></div>
					</div>
					
	                  <label class="control-label" id="medicareStatusFlg_label" for="medicareStatusFlg">
	                  	<g:message code="eligHistory.medicareStatusFlg.label" default="Medicare Status Flag :" />
	                  </label>
	                  <div class="fms_form_input">
	                     <g:secureTextField class="form-control" id="medicareStatusFlg" aria-labelledby="medicareStatusFlg_label" aria-describedby="medicareStatusFlg_error" aria-required="false"
	                     					maxlength="12"
											name="eligHistory.${memberMaster.memberDBID }.medicareStatusFlg" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="medicareStatusFlg" 
											value="${eligibilityHistoryVar?.medicareStatusFlg}"
											disabled="${!elementsEnabled?"true":"false"}">
						 </g:secureTextField>
	                     <div class="fms_form_error" id="medicareStatusFlg_error"></div>
	                  </div>

	                  <label class="control-label" id="subscLocation_label" for="subscLocation">
	                  	<g:message code="eligHistory.subscLocation.label" default="Location :" />
	                  </label>
	                  <div class="fms_form_input">
							<g:secureSystemCodeToken
								cssClass="form-control"
								systemCodeType="MELIGLOC" languageId="0"
								tableName="MEMBER_ELIG_HISTORY" attributeName="subscLocation" 
								htmlElelmentId="eligHistory.${memberMaster.memberDBID }.subscLocation"
								blankValue="Location" 
								defaultValue="${eligibilityHistoryVar?.subscLocation}"
								disable="${!elementsEnabled?"disabled":""}" 
								aria-labelledby="subscLocation_label"
								aria-describedby="subscLocation_error"
								aria-required="false">
							</g:secureSystemCodeToken>	
	                    <div class="fms_form_error" id="subscLocation_error"></div>
	                  </div>
					
	                  <label class="control-label" id="csIndicator_label" for="csIndicator">
	                  	<g:message code="eligHistory.csIndicator.label" default="CS Indicator :" />
	                  </label>
	                  <div class="fms_form_input">
							<g:secureSystemCodeToken
								cssClass="form-control"
								systemCodeType="MEMCSIND" languageId="0"
								tableName="MEMBER_ELIG_HISTORY" attributeName="csIndicator" 
								htmlElelmentId="eligHistory.${memberMaster.memberDBID }.csIndicator"
								blankValue="CS Indicator" 
								defaultValue="${eligibilityHistoryVar?.csIndicator}"
								disable="${!elementsEnabled?"disabled":""}"
								aria-labelledby="csIndicator_label"
								aria-describedby="csIndicator_error"
								aria-required="false" >
							</g:secureSystemCodeToken>	
	                    <div class="fms_form_error" id="csIndicator_error"></div>
	                  </div>

 					<label class="control-label" id="user_defined_1_t_label" for="user_defined_1_t">
						<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" defaultText="User Defined 1"/>
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.userDefined1" aria-labelledby="user_defined_1_t_label" aria-describedby="user_defined_1_t_error" aria-required="false" 
											name="eligHistory.${memberMaster.memberDBID }.userDefined1" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined1" 
											value="${eligibilityHistoryVar?.userDefined1}"
											disabled="${!elementsEnabled?"true":"false"}">
						</g:secureTextField>
						<div class="fms_form_error" id="user_defined_t_1_error"></div>
					</div>

					<label class="control-label" id="user_defined_2_t_label" for="user_defined_2_t">
						<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"/>
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.userDefined2"" aria-labelledby="user_defined_2_t_label" aria-describedby="user_defined_2_t_error" aria-required="false"
											name="eligHistory.${memberMaster.memberDBID }.userDefined2" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined2" 
											value="${eligibilityHistoryVar?.userDefined2}"
											disabled="${!elementsEnabled?"true":"false"}">
										</g:secureTextField>
						<div class="fms_form_error" id="user_defined_2_t_error"></div>
					</div>

					<label class="control-label" id="user_defined_3_t_label" for="user_defined_3_t">
						<g:userDefinedFieldLabel winId="MEMBR" datawindowId ="dw_melig_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"/>
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="eligHistory.${memberMaster.memberDBID }.userDefined3" aria-labelledby="user_defined_3_t_label" aria-describedby="user_defined_3_t_error" aria-required="false"
											name="eligHistory.${memberMaster.memberDBID }.userDefined3" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined3" 
											value="${eligibilityHistoryVar?.userDefined3}"
											disabled="${!elementsEnabled?"true":"false"}">
						</g:secureTextField>
						<div class="fms_form_error" id="user_defined_3_t_error"></div>
					</div>



				</div>
	           </div>