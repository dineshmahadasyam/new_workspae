<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?true:false}" />
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<g:set var="appContext" bean="grailsApplication"/>
<g:render template="memberMedicareEnrollInfoValidations" />

<input type="hidden" name="editType" value="MEDICARE_ENROLLMENT_INFO" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />

        
    <div id="fms_content_body">
   	 <div class="right-corner" align="right">MEMMC</div>  
   	 
   	 <%-- Error messages start--%>
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
	<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
	<%-- Error messages end--%>
   	 
   	 
    	 <div id="DataTableSection">
         	  <div class="fms_widget form-inline">
         
            <label class="control-label bold" id="SelectMember_label" for="SelectMember">Select Member:</label>

            <select id="memberIdSelectList"  class="form-control" name="memberIdlist" onChange="showAddress(this)" >
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
		</div>  
		   

        <table>
        	<tr>
        		<td>
					<div id="addAddressDiv" style="display: none"></div>
				</td>
			<td>
				<div id="releaseSelect" style="display: none">
					<input type="button" name="enableMemberSelection" value="Enable Member Selection"
					onClick="releaseMemberSelection()">
				</div>
			</td>
		</tr>
	</table>
		
		
		
		
<div class="fms_required_legend fms_required">= required</div> 		
<div id="dummy">&nbsp;</div>
<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
		
		
		<div id="SearchResults" class="fms_widget">
           <div class="fms_widget">
           
           <div class="row bottom-margin-sm">
                  <div class="col-xs-6">
                    <button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
                  </div>
                  <div class="col-xs-6 text-right">
					<button id="BtnSave" class="btn btn-primary btn-sm BtnSaveModal" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
					<button id="BtnUndo" class="btn btn-default btn-sm BtnUndoModal" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
				</div>
       	   </div>
			 <div class="fms_table_wrapper">
                <table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
                  <thead>
                    <tr role="row" class="tablesorter-headerRow">
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Effective Date </th>
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Term Date</th>
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">M</th>
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">D</th>
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">H</th>
                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">I</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">E</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Wa</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">W</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">P</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Part A</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Part B</th>
					  <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Actions</th>
                    </tr>
                  </thead>
		<tfoot>
              
         </tfoot> 
              
              
     <tbody aria-live="polite" aria-relevant="all">
     
           <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i" var="eligibilityHistoryVar">
				<input type="hidden" name="seq_prem_id_${i}" value="${eligibilityHistoryVar.seqEligHist }">
				<input type="hidden" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount" value="${eligibilityHistoryVar.seqEligHist }">
                 
                <tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
	                 <td><g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.effectiveDate}" /></td>
                      <td><g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.termDate}" /></td>
                      <td>${eligibilityHistoryVar.mcareMedicaidFlag}</td>
                      <td>${eligibilityHistoryVar.mcareDisableFlag}</td>
                      <td>${eligibilityHistoryVar.mcareHospiceFlag}</td>
                      <td>${eligibilityHistoryVar.mcareInstitutionalFlag}</td>
                      <td>${eligibilityHistoryVar.mcareEsrdFlag}</td>
                      <td>${eligibilityHistoryVar.mcareWorkingAgedFlag}</td>
                      <td>${eligibilityHistoryVar.entMcareWelfareFlg}</td>
                      <td>${eligibilityHistoryVar.entMcarePipdcgFactor}</td>
                      <td>${eligibilityHistoryVar.entMcarePartAFlg}</td>
                      <td>${eligibilityHistoryVar.entMcarePartBFlg}</td>
                <td>
                
                <button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                <button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
                        							
                </td>
       	</tr> 
     
        <tr id="Row2Child" class="tablesorter-childRow">
         	<td colspan="14" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.toggleFields" class="" style="display:none;">
                   
 			<div class="fms_widget">
                <fieldset>
                  <legend>Entitlement Information</legend>

                  <div class="fms_form_layout_2column">                  
                    <div class="fms_form_column fms_very_long_labels">
						
						
						 <label class="control-label" id="mcareMedicaidFlag_label" for="mcareMedicaidFlag">
						 <g:message code="eligHistory.mcareMedicaidFlag.label" default="Medicaid :" />
						 </label>
                            <div class="fms_form_input">
                              <g:secureTextField maxlength="2" type="text" class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareMedicaidFlag" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="mcareMedicaidFlag" 
									value="${eligibilityHistoryVar.mcareMedicaidFlag}"
									title="Choose Y if Medicaid, N if not"
									readonly="readonly">
							</g:secureTextField>
						    <div class="fms_form_error" id="mcareMedicaidFlag_error"></div>
                         </div>
						
			
		         		 <label class="control-label" id="mcareHospiceFlag_label" for="mcareHospiceFlag">
		         		 <g:message code="eligHistory.mcareHospiceFlag.label" default="Hospice :" />
		         		 </label>
		         		    <div class="fms_form_input">
                              <g:secureTextField maxlength="2" type="text" class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareHospiceFlag"  
									tableName="MEMBER_ELIG_HISTORY" attributeName="mcareHospiceFlag" 
									value="${eligibilityHistoryVar.mcareHospiceFlag}"
									title="Choose Y if Hospice, N if not"
									readonly="readonly">
							  </g:secureTextField>
		           			<div class="fms_form_error" id="mcareHospiceFlag_error"></div>          
		       			 </div>
       				 
       				 
		         		 <label class="control-label" id="mcareNhcFlag_label" for="mcareNhcFlag">
		         		 <g:message	code="eligHistory.mcareNhcFlag.label" default="NHC :" />
		         		 </label>
		         		    <div class="fms_form_input">
                              <g:secureTextField maxlength="2" type="text" class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareNhcFlag" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="mcareNhcFlag" 
									value="${eligibilityHistoryVar.mcareNhcFlag}"
									readonly="readonly" 
									title="Nursing Home Candidate">
							  </g:secureTextField>
		           			<div class="fms_form_error" id="mcareNhcFlag_error"></div>             
		       			 </div>
       				 
       				 	 
		         		 <label class="control-label" id="mcareWorkingAgedFlag_label" for="mcareWorkingAgedFlag">
		         		 <g:message code="eligHistory.mcareWorkingAgedFlag.label" default="Working Aged :" />
		         		 </label>
		         		    <div class="fms_form_input">
                              <g:secureTextField maxlength="2" type="text" class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareWorkingAgedFlag" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="mcareWorkingAgedFlag" 
									value="${eligibilityHistoryVar.mcareWorkingAgedFlag}"
									title="Choose Y if Working Aged, N if not"
									readonly="readonly">
							  </g:secureTextField>
		          			<div class="fms_form_error" id="mcareWorkingAgedFlag_error"></div> 
		           		 </div>
       				 
       				  
		         		 <label class="control-label fms_required" id="entMcarePipdcgFactor_label" for="entMcarePipdcgFactor">
		         		 <g:message code="eligHistory.entMcarePipdcgFactor.label" default="PIP-DCG :" />
						 
		         		 </label>
		         		   <div class="fms_form_input">
                              <g:secureTextField maxlength="2" type="text" class="form-control numeric "
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePipdcgFactor" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePipdcgFactor" 
															value="${formatNumber(number: eligibilityHistoryVar?.entMcarePipdcgFactor, format: '###,##0')}" 
															title="Member is under PIP DCG care">
							  </g:secureTextField>
		                   <div class="fms_form_error" id="entMcarePipdcgFactor_error"></div>
		                 </div> 
		       	
		       	
		       	  		<label class="control-label fms_required" id="entMcarePartBFlg_label" for="entMcarePartBFlg"> 
							 			<g:message	code="eligHistory.entMcarePartBFlg.label" default="Part B :" />
						</label>
						<div class="fms_form_input">
							<g:secureComboBox class="form-control "
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePartBFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePartBFlg" value="${eligibilityHistoryVar.entMcarePartBFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member is under Part B coverage">
														</g:secureComboBox>	
							<div class="fms_form_error" id="SelectMember_error"></div>
						</div>
		     
       				 	<label class="control-label" for="medicarePartBEnrollDate" id="medicarePartBEnrollDate_label">
       				 	<g:message code="eligHistory.medicarePartBEnrollDate.label" default="Medicare Part B Enrl Dt :" />	
       				 	</label>                              
                        <div class="fms_form_input">
                                
                                
						<g:securejqDatePickerUIUX tableName="MEMBER_ELIG_HISTORY" attributeName="medicarePartBEnrollDate"
											dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartBEnrollDate" 
											dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartBEnrollDate" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.medicarePartBEnrollDate != null ? eligibilityHistoryVar?.medicarePartBEnrollDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.medicarePartBEnrollDate != null ? eligibilityHistoryVar?.medicarePartBEnrollDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}' " 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.medicarePartBEnrollDate)}"
											title = "Effective Date when Part B Coverage began"
											ariaAttributes="aria-labelledby='medicarePartBEnrollDate_label' aria-describedby='medicarePartBEnrollDate_error' aria-required='false'" 
					                     	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}"/>
                               
                                                                 
                                <div class="fms_form_error" id="medicarePartBEnrollDate_error"></div>
                        </div>  
                              
                               <label class="control-label" for="revisedEndDate" id="revisedEndDate_label">
                               <g:message code="eligHistory.revisedEndDate.label" default="Revised End Dt :" />
                               </label>                              
                              <div class="fms_form_input">
                                
                               <g:securejqDatePickerUIUX 
																tableName="MEMBER_ELIG_HISTORY" attributeName="revisedEndDate"
																dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.revisedEndDate" 
																dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.revisedEndDate" 
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.revisedEndDate != null ? eligibilityHistoryVar?.revisedEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.revisedEndDate != null ? eligibilityHistoryVar?.revisedEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.revisedEndDate)}"
																title = "New end date when Gap enrollment is accepted"
																ariaAttributes="aria-labelledby='revisedEndDate_label' aria-describedby='revisedEndDate_error' aria-required='false'" 
										                     	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="revisedEndDate_error"></div>
                              </div>  
                              
                               <label class="control-label" for="endDate" id="endDate_label">
                               <g:message code="eligHistory.endDate.label" default="End Dt :" />
                               </label>                              
                              <div class="fms_form_input">
                                
                               <g:securejqDatePickerUIUX  
															tableName="MEMBER_ELIG_HISTORY" attributeName="endDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.endDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.endDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.endDate != null ? eligibilityHistoryVar?.endDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.endDate != null ? eligibilityHistoryVar?.endDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.endDate)}"
															title = "End Dt on the gap enrollment transaction"
															ariaAttributes="aria-labelledby='endDate_label' aria-describedby='endDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="endDate_error"></div>
                              </div>

                            </div>
                            
                  
                  <div class="fms_form_column fms_very_long_labels">  
                  
                  
                           
         			 <label class="control-label" id="mcareDisableFlag_label" for="mcareDisableFlag">
         			 <g:message	code="eligHistory.mcareDisableFlag.label" default="Disabled :" />
         			 </label>
         			 <div class="fms_form_input">
          			    <g:secureTextField maxlength="2" type="text" class="form-control "
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareDisableFlag" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="mcareDisableFlag" 
											value="${eligibilityHistoryVar.mcareDisableFlag}"
											title="Choose Y if Disabled, N if not"
											readonly="readonly">
						</g:secureTextField>
          			    <div class="fms_form_error" id="mcareDisableFlag_error"></div>
          			 </div>
       				 
       				 
         			 <label class="control-label" id="mcareInstitutionalFlag_label" for="mcareInstitutionalFlag">
         			 <g:message code="eligHistory.mcareInstitutionalFlag.label" default="Institutional :" />
         			 </label>
         			 <div class="fms_form_input">
          			    <g:secureTextField maxlength="2" type="text" class="form-control "
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareInstitutionalFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareInstitutionalFlag" 
															value="${eligibilityHistoryVar.mcareInstitutionalFlag}"
															title="Choose Y if Institutional, N if not"
															readonly="readonly">
						</g:secureTextField>
           			    <div class="fms_form_error" id="mcareInstitutionalFlag_error"></div>    
       				 </div>
       				 
       				
         			 <label class="control-label" id="mcareEsrdFlag_label" for="mcareEsrdFlag">
         			 <g:message code="eligHistory.mcareEsrdFlag.label" default="ESRD :" />
         			 </label>
         			 <div class="fms_form_input">
          			      <g:secureTextField maxlength="2" type="text" class="form-control "
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareEsrdFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcareEsrdFlag" 
															value="${eligibilityHistoryVar.mcareEsrdFlag}"
															readonly="readonly" 
															title="End State Renal Disease">
						   </g:secureTextField>
           			      <div class="fms_form_error" id="mcareInstitutionalFlag_error"></div>  
       				 </div>
       				 
       				 
       				 
       				  
         			 <label class="control-label  fms_required" id="entMcareWelfareFlg_label" for="entMcareWelfareFlg">
         			 <g:message	code="eligHistory.entMcareWelfareFlg.label" default="Welfare :" />
					 
         			 </label>
          			 <div class="fms_form_input">	
           			 <g:secureComboBox class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcareWelfareFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcareWelfareFlg" value="${eligibilityHistoryVar.entMcareWelfareFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member Currently on Welfare">
					 </g:secureComboBox>	
					<div class="fms_form_error" id="SelectMember_error"></div>
       				</div>
       				 
       				
       				<label class="control-label fms_required" id="entMcarePartAFlg_label" for="entMcarePartAFlg"> 
					<g:message code="eligHistory.entMcarePartAFlg.label" default="Part A :" />
                    </label>
                    <div class="fms_form_input">
					<g:secureComboBox class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.entMcarePartAFlg" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="entMcarePartAFlg" value="${eligibilityHistoryVar.entMcarePartAFlg}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member is under Part A coverage">
					</g:secureComboBox>
					<div class="fms_form_error" id="SelectMember_error"></div>
					</div>
       				 
       				  
       				  
       				  <label class="control-label  fms_required" for="medicarePartAEffectDate" id="medicarePartAEffectDate_label">
       				  <g:message code="eligHistory.medicarePartAEffectDate.label" default="Medicare Part A Eff Dt :" />
					  
       				  </label>                              
                        <div class="fms_form_input">
								
								<g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="medicarePartAEffectDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicarePartAEffectDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.medicarePartAEffectDate != null ? eligibilityHistoryVar?.medicarePartAEffectDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.medicarePartAEffectDate != null ? eligibilityHistoryVar?.medicarePartAEffectDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.medicarePartAEffectDate)}"
															title = "Effective Date when Part A Coverage began"
															ariaAttributes="aria-labelledby='medicarePartAEffectDate_label' aria-describedby='medicarePartAEffectDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
								
                                <div class="fms_form_error" id="medicarePartAEffectDate_error"></div>
                        </div> 
                              
                          
                               <label class="control-label" for="mcarePartABTermDate" id="mcarePartABTermDate_label">
                               <g:message code="eligHistory.mcarePartABTermDate.label" default="Medicare Part A, B Term Dt:" />
                               </label>                              
                              <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX
															tableName="MEMBER_ELIG_HISTORY" attributeName="mcarePartABTermDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcarePartABTermDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcarePartABTermDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.mcarePartABTermDate != null ? eligibilityHistoryVar?.mcarePartABTermDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.mcarePartABTermDate != null ? eligibilityHistoryVar?.mcarePartABTermDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.mcarePartABTermDate)}"
															title = "Term Dt of Medicare Part A and Part B"
															ariaAttributes="aria-labelledby='mcarePartABTermDate_label' aria-describedby='mcarePartABTermDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="mcarePartABTermDate_error"></div>
                              </div>  
                              
                               <label class="control-label" for="dialysisEndDate" id="dialysisEndDate_label">
                               <g:message code="eligHistory.dialysisEndDate.label" default="Dialysis End Dt :" />
                               </label>                              
                               <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="dialysisEndDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dialysisEndDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dialysisEndDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.dialysisEndDate != null ? eligibilityHistoryVar?.dialysisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.dialysisEndDate != null ? eligibilityHistoryVar?.dialysisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.dialysisEndDate)}"
															title = "End Dt on the gap enrollment transaction"
															ariaAttributes="aria-labelledby='dialysisEndDate_label' aria-describedby='dialysisEndDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="dialysisEndDate_error"></div>
                              </div>  
                              <label class="control-label" id="medicareNo_label" for="medicareNo">
		         			 	<g:message	code="memberMaster.medicareNo.label" default="Medicare / HIC # :" />
		         			 </label>
		         			 <div class="fms_form_input">
		          			    <g:secureTextField maxlength="12" type="text" class="form-control alphanum"
													name="memberMaster.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicareNo" 
													tableName="MEMBER_MASTER" attributeName="medicareNo" 
													value="${memberEnrollmentMaster.get(memberDBID).medicareNo}">
								</g:secureTextField>
		          			    <div class="fms_form_error" id="medicaidNo_error"></div>
		          			 </div>
                           </div>
                          </div>                    
                        </fieldset>
                      
                      </div>
                      
                      
                      <div class="fms_widget">
                  
                      <fieldset>
                          <legend><h3>Demographics</h3></legend>

                          <div class="fms_form_layout_2column">                  
                            <div class="fms_form_column fms_very_long_labels">

                            
         			 <label class="control-label" id="mcareStateCode_label" for="mcareStateCode">
         			 <g:message	code="eligHistory.mcareStateCode.label"	default="CMS State Cd :" />
         			 </label>
          				<div class="fms_form_input">
          			      <g:secureTextField maxlength="2" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareStateCode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="mcareStateCode" 
														value="${eligibilityHistoryVar?.mcareStateCode}"
														readonly="readonly" 
														title="State Code">
													</g:secureTextField>
                         <div class="fms_form_error" id="mcareStateCode_error"></div>
                        </div>        
       				 
       				 
       				 
       				
         		    <label class="control-label  fms_required" id="geocode_label" for="geocode">
         		    <g:message code="eligHistory.geocode.label"	default="Geo Code :" />
					
         		    </label>
         		       <div class="fms_form_input">
          			      
          			      <g:secureTextField maxlength="5" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.geocode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="geocode" 
														value="${eligibilityHistoryVar?.geocode}"
														title="CMS assigned Geo code for county">
						   </g:secureTextField>
          			      
                          <div class="fms_form_error" id="geocode_error"></div>
                       </div> 
       				 

					
         		    <label class="control-label  fms_required" id="pbpSegmentNumber_label" for="pbpSegmentNumber">
         		    <g:message code="eligHistory.pbpSegmentNumber.label" default="PBP Segment ID :" />
					
         		    </label>
         		      <div class="fms_form_input">
          			      
          			      <g:secureTextField maxlength="3" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpSegmentNumber" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="pbpSegmentNumber" 
														value="${eligibilityHistoryVar?.pbpSegmentNumber}"
														title="PBP by geographic boundaries. Needed for outbound MMA Transaction file">
						  </g:secureTextField>
          			      
                         <div class="fms_form_error" id="pbpSegmentNumber_error"></div>
                      </div> 
                      
                    
         			 <label class="control-label  fms_required" id="overrideFlag_label" for="overrideFlag">
         			 <g:message	code="eligHistory.overrideFlag.label" default="Override Flag :" />
					 
         			 </label>
                                  <div class="fms_form_input">
				                     <g:secureComboBox
				                     						class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.overrideFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="overrideFlag" value="${eligibilityHistoryVar.overrideFlag}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Flag indicates to bypass edit for a member">
									 </g:secureComboBox>
														<div class="fms_form_error" id="SelectMember_error"></div>													
													</div>
					             
       				 
       				    <label class="control-label" for="pbpEffectiveDate" id="pbpEffectiveDate_label">
       				    <g:message code="eligHistory.pbpEffectiveDate.label" default="PBP Eff Dt :" />
       				    </label>                              
                              <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="pbpEffectiveDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpEffectiveDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpEffectiveDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.pbpEffectiveDate != null ? eligibilityHistoryVar?.pbpEffectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.pbpEffectiveDate != null ? eligibilityHistoryVar?.pbpEffectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.pbpEffectiveDate)}"
															title = "Date the member acknowledged or signed."
															ariaAttributes="aria-labelledby='pbpEffectiveDate_label' aria-describedby='pbpEffectiveDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="pbpEffectiveDate_error"></div>
                              </div>  
                             
       				 
							
					
         		 <label class="control-label" id="riskAdjusterFactorA" for="riskAdjusterFactorA">
         		 <g:message code="eligHistory.riskAdjusterFactorA.label" default="Risk Adj Factor A :" />
         		 </label>
         		 <div class="fms_form_input">
					<g:secureTextField maxlength="7" type="text" class="form-control amtNumeric" 
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riskAdjusterFactorA" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riskAdjusterFactorA" 
																value="${formatNumber(number: eligibilityHistoryVar?.riskAdjusterFactorA, format: '###,##0.0000')}" 
																title="Risk adjuster factor for Part A">
					</g:secureTextField>																					
					<div class="fms_form_error" id="riskAdjusterFactorA_error"></div>								
					</div>
       				 
       				 
				    <label class="control-label" for="appReceivedDate" id="appReceivedDate_label">
				    <g:message code="eligHistory.appReceivedDate.label"	default="CMS Application Dt :" />
				    </label>                              
                    <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="appReceivedDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.appReceivedDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.appReceivedDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.appReceivedDate != null ? eligibilityHistoryVar?.appReceivedDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.appReceivedDate != null ? eligibilityHistoryVar?.appReceivedDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.appReceivedDate)}"
															title = "Application Received Dt"
															ariaAttributes="aria-labelledby='appReceivedDate_label' aria-describedby='appReceivedDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                
                                <div class="fms_form_error" id="appReceivedDate_error"></div>
                              </div>  
       				 
       				
         		    <label class="control-label" id="residenceScc_label" for="residenceScc">
         		    <g:message code="eligHistory.residenceScc.label" default="Residence SCC :" />
         		    </label>
         		    <div class="fms_form_input">
          			      <g:secureTextField maxlength="5" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.residenceScc" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="residenceScc" 
															value="${eligibilityHistoryVar?.residenceScc}"
															title="Beneficiary Residence State and County Code">
														</g:secureTextField>
                         <div class="fms_form_error" id="residenceScc_error"></div>
                      </div> 
       				 
       				 
       				 
					
         		 <label class="control-label" id="cmsDisenrollmentReasonCode_label" for="cmsDisenrollmentReasonCode">
         		 <g:message	code="eligHistory.cmsDisenrollmentReasonCode.label" default="CMS Disenrl Rsn Code:" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="2" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.cmsDisenrollmentReasonCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="cmsDisenrollmentReasonCode" 
															value="${eligibilityHistoryVar?.cmsDisenrollmentReasonCode}"
															title="CMS Disenrollment Reason Code">
														</g:secureTextField>
                         <div class="fms_form_error" id="cmsDisenrollmentReasonCode_error"></div>
                      </div> 
       				 
       				 
       				  
         			 <label class="control-label  fms_required" id="uiInitiatedChange_label" for="uiInitiatedChange">
         			 <g:message	code="eligHistory.uiInitiatedChange.label" default="UI Initiated :" />
					 </label>
          				<div class="fms_form_input">
           			  	
           			  	<g:secureComboBox
           			  				class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiInitiatedChange" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="uiInitiatedChange" value="${eligibilityHistoryVar.uiInitiatedChange}"
									from="${['':'', '0': '0', '1':'1']}" optionValue="value" optionKey="key"
									title="0=Transaction intiated from other than UI, 1=UI Initiated Transaction">
						</g:secureComboBox>
           			  			 
						<div class="fms_form_error" id="uiInitiatedChange_error"></div>
													
						</div> 
						
       				 
       				 <label class="control-label" for="attemptedEnrollEffDt" id="attemptedEnrollEffDt_label">
       				 <g:message	code="eligHistory.attemptedEnrollEffDt.label" default="Attempted Enroll Eff Dt :" />
       				 </label>                              
                              <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="attemptedEnrollEffDt"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.attemptedEnrollEffDt" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.attemptedEnrollEffDt" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.attemptedEnrollEffDt != null ? eligibilityHistoryVar?.attemptedEnrollEffDt.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.attemptedEnrollEffDt != null ? eligibilityHistoryVar?.attemptedEnrollEffDt.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.attemptedEnrollEffDt)}"
															title = "The effective date of an enrollment transaction that was submitted but rejected."
															ariaAttributes="aria-labelledby='attemptedEnrollEffDt_label' aria-describedby='attemptedEnrollEffDt_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="attemptedEnrollEffDt_error"></div>
                              </div>  
                     
                     
         			 <label class="control-label  fms_required" id="uiUserOrgDesignation_label" for="uiUserOrgDesignation">
         			 	<g:message	code="eligHistory.uiUserOrgDesignation.label" default="UI User Org :" />
					 </label>
	   				<div class="fms_form_input">
   			  			<g:secureComboBox
   			  				class="form-control"
							name="eligHistory.${memberDBID }?.${eligibilityHistoryVar?.seqEligHist}.uiUserOrgDesignation" 
							cssClass="form-control"
							tableName="MEMBER_ELIG_HISTORY" attributeName="uiUserOrgDesignation" value="${eligibilityHistoryVar?.uiUserOrgDesignation}"
							from="${['02':'Regional Office', '03': 'Central Office', ' ': 'Not UI transaction']}" optionValue="value" optionKey="key">
						</g:secureComboBox>														
					</div>  

   				<div class="fms_widget form-inline">
         		 <label class="control-label" id="prevPartDContractPbp_label" for="prevPartDContractPbp">
         		 <g:message code="eligHistory.prevPartDContractPbp.label" default="Previous Contract/PBP :" />
         		</label>
         		  <div class="fms_form_input">
          			      
          			      <g:secureTextField maxlength="3" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.prevPartDContractPbp" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="prevPartDContractPbp" 
															value="${eligibilityHistoryVar?.prevPartDContractPbp}"
															title="CCCCCPPP Format CCCCC = Contract Number PPP = Plan Benefit Package (PBP) Number">
						  </g:secureTextField>
          			      
                         <div class="fms_form_error" id="prevPartDContractPbp_error"></div>
                      </div> 
       				 </div>
                   </div>     
                            
                                     
                    <div class="fms_form_column fms_very_long_labels">
                    
                    
         		 <label class="control-label" id="mcareCountyCode_label" for="mcareCountyCode">
         		 <g:message code="eligHistory.mcareCountyCode.label" default="CMS County Cd :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="3" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mcareCountyCode" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="mcareCountyCode" 
														value="${eligibilityHistoryVar?.mcareCountyCode}"
														readonly="readonly"
														title="County Code">
													</g:secureTextField>
                         <div class="fms_form_error" id="mcareCountyCode_error"></div>
                  </div> 
       				 
       				 
       				
         		 <label class="control-label  fms_required" id="pbp_label" for="pbp">
         		 <g:message	code="eligHistory.pbp.label" default="PBP :" />
				 
         		 </label>
         		  <div class="fms_form_input">
          			      
          			      <g:secureTextField maxlength="3" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbp" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="pbp" 
														value="${eligibilityHistoryVar?.pbp}"
														title="Plan Benefit Package assigned by CMS"
														>
						  </g:secureTextField>
          			      
                         <div class="fms_form_error" id="pbp_error"></div>
                  </div> 
       				
       				
         			 <label class="control-label  fms_required" id="longTermInstFlag_label" for="longTermInstFlag">
         			 <g:message	code="eligHistory.longTermInstFlag.label" default="L T Inst  Flag :" />
         			 </label>
         			 <div class="fms_form_input">
           			                  <g:secureComboBox class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.longTermInstFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="longTermInstFlag" value="${eligibilityHistoryVar.longTermInstFlag}"
															from="${['N': 'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
															title="Member choice in an institution for long term">
									  </g:secureComboBox>
														<div class="fms_form_error" id="SelectMember_error"></div>													
													</div>
												
       				 
       				 
         		 <label class="control-label" id="pbpAcknowledgeIndicator_label" for="pbpAcknowledgeIndicator">
         		  <g:message code="eligHistory.pbpAcknowledgeIndicator.label" default="PBP Acknowl Ind :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="1" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pbpAcknowledgeIndicator" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="pbpAcknowledgeIndicator" 
															value="${eligibilityHistoryVar?.pbpAcknowledgeIndicator}"
															title="Indicates that the member has acknowledged a PBP change.">
						  </g:secureTextField>
                         <div class="fms_form_error" id="pbpAcknowledgeIndicator_error"></div>
                      </div> 
       				
       				 
       				 
         		 <label class="control-label" id="oldPlanBenefitPackageId_label" for="oldPlanBenefitPackageId">
         		 <g:message	code="eligHistory.oldPlanBenefitPackageId.label" default="Prior PBP :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="3" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.oldPlanBenefitPackageId" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="oldPlanBenefitPackageId" 
															value="${eligibilityHistoryVar?.oldPlanBenefitPackageId}"
															title="Prior PBP number; present only when transaction type code is 71">
						  </g:secureTextField>	
                         <div class="fms_form_error" id="oldPlanBenefitPackageId_error"></div>
                      </div> 
       			
       			
         		 <label class="control-label" id="riskAdjusterFactorB" for="riskAdjusterFactorB">
         		 <g:message	code="eligHistory.riskAdjusterFactorB.label" default="Risk Adj Factor B :" />
         		 </label>
         		 <div class="fms_form_input">
					<g:secureTextField maxlength="7" type="text" class="form-control amtNumeric" 
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riskAdjusterFactorB" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="riskAdjusterFactorB" 
																value="${formatNumber(number: eligibilityHistoryVar?.riskAdjusterFactorB, format: '###,##0.0000')}" 
																title="Risk adjuster factor for Part B">
					</g:secureTextField>
					<div class="fms_form_error" id="riskAdjusterFactorB_error"></div>						
       				 </div>
       				 
       			
       			
         			 <label class="control-label" id="outOfAreaFlag" for="outOfAreaFlag">
         			 <g:message code="eligHistory.outOfAreaFlag.label" default="Out of Area :" />
         			 </label>
          				<div class="fms_form_input">
       			      <g:secureTextField maxlength="1" class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.outOfAreaFlag" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="outOfAreaFlag" 
											value="${eligibilityHistoryVar?.outOfAreaFlag}"
											title="MMCS Data file ended with position 133.">
					  </g:secureTextField>
														<div class="fms_form_error" id="SelectMember_error"></div>													
													</div>
												
       				 
       				
         		 <label class="control-label" id="ssaDistrictOfficeNumber_label" for="ssaDistrictOfficeNumber">
         		 <g:message code="eligHistory.ssaDistrictOfficeNumber.label" default="SSA District Office :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="3" class="form-control" 
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ssaDistrictOfficeNumber" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="ssaDistrictOfficeNumber" 
															value="${eligibilityHistoryVar?.ssaDistrictOfficeNumber}"
															title="Originating SSA district Office code">
						  </g:secureTextField>
                         <div class="fms_form_error" id="ssaDistrictOfficeNumber_error"></div>
                      </div> 
       				
       				 
       			
         		 <label class="control-label" id="sourceCode_label" for="sourceCode">
         		 <g:message code="eligHistory.sourceCode.label" default="TX Source ID :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="5" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.sourceCode" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="sourceCode" 
															value="${eligibilityHistoryVar?.sourceCode}" 
															title="Transaction Source Identifier">
						  </g:secureTextField>
                         <div class="fms_form_error" id="sourceCode_error"></div>
                      </div> 
       				 
                  
                   <label class="control-label  fms_required" for="uiUserDate" id="uiUserDate_label">
                   <g:message code="eligHistory.uiUserDate.label" default="UI User Date :" />
				   </label>                              
                   <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="uiUserDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uiUserDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.uiUserDate != null ? eligibilityHistoryVar?.uiUserDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.uiUserDate != null ? eligibilityHistoryVar?.uiUserDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.uiUserDate)}"
															title = "Date Identifying Information Changed by UI User"
															ariaAttributes="aria-labelledby='uiUserDate_label' aria-describedby='uiUserDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                
                                <div class="fms_form_error" id="uiUserDate_error"></div>
                              </div>  
                            
                            	
         			 <label class="control-label  fms_required" id="Application Date Ind" for="Application Date Ind">
         			 <g:message code="eligHistory.applicationDateIndicator.label" default="Application Date Ind :" />
					 </label>
         	         
         	         <div class="fms_form_input">
 						
 						<g:secureComboBox
 									class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.applicationDateIndicator" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="applicationDateIndicator" value="${eligibilityHistoryVar.applicationDateIndicator}"
									from="${['':'', 'Y':'Y']}" optionValue="value" optionKey="key"
									title="The application date associated with a UI submitted enrollment has a system generated default value.">
						</g:secureComboBox>
 						
						<div class="fms_form_error" id="SelectMember_error"></div>	
					 </div>
						
                            
                      
         		 <label class="control-label" id="CMS Process Time stamp_label" for="CMS Process Time stamp">
         		 <g:message code="eligHistory.cmsProcTimestamp.label" default="CMS Process Time stamp :" />
         		 </label>
         		  <div class="fms_form_input">
          			      <g:secureTextField maxlength="15" class="form-control"
															name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.cmsProcTimestamp" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="cmsProcTimestamp" 
															value="${eligibilityHistoryVar?.cmsProcTimestamp}"
															title="Format: HH.MM.SS.SSSSSS">
						  </g:secureTextField>
                          <div class="fms_form_error" id="CMS Process Time stamp_error"></div>
                  </div> 
       				 
       				 
       				 
       				 <label class="control-label" for="trrTransDate" id="trrTransDate_label">
       				 <g:message	code="eligHistory.trrTransDate.label" default="TRR Tran Date :" />
       				 </label>                              
                     <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="trrTransDate" title="Date of last Transaction Reply Report (TRR)"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.trrTransDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.trrTransDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.trrTransDate != null ? eligibilityHistoryVar?.trrTransDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.trrTransDate != null ? eligibilityHistoryVar?.trrTransDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.trrTransDate)}"
															ariaAttributes="aria-labelledby='trrTransDate_label' aria-describedby='trrTransDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                
                                <div class="fms_form_error" id="trrTransDate_error"></div>
                        </div>  
						</div>
						</div>
                                      
                </fieldset>

              </div>
              
            <div class="fms_widget">
      
                <fieldset>
                  <legend>Part C/D Information</legend>

                  <div class="fms_form_layout_2column">                  
                    <div class="fms_form_column fms_very_long_labels">
                    
                    
                    
                     
         		 <label class="control-label" id="priorCommercialOverride_label" for="priorCommercialOverride">
         		 <g:message code="eligHistory.priorCommercialOverride.label" default="Prior Commercial Override :" />
         		 </label>
         		  <div class="fms_form_input">
         		  		<g:secureTextField maxlength="1" class="form-control alphanum" 
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.priorCommercialOverride" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="priorCommercialOverride" 
										value="${eligibilityHistoryVar?.priorCommercialOverride}"
										title="If prior Commercial Authorization is not needed choose Y else choose N">
						</g:secureTextField>	
                         <div class="fms_form_error" id="priorCommercialOverride_error"></div>
                      </div> 
       			
       				 
       				 <label class="control-label" for="lateEnrollStartDate" id="lateEnrollStartDate_label">
       				 <g:message code="eligHistory.lateEnrollStartDate.label" default="Late Enrl start Dt :" />
       				 </label>                              
                     <div class="fms_form_input">
                                
                               <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollStartDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStartDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStartDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.lateEnrollStartDate != null ? eligibilityHistoryVar?.lateEnrollStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.lateEnrollStartDate != null ? eligibilityHistoryVar?.lateEnrollStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStartDate)}"
															title = "The begin dt of the late enrollment penalty period"
															ariaAttributes="aria-labelledby='lateEnrollStartDate_label' aria-describedby='lateEnrollStartDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="lateEnrollStartDate_error"></div>
                              </div>  <br><br>
                    
					
         			 <label class="control-label" id="creditableCovFlag" for="creditableCovFlag">
         			 <g:message	code="eligHistory.creditableCovFlag.label"	default="Creditable Cov :" />
         			 </label>
          				 <div class="fms_form_input">
							<g:secureTextField maxlength="1" class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.creditableCovFlag" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="creditableCovFlag" 
								value="${eligibilityHistoryVar?.creditableCovFlag}"
								title="If Creditable Coverage choose Y else choose N">
							</g:secureTextField>
						 	<div class="fms_form_error" id="creditableCovFlag_error"></div>														
						</div>
												
       				 
       				 
         		 <label class="control-label" id="electionCode" for="electionCode">
         		 <g:message code="eligHistory.electionCode.label" default="Election Type :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="1"
         		  			class="form-control"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.electionCode" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="electionCode" 
							value="${eligibilityHistoryVar?.electionCode}"
							title="Election code for enrollment">
					</g:secureTextField>
                         <div class="fms_form_error" id="electionCode_error"></div>
                      </div>


