<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="appContext" bean="grailsApplication"/>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script src="${resource(dir: '/js/layout_1_scripts', file: 'jquery.maskMoney.js')}" ></script>

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
	
	function showBill(selectedObj) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var billDivObj = document.getElementById(selectedValue)
			if (billDivObj != null) {
				billDivObj.style.display = "block"
			}else {
				billDivObj.style.display = "none"
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

<head>
<script>
function editBilling(eligibilityHistoryVar){
	//var address = document.getElementById(address);
	//alert(address);
	$(document.getElementById('eligHistory.'+eligibilityHistoryVar+'.toggleFields')).css('display','table-cell');
	$(document.getElementById('eligHistory.'+eligibilityHistoryVar+'.toggleSaveButton')).css('display','table-cell');
	$(document.getElementById('eligHistory.'+eligibilityHistoryVar+'.toggleResetButton')).css('display','table-cell');
	$(document.getElementById('eligHistory.'+eligibilityHistoryVar+'.toggleEditButton')).css('display','none');

}
</script>

<script type="text/javascript">

	$(document).ready(function() {

		 $('.btnSaveBilling').hide();
         // $('.btnResetBilling').hide();  
         $('.btnResetBillingAlert').hide();  


         $('.tablesorter').delegate('.btnEditBilling, .btnResetBilling', 'click' ,function(){
             var parentTR = $(this).closest('tr');
             $(parentTR).find('.btnEditBilling').toggle();
             $(parentTR).find('.btnSaveBilling').toggle();
             $(parentTR).find('.btnResetBillingAlert').toggle();
             $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
             $('#NewAddress').prop('disabled', function(i, v) { return !v; });


             // $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
            //  return false;
           });

         $('.tablesorter').delegate('.btnSaveBilling', 'click' ,function(){
             $('#editForm').submit();
           });
         
           
           $( ".btnResetBilling" ).click(function() {             
             $('.btnEditBilling').show();
             $('.btnSaveBilling').hide();
             $('.btnResetBillingAlert').hide();
             $('.tablesorter-childRow').find('td').hide();
              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
             // return false;
           });


          
             $('.btnResetBillingAlert').click(function(e){ 
               $('#WarningAlert').modal('show');
             });

             $('#WarningAlert').modal({
               backdrop: 'static',
               show: false
             });

             $('btnResetddressAlert').click(function() {
                        $('#editForm').each(function() {
                     	            this.reset();
                      });
                  }); 
             $(".fms_mask_money").maskMoney({prefix:'', allowNegative: true, thousands:'', decimal:'.', affixesStay: false});
             $(".fms_mask_money").css('text-align', 'right');

             $(".fms_mask_amount").maskMoney({prefix:'', allowNegative: true, thousands:'', decimal:'.', precision: 4, affixesStay: false});
             $(".fms_mask_amount").css('text-align', 'right');

              $("table[id='DataTable']").removeClass( "hidden" );
   });

</script>
</head>

<input type="hidden" name="editType" value="BILLING" />
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
				<g:each in="${memberMasterMap.keySet() }" status="idCount" var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
					<input type="hidden" id="${subscriberMember.subscriberID}:${memberDBID }" name="${subscriberMember.subscriberID}:${memberDBID }" value="${ member.personNumber }"/>
				</g:each>
			</div>
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
<div class="fms_required_legend fms_required">= required</div>
<div id="dummy"></div>
<g:each in="${memberEligHistoryMap.keySet()}" status="idCount"
	var="memberDBID">
	<div id="${memberDBID }" style="display: none">
	<div class="row fms-col_selector_row">
                <div id="DataTableFound" class="col-xs-6 fms-results-found"></div>
               
	 	</div>
	<div class="fms_table_wrapper">
                <table id="DataTable" class="hidden tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
                  <thead>
                    <tr role="row" class="tablesorter-headerRow">
                    <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Effective Date</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">End Date</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Elig Status</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Group ID</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Plan Code</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Riders</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">PCP ID</th>
		            <th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Actions</th>
		            </tr>
                  </thead>
                  
      			<tbody aria-live="polite" aria-relevant="all">                                        
 
  
			<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i" var="eligibilityHistoryVar">
				
				<input type="hidden" name="seq_prem_id_${i}" value="${eligibilityHistoryVar.seqEligHist }">				
				<input type="hidden" name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount" value="${eligibilityHistoryVar.seqEligHist}">
				<input type="hidden" name="billingHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist }.iterationCount" value="${eligibilityHistoryVar.seqEligHist }">										
                  <tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
                      <td><g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.effectiveDate}" /></td>
                      <td><g:formatDate format="yyyy-MM-dd" date="${eligibilityHistoryVar.termDate}" /></td>
                      <td>${eligibilityHistoryVar.eligStatus}</td>
                      <td>${eligibilityHistoryVar.groupId}</td>
                      <td>${eligibilityHistoryVar.planCode}</td>
                      <td class="clickme">
						<g:if test="${eligibilityHistoryVar.riderCode1}">  ${eligibilityHistoryVar.riderCode1}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode2}">, ${eligibilityHistoryVar.riderCode2}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode3}">, ${eligibilityHistoryVar.riderCode3}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode4}">, ${eligibilityHistoryVar.riderCode4}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode5}">, ${eligibilityHistoryVar.riderCode5}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode6}">, ${eligibilityHistoryVar.riderCode6}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode7}">, ${eligibilityHistoryVar.riderCode7}</g:if>
						<g:if test="${eligibilityHistoryVar.riderCode8}">, ${eligibilityHistoryVar.riderCode8}</g:if>
					  </td>
                     
                      <td></td>
                                    
                      <td>
                      <button id="BtnAddressEdit2"  type="button" class="btn fms_btn_icon btn-sm btnEditBilling" title="Click to edit billing."><span class="glyphicon glyphicon-pencil"></span></button>
                      <button id="BtnAddressSave2" type="button" class="btn fms_btn_icon btn-sm btnSaveBilling" title="Click to save billing changes."><span class="fa fa-floppy-o"></span></button>
                      <button id="BtnAddressReset2" type="button" class="btn fms_btn_icon btn-sm btnResetBillingAlert" title="Click to reset billing form." data-target="#WarningAlert"><span class="glyphicon glyphicon-repeat"></span></button>
                     </td>
                    </tr>
                    <tr id="Row2Child" class="tablesorter-childRow" role="row">
                      <td colspan="8" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.toggleFields" class="" style="display:none;">
                      						
                         <div class="fms_widget">
                         <fieldset>
                            <legend><h3>Specifications</h3></legend>

                            <div class="fms_form_layout_2column">                  
                              <div class="fms_form_column fms_very_long_labels">
							
                                <label for="rateOverrideType" class="control-label" id="rateOverrideType_label">
                                	<g:message code="eligHistory.rateOverrideType.label" default="Override Type:" />
                                </label>
                                                                                               
                                <div class="fms_form_input">
	                                  <g:secureComboBox
										class="form-control" title="Type of Billing Override"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverrideType" 
										onchange="enabledisableamount('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}')"
										tableName="MEMBER_ELIG_HISTORY" attributeName="rateOverrideType" 
										value="${eligibilityHistoryVar.rateOverrideType}"
										from="${['A':'Add to Amount', 'D': 'Rate Determinant Override', 'R': 'Replacement Amount']}" 
										optionValue="value" optionKey="key">
									  </g:secureComboBox>
                                  	<div class="fms_form_error" id="rateOverrideType_error"></div>
                                 </div>
								
								<label for="familySizeOverride" class="control-label" id="familySizeOverride_label"> 
									<g:message code="eligHistory.familySizeOverride.label" default="Subscriber Rating Family Size:" />
								</label>
								
                                <div class="fms_form_input">
                                		<g:secureComboBox class="form-control"
                                			title="Override family size amount to be used to look up the rate table premium rather than the actual family size"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.familySizeOverride" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="familySizeOverride" value="${eligibilityHistoryVar?.familySizeOverride}"
											from="${1..100}" noSelection="['':'-Family Size-']">
										</g:secureComboBox>
										<div class="fms_form_error" id="familySizeOverride_error"></div>
								</div>  					
								
                                <label for="covInsuranceLnCode" class="control-label" id="covInsuranceLnCode_label" >
									<g:message code="billingHistory.covInsuranceLnCode.label" default="Insurance Line Code:" />
								</label>
														
								<g:each in="${memberBillingMap.get(memberDBID)}" status="j" var="billingHistoryVar">
									<g:if test="${billingHistoryVar.seqEligHist.equals(eligibilityHistoryVar.seqEligHist)}">														
										<div class="fms_form_input">
											<g:secureTextField 
												type="text" 
												class="form-control" 
												maxlength="3"
												name="billingHistory.${memberDBID }.${billingHistoryVar?.seqEligHist}.covInsuranceLnCode" 
												tableName="MEMBER_ELIG_SBMT" attributeName="covInsuranceLnCode" 
												value="${billingHistoryVar?.covInsuranceLnCode}"
												title="5010 X12 data - Insurance Line Code">
											</g:secureTextField>
											<div class="fms_form_error" id="covInsuranceLnCode_error"></div>
										</div> 
									</g:if>
								</g:each>
								
								
								<label for="assignedQhpId" class="control-label" id="assignedQhpId_label" >
                                	<g:message code="eligHistory.assignedQhpId.label" default="Assigned QHP ID :" />
								</label>
                                
                                <div class="fms_form_input">
									<g:secureTextField 
										class="form-control qhpMask"
										maxlength="16"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.assignedQhpId" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="assignedQhpId" 
										value="${eligibilityHistoryVar?.assignedQhpId}" 
										title="Assigned Qualified Health Plan Identifier. Format #####XX######### where ## is a number and XX is a character.">
									</g:secureTextField>
                                
								 	<div class="fms_form_error" id="assignedQhpId_error"></div>
                                 </div> 
								
								<label for="smbAmount" class="control-label" id="smbAmount_label">
									<g:message code="eligHistory.smbAmount.label" default="SMB Amount:" />
								</label>
								
								<div class="fms_form_input fms_has_feedback_money">
                                			<span class="fms_form_control_dollar"></span>
												<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
													name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.smbAmount" 
													tableName="MEMBER_ELIG_HISTORY" attributeName="smbAmount" 
													value="${formatNumber(number: eligibilityHistoryVar?.smbAmount, format: '###,##0.00')}" 
													title="State Mandated Benefits (Rebate) amount"
													aria-labelledby="Amount_r1_label" aria-describedby="Amount_r1_error" aria-required="false" placeholder="0.00" >                                 
												</g:secureTextField>
											<div class="fms_form_error" id="smbAmount_error"></div>
								</div>

								<label for="famStateWrapPrem" class="control-label" id="famStateWrapPrem_label">
									<g:message code="eligHistory.famStateWrapPrem.label" default="State WRAP Premium:" />
								</label>
								<div class="fms_form_input fms_has_feedback_money">
									<span class="fms_form_control_dollar"></span>
														<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
																name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.stateWrapPrem" 
																tableName="MEMBER_ELIG_HISTORY" attributeName="stateWrapPrem" 
																value="${formatNumber(number: eligibilityHistoryVar?.stateWrapPrem, format: '###,##0.00')}"
																title="State Wrap Premium calculated"
																aria-labelledby="famStateWrapPrem_r1_label" aria-describedby="famStateWrapPrem_r1_error" aria-required="false" placeholder="0.00">
														</g:secureTextField>
										<div class="fms_form_error" id="famStateWrapPrem_error"></div>
	                             </div>
                                
                                <label for="fedAptcPrem" class="control-label" id="fedAptcPrem_label">
								<g:message code="eligHistory.fedAptcPrem.label"	default="Fed APTC Premium:" />
								</label> 
								<div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" 
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.fedAptcPrem" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="fedAptcPrem" maxlength="21"
											value="${formatNumber(number: eligibilityHistoryVar?.fedAptcPrem, format: '###,##0.00')}"
											title="Federal Subsidy Premium availed"
											aria-labelledby="fedAptcPrem_r1_label" aria-describedby="fedAptcPrem_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									  <div class="fms_form_error" id="fedAptcPrem_error"></div>
                                </div>    
                                
								<label for="famTotalPremium" class="control-label" id="famTotalPremium_label">
									<g:message code="eligHistory.famTotalPremium.label"	default="Fam Total Premium:" />
								</label> 
								<div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField maxlength="23" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famTotalPremium" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="famTotalPremium" 
											value="${formatNumber(number: eligibilityHistoryVar?.famTotalPremium, format: '###,##0.00')}" 
											title="Total premium rate for the family"
											aria-labelledby="famTotalPremium_r1_label" aria-describedby="famTotalPremium_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									 <div class="fms_form_error" id="famTotalPremium_error"></div>
                                </div>  
								
								<label for="famStateWrapPrem" class="control-label" id="famStateWrapPrem_label"> 
								<g:message code="eligHistory.famStateWrapPrem.label" default="Fam State WRAP Premium:" />
								</label>
								<div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField maxlength="23" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famStateWrapPrem" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="famStateWrapPrem" 
											value="${formatNumber(number: eligibilityHistoryVar?.famStateWrapPrem, format: '###,##0.00')}" 
											title="Total State Wrap for the family (Wrap Premium)"
											aria-labelledby="famStateWrapPrem_r1_label" aria-describedby="famStateWrapPrem_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									   <div class="fms_form_error" id="famStateWrapPrem_error"></div>
                               </div>   
								
								<label for="rateAdjustmentFactor" class="control-label" id="rateAdjustmentFactor_label">
								 <g:message	code="eligHistory.rateAdjustmentFactor.label" default="Rate Adjust Factor:" />
								</label>
								<div class="fms_form_input fms_has_feedback_percentage">
										<g:secureTextField maxlength="19" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateAdjustmentFactor" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="rateAdjustmentFactor" 
											value="${eligibilityHistoryVar?.rateAdjustmentFactor}" 
											title="Adjustment factor by which premium rate determined for this family/member is multiplied to arrive at the final rate"
											aria-labelledby="RateAdjustFactor_r1_label" aria-describedby="RateAdjustFactor_r1_error" aria-required="false" placeholder="0">
											<span class="fms_form_control_percentage"></span>
										</g:secureTextField>
									<div class="fms_form_error" id="rateAdjustmentFactor_error"></div>
                                </div>
								
								<label for="otherPmtAmt" class="control-label" id="otherPmtAmt_label">
									<g:message code="eligHistory.otherPmtAmt.label"	default="Other Payment Amount:" />
								</label>
								<div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField maxlength="21" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.otherPmtAmt" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="otherPmtAmt" 
											value="${formatNumber(number: eligibilityHistoryVar?.otherPmtAmt, format: '###,##0.00')}" 
											title="Other Payer Amounts. Amount the QHP Issuer can expect to receive from other payment sources to pay a portion of Premium"
											aria-labelledby="famStateWrapPrem_r1_label" aria-describedby="famStateWrapPrem_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									<div class="fms_form_error" id="otherPmtAmt_error"></div> 
                                </div>
								
								<label for="userRate2" class="control-label" id="userRate2_label"> 
									<g:message code="eligHistory.userRate2.label" default="User Rate 2:" />
								</label>
                               <div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField maxlength="21" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate2" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userRate2" 
											value="${formatNumber(number: eligibilityHistoryVar?.userRate2, format: '###,##0.00')}" 
											aria-labelledby="userRate2_r1_label" aria-describedby="userRate2_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									<div class="fms_form_error" id="userRate2_error"></div>
                                </div>   
								
								<label for="coverageAmount" class="control-label" id="coverageAmount_label"> 
								<g:message code="eligHistory.coverageAmount.label" default="Life Coverage Amount :" />
								</label>
													
                               <div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
										<g:secureTextField maxlength="21" class="form-control amtNumeric fms_small_input"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.coverageAmount" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="coverageAmount" 
											value="${formatNumber(number: eligibilityHistoryVar?.coverageAmount, format: '###,##0.00')}" 
											title="This field stores the coverage amount for Life Insurance."
											aria-labelledby="coverageAmount_r1_label" aria-describedby="coverageAmount_r1_error" aria-required="false" placeholder="0.00">
										</g:secureTextField>
									 <div class="fms_form_error" id="coverageAmount_error"></div>
                              	</div>
								
								<label for="tobaccoUse" class="control-label" id="tobaccoUse_label">
									<g:message code="eligHistory.tobaccoUse.label" default="Tobacco Use:" />
								</label>
								<div class="fms_form_input"> 
									 <g:secureComboBox class="form-control"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.tobaccoUse" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="tobaccoUse" value="${eligibilityHistoryVar.tobaccoUse}"
											from="${['':'','N':'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
											title="This field determines whether member is a tobacco user or not">
							 		 </g:secureComboBox>									
	                                  <div class="fms_form_error" id="tobaccoUse_error"></div>
                                </div>


                              </div>
                              <div class="fms_form_column fms_very_long_labels">
                             
                               <label for="rateOverride" class="control-label" id="rateOverride_label">
                               		<g:message code="eligHistory.rateOverride.label" default="Amount:" />
							   </label>
                                
                                <div class="fms_form_input fms_has_feedback_money">                              
	                               <span class="fms_form_control_dollar"></span>
									 	<g:secureTextField type="text" class="form-control fms_small_input" maxlength="19"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverride" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="rateOverride"
										value="${formatNumber(number: eligibilityHistoryVar?.rateOverride, format: '###,##0.00')}"
										title="Amount to be either added to the calculated premium or to be used to replace the calculated premium"
										aria-labelledby="rateOverride_r1_label" aria-describedby="rateOverride_r1_error" aria-required="false" placeholder="0.00" >                                 
										</g:secureTextField>
																
										<script type="text/javascript">
										 enabledisableamount('eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}')
									    </script>
									 <input type="hidden" id="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.rateOverridehidden" value="${formatNumber(number: eligibilityHistoryVar?.rateOverride, format: '###,##0.00')}"/>                 
                                  	<div class="fms_form_error" id="rateOverride_error"></div>
								</div>
							
								<label for="spouseFlagOverride" class="control-label" id="spouseFlagOverride_label">
									<g:message code="eligHistory.spouseFlagOverride.label" default="Subscriber Rating Spouse Flag:" />
								</label>
								
								<div class="fms_form_input">                                     	
									<g:secureComboBox
										class="form-control"
										title="Value of the override Spouse Flag to be used to look up the rate table premium rather than the actual spouse flag value"
										name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.spouseFlagOverride" 
										tableName="MEMBER_ELIG_HISTORY" attributeName="spouseFlagOverride" value="${eligibilityHistoryVar.spouseFlagOverride}"
										from="${['':'', 'Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key">
									</g:secureComboBox>
									<div class="fms_form_error" id="spouseFlagOverride_error"></div>
								</div>
                           <g:each in="${memberBillingMap.get(memberDBID)}" status="j" var="billingHistoryVar">
								<g:if test="${billingHistoryVar.seqEligHist.equals(eligibilityHistoryVar.seqEligHist)}">
										
									<label for="spouseFlagOverride" class="control-label" id="spouseFlagOverride_label">
										<g:message code="billingHistory.covLevelCode.label"	default="Coverage Level Code:" />
									</label>
											<div class="fms_form_input">                                     	
												<g:secureTextField type="text" 
													class="form-control"
													maxlength="3"
													name="billingHistory.${memberDBID }.${billingHistoryVar?.seqEligHist}.covLevelCode" 
													tableName="MEMBER_ELIG_SBMT" attributeName="covLevelCode" 
													value="${billingHistoryVar?.covLevelCode}"
													title="5010 X12 data - Coverage Level Code">
												</g:secureTextField>
	                                   			<div class="fms_form_error" id="spouseFlagOverride_error"></div>
	                                	</div>
								</g:if>
							</g:each>

                               <label for="totalPremium" class="control-label" id="totalPremium_label">
                                  <g:message code="eligHistory.totalPremium.label"	default="Total Premium:" />
							   </label>
                                
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.totalPremium" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="totalPremium" 
											value="${formatNumber(number: eligibilityHistoryVar?.totalPremium, format: '###,##0.00')}"
											title="Total premium calculated per member"
											aria-labelledby="totalPremium_r1_label" aria-describedby="totalPremium_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									 <div class="fms_form_error" id="totalPremium_error"></div>
                                </div>

                                <label for="totalResAmt" class="control-label" id="totalResAmt_label">
                                	<g:message code="eligHistory.totalResAmt.label"	default="Total Responsibility Amount:" />
								</label>
                                
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.totalResAmt" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="totalResAmt" 
											value="${formatNumber(number: eligibilityHistoryVar?.totalResAmt, format: '###,##0.00')}"
											title="Total Responsibility Amount"
											aria-labelledby="totalResAmt_r1_label" aria-describedby="totalResAmt_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									  <div class="fms_form_error" id="totalResAmt_error"></div>
                                </div>

                                <label for="stateWrapCsr" class="control-label" id="stateWrapCsr_label"> 
                                	<g:message code="eligHistory.stateWrapCsr.label" default="State WRAP CSR:" />
								</label>                              
                                
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.stateWrapCsr" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="stateWrapCsr" 
											value="${formatNumber(number: eligibilityHistoryVar?.stateWrapCsr, format: '###,##0.00')}"
											title="State Cost Share Reduction amount"
											aria-labelledby="stateWrapCsr_r1_label" aria-describedby="stateWrapCsr_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									<div class="fms_form_error" id="stateWrapCsr_error"></div>
                                </div> 
								
								<label for="fedAptcCsr" class="control-label" id="fedAptcCsr_label"> 
									<g:message code="eligHistory.fedAptcCsr.label" default="Fed APTC CSR:" />
								</label>                              
                                
                                 <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.fedAptcCsr" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="fedAptcCsr" 
											value="${formatNumber(number: eligibilityHistoryVar?.fedAptcCsr, format: '###,##0.00')}" 
											title="Federal Subsidy CSR amount"
											aria-labelledby="fedAptcCsr_r1_label" aria-describedby="fedAptcCsr_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									<div class="fms_form_error" id="fedAptcCsr_error"></div>
                                </div>  
								
								<label for="famFedAptcPrem" class="control-label" id="famFedAptcPrem_label">
									<g:message code="eligHistory.famFedAptcPrem.label" default="Fam Fed APTC Premium:" />
								</label>                              
                               
                               <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="23"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.famFedAptcPrem" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="famFedAptcPrem" 
											value="${formatNumber(number: eligibilityHistoryVar?.famFedAptcPrem, format: '###,##0.00')}" 
											title="Total APTC for the family (APTC Premium)"
											aria-labelledby="famFedAptcPrem_r1_label" aria-describedby="famFedAptcPrem_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									 <div class="fms_form_error" id="famFedAptcPrem_error"></div>
                                </div>  
								
								<label for="ffmRatingArea" class="control-label" id="ffmRatingArea_label"> 
									<g:message code="eligHistory.ffmRatingArea.label" default="FFM Rating Area:" />
								</label>
								<div class="fms_form_input">                                     	
									<g:secureTextField type="text" 
														class="form-control"
														maxlength="15"
														name="eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.ffmRatingArea" 
														tableName="MEMBER_ELIG_HISTORY" attributeName="ffmRatingArea" 
														value="${eligibilityHistoryVar?.ffmRatingArea}" 
														title="Rating Area used to determine the premium amounts Identified by the category">
									</g:secureTextField>
                                  <div class="fms_form_error" id="ffmRatingArea_error"></div>
                                </div> 
								
								<label for="otherPmtAmt2" class="control-label" id="otherPmtAmt2_label"> 
									<g:message code="eligHistory.otherPmtAmt2.label" default="Other Payment Amount 2:" />
								</label>                             
                                
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.otherPmtAmt2" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="otherPmtAmt2" 
											value="${formatNumber(number: eligibilityHistoryVar?.otherPmtAmt2, format: '###,##0.00')}" 
											title="Store the value received in the 2750 Reporting Loop with a REF02 value OTH PAY AMT 2"
											aria-labelledby="otherPmtAmt2_r1_label" aria-describedby="otherPmtAmt2_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									 <div class="fms_form_error" id="otherPmtAmt2_error"></div>
                                </div> 		
                                
								<label for="userRate1" class="control-label" id="userRate1_label"> 
									<g:message code="eligHistory.userRate1.label" default="User Rate 1:" />
								</label>                             
                              
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate1" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userRate1" 
											value="${formatNumber(number: eligibilityHistoryVar?.userRate1, format: '###,##0.00')}" 
											aria-labelledby="famFedAptcPrem_r1_label" aria-describedby="famFedAptcPrem_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									  <div class="fms_form_error" id="userRate1_error"></div>
                                </div>
								
								<label for="userRate3" class="control-label" id="userRate3_label">
									<g:message code="eligHistory.userRate3.label" default="User Rate 3:" />
								</label>                              
                                
                                <div class="fms_form_input fms_has_feedback_money">
                                	<span class="fms_form_control_dollar"></span>
										<g:secureTextField class="form-control amtNumeric fms_small_input" maxlength="21"
											name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.userRate3" 
											tableName="MEMBER_ELIG_HISTORY" attributeName="userRate3" 
											value="${formatNumber(number: eligibilityHistoryVar?.userRate3, format: '###,##0.00')}" 
											aria-labelledby="userRate3_r1_label" aria-describedby="userRate3_r1_error" aria-required="false" placeholder="0.00" >
										</g:secureTextField>
									<div class="fms_form_error" id="userRate3_error"></div>
                                </div> 
				
								<label for="aboveGiaApprovalInd" class="control-label fms_required" id="aboveGiaApprovalInd_label">
									<g:message code="eligHistory.aboveGiaApprovalInd.label" default="Above GIA Approval Indicator:" />
								</label>
								
								<div class="fms_form_input">
									<g:secureComboBox class="form-control" 
													  name="eligHistory.${memberDBID }.${eligibilityHistoryVar.seqEligHist}.aboveGiaApprovalInd" 
													  tableName="MEMBER_ELIG_HISTORY" attributeName="aboveGiaApprovalInd" value="${eligibilityHistoryVar.aboveGiaApprovalInd}"
													  from="${['N':'No', 'Y': 'Yes']}" optionValue="value" optionKey="key"
													  title="This field determines whether approval has been received for Life coverage above the GIA">
									</g:secureComboBox>									
                                     <div class="fms_form_error" id="aboveGiaApprovalInd_error"></div>
								 	 </div> 
                                  </div>                 						
								</div>
                               </fieldset>
                             </div>
						   </td>
					     </tr>
                       </g:each>
				     </tbody>
			       </table>
		        </div>
	        </div>
        </g:each>
     </div>
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
                  <button type="button" class="btn btn-danger btnResetBilling" data-dismiss="modal" onclick="this.form.reset();">Yes, Reset</button>
                </div>
              </div>
            </div>
          </div>
<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showAddress(memberSelectObject)
</script>