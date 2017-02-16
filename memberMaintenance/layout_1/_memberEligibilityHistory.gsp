<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistoryExtn"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?true:false}" />
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

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

<script>
	function editLis(LisInfo){
		//var LisInfo = document.getElementById(LisInfo);
		//alert(LisInfo);
		$(document.getElementById('LisInfo.'+LisInfo+'.toggleFields')).css('display','table-cell');
		$(document.getElementById('LisInfo.'+LisInfo+'.toggleSaveButton')).css('display','table-cell');
		$(document.getElementById('LisInfo.'+LisInfo+'.toggleResetButton')).css('display','table-cell');
		$(document.getElementById('LisInfo.'+LisInfo+'.toggleEditButton')).css('display','none');
	}
</script>

<script type="text/javascript">

	$(document).ready(function() {

		 $('.btnSaveAddress').hide();
         // $('.btnResetddress').hide();  
         $('.btnResetddressAlert').hide();  

         $('.tablesorter').delegate('.btnEditAddress, .btnResetddress', 'click' ,function(){
             var parentTR = $(this).closest('tr');
             $(parentTR).find('.btnEditAddress').toggle();
             $(parentTR).find('.btnSaveAddress').toggle();
             $(parentTR).find('.btnResetddressAlert').toggle();
             $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
             $('#NewAddress').prop('disabled', function(i, v) { return !v; });


             // $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
            //  return false;
           });

         $('.tablesorter').delegate('.btnSaveAddress', 'click' ,function(){
             $('#editForm').submit();
           });
         
         $('.modal-footer').delegate('.btnResetddress', 'click' ,function(){
       		this.form.reset();
       		//document.forms['editForm'].reset()       		
       		//$('#editForm').reset();
             /*$('#editForm').each(function() {
          	            this.reset();
           	});*/
       	});
           
           $( ".btnResetddress" ).click(function() {             
             $('.btnEditAddress').show();
             $('.btnSaveAddress').hide();
             $('.btnResetddressAlert').hide();
             $('.tablesorter-childRow').find('td').hide();
              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
             // return false;
           });

             $('.btnResetddressAlert').click(function(e){ 
               $('#WarningAlert').modal('show');
             });

             $('#WarningAlert').modal({
               backdrop: 'static',
               show: false
             });
              $("table[id='DataTable']").removeClass( "hidden" );

	});

</script>

</head>

<input type="hidden" name="editType" value="DETAIL" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<div id="fms_content_body">
<div class="right-corner" align="right">MELIG</div> 
    	   
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
            	<select id="memberIdSelectList"  class="form-control" name="memberIdlist" onChange="showAddress(this)">
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
		<g:each in="${memberMasterMap.keySet() }" status="idCount"
					var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
				<input type="hidden"  id="${subscriberMember.subscriberID}:${memberDBID }" 
				name="${subscriberMember.subscriberID}:${memberDBID }" value="${ member.personNumber }"/>
		</g:each>
		</div>
	</div>	
			<g:checkURIAuthorization uri="/memberMaintenance/addEligibilityPeriod">
			 <h2>Detail Records  <button name="addEligibilityPeriod1" type="button" class="btn btn-primary btn-sm" title="Click to add a new Eligibility info." onClick="addEligibilityPeriod()"><i class="fa fa-plus"></i> New Eligibility Period</button></h2>
				</g:checkURIAuthorization>
<table>
<tr>
				<td>
					<div id="addAddressDiv" style="display:block"></div>
				</td>
				<td>
					<div id="releaseSelect" style="display: none">
						<input type="button" name="enableMemberSelection" value="Enable Member Selection" onClick="releaseMemberSelection()">
					</div>
				</td>
</tr>
	