<!-- 
					<label class="control-label  fms_required"
						id="thirdPartyId" for="thirdPartyId"> <g:message
							code="eligHistory.thirdPartyId.label"
							default="Third Party Partner ID :" />
					</label>
					<div class="fms_form_input">
						<g:secureTextField maxlength="12"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId"
							tableName="MEMBER_ELIG_HISTORY"
							attributeName="thirdPartyId"
							value="${eligibilityHistoryVar?.thirdPartyId}"
							title="Third Party billing entity for split billing">
						</g:secureTextField>
						<fmsui:cdoLookup
							lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId"
							lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId"
							lookupElementValue="${eligibilityHistoryVar?.thirdPartyId}"
							lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ThirdParty"
							lookupCDOClassAttribute="thirdPartyId" />
						<div class="fms_form_error" id="thirdPartyId_error"></div>
					</div>
-->
			 		<label class="control-label fms_required" id="thirdPartyId_label" for="thirdPartyId">
						<g:message code="eligHistory.thirdPartyId.label" default="Third Party Partner ID :" />
					</label>
					<div class="fms_form_input fms_has_feedback">
						<g:secureTextField class="form-control" maxlength="12" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="thirdPartyId"
											value="${eligibilityHistoryVar?.thirdPartyId}" aria-labelledby="thirdPartyId_label" aria-describedby="thirdPartyId_error" 
											aria-required="false"
											title="Third Party billing entity for split billing"></g:secureTextField>
						<fmsui:cdoLookup
							lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId"
							lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.thirdPartyId"
							lookupElementValue="${eligibilityHistoryVar?.thirdPartyId}"
							lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ThirdParty"
							lookupCDOClassAttribute="thirdPartyId" />
						<div class="fms_form_error" id="thirdPartyId_error"></div>
					</div>



					<label class="control-label fms_required"
						id="newLisCostShareSubsidy"
						for="newLisCostShareSubsidy"> <g:message
							code="eligHistory.newLisCostShareSubsidy.label"
							default="New LICSS :" />
					</label>
					<div class="fms_form_input">

						<g:secureComboBox class="form-control"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.newLisCostShareSubsidy"
							tableName="MEMBER_ELIG_HISTORY"
							attributeName="newLisCostShareSubsidy"
							value="${eligibilityHistoryVar.newLisCostShareSubsidy}"
							from="${['':'', '1': 'High', '2': 'Low', '3': '0', '4': '15%']}"
							optionValue="value" optionKey="key"
							title="Part D low-income subsidy status(copay level)">
						</g:secureComboBox>

						<div class="fms_form_error"
							id="newLisCostShareSubsidy_error"></div>
					</div>



					 <label class="control-label fms_required" id="premiumWithholdOption" for="premiumWithholdOption">
         			 <g:message	code="eligHistory.premiumWithholdOption.label"	default="Premium Withhold Option:" />
         			 </label>
          				 <div class="fms_form_input">
										
								<g:secureComboBox
											class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.premiumWithholdOption" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="premiumWithholdOption" value="${eligibilityHistoryVar.premiumWithholdOption}"
											from="${['':'', 'D': 'Direct Self-Pay', 'S': 'Deduct from SSA benefits', 'R': 'Deduct from RRB benefits', 'O': 'Deduct from OPM benefits' , 'N': 'No premium applicable']}" 
											optionValue="value" optionKey="key"
											title="Premium Payment Option(Part-C and D)">
								</g:secureComboBox>						
														
															
					<div class="fms_form_error" id="premiumWithholdOption_error"></div>																								
													</div>
												
       				 
       				 
         			 <label class="control-label" id="mspStatusFlag" for="mspStatusFlag">
         			 <g:message code="eligHistory.mspStatusFlag.label" default="MSP Status Flag :" />
         			 </label>
          				<div class="fms_form_input">
														<g:secureComboBox
															class="form-control"
															name="eligHistory.${memberDBID }?.${eligibilityHistoryVar?.seqEligHist}.mspStatusFlag" 
															tableName="MEMBER_ELIG_HISTORY" attributeName="mspStatusFlag" value="${eligibilityHistoryVar?.mspStatusFlag}"
															from="${['': 'Null', 'P': 'Medicare Primary payor', 'S': 'Medicare Secondary payor', 'N': 'Non-respondent beneficiary']}" 
															optionValue="value" optionKey="key"
															title="Medicare as Primary/secondary Payor">
														</g:secureComboBox>
						<div class="fms_form_error" id="mspStatusFlag_error"></div>																							
													</div>
												
       				 
       				 
                      
         		 <label class="control-label" id="lateEnrollPct" for="lateEnrollPct">
         		 <g:message	code="eligHistory.lateEnrollPct.label"	default="Late Enrl Pct :" />
         		 </label>
         		  <div class="fms_form_input">
         		  		<g:secureTextField maxlength="6" type="text" 
 		  						class="form-control amtNumeric" 
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollPct" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollPct" 
								value="${formatNumber(number: eligibilityHistoryVar?.lateEnrollPct, format: '###,##0.0000')}" 
								title="The CMS Late Enrollment Percent">
						</g:secureTextField>										
                         <div class="fms_form_error" id="lateEnrollPct_error"></div>
                      </div> 
       				  

                 </div>    
                     

                    
                    <div class="fms_form_column fms_very_long_labels">
                    
                    
                 
         			 <label class="control-label" id="employerSubsidyOverride" for="employerSubsidyOverride">
         			 <g:message code="eligHistory.employerSubsidyOverride.label" default="Employer Subsidy Override :" />
         			 </label>
         			 <div class="fms_form_input">
          				<g:secureTextField maxlength="1" 
		  							class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.employerSubsidyOverride" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="employerSubsidyOverride" 
									value="${eligibilityHistoryVar?.employerSubsidyOverride}"
									title="Choose Y to override Employer Subsidy else choose N">
								</g:secureTextField>
								 <div class="fms_form_error" id="employerSubsidyOverride_error"></div>     
       				 </div>
       				 
       				 
       				
	        		 <label class="control-label" id="sourceCode" for="sourceCode">
	        		 <g:message	code="eligHistory.sourceCode.label" default="Enroll Source :" />
	        		 </label>
	        		  <div class="fms_form_input">
	        		  	<g:secureTextField maxlength="1" 
	        		  					class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.electionPeriod" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="electionPeriod" 
									value="${eligibilityHistoryVar?.electionPeriod}"
									title="Transaction Source Identifier">		
					    </g:secureTextField>
	                        <div class="fms_form_error" id="sourceCode_error"></div>
	                     </div> 
       				 
       				 
       				  <label class="control-label" for="lateEnrollStopDate" id="lateEnrollStopDate">
       				  <g:message code="eligHistory.lateEnrollStopDate.label" default="Late Enrl Stop Dt :" />
       				  </label>                              
                              <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lateEnrollStopDate"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStopDate" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lateEnrollStopDate" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.lateEnrollStopDate != null ? eligibilityHistoryVar?.lateEnrollStopDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.lateEnrollStopDate != null ? eligibilityHistoryVar?.lateEnrollStopDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStopDate)}"
															title = "End dt of Late enrollment Penalty Period"
															ariaAttributes="aria-labelledby='lateEnrollStopDate_label' aria-describedby='lateEnrollStopDate_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="lateEnrollStopDate_error"></div>
                              </div>
       				
       				 
       				 
         			 <label class="control-label" id="eghpIndicator" for="eghpIndicator">
         			 <g:message	code="eligHistory.eghpIndicator.label" default="EGHP :" />
         			 </label>
          				<div class="fms_form_input">
							<g:secureComboBox
								class="form-control"
								title="Employer Group Health Plan"
								name="eligHistory.${memberDBID }?.${eligibilityHistoryVar?.seqEligHist}.eghpIndicator" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="eghpIndicator" value="${eligibilityHistoryVar?.eghpIndicator}"
								from="${['Y': 'EGHP', 'N': 'Not EGHP',' ':'No change']}" optionValue="value" optionKey="key">
							</g:secureComboBox>		
						 <div class="fms_form_error" id="eghpIndicator_error"></div>																				
						</div>
						
					  <label class="control-label" id="electionCode" for="CMS Process Time stamp">
	         		  <g:message code="eligHistory.electionCode.label" default="Auto Enroll Opt-out :" />
	         		  </label>
						<div class="fms_form_input">
							<g:secureTextField maxlength="1" class="form-control"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDOptOutFlag" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="partDOptOutFlag" 
										value="${eligibilityHistoryVar?.partDOptOutFlag}"
										title="Chose Y if member opted out of Auto Enrollment else choose N">
							</g:secureTextField>
							<div class="fms_form_error" id="CMS Process Time stamp_error"></div>						
       				 	</div>
       				
      				  <label class="control-label" for="surveyYear" id="surveyYear_label">
      				  <g:message code="eligHistory.surveyYear.label" default="Survey Year :" />
      				  </label>                              
                             <div class="fms_form_input">
                               
                               <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="surveyYear"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.surveyYear" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.surveyYear" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.surveyYear != null ? eligibilityHistoryVar?.surveyYear.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.surveyYear != null ? eligibilityHistoryVar?.surveyYear.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.surveyYear)}"
															title = "Field will be used to submit data to CMS via the MMA Transaction type 85"
															ariaAttributes="aria-labelledby='surveyYear_label' aria-describedby='surveyYear_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                
                               <div class="fms_form_error" id="surveyYear_error"></div>
                             </div>  
       				  
       				 
       				
	         		 <label class="control-label" id="uncoveredMonths" for="uncoveredMonths">
	         		 <g:message code="eligHistory.uncoveredMonths.label" default="Uncov Months :" />
	         		 </label>
	         		  <div class="fms_form_input">
	         		  		<g:secureTextField maxlength="3" type="text"
	 		  						class="form-control numeric"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.uncoveredMonths" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="uncoveredMonths" 
									value="${formatNumber(number: eligibilityHistoryVar?.uncoveredMonths, format: '###,##0')}" 
									title="Count of Total Months without drug coverage.">
							</g:secureTextField>		
	                         <div class="fms_form_error" id="uncoveredMonths_error"></div>
	                      </div> 
       				 
       				  
	         		 <label class="control-label" id="contractNumber" for="contractNumber">
	         		 <g:message	code="eligHistory.contractNumber.label" default="CMS Contract No :" />
	         		 </label>
	         		  <div class="fms_form_input">
	         		  		<g:secureTextField maxlength="5"
	  		  						class="form-control"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.contractNumber" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="contractNumber" 
									value="${eligibilityHistoryVar?.contractNumber}" 
									title="Plan Contract Number">
							</g:secureTextField>
	                         <div class="fms_form_error" id="contractNumber_error"></div>
	                      </div> 
       				
       				 
         			 <label class="control-label fms_required" id="mmpOptOutFlag" for="mmpOptOutFlag">
         			 <g:message code="eligHistory.mmpOptOutFlag.label" default="MMP-Opt out Flag :" />
         			 </label>
          				<div class="fms_form_input">
							
							<g:secureComboBox
										class="form-control"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.mmpOptOutFlag" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="mmpOptOutFlag" value="${eligibilityHistoryVar.mmpOptOutFlag}"
										from="${['':'', 'Y': 'Yes', 'N': 'No']}" 
										optionValue="value" optionKey="key"
										title="Member doesn't want passive enrollment">
							</g:secureComboBox>	
								
							<div class="fms_form_error" id="mmpOptOutFlag_error"></div>													
						</div>
												
						      
       				 </div>

                    </div>                    
                </fieldset>
                </div>
                
                
                <div class="fms_widget">
      
                <fieldset>
                  <legend>Premium Rate Information</legend>

                  <div class="fms_form_layout_2column">                  
                    <div class="fms_form_column fms_extra_long_labels">
                  
       				 
       				  
         		 <label class="control-label" id="partCBeneficiaryPremium" for="partCBeneficiaryPremium">
         		 <g:message code="eligHistory.partCBeneficiaryPremium.label" default="Part C Benificiary Prem:" />
         		 </label>      		 
           		  <div class="fms_form_input">
           		  		<g:secureTextField maxlength="19" type="text" 
     		  						Class="form-control amtNumeric"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partCBeneficiaryPremium" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="partCBeneficiaryPremium" 
									value="${formatNumber(number: eligibilityHistoryVar?.partCBeneficiaryPremium, format: '###,##0.00')}" 
									title="Part C Beneficiary Premium Amount">
						</g:secureTextField>									
                         <div class="fms_form_error" id="partCBeneficiaryPremium_error"></div>
                   </div> 
       				 
       				 
       			 
         		 <label class="control-label" id="partDEnrollWaivePenalty" for="partDEnrollWaivePenalty">
         		 <g:message	code="eligHistory.partDEnrollWaivePenalty.label" default="Part D Late Enrollment Penalty Waive:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
	  		  						class="form-control amtNumeric"
									name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDEnrollWaivePenalty" 
									tableName="MEMBER_ELIG_HISTORY" attributeName="partDEnrollWaivePenalty" 
									value="${formatNumber(number: eligibilityHistoryVar?.partDEnrollWaivePenalty, format: '###,##0.00')}" 
									title="Part D Late Enrollment Penalty Waive Amount">
					</g:secureTextField>	
                         <div class="fms_form_error" id="partDEnrollWaivePenalty_error"></div>
                         <br><br>
                   </div>
       				 
   				  <label class="control-label" for="lowIncomePremiumSubsidy" id="lowIncomePremiumSubsidy_label">
   				  <g:message code="eligHistory.lowIncomePremiumSubsidy.label" default="Low Income Premium Subsidy:" />
   				  </label>                              
                  <div class="fms_form_input">
                            
                            <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="lowIncomePremiumSubsidy"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomePremiumSubsidy" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomePremiumSubsidy" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.lowIncomePremiumSubsidy != null ? eligibilityHistoryVar?.lowIncomePremiumSubsidy.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.lowIncomePremiumSubsidy != null ? eligibilityHistoryVar?.lowIncomePremiumSubsidy.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lowIncomePremiumSubsidy)}"
															ariaAttributes="aria-labelledby='lowIncomePremiumSubsidy_label' aria-describedby='lowIncomePremiumSubsidy_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                             
                            <div class="fms_form_error" id="lowIncomePremiumSubsidy_error"></div>
                            <br><br>
                            
                          </div>  
       				  
       				
         		 <label class="control-label" id="correctPartDPrem" for="correctPartDPrem">
         		 <g:message	code="eligHistory.correctPartDPrem.label" default="Correct Part D Premium Rate:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.correctPartDPrem" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="correctPartDPrem" 
							value="${formatNumber(number: eligibilityHistoryVar?.correctPartDPrem, format: '###,##0.00')}" 
							title="ZZZZZZZZ9.99 Format amount reported by HPMS">
					</g:secureTextField>
                         <div class="fms_form_error" id="correctPartDPrem_error"></div>
                         <br><br>
                      </div> 
       				
       			
       				
         		 <label class="control-label" id="partCModPremAmount" for="partCModPremAmount">
         		 <g:message code="eligHistory.partCModPremAmount.label"	default="Modified Part C Premium:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partCModPremAmount" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="partCModPremAmount" 
							value="${formatNumber(number: eligibilityHistoryVar?.partCModPremAmount, format: '###,##0.00')}" 
							title="Part C premium amount reported by HPMS">
					</g:secureTextField>
                    <div class="fms_form_error" id="partCModPremAmount_error"></div>
                 </div> 
       				
       				 

                     </div>
                  
           
                    <div class="fms_form_column fms_very_long_labels">
                    
                    
                 
         		 <label class="control-label" id="partDBeneficiaryPremium" for="partDBeneficiaryPremium">
         		 <g:message	code="eligHistory.partDBeneficiaryPremium.label" default="Part D Benificiary Prem:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDBeneficiaryPremium" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="partDBeneficiaryPremium" 
							value="${formatNumber(number: eligibilityHistoryVar?.partDBeneficiaryPremium, format: '###,##0.00')}" 
							title="Part D Beneficiary Premium Amount">
					</g:secureTextField>
                         <div class="fms_form_error" id="partDBeneficiaryPremium_error"></div>
                      </div> 
       				 
       				 
       			
         		 <label class="control-label" id="partDEnrollLatePenalty" for="partDEnrollLatePenalty">
         		 <g:message	code="eligHistory.partDEnrollLatePenalty.label" default="Part D Late Enroll Penalty:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.partDEnrollLatePenalty" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="partDEnrollLatePenalty" 
							value="${formatNumber(number: eligibilityHistoryVar?.partDEnrollLatePenalty, format: '###,##0.00')}" 
							title="Calculated Part D late enrollment penalty">
					</g:secureTextField>	
                         <div class="fms_form_error" id="partDEnrollLatePenalty_error"></div>
                      </div> 
       				
       				 
       				
         		 <label class="control-label" id="newLisSubsidy" for="newLisSubsidy">
         		 <g:message	code="eligHistory.newLisSubsidy.label" default="New LIS Subsidy:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.newLisSubsidy" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="newLisSubsidy" 
							value="${formatNumber(number: eligibilityHistoryVar?.newLisSubsidy, format: '###,##0.00')}" 
							title="ZZZZZZZZ9.99 Format; Part D low-income premium Amount">
					</g:secureTextField>
                         <div class="fms_form_error" id="newLisSubsidy_error"></div>
                      </div> 
       				
       				
         		 <label class="control-label" id="deMinimisDiff" for="deMinimisDiff">
         		 <g:message	code="eligHistory.deMinimisDiff.label" default="De Minimis Differential:" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="19" type="text" 
 		  					class="form-control amtNumeric"
							name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.deMinimisDiff" 
							tableName="MEMBER_ELIG_HISTORY" attributeName="deMinimisDiff" 
							value="${formatNumber(number: eligibilityHistoryVar?.deMinimisDiff, format: '###,##0.00')}" 
							title="Part D de minimis Plans">
					</g:secureTextField>
                         <div class="fms_form_error" id="deMinimisDiff_error"></div>
                      </div> 
       				 </div>
       				 
    				 </div>                                     
                </fieldset>
                </div> 
                
                <div class="fms_widget">
      
                <fieldset>
                  <legend>MEMMC Pharmacy</legend>

                  <div class="fms_form_layout_2column">                  
                    <div class="fms_form_column fms_very_long_labels">
                  
       				 
       				  
	         		 <label class="control-label fms_required" id="rxBin " for="rxBin">
	         		 <g:message	code="eligHistory.rxBin.label" default="RX BIN :" />
	         		 </label>
	         		  <div class="fms_form_input">
	         		  	
	         		  	<g:secureTextField maxlength="6" class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxBin" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="rxBin" 
											value="${eligibilityHistoryVar?.rxBin}"
											title="Card issuer identifier or bank identifying number">
						</g:secureTextField>
	         		  	
                         <div class="fms_form_error" id="rxBin_error"></div>
                      </div> 
       				 
       				 
       				
         		 <label class="control-label" id="rxId" for="rxId">
         		 <g:message	code="eligHistory.rxId.label" default="RX ID :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="20"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxId" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="rxId" 
								value="${eligibilityHistoryVar?.rxId}"
								title="Part D plan's ID number for beneficiary. Needed for outbound MMA Transaction file.">
					</g:secureTextField>
                         <div class="fms_form_error" id="rxId_error"></div>
                      </div> 
       				 
       				 
       			 
         			 <label class="control-label" id="secondaryRxIndicator" for="secondaryRxIndicator">
         			 <g:message code="eligHistory.secondaryRxIndicator.label" default="Secondary Rx :" />
         			 </label>
          				<div class="fms_form_input">
					<g:secureComboBox
								class="form-control"
								name="eligHistory.${memberDBID }?.${eligibilityHistoryVar?.seqEligHist}.secondaryRxIndicator" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxIndicator" value="${eligibilityHistoryVar?.secondaryRxIndicator}"
								from="${['Y': 'Beneficiary has secondary drug insurance', 'N': 'Beneficiary does not have secondary drug insurance available' , '': 'Do not know whether beneficiary has secondary drug insurance']}" 
								optionValue="value" optionKey="key" title="Secondary Drug Insurance">
					</g:secureComboBox>		
					<div class="fms_form_error" id="secondaryRxIndicator_error"></div>
       				 </div>

       				 
       				 
       				  
         		 <label class="control-label" id="secondaryRxBin" for="secondaryRxBin">
         		 <g:message	code="eligHistory.secondaryRxBin.label" default="Secondary Rx BIN :" />
         		 </label>
         		  <div class="fms_form_input">
         		  		<g:secureTextField maxlength="6"
         		  				class="form-control" 
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxBin" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxBin" 
								value="${eligibilityHistoryVar?.secondaryRxBin}"
								title="Secondary RX Bank Identification Number">
						</g:secureTextField>
                         <div class="fms_form_error" id="secondaryRxBin_error"></div>
                      </div> 
       				 
       			
       				
         		 <label class="control-label" id="secondaryRxId" for="secondaryRxId">
         		 <g:message	code="eligHistory.secondaryRxId.label" default="Secondary RX ID :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="20"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxId" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxId" 
								value="${eligibilityHistoryVar?.secondaryRxId}"
								title="Secondary Drug Insurance Plan ID">
					</g:secureTextField>
                         <div class="fms_form_error" id="secondaryRxId_error"></div>
                      </div> 
       				

                     </div>
                  
           
                    <div class="fms_form_column fms_very_long_labels">
                    
                    
              
         		 <label class="control-label fms_required" id="rxPcn" for="rxPcn">
         		 <g:message code="eligHistory.rxPcn.label" default="RX PCN :" />
         		 </label>
         		  <div class="fms_form_input">
  		  			<g:secureTextField maxlength="10"
  		  						class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxPcn" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="rxPcn" 
								value="${eligibilityHistoryVar?.rxPcn}"
								title="Number assigned by processor or 9999999999 if not known"
								onchange="">
				    </g:secureTextField>
					<script type="text/javascript">
									setDefault('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxPcn');
					</script>
                         <div class="fms_form_error" id="rxPcn_error"></div>
                      </div> 
       				 
       			 
       				
         		 <label class="control-label" id="rxGroup" for="rxGroup">
         		 <g:message	code="eligHistory.rxGroup.label" default="RX Group :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="15"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rxGroup" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="rxGroup" 
								value="${eligibilityHistoryVar?.rxGroup}"
								title="RX Group Number">
					</g:secureTextField>
                         <div class="fms_form_error" id="rxGroup_error"></div>
                      </div> 
       				
       				 
       				 
       				
         		 <label class="control-label" id="secondaryRxGroup" for="secondaryRxGroup">
         		 <g:message	code="eligHistory.secondaryRxGroup.label" default="Secondary Rx Group ID :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="15"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxGroup" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxGroup" 
								value="${eligibilityHistoryVar?.secondaryRxGroup}"
								title="Secondary Insurance plan's Group ID number">
					</g:secureTextField>
                         <div class="fms_form_error" id="secondaryRxGroup_error"></div>
                      </div> 
       				 
       			
       				
         		 <label class="control-label" id="secondaryRxPcn" for="secondaryRxPcn">
         		  <g:message code="eligHistory.secondaryRxPcn.label" default="Secondary RX PCN :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="10"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.secondaryRxPcn" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="secondaryRxPcn" 
								value="${eligibilityHistoryVar?.secondaryRxPcn}"
								title="Secondary RX Processor Control Number">
					</g:secureTextField>
                         <div class="fms_form_error" id="secondaryRxPcn_error"></div>
                      </div> 
       				 </div>
       				 
    				 </div>                                    
                </fieldset>
               </div>  
                
         <div class="fms_widget">
      
                <fieldset>
                  <legend>Medicare User Defined Fields</legend>

                  <div class="fms_form_layout_2column">                  
                    <div class="fms_form_column fms_very_long_labels">
                  
       				 
       				  
         		 <label class="control-label" id="lowIncomeSubsidyLevel" for="lowIncomeSubsidyLevel">
         		 <g:message code="eligHistory.lowIncomeSubsidyLevel.label" default="Subsidy Lvl :" /> 
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="6" type="text" 
  		  						class="form-control amtNumeric"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lowIncomeSubsidyLevel" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="lowIncomeSubsidyLevel" 
								value="${formatNumber(number: eligibilityHistoryVar?.lowIncomeSubsidyLevel, format: '###,##0.0000')}"
								title="CMS assigned Part D Subsidy low-income level" >
					</g:secureTextField>
                         <div class="fms_form_error" id="lowIncomeSubsidyLevel_error"></div>
                      </div> 
       				 
       				 
       				
         		 <label class="control-label" id="userDefined4" for="userDefined4">
         		 <g:message	code="eligHistory.userDefined4.label"	default="User Def 4 :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="30"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined4" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined4" 
								value="${eligibilityHistoryVar?.userDefined4}" >
					</g:secureTextField>
                         <div class="fms_form_error" id="User Def 4_error"></div>
                      </div> 
       				
       				 
       				 
       				 
         		 <label class="control-label" id="userDefined5" for="userDefined5">
         		 <g:message	code="eligHistory.userDefined5.label"	default="User Def 5 :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="30"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined5" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined5" 
								value="${eligibilityHistoryVar?.userDefined5}" >
					</g:secureTextField>
                         <div class="fms_form_error" id="userDefined5_error"></div>
                      </div> 
       				 
       				 
       				 
       				  
         		 <label class="control-label" id="userDefined6" for="userDefined6">
         		 <g:message	code="eligHistory.userDefined6.label" default="User Def 6 :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="30"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined6" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined6" 
								value="${eligibilityHistoryVar?.userDefined6}" >
					</g:secureTextField>
                         <div class="fms_form_error" id="userDefined6_error"></div>
                      </div> 
       				
       			
       				
         		 <label class="control-label" id="userDefined7" for="userDefined7">
         		 <g:message	code="eligHistory.userDefined7.label"	default="User Def 7 :" />
         		 </label>
         		  <div class="fms_form_input">
         		  	<g:secureTextField maxlength="30"
         		  				class="form-control"
								name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined7" 
								tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined7" 
								value="${eligibilityHistoryVar?.userDefined6}" >
					</g:secureTextField>
                         <div class="fms_form_error" id="userDefined7_error"></div>
                      </div> 
       				 
       				 
   				   <label class="control-label" for="userDate7" id="userDate7_label">
   				   <g:message code="eligHistory.userDate7.label" default="User Date 7 :" />
   				   </label>                              
                          <div class="fms_form_input">
                            
                            <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate7"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate7" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate7" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.userDate7 != null ? eligibilityHistoryVar?.userDate7.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.userDate7 != null ? eligibilityHistoryVar?.userDate7.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate7)}"
															ariaAttributes="aria-labelledby='userDate7_label' aria-describedby='userDate7 	_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                             
                            <div class="fms_form_error" id="userDate7_error"></div>
                          </div>  
   				 

                 </div>
                  
           
                    <div class="fms_form_column fms_very_long_labels">
                    
                                
                   <label class="control-label" for="caeUserDate1" id="caeUserDate1_label">
                   <g:message code="eligHistory.caeUserDate1.label" default="User Date 1 :" />
                   </label>                              
                              <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="caeUserDate1"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate1" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate1" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.lateEnrollStopDate != null ? eligibilityHistoryVar?.lateEnrollStopDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.lateEnrollStopDate != null ? eligibilityHistoryVar?.lateEnrollStopDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.lateEnrollStopDate)}"
															ariaAttributes="aria-labelledby='caeUserDate1_label' aria-describedby='caeUserDate1_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="caeUserDate1_error"></div>
                              </div>  
                              
                              
                                <label class="control-label" for="caeUserDate2" id="UserDate2_label">
                                <g:message code="eligHistory.caeUserDate2.label" default="User Date 2 :" />
                                </label>                              
                                <div class="fms_form_input">
                                
                                	<g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="caeUserDate2"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate2" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.caeUserDate2" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.caeUserDate2 != null ? eligibilityHistoryVar?.caeUserDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.caeUserDate2 != null ? eligibilityHistoryVar?.caeUserDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.caeUserDate2)}"
															ariaAttributes="aria-labelledby='caeUserDate2_label' aria-describedby='caeUserDate2_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="caeUserDate2_error"></div>
                              </div>  
                              
                           
                                <label class="control-label" for="userDate4" id="UserDate4_label">
                                <g:message code="eligHistory.userDate4.label" default="User Date 4 :" />
                                </label>                              
                                <div class="fms_form_input">
                                
                                	<g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate4"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate4" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate4" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.userDate4 != null ? eligibilityHistoryVar?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.userDate4 != null ? eligibilityHistoryVar?.userDate4.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate4)}"
															ariaAttributes="aria-labelledby='userDate4_label' aria-describedby='userDate4_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="userDate4_error"></div>
                              </div>  
                              
                              
                                <label class="control-label" for="userDate5" id="userDate5_label">
                                <g:message code="eligHistory.caeUserDate5.label" default="User Date 5 :" />
                                </label>                              
                                <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX 
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate5"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate5" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate5" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.userDate5 != null ? eligibilityHistoryVar?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.userDate5 != null ? eligibilityHistoryVar?.userDate5.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate5)}"
															ariaAttributes="aria-labelledby='userDate5_label' aria-describedby='userDate5_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="userDate5_error"></div>
                              </div>  
                              
                              
                                <label class="control-label" for="userDate6" id="userDate6_label">
                                <g:message code="eligHistory.userDate6.label" default="User Date 6 :" />
                                </label>                              
                                <div class="fms_form_input">
                                
                                <g:securejqDatePickerUIUX  
															tableName="MEMBER_ELIG_HISTORY" attributeName="userDate6"
															dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate6" 
															dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDate6" 
															datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((eligibilityHistoryVar?.userDate6 != null ? eligibilityHistoryVar?.userDate6.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((eligibilityHistoryVar?.userDate6 != null ? eligibilityHistoryVar?.userDate6.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}'" 
															dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.userDate6)}"
															ariaAttributes="aria-labelledby='userDate6_label' aria-describedby='userDate6_error' aria-required='false'" 
										                    classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
															showIconDefault="${isShowCalendarIcon}"/>
                                                                 
                                <div class="fms_form_error" id="userDate6_error"></div>
                              </div>
																	</div>
																</div>
															</fieldset>
														</div>
										           	 
														<!-- END - WIDGET: Other Information -->	
													</td>
												</tr>
											</g:each>
										</tbody>
									</table>
								</div>
								<!-- END - FMS Table Wrapper -->
							</div>
							<!-- END - FMS Widget -->
			          	</div>
			      	</div>
				</g:each>  
			</div>
		</div>
		<!-- START - Data Table Section -->	
	</div>
 <div id="addGroupPlaceHolder"></div>
	
<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>