</table>	
<div class="fms_required_legend fms_required">= required</div>
<div id="dummy">&nbsp;</div>
<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">     
        
         <div id="SearchResults" class="fms_widget">
           			 <div class="fms_widget">
						<div class="row fms-col_selector_row">
                			<div id="DataTableFound" class="col-xs-6 fms-results-found"></div>
                			<div class="col-xs-6 fms-column-selector">
                				<div class="columnSelectorWrapper">
				                    <%--<input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
				                    <label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
				                    <div id="columnSelector" class="columnSelector">
				                    	<label>
				                   			<input type="checkbox" data-column="auto">Auto display columns: 
				                    	</label>
				                       this div is where the column selector is added 
				                
				                    	<label><input type="checkbox" data-column="0" class="checked">Effective Date</label>
				                    	<label><input type="checkbox" data-column="1" class="checked">End Date</label> 
				                    	<label><input type="checkbox" data-column="2" class="checked">Elig Status</label> 
				                    	<label><input type="checkbox" data-column="3" class="checked">Group ID</label>    
				                    	<label><input type="checkbox" data-column="4" class="checked">Plan Code</label>    
				                    	<label><input type="checkbox" data-column="5" class="checked">Benefit Start Date</label>    
				                    	<label><input type="checkbox" data-column="6" class="checked">Benefit End Date</label>    
				                    	<label><input type="checkbox" data-column="7" class="checked">Product Type</label>                      
              						</div>
              						--%></div>
              					</div>
              				</div>
       							<div class="fms_table_wrapper">
          						<table id="DataTable" class="hidden tablesorter tablesorter-fms tablesorteree7b702bcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
		                  <thead>
		                    <tr role="row" class="tablesorter-headerRow">
		                   <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Effective Date</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">End Date</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Elig Status</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Group ID</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="5" data-columnselector="disable" aria-disabled="true">Plan Code</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Benefit Start Date</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">Benefit End Date</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="8" data-columnselector="disable" aria-disabled="true">Product Type</th>
		                      
							<th class="{sorter: false} tablesorter-header sorter-false" data-column="9" data-columnselector="disable" aria-disabled="true">Actions</th>		                    </tr>
		                  </thead>
		                   
		                   <tbody aria-live="polite" aria-relevant="all"> 
		                   
		                   <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i" var="eligibilityHistoryVar">
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
					
							<input type="hidden" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount"
										value="${eligibilityHistoryVar.seqEligHist }">
										
					<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
							
						<td>	
						<g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.effectiveDate}" /></td>
							
						<td>	
						<g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.termDate}" /></td>
							
							<td>
								${eligibilityHistoryVar.eligStatus}
							</td>
							<td>
								${eligibilityHistoryVar.groupId}
							</td>
							<td>
								${eligibilityHistoryVar.planCode}
							</td>
							<td>
								<g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.benefitStartDate}" />
							</td>
							<td>
								<g:formatDate format="yyyy-MM-dd" date="${memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate}" />
							</td>
							<td>
								${productTypesMap?.get(eligibilityHistoryVar.planCode)}
							</td>
							 <td>
											<button id="BtnAddressEdit2"  type="button" class="btn fms_btn_icon btn-sm btnEditAddress" title="Click to edit Eligibility."><span class="glyphicon glyphicon-pencil"></span></button>
											<span style=" white-space: nowrap;"><button id="BtnAddressSave2" type="button" class="btn fms_btn_icon btn-sm btnSaveAddress" title="Click to save Eligibility changes."><span class="fa fa-floppy-o"></span></button>
											<button id="BtnAddressReset2" type="button" class="btn fms_btn_icon btn-sm btnResetddressAlert" title="Click to reset Eligibility form." data-target="#WarningAlert"><span class="glyphicon glyphicon-repeat"></span></button></span>
										</td>
						</tr>
						 
				   
					<tr id="Row2Child" class="tablesorter-childRow" role="row">					   
						<td colspan="9" id="memberEligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.toggleFields" class="" style="display:none;">
					<div class="fms_widget">        
						<fieldset>
							<legend><h3>Detail Records</h3></legend>
						<!-- RIGHT SIDE START -->
							<div class="fms_form_layout_2column">                  
								<div class="fms_form_column fms_very_long_labels">
								<label class="control-label fms_required" for="effectiveDate" id="effectiveDate_label">
								  <g:message code="eligHistory.effectiveDate.label" default="Effective Date :" />
								</label>                              
								<div class="fms_form_input">
									<g:securejqDatePickerUIUX 
											tableName="MEMBER_ELIG_HISTORY" attributeName="effectiveDate" title="Effective Date of the Eligibility Record"
											dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.effectiveDate"
											dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.effectiveDate"
											datePickerOptions="changeMonth: true, changeYear: true,maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.effectiveDate != null ? eligibilityHistoryVar?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1"
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.effectiveDate)}"
											ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='dateOfDeath_error' aria-required='false'"
											classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                    showIconDefault="${isShowCalendarIcon}"/>   
									<div class="fms_form_error" id="effectiveDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
								 
							  
								<label class="control-label " for="dateOfDeath" id="dateOfDeath_label">
									<g:message code="eligHistory.dateOfDeath.label" default="DOD :" />
								</label>                              
								<div class="fms_form_input">
									<g:securejqDatePickerUIUX 
											tableName="MEMBER_ELIG_HISTORY" attributeName="dateOfDeath" title="Date of Death of the Member"
											dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dateOfDeath"
											dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.dateOfDeath"
											datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.dateOfDeath != null ? eligibilityHistoryVar?.dateOfDeath.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+0',
											maxDate:0, numberOfMonths: 1" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.dateOfDeath)}"
											ariaAttributes="aria-labelledby='dateOfDeath_label' aria-describedby='dateOfDeath_error' aria-required='false'"
											classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                    showIconDefault="${isShowCalendarIcon}"/>  
									<div class="fms_form_error" id="dateOfDeath_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
						
							
								<label class="control-label fms_required" Class="form-control" id="eligStatus" for="eligStatus">
									<g:message code="eligHistory.eligStatus.label" default="Elig Status :" />
								</label>
								<div class="fms_form_input">
									<g:secureComboBox
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.eligStatus" 
										tableName="MEMBER_ELIG_HISTORY" 
										attributeName="eligStatus" Class="form-control"
										value="${eligibilityHistoryVar.eligStatus}"
										from="${['N': 'No', 'Y': 'Yes']}" 
										optionValue="value" optionKey="key"
										title="Eligibility status of the Member">
									</g:secureComboBox>
									<div class="fms_form_error" id="eligStatus_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
       					
								 
								<label class="control-label" for="recordStatus" id="recordStatus">
									<g:message code="eligHistory.recordStatus.label" default="Record Sts :" />
								</label>
								<div class="fms_form_input">
									 <g:secureTextField maxlength="15"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.recordStatus" 
										tableName="MEMBER_ELIG_HISTORY" 
										attributeName="recordStatus" Class="form-control"
										value="${eligibilityHistoryVar?.recordStatus}" 
										title="Status of the Member Record"></g:secureTextField>
									<div class="fms_form_error" id="recordStatus_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
							
							
								<label class="control-label" id="relationshipCode_label" for="relationshipCode">
									<g:message code="eligHistory.relationshipCode.label" default="RelationShip Code :" />
								</label>
								<div class="fms_form_input">
									<g:secureDiamondDataWindowDetail 
										columnName="relationship_code_fms" dwName="dw_ccont_melig" languageId="0"
										cssClass="form-control" title="Members Relationship to the Insured"
										htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.relationshipCode"
										defaultValue="${eligibilityHistoryVar?.relationshipCode}" blankValue="Relationship Code"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.relationshipCode" 
										tableName="MEMBER_ELIG_HISTORY" 
										attributeName="relationshipCode" 
										value="${eligibilityHistoryVar?.relationshipCode}"/>	
									<div class="fms_form_error" id="relationshipCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
                              
							  
								<label class="control-label  fms_required" id="groupId_label" for="groupId">
									<g:message code="eligHistory.groupId.label" default="Group Id :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
									<input type="hidden" 
										id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId" 
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId" 
										value="${eligibilityHistoryVar.seqGroupId}"
										class="form-control"/>														
																
									<g:secureTextField 
										maxlength="50" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.groupId" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="groupId" Class="form-control"
										value="${eligibilityHistoryVar?.groupId}" title="The Group Number the member is associated to">
									</g:secureTextField>
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.groupId"
                                                lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.groupId" 
                                                lookupElementValue="${eligibilityHistoryVar?.groupId}"
                                                lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
                                                lookupCDOClassAttribute="groupId"/>
										
									<div class="fms_form_error" id="groupId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
								
								<label class="control-label  fms_required" id="planCode_label" for="planCode">
									<g:message code="eligHistory.planCode.label" default="Plan Code :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
									<input type="hidden" id="planRecordType" name="planRecordType" value="P"/>
									<g:secureTextField
										maxlength="20" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.planCode" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="planCode" Class="form-control"
										value="${eligibilityHistoryVar?.planCode}" title="The Plan the member is associated to">
									</g:secureTextField>
									<fmsui:cdoLookup 
											lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.planCode"
                                            lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.planCode" 
                                            lookupElementValue="${eligibilityHistoryVar?.planCode}"
                                            lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
                                            lookupCDOClassAttribute="planRiderCode"
                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|PlanRecordType"
						   					htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
									
									<div class="fms_form_error" id="planCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div> 
								
								<label class="control-label" for="covLevelCode" id="covLevelCode_label">
									<g:message code="memberEligSbmtMap.covLevelCode.label" default="Coverage Level:" />
								</label>
								<div class="fms_form_input">
								  <g:secureTextField 
									name="memberEligSbmtMap.${eligibilityHistoryVar.seqEligHist}.covLevelCode" 
									tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" Class="form-control"
									value="${memberEligSbmtMap?.get(eligibilityHistoryVar?.seqEligHist)?.covLevelCode}"
									title ="Enter a 3-character coverage level code">
									</g:secureTextField>	
									<div class="fms_form_error" id="covLevelCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
								
								<!-- <label class="control-label" id="riders_label" for="riders">
						<g:message code="eligHistory.dentalLob.label" default="Riders :" />
					</label>
					<div class="fms_form_input">
						<input value="Riders" type="text" class="form-control" id="riders"
							aria-labelledby="riders_label" aria-describedby="riders_error"
							aria-required="false" />
						<div class="fms_form_error" id="riders_error"></div>
					</div>  -->
							<label class="control-label" id="riders_label" for="riders">
								<g:message code="eligHistory.dentalLob.label" default="Riders :" />
							</label>
							<div class="fms_form_input fms_multiple_sm">
								<div class="row sm-margin-bottom">
										<div class="col-xs-4">
											<input type="hidden" id="RiderRecordType" name="RiderRecordType" value="R" class="form-control"/>
											<input type="hidden" id="PlanRecordType" name="PlanRecordType" value="P" class="form-control"/>
											<g:secureTextField 
											class="form-control"
											maxlength="2" size="2" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode1" 
											value="${eligibilityHistoryVar?.riderCode1}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode1" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode1}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode1_error"></div>
										</div>
											<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2"
												aria-labelledby="riderCode2_label"
												aria-describedby="riderCode2_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode2"
												value="${eligibilityHistoryVar?.riderCode2}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode2" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode2}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode2_error"></div>
										</div>
											<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3"
												aria-labelledby="riderCode3_label"
												aria-describedby="riderCode3_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode3"
												value="${eligibilityHistoryVar?.riderCode3}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode3" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode3}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode3_error"></div>
										</div>
										</div>
										<div class="row sm-margin-bottom">
										<div class="col-xs-4">
											<g:secureTextField
												maxlength="2" size="2"  
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4"
												aria-labelledby="riderCode4_label"
												aria-describedby="riderCode4_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode4"
												value="${eligibilityHistoryVar?.riderCode4}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode4" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode4}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode4_error"></div>
										</div>
											<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5"
												aria-labelledby="riderCode5_label"
												aria-describedby="riderCode5_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode5"
												value="${eligibilityHistoryVar?.riderCode5}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode5" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode5}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode5_error"></div>
										</div>
											<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6"
												aria-labelledby="riderCode6_label"
												aria-describedby="riderCode6_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode6"
												value="${eligibilityHistoryVar?.riderCode6}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode6" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode6}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode6_error"></div>
										</div>
										</div>
											<div class="row sm-margin-bottom">
											<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7"
												aria-labelledby="riderCode7_label"
												aria-describedby="riderCode7_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode7"
												value="${eligibilityHistoryVar?.riderCode7}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode7" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode7}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
											
											<div class="fms_form_error" id="riderCode7_error"></div>
										</div>
										<div class="col-xs-4">
											<g:secureTextField 
												maxlength="2" size="2" 
												class="form-control" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8"
												aria-labelledby="riderCode8_label"
												aria-describedby="riderCode8_error" aria-required="false"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8"
												tableName="MEMBER_ELIG_HISTORY" attributeName="riderCode8"
												value="${eligibilityHistoryVar?.riderCode8}" title="Rider of the Benefit Plan">
											</g:secureTextField>
											<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderCode8" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.riderCode8}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.PremiumMaster"
	                                            lookupCDOClassAttribute="planRiderCode"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId|RiderRecordType"
												htmlElementsToAddToQueryCDOProperty="seqGroupId|recordType"/>
					
											<div class="fms_form_error" id="riderCode8_error"></div>
										</div>
									</div>
									</div>
								<label class="control-label" id="issuerSubscriberId_label" for="issuerSubscriberId">
									<g:message code="eligHistory.issuerSubscriberId.label" default="Issuer Subscriber Id :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
								   <g:secureTextField 
										maxlength="50"  name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerSubscriberId" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="issuerSubscriberId" Class="form-control"
										value="${eligibilityHistoryVar?.issuerSubscriberId}" title="Issuer's Subscriber ID for the Member">
									</g:secureTextField>
									
									<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerSubscriberId"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerSubscriberId" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.issuerSubscriberId}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
	                                            lookupCDOClassAttribute="issuerSubscriberId"/>
									
									<div class="fms_form_error" id="issuerSubscriberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div> 
								
								<label class="control-label " id="issuerMemberId_label" for="issuerMemberId">
									<g:message code="eligHistory.issuerMemberId.label" default="Issuer Member Id :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
									<g:secureTextField
										maxlength="50" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerMemberId" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="issuerMemberId" Class="form-control"
										value="${eligibilityHistoryVar?.issuerMemberId}" title="Issuer's Member ID for the Member">
									</g:secureTextField>
									<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerMemberId"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerMemberId" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.issuerMemberId}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
	                                            lookupCDOClassAttribute="issuerMemberId"/>
									
									<div class="fms_form_error" id="issuerMemberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div> 
                            
								<label class="control-label " id="issuerGroupNumber_label" for="issuerGroupNumber">
									<g:message code="eligHistory.issuerGroupNumber.label" default="Issuer Group Number :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
										<g:secureTextField 
											maxlength="30"  name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerGroupNumber" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="issuerGroupNumber" Class="form-control"
											value="${eligibilityHistoryVar?.issuerGroupNumber}" title="Issuer's Group ID for the Member">
										</g:secureTextField>
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerGroupNumber"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerGroupNumber" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.issuerGroupNumber}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
	                                            lookupCDOClassAttribute="issuerGroupNumber"/>
										
										<div class="fms_form_error" id="issuerGroupNumber_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									
								</div>
                           
								<label class="control-label" for="exchangeAssignedPolicyNo" id="exchangeAssignedPolicyNo">
									<g:message code="eligHistory.exchangeAssignedPolicyNo.label" default="Ex Assig Policy No :" />
								</label>
								<div class="fms_form_input">
								   <g:secureTextField 
										maxlength="50" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.exchangeAssignedPolicyNo" 
										tableName="MEMBER_ELIG_HISTORY" 
										attributeName="exchangeAssignedPolicyNo" Class="form-control"
										value="${eligibilityHistoryVar?.exchangeAssignedPolicyNo}"
										title="Exchange Assigned Policy Number"></g:secureTextField>
									<div class="fms_form_error" id="exchangeAssignedPolicyNo_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>								
								
								<label class="control-label" for="siteCode" id="siteCode">
									<g:message code="eligHistory.siteCode.label" default="Site Code :" />
								</label>
								<div class="fms_form_input">
									 <g:secureTextField 
										 maxlength="12"  name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.siteCode" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="siteCode" Class="form-control"
										value="${eligibilityHistoryVar?.siteCode}" title="A user assigned code where the primary care physician practices">
									</g:secureTextField>
									<div class="fms_form_error" id="siteCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
                              
								<label class="control-label" id="ipaId_label" for="ipaId">
									<g:message code="eligHistory.ipaId.label" default="IPA Id :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
									<input type="hidden" name="ipaLevelCode" id="ipaLevelCode" value="1"/>
									<g:secureTextField 
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ipaId" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="ipaId" Class="form-control"
										value="${eligibilityHistoryVar?.ipaId}" title="Provider IPA associated with this Member">
									</g:secureTextField>
									<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ipaId"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.ipaId" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.ipaId}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.IpaMaster"
	                                            lookupCDOClassAttribute="ipaId"
	                                            htmlElementsToAddToQuery="ipaLevelCode"
							   					htmlElementsToAddToQueryCDOProperty="levelCode"/>
									
									<div class="fms_form_error" id="ipaId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
                                
                                
								
								<label class="control-label" id="pcpChangeReason_label" for="pcpChangeReason">
									<g:message code="eligHistory.pcpChangeReason.label" default="PCP Change Reason:" />
								</label>
								<div class="fms_form_input fms_has_feedback">
										<input type="hidden" name="PCPReasonType" id="PCPReasonType" value="PC"/>
										<g:secureTextField 
											maxlength="5" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="pcpChangeReason" Class="form-control"
											value="${eligibilityHistoryVar?.pcpChangeReason}"
											title="The reason the Primary Care Physician was changed">
										</g:secureTextField>
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.pcpChangeReason" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.pcpChangeReason}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
	                                            lookupCDOClassAttribute="reasonCode"
	                                            htmlElementsToAddToQuery="PCPReasonType"
							   					htmlElementsToAddToQueryCDOProperty="reasonCodeType"/>
										
											<div class="fms_form_error" id="pcpChangeReason_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								
								</div>
					
								
								
								<label class="control-label" id="subscDept_label" for="subscDept">
									<g:message code="eligHistory.subscDept.label" default="Subscriber Dept :" />
								</label>
								<div class="fms_form_input fms_has_feedback">
									<g:secureTextField 
										 maxlength="20" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscDept" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="subscDept" Class="form-control"
										value="${eligibilityHistoryVar?.subscDept}" title="Subscriber Department">
									</g:secureTextField>
									<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscDept"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscDept" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.subscDept}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupDepartment"
	                                            lookupCDOClassAttribute="deptNumber"/>
										<div class="fms_form_error" id="subscDept_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
								
								
								<label class="control-label " for="hireDate" id="hireDate_label">
									<g:message code="eligHistory.hireDate.label" default="Hire Date:" />
								</label>                              
								<div class="fms_form_input">
									  <g:securejqDatePickerUIUX 
										tableName="MEMBER_ELIG_HISTORY" attributeName="hireDate" title="The Date the Member was hired"
										dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.hireDate"
										dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.hireDate"
										datePickerOptions="changeMonth: true, changeYear: true,maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.hireDate != null ? eligibilityHistoryVar?.hireDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1" 
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.hireDate)}"
										ariaAttributes="aria-labelledby='hireDate_label' aria-describedby='hireDate_error' aria-required='false'"
										classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                showIconDefault="${isShowCalendarIcon}"/>   
										<div class="fms_form_error" id="hireDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
                          
								<label class="control-label" for="prospectivePremiumAmt" id="prospectivePremiumAmt">
									<g:message code="eligHistory.prospectivePremiumAmt.label" default="Prospective Premium Amt :" />
								</label>
								<div class="fms_form_input">
										<g:secureTextField 
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.prospectivePremiumAmt" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="prospectivePremiumAmt" Class="form-control"
											value="${eligibilityHistoryVar?.prospectivePremiumAmt}"
											title="Prospective Premium Amount anticipated">
										</g:secureTextField>
										<div class="fms_form_error" id="prospectivePremiumAmt_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								
								</div>
							
								<label class="control-label" for="memberClass1" id="memberClass1">
									<g:message code="eligHistory.memberClass1.label" default="Member Class1 :" />
								</label>
								<div class="fms_form_input">
									  <g:secureTextField
									  	id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass1"
										maxlength="5" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass1" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass1" Class="form-control"
										value="${eligibilityHistoryVar?.memberClass1}"
										title="Member's home facility and market">
									  </g:secureTextField>
										<div class="fms_form_error" id="memberClass1_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
                              
							  
								<label class="control-label" for="memberClass2" id="memberClass2">
									<g:message code="eligHistory.memberClass2.label"default="Member Class2 :" />
								</label>
								<div class="fms_form_input">
									<g:secureTextField 
										id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass2"
										maxlength="5" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.memberClass2" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="memberClass2" Class="form-control"
										value="${eligibilityHistoryVar?.memberClass2}"
										title="Member's home facility and market">
									</g:secureTextField>
									<div class="fms_form_error" id="memberClass2_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
							  
						</div>
 <!-- LEFT SIDE -->
                              
							<div class="fms_form_column fms_very_long_labels">
                              
							  
								<label class="control-label " for="termDate" id="termDate_label">
									<g:message code="eligHistory.termDate.label" default="Term Date :" />
								</label>                              
								<div class="fms_form_input">
									<g:securejqDatePickerUIUX
										tableName="MEMBER_ELIG_HISTORY" attributeName="termDate" title="Termination Date of the Eligibility Record"
										dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termDate"
										dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termDate"
										datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.termDate != null ? eligibilityHistoryVar?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+0'"
										datePickerOptions="changeMonth: true, changeYear: true,maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.termDate != null ? eligibilityHistoryVar?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1" 
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.termDate)}"
										ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'"
										classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                showIconDefault="${isShowCalendarIcon}"/>   
								<div class="fms_form_error" id="termDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
										
								<label class="control-label" id="termReason_label" for="termReason">
									<g:message code="eligHistory.termReason.label" default="Term Reason :" />
								</label>
							   <div class="fms_form_input fms_has_feedback">
								   <g:secureTextField
										maxlength="5" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termReason" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="termReason" Class="form-control"
										value="${eligibilityHistoryVar?.termReason}" title="Reason for the Member Termination">
									</g:secureTextField>
									<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termReason"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.termReason" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.termReason}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
	                                            lookupCDOClassAttribute="reasonCode"/>
									<div class="fms_form_error" id="termReason_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
							
								 <label class="control-label" id="voidEligFlag_label" for="voidEligFlag">
								   <g:message code="eligHistory.voidEligFlag.label" default="Void Elig :" />
								  </label>
								  <div class="fms_form_input">	
									  <g:secureComboBox
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.voidEligFlag" 
										tableName="MEMBER_ELIG_HISTORY" 
										attributeName="voidEligFlag" Class="form-control"
										value="${eligibilityHistoryVar.voidEligFlag}"
										from="${['N': 'No' , 'Y': 'Yes']}" optionValue="value" optionKey="key"
										title="To Void the eligiblity, choose Y else choose N">
									</g:secureComboBox>
									<div class="fms_form_error" id="voidEligFlag_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
	       							
                            
								<label class="control-label fms_required" for="benefitStartDate" id="benefitStartDate_label">
								<g:message code="eligHistory.benefitStartDate.label" default="Benefit Start Date :" />
								</label>                              
								  <div class="fms_form_input">
									<g:securejqDatePickerUIUX 
										tableName="MEMBER_ELIG_HISTORY" attributeName="benefitStartDate"
										precision="day" noSelection="['':'']" default="none"
										title="Benefit Start Date for the Member"
										dateElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.benefitStartDate"
										dateElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.benefitStartDate"
										datePickerOptions="changeMonth: true, changeYear: true,maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (eligibilityHistoryVar?.benefitStartDate != null ? eligibilityHistoryVar?.benefitStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1"
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: eligibilityHistoryVar?.benefitStartDate)}"
										ariaAttributes="aria-labelledby='benefitStartDate_label' aria-describedby='benefitStartDate_error' aria-required='false'"
										classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                showIconDefault="${isShowCalendarIcon}"/>   
									<div class="fms_form_error" id="benefitStartDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								 </div>
		
		
								<label class="control-label" id="benefitEndDate_label" for="benefitEndDate">
									<g:message code="memberEligHistoryExtnList.benefitEndDate.label" default="Benefit End Date :" />
								</label>
								<div class="fms_form_input">
									<fmsui:jqDatePickerUIUX 
										datePickerOptions="changeMonth: true, changeYear: true, maxDate:0, yearRange: '-100:+0', numberOfMonths: 1, showOn: 'button'" 
									 	tableName="MEMBER_ELIG_HISTORY_EXTN" attributeName="benefitStartDate"
									 	title = "Benefit End Date for the Member"
									 	precision="day" noSelection="['':'']"
										dateElementId="memberEligHistoryExtnList.${eligibilityHistoryVar.seqEligHist}.benefitEndDate"
										dateElementName="memberEligHistoryExtnList.${eligibilityHistoryVar.seqEligHist}.benefitEndDate"
										disabled="${ MultiPlanEnabled ? ("01".equals(eligibilityHistoryVar?.personNumber) ? "false" : "true") : false}"
										datePickerOptions="changeMonth: true, changeYear: true,maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate != null ? memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1"
										dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberEligHistoryExtnList?.get(eligibilityHistoryVar?.seqEligHist)?.benefitEndDate)}"
										ariaAttributes="aria-labelledby='benefitEndDate_label' aria-describedby='benefitStartDate_error' aria-required='false'"
										classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                showIconDefault="${isShowCalendarIcon}"/>   
									<div class="fms_form_error" id="benefitEndDate_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								</div>
	                              
                            
	  
									<label class="control-label fms_required" id="subsidizedFlag_label" for="subsidizedFlag">
										<g:message code="eligHistory.subsidizedFlag.label" default="Subsidized Flag :" />
									</label>
									 <div class="fms_form_input">
										<g:secureComboBox
											name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.subsidizedFlag" 
											tableName="MEMBER_ELIG_HISTORY" 
											attributeName="subsidizedFlag" Class="form-control"
											value="${eligibilityHistoryVar.subsidizedFlag}"
											from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key"
											title="If the member is subsidized choose Y else choose N">
										</g:secureComboBox>  
										<div class="fms_form_error" id="subsidizedFlag_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
	       							
								 
		
									<label class="control-label fms_required" id="privacyOn_label" for="privacyOn">
											<g:message code="eligHistory.privacyOn.label" default="Privacy On :" />
									</label>
									<div class="fms_form_input">
											<g:secureComboBox
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.privacyOn" 
												tableName="MEMBER_ELIG_HISTORY"
												attributeName="privacyOn" Class="form-control"
												value="${eligibilityHistoryVar.privacyOn}"
												from="${['':'', 'Y':'Yes', 'N':'No']}" optionValue="value" optionKey="key"
												title="To restrict sharing of correspondence, choose Y else choose N">
											</g:secureComboBox> 
											<div class="fms_form_error" id="privacyOn_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>    
									
										<label class="control-label" id="lineOfBusiness_label" for="lineOfBusiness">
										<g:message code="eligHistory.lineOfBusiness.label" default="Line Of Business :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:secureTextField maxlength="3"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="lineOfBusiness" Class="form-control"
										value="${eligibilityHistoryVar?.lineOfBusiness}" title="Line of Business for the Member">
										</g:secureTextField>	
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.lineOfBusiness}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.LineOfBusinessMaster"
	                                            lookupCDOClassAttribute="lineOfBusiness"/>
										<div class="fms_form_error" id="lineOfBusiness_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>

									 <label class="control-label " id="Rider_Contact_Type_label" for="Gender">
									<g:message code="eligHistory.dentalLob.label" default="Riders Contract type :" />
									 </label>
									<div class="fms_form_input fms_multiple_sm">
										<div class="row sm-margin-bottom">
												<div class="col-xs-4">
													<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode1" 
													aria-labelledby="riderCode1_label"
													aria-describedby="riderCode1_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode1" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode1" 
													value="${eligibilityHistoryVar?.riderContractTypeCode1}" title="Rider's Contract Type">
													</g:secureTextField>
												</div>
												<div class="col-xs-4">
													<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode2"
													aria-labelledby="riderCode2_label"
													aria-describedby="riderCode2_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode2" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode2" 
													value="${eligibilityHistoryVar?.riderContractTypeCode2}" title="Rider's Contract Type">
													</g:secureTextField> 
												</div>
												<div class="col-xs-4">
														<g:secureTextField 
														maxlength="2" size="2"
														id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode3"
														aria-labelledby="riderCode3_label"
														aria-describedby="riderCode3_error" aria-required="false" class="form-control"
														name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode3" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode3" 
														value="${eligibilityHistoryVar?.riderContractTypeCode3}" title="Rider's Contract Type">
														</g:secureTextField>
												</div>
												</div>
												<div class="row sm-margin-bottom">
												<div class="col-xs-4">
													<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode4" 
													aria-labelledby="riderCode4_label"
													aria-describedby="riderCode4_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode4" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode4" 
													value="${eligibilityHistoryVar?.riderContractTypeCode4}" title="Rider's Contract Type">
													</g:secureTextField>
												</div>

											<div class="col-xs-4">
												<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode5" 
													aria-labelledby="riderCode5_label"
													aria-describedby="riderCode5_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode5" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode5" 
													value="${eligibilityHistoryVar?.riderContractTypeCode5}" title="Rider's Contract Type">
												</g:secureTextField>
											</div>
										<div class="col-xs-4">
												<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode6" 
													aria-labelledby="riderCode6_label"
													aria-describedby="riderCode6_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode6" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode6" 
													value="${eligibilityHistoryVar?.riderContractTypeCode6}" title="Rider's Contract Type">
												</g:secureTextField>
											
											</div>
											</div>
											<div class="row sm-margin-bottom">
											<div class="col-xs-4">
												<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode7" 
													aria-labelledby="riderCode7_label"
													aria-describedby="riderCode7_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode7" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode7" 
													value="${eligibilityHistoryVar?.riderContractTypeCode7}" title="Rider's Contract Type">
												</g:secureTextField>
											</div>
											<div class="col-xs-4">
												<g:secureTextField 
													maxlength="2" size="2"
													id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode8" 
													aria-labelledby="riderCode8_label"
													aria-describedby="riderCode8_error" aria-required="false" class="form-control"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.riderContractTypeCode8" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="riderContractTypeCode8" 
													value="${eligibilityHistoryVar?.riderContractTypeCode8}" title="Rider's Contract Type">
												</g:secureTextField>
											</div>
										<div class="fms_form_error" id="Rider_Contact_Type_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
								</div> 
								
									<label class="control-label" id="issuerPolicyNumber_label" for="issuerPolicyNumber">
										<g:message code="eligHistory.issuerPolicyNumber.label" default="Issuer Policy Number :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
									   <g:secureTextField
											maxlength="50" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerPolicyNumber" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="issuerPolicyNumber" Class="form-control"
											value="${eligibilityHistoryVar?.issuerPolicyNumber}" title="Issuer's Policy Number">
									  </g:secureTextField>
									  <fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerPolicyNumber"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.issuerPolicyNumber" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.issuerPolicyNumber}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.MemberEligHistory"
	                                            lookupCDOClassAttribute="issuerPolicyNumber"/>
										<div class="fms_form_error" id="issuerPolicyNumber_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
								
									<label class="control-label" id="rateType_label" for="rateType">
										<g:message code="eligHistory.rateType.label" default="Rate Type :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<input type="hidden" id="systemCodeType" 
											name="systemCodeType" value="RATETYPE"/>															
										<g:secureTextField 
											maxlength="10" Class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateType" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="rateType" 
											value="${eligibilityHistoryVar?.rateType}" title="Rate type that determines the rate">
										</g:secureTextField>
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateType"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateType" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.rateType}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
	                                            lookupCDOClassAttribute="systemCode"/>
										<div class="fms_form_error" id="rateType_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
								
									<label class="control-label" for="exchangeMemberId" id="exchangeMemberId">
										<g:message code="eligHistory.exchangeMemberId.label" default="Exchange Member Id :" />
									</label>
									<div class="fms_form_input">
											<g:secureTextField 
												maxlength="50" Class="form-control" title="Exchange Member Identifier for the Member"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.exchangeMemberId" 
												tableName="MEMBER_ELIG_HISTORY" attributeName="exchangeMemberId" 
												value="${eligibilityHistoryVar?.exchangeMemberId}"></g:secureTextField>									
											<div class="fms_form_error" id="exchangeMemberId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									
									</div>
								
									<label class="control-label " id="panelId_label" for="panelId">
										<g:message code="eligHistory.panelId.label" default="Panel Id :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
										<g:secureTextField maxlength="3" 
											Class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.panelId" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="panelId" 
											value="${eligibilityHistoryVar?.panelId}" title="Provider panel associated with this Member's Provider">
										</g:secureTextField>
										<fmsui:cdoLookup 
												lookupElementId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.panelId"
	                                           	lookupElementName="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.panelId" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.panelId}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupPanel"
	                                            lookupCDOClassAttribute="panelId"
	                                            htmlElementsToAddToQuery="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqGroupId"
							   					htmlElementsToAddToQueryCDOProperty="seqGroupId"/>
										<div class="fms_form_error" id="panelId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div> 
								 
       							 
								 
									<label class="control-label" id="PCPID_label" for="PCPID">
										<g:message code="eligHistory.PCPID.label" default="PCP ID :" />
									</label>
									<div class="fms_form_input fms_has_feedback">
											<g:hiddenField name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.seqProvId" value="${eligibilityHistoryVar?.seqProvId }"/>
											<g:if test="${eligibilityHistoryVar?.seqProvId}">
												<g:each in="${provIdList}" var="provId">
													<g:if test="${provId.seqProvId.equals(eligibilityHistoryVar?.seqProvId)}">
														<g:secureTextField  readonly="readonly"
															name="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId" 
															tableName="MEMBER_ELIG_HISTORY" Class="form-control" attributeName="seqProvId" 
															value="${provId.providerId}"
															onclick="PCPIdfieldClickMessage()"
															title="Primary Care Physician of the Member">
														</g:secureTextField>
													</g:if>
												</g:each>
											</g:if>
											<g:else>
												<g:secureTextField  readonly="readonly" Class="form-control"
													name="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="seqProvId" 
													value=""
													Class="form-control" onclick="PCPIdfieldClickMessage()"
													title="Primary Care Physician of the Member">
												</g:secureTextField>
											</g:else>
											<fmsui:cdoLookup 
												lookupElementId="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId"
	                                           	lookupElementName="providerId.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.providerId" 
	                                           	lookupElementValue="${eligibilityHistoryVar?.seqProvId}"
	                                           	lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ProvMaster"
	                                            lookupCDOClassAttribute="providerId"/>	
											<div class="fms_form_error" id="PCPID_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
								
								
								
									<label class="control-label" for="medicareStatusFlg" id="medicareStatusFlg">
										<g:message code="eligHistory.medicareStatusFlg.label" default="Medicare Status Flag :" />
									</label>
									<div class="fms_form_input">
										<g:secureTextField maxlength="12"
											Class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.medicareStatusFlg" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="medicareStatusFlg" 
											value="${eligibilityHistoryVar?.medicareStatusFlg}">
										</g:secureTextField>
										<div class="fms_form_error" id="medicareStatusFlg_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
							  
							  
		
									<label class="control-label" id="subscLocation_label" for="subscLocation">
										<g:message code="eligHistory.subscLocation.label" default="Location :" />
									</label>
									<div class="fms_form_input">
											<g:secureSystemCodeToken
													systemCodeType="MELIGLOC" languageId="0"
													tableName="MEMBER_ELIG_HISTORY" 
													attributeName="subscLocation" cssClass="form-control"
													htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.subscLocation"
													blankValue="Location" 
													defaultValue="${eligibilityHistoryVar?.subscLocation}" 
													>
											</g:secureSystemCodeToken>
											<div class="fms_form_error" id="subscLocation_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
												   
									</div>
								 
	
									<label class="control-label" id="csIndicator_label" for="csIndicator">
										<g:message code="eligHistory.csIndicator.label" default="CS Indicator :" />
									</label>
									<div class="fms_form_input">
									  <g:secureSystemCodeToken
											systemCodeType="MEMCSIND" languageId="0"
											tableName="MEMBER_ELIG_HISTORY" 
											attributeName="csIndicator" cssClass="form-control" 
											htmlElelmentId="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.csIndicator"
											blankValue="CS Indicator" 
											defaultValue="${eligibilityHistoryVar?.csIndicator}" 
											title="Indicates if information for this member should be confidential or is sensitive">
										</g:secureSystemCodeToken>
										<div class="fms_form_error" id="csIndicator_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
											
									</div>
								 
								 
									<label class="control-label" for="userDefined1" id="userDefined1">
										<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"/>
									</label>
									<div class="fms_form_input">
										<g:secureTextField maxlength="30"
												Class="form-control"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined1" 
												tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined1" 
												value="${eligibilityHistoryVar?.userDefined1}">
										</g:secureTextField>
										<div class="fms_form_error" id="userDefined1_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
							  
									<label class="control-label" for="userDefined2" id="userDefined2">
										<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"/>
									</label>
									<div class="fms_form_input">
										<g:secureTextField maxlength="30"
											Class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined2" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined2" 
											value="${eligibilityHistoryVar?.userDefined2}">
										</g:secureTextField>
										<div class="fms_form_error" id="userDefined2_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
							 
									<label class="control-label" for="userDefined2" id="userDefined2">
										<g:userDefinedFieldLabel winId="MELIG" datawindowId ="dw_melig_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"/>
									</label>
									<div class="fms_form_input">
											<g:secureTextField maxlength="30"
												Class="form-control"
												name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userDefined3" 
												tableName="MEMBER_ELIG_HISTORY" attributeName="userDefined3" 
												value="${eligibilityHistoryVar?.userDefined3}">
											</g:secureTextField>
											<div class="fms_form_error" id="userDefined3_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
									</div>
								</div>
						</div>
			</fieldset>
		</div>
		 </td>
			</g:each>				
					</tbody>
					</table>
				</div>
   			</div>
 		</div>
   	</div>
	</g:each>  
	</div>
	<div id="addGroupPlaceHolder"></div>

		<div class="modal fade" id="WarningAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_warning">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Are you sure you want to reset this form?</h4>
	           		<p>You'll lose any changes you made by doing so.</p>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	             	<button type="button" class="btn btn-danger btnResetddress" data-dismiss="modal">Yes, Reset</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>
</html>