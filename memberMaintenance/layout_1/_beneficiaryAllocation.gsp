<%@ page import="com.dell.diamond.fms.FMSBeneficiaryObject" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.Beneficiary"%>

<html>
	<head>
		<g:set var="appContext" bean="grailsApplication"/>
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script> 
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		
		<title>FMS - Member Maintenance - Beneficiary Allocation</title>

		<script type="text/javascript">
		//<![CDATA[ 
		$(window).load(function() {
			$('.hideme').find('div').hide();
			$('.clickme').click(function() {
				$(this).parent().next('.hideme').find('div').slideToggle(500);
				return false;
			});
		
			needToConfirm = false; 
		
			var primaryCheck = true;
		 	var contingentCheck = true;
		 	var numberOfPlans = document.getElementById("numberOfPlans").value;
		 	
		 	for (j = 0; j < numberOfPlans; j++) {
				var formIdForPrimaryPercent = j+".allocatePercent.primary";
			 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
			 	var formIdForContingentPercent = j+".allocatePercent.contingent";
			 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
			 	var formPercentSave = "allocatePercentForSave."+j;
			 	
			 	if(primaryElements && primaryElements.length > 0){	
			 		var primaryTotal = 0;
				 	var number = primaryTotal;
				 	for (i = 0; i < primaryElements.length; i++) { 
					    	number += parseFloat(primaryElements[i].value);
				 	}
				 	primaryTotal = Math.round( number * 10 ) / 10;
				 	if(primaryTotal < 99.9 || primaryTotal > 100){
				 		needToConfirm = true;
					}
				}
				
			 	if(contingentElements && contingentElements.length > 0){
			 		var contingentTotal = 0;
			 		var number = contingentTotal;
				 	for (i = 0; i < contingentElements.length; i++) { 
							number += parseFloat(contingentElements[i].value);
				 	}
				 	contingentTotal = Math.round( number * 10 ) / 10;
				 	if(contingentTotal < 99.9 || contingentTotal > 100){
				 		needToConfirm = true;
					}
			 	}
		 	}
			
			$("form").submit(function() {
				needToConfirm = false;
				window.onbeforeunload = null;
			});
		
			function askConfirm() {
				if(needToConfirm){
			    	return "Beneficiary Allocation Percentages MUST add up to 100% for both the Primary and Contingent Beneficiaries!";
				}
			}
			
			window.onbeforeunload = askConfirm;
		});//]]>
		</script>
		
		<script>
			function checkPercentages(form, primary, contingent){
				//alert("form: "+form+" Primary: "+primary.value+" contingent: "+contingent.value+ " Return:"+form+".allocatePercent" );
			 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
			 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
			 	var formIdForContingentPercent = form+".allocatePercent.contingent";
			 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
			 	
			 	if(primaryElements && primaryElements.length > 0){
				 	var primaryTotal = 100 / (primaryElements.length);
				 	var number = primaryTotal;
				 	primaryTotal = Math.round( number * 10 ) / 10;
				 	for (i = 0; i < primaryElements.length; i++) { 
					    if(primary.value == "Y"){
					    	//document.getElementsByName(formIdForPrimaryPercent)[i].setAttribute('readOnly', true);
					    	primaryElements[i].value = primaryTotal;
					    	primaryElements[i].click();
						}
				 	}
				 	checkPercentforSave(form);
				}
				
			 	if(contingentElements && contingentElements.length > 0){
				 	var contingentTotal = 100 / (contingentElements.length);
				 	var number = contingentTotal;
				 	contingentTotal = Math.round( number * 10 ) / 10;
				 	for (i = 0; i < contingentElements.length; i++) { 
						if(contingent.value == "Y"){
							contingentElements[i].value = contingentTotal;
							contingentElements[i].click();
						}
				 	}
				 	checkPercentforSave(form);
			 	}
			}
		</script>
		
		<script>
			function clickFieldsToUpdateValues(form){
				//alert("form: "+form+" Primary: "+primary.value+" contingent: "+contingent.value+ " Return:"+form+".allocatePercent" );
			 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
			 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
			 	var formIdForContingentPercent = form+".allocatePercent.contingent";
			 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
			 	 
			 	if(primaryElements && primaryElements.length > 0){
				 	for (i = 0; i < primaryElements.length; i++) { 
					    primaryElements[i].click();
				 	}
				}
				
			 	if(contingentElements && contingentElements.length > 0){
				 	for (i = 0; i < contingentElements.length; i++) { 
						contingentElements[i].click();
				 	}
			 	}
			}
		</script>
		
		<script>
			function updateSeq(selectedObject, indexToUpdate){	
				var split = selectedObject.value.split(",");
				var v1 = split[0];
				var v2 = split[1];
				
				var seqIdLocation = "seqBeneficiaryIdForSave.".concat(indexToUpdate);
			    document.getElementById(seqIdLocation).value = v1;
		
			    var dateLocation = "dateOfBirthForSave".concat(indexToUpdate);
			    document.getElementById(dateLocation).value = v2;
			}
		</script>
		
		<script type="text/javascript">
			function deleteAllocation(seqId){
			    document.getElementById('deleteThisAllocation').value = seqId;
			    return true;
			}
		</script>
		
		<script type="text/javascript">
			function checkAllocationPercentagesOnClose(seqId){
			    document.getElementById('deleteThisAllocation').value = seqId;
			    return true;
			}
		</script>
		
		<script>
			function checkPercentforSave(form){
			 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
			 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
			 	var formIdForContingentPercent = form+".allocatePercent.contingent";
			 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
			 	var formPercentSave = "allocatePercentForSave."+form;
			 	var formTypeSave = "bfciaryTypeForSave."+form;
			 	var typeValue = document.getElementById(formTypeSave).value
			
			 	if(!primaryElements || primaryElements.length == 0){	
				 	if(typeValue == "P"){
				 		document.getElementById(formPercentSave).value = 100;
					}
				}
			 	else if(primaryElements && primaryElements.length > 0){	
				 	if(typeValue == "P"){
				 		var primaryTotal = 0;
					 	var number = primaryTotal;
					 	for (i = 0; i < primaryElements.length; i++) { 
						    	number += parseFloat(primaryElements[i].value);
					 	}
					 	primaryTotal = 100 - number;
					 	primaryTotal = Math.round( primaryTotal * 10 ) / 10;
					 	if(!isNaN(primaryTotal)){
					 		document.getElementById(formPercentSave).value = primaryTotal;
					 	}
				 	}
				}
				
			 	if(!contingentElements || contingentElements.length == 0){
			 		if(typeValue == "C"){
				 		document.getElementById(formPercentSave).value = 100;
					}
			 	}
			 	
			 	else if(contingentElements && contingentElements.length > 0){
				 	if(typeValue == "C"){
				 		var contingentTotal = 0;
				 		var number = contingentTotal;
					 	for (i = 0; i < contingentElements.length; i++) { 
								number += parseFloat(contingentElements[i].value);
					 	}
					 	contingentTotal = 100 - number;
					 	contingentTotal = Math.round( contingentTotal * 10 ) / 10;
					 	if(!isNaN(contingentTotal)){
							document.getElementById(formPercentSave).value = contingentTotal;
					 	}
				 	}
			 	}
			}
		</script>
		
		<script type="text/javascript">
			function addAllocation(index){
			    document.getElementById('addThisAllocationIndex').value = index;
			    return true;
			}
		</script>
		
		<script type="text/javascript">
			function updateAllocation(indexValue){
			    document.getElementById("indexForUpdate").value = indexValue;
			}
		</script>
		
		<script type="text/javascript">
			function updatePercentValue(formId, seqId, inputValue){ 
				var formDocumentId = "allocationRecord."+formId+"."+seqId+".allocatePercent";
				document.getElementById(formDocumentId).value = inputValue.value;
			}
		</script>
		
		<script>
			function updateBirthDate(indexToUpdate){
				var seqIdLocation = "seqBeneficiaryIdForSave.".concat(indexToUpdate);
				document.getElementById(seqIdLocation).value = seqId.value;
				
			    var dobLocation = "dobTrigger.".concat(indexToUpdate);
			    document.getElementById(dobLocation).value = seqId.value;
			}
		</script>
		
		<script>
		
		function editAddress(address) {
		
			$(document.getElementById('address.'+address+'.toggleFields')).css('display','table-cell');
		
			$(document.getElementById('address.'+address+'.toggleSaveButton')).css('display','table-cell');
		
			$(document.getElementById('address.'+address+'.toggleResetButton')).css('display','table-cell');
		
			$(document.getElementById('address.'+address+'.toggleEditButton')).css('display','none');
		
		}
		 function gotoSearch() {
					var appName = "${appContext.metadata['app.name']}";
					window.location.assign("/"+appName+"/memberMaintenance/list");
				}
		
		</script>
		
		
<script type="text/javascript">
		
			$(document).ready(function() {
				
				$('.btnInfoAlert').hide();  
			$('.btnInfoAlert').click(function(e){ 
	        	$('#InfoAlert').modal('show');
	        });
	     	$('#InfoAlert').modal({
	        	backdrop: 'static',
	           show: false
	       	});

	     	 
		      $('.BtnDeleteRow').click(function(e){
	              $('#DeleteAlertModal').modal('show');
	          });
		      $('#DeleteAlertModal').modal( {
			      backdrop: 'static',
			       show: false 
			  });
		      $("#BtnDeleteRowYes").click(function(e){	  		         
		               var appName = "${appContext.metadata['app.name']}";
		               var myFm = document.getElementById("editForm") ; 			
		               myFm.action = "/"+appName+"/memberMaintenance/deleteBeneficiaryAllocation";     	
		               myFm.submit();
		           
		  		});
			
			
			 $('.btnResetddressAlert').hide(); 
		    
		     $('.btnResetddressAlert').click(function(e){ 
		     	this.form.reset();
		     	$('.btnEditAddress').show();
	             $('.btnSaveAddress').hide();
	             $('.btnResetddressAlert').hide();
	             $('.tablesorter-childRow').find('td').hide();
	              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
		     	
		     	
	         });
	
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
		         
		         $('.tablesorter').delegate('.btnAddAddress', 'click' ,function(){            
		             var appName = "${appContext.metadata['app.name']}";
		             var myFm = document.getElementById("editForm") ; 			
		             myFm.action = "/"+appName+"/memberMaintenance/createBeneficiaryAllocation";     	
		             myFm.submit();
		           });
		  		
		  		
		         $('.tablesorter').delegate('.btnSaveAddress', 'click' ,function(){            
		             var appName = "${appContext.metadata['app.name']}";
		             var myFm = document.getElementById("editForm") ; 			
		             myFm.action = "/"+appName+"/memberMaintenance/updateBeneficiaryAllocation";     	
		             myFm.submit();
		           });
		         
		           $( ".btnResetddress" ).click(function() {             
		             $('.btnEditAddress').show();
		             $('.btnSaveAddress').hide();
		             $('.btnResetddressAlert').hide();
		             $('.tablesorter-childRow').find('td').hide();
		              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
		             // return false;
		           });
		
		
		           $( "#EffectiveDate, #TermDate, #EffectiveDate2, #TermDate2" ).datepicker({
		               numberOfMonths: 1,
		               showOn: "button",
		               buttonText: "<i class='fa fa-calendar'></i>",
		             });        

			   $('#DataTable').removeClass( "hidden" );
			   
			});
		
		</script>
	
		<g:javascript>
			var userflag=false;
				$(function(){
				  $("form")	   
				    .dirty_form({changedClass: "forever_changes"})
				    .dirty(function(event, data){
				      var label = $(event.target).parents("li").find("label");
				      userflag=true;	     
				    })
				});	
		</g:javascript>

	</head>

	<div id="fms_content_body">
		<div class="right-corner" align="right">MEBNA</div>
		
		
		<g:each in="${FmsBeneficiaryObjects}" status="i" var="fmsbo">
			<g:if test="${fmsbo?.plan?.planCode}">
				<g:if test="${benificiaries}"></g:if>
				<g:else>
					<ul class="errors">
					  	<li>No Beneficiaries available. Please setup Beneficiaries in Manage Beneficiaries Screen.</li>
					</ul>
				</g:else>
			</g:if>
		</g:each>
	
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
		
		<div id="DataTableSection">

			<div id="dummy" style="display: none">&nbsp;</div>
			<div class="fms_required_legend fms_required">= required</div>
		
			<div id="SearchResults" class="fms_widget">							
				<g:hiddenField name="indexForUpdate" value=""/>
				<g:hiddenField name="memberDbId" value="${subscriberMember?.memberDBID}"/>
				<g:hiddenField name="deleteThisAllocation" value=""/>
				<g:hiddenField name="addThisAllocationIndex" value=""/>
				<g:hiddenField name="subscriberId" value="${subscriberMember?.subscriberID}"/>
				<g:hiddenField name="numberOfPlans" value="${FmsBeneficiaryObjects.size()}"/>

				<!-- START - FMS Widget -->
				<div class="fms_widget">
					<div class="row bottom-margin-sm">
		                  <div class="col-xs-6">
		                    <button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
		                  </div>
		       		</div>

					<g:each in="${FmsBeneficiaryObjects}" status="i" var="fmsbo">
						<g:if test="${fmsbo?.plan?.planCode}">
	
							<!-- START - FMS Table Wrapper -->
							<div class="fms_table_wrapper">
							    <table id="DataTable" class="hidden tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
									<thead>
										<tr role="row" class="tablesorter-headerRow">
											<th>Plan Code</th>
											<th>Product Category</th>
											<tH>Short Description</th>											
											<th>Effective Date</th>
											<th>Term Date</th>
											<th>Actions</th>
		  								</tr>
									</thead>
		
									<tbody aria-live="polite" aria-relevant="all">											
										<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">													
											<td>${fmsbo.plan?.planCode}	</td>
											<td>${fmsbo.plan?.productType}</td>
											<td>${fmsbo.plan?.shortDescription}</td>
											<td><g:formatDate format="yyyy-MM-dd" date="${fmsbo.eligRecord?.effectiveDate}"/></td>
											<td><g:formatDate format="yyyy-MM-dd" date="${fmsbo.eligRecord?.termDate}"/></td>
											<td>
												<button id="BtnAddressEdit2"  type="button" class="btn fms_btn_icon btn-sm btnEditAddress" title="Click to edit beneficiary."><span class="glyphicon glyphicon-pencil"></span></button>
		      									<button id="BtnAddressSave2" type="button" class="btn fms_btn_icon btn-sm btnSaveAddress" onclick="updateAllocation(${i}); clickFieldsToUpdateValues(${i});" title="Click to save beneficiary changes."><span class="fa fa-floppy-o"></span></button>
												<button id="BtnAddressReset2" type="button" class="btn fms_btn_icon btn-sm btnResetddressAlert" onclick="clickFieldsToUpdateValues(${i});" title="Click to reset beneficiary details."><span class="glyphicon glyphicon-repeat"></span></button>
					
											</td>
										</tr>
			
										<tr id="Row2Child" class="tablesorter-childRow" role="row">
		   									<td colspan="6" id="" class="" style="display:none;">
		   									
		   										<%--I widget start --%>
												<div class="fms_widget">        
													<g:hiddenField name="createPlanType.${i}" value="${fmsbo.plan?.productType}"/>
													<g:hiddenField name="createPlanCode.${i}" value="${fmsbo.plan?.planCode}"/>
													<g:hiddenField name="seqBeneficiaryIdForSave.${i}" value=""/>	
													<fieldset>
		     											<legend><h3>Allocation</h3></legend>
														<div class="fms_form_layout_1column">                  
												      		<div class="fms_form_column fms_very_long_labels">
		
																<label for="allocatePrimaryBenif" class="control-label" id="allocatePrimaryBenif_label">
																   	<g:message code="eligHistory.voidEligFlag.label" default="Allocate percentage evenly to all Primary Beneficiaries?"/>
																</label>                             
																<div class="fms_form_input form-inline">								                 
																	<select class="form-control" name="allocatePrimaryBenif${i}" aria-labelledby="allocatePrimaryBenif_label" aria-describedby="allocatePrimaryBenif${i}_error" aria-required="true" onChange="checkPercentages(${i}, allocatePrimaryBenif${i}, allocateContingentBenif${i})">
																		<option value="N">No</option>
																		<option value="Y">Yes</option>
																	</select>
																	<div class="fms_form_error" id="allocatePrimaryBenif${i}_error"></div>
																</div>
		
																<label for="allocateContingentBenif" class="control-label" id="allocateContingentBenif_label">
																	<g:message code="eligHistory.voidEligFlag.label" default="Allocate percentage evenly to all Contingent Beneficiaries?" />
																</label>                           
																<div class="fms_form_input form-inline">								                 
																	<select class="form-control" name="allocateContingentBenif${i}" onChange="checkPercentages(${i}, allocatePrimaryBenif${i}, allocateContingentBenif${i})">
																		<option value="N">No</option>
																		<option value="Y">Yes</option>
																	</select>
																	<div class="fms_form_error" id="allocateContingentBenif_error"></div>
																</div>													
															</div>
														</div>
													</fieldset>
												</div>	
												
												<%--I widget end ..II widget start --%>
												
												<g:each in="${fmsbo?.beneficiaryAllcoation}" status="j" var="benefAllocationObject">													
													<g:if test="${benefAllocationObject.planCode.equals(fmsbo.eligRecord?.planCode)}">
														<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
																			
															<div class="fms_widget">        
					          									<fieldset>
					                								<legend><h3>Beneficiary</h3></legend>				                               
																	<div class="fms_form_layout_2column">    
																		<div class="fms_form_column fms_very_long_labels">			                           			
		
																			<label for="bfciaryName" class="control-label fms_required"> 
																				<g:message code="bfciaryName.label" default="Name: " />																	
																			</label>
																			<div class="fms_form_input">
																				<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																					<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																						<g:textField class="form-control" title="The Beneficiary Name" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled" value="${benefObject.bfciaryName}" />
																						<div class="fms_form_error" id="bfciaryName_r2_error"></div>
																					</g:if>
																				</g:each>																
																			</div>	
		
																			<label for="bfciaryType" class="control-label fms_required" > 
																				<g:message code="beneficiary.bfciaryType.label" default="Type: " />																		
																			</label>
																			<div class="fms_form_input">
																				<select class="form-control" name="bfciaryType.${i}.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled">
																					<option value="P" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')) ? 'selected':'' }>Primary</option>
																					<option value="C" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')) ? 'selected':'' }>Contingent</option>
																				</select>	
																				<div class="fms_form_error" id="bfciaryType_r2_error"></div>
																			</div>					
		             													</div>
																		
																		<div class="fms_form_column fms_very_long_labels">
		             														<label for="dateOfBirth" class="control-label"> 
		             															<g:message	code="beneficiary.dateOfBirth.label" default="Date of Birth: " />														
																			</label>
																			<div class="fms_form_input">
																				<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																					<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																						<g:textField class="form-control" title="The Beneficiary Date of Birth" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}.placeholder" disabled="disabled" size="10" value="${formatDate(date: benefObject.dateOfBirth, format: 'MM/dd/yyyy')}" />
																						<div class="fms_form_error" id="dateOfBirth_r2_error"></div>
																					</g:if>
																				</g:each>	
																			</div>					                           			
		
																			<label for="allocatePercent" class="control-label fms_required"> 
																				<g:message	code="beneficiary.allocatePercent.label" default="Payout Percent: " />
																			</label>
																			<div class="fms_form_input fms_has_feedback_percentage">																		
																				<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
																					<g:textField class="form-control fms_small_input fms_percentage_mask" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.primary" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																						onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																						onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"
																						aria-labelledby="allocatePercent_r1_label" aria-describedby="allocatePercent_r1_error" aria-required="false"/>
																						<span class="fms_form_control_percentage"></span>
																					<div class="fms_form_error" id="allocatePercent_r2_error"></div>
																					<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																			
																				</g:if>
																				<g:else>
																					<g:textField class="form-control fms_small_input fms_percentage_mask" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.contingent" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																						onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																						onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"
																						aria-labelledby="allocatePercent_r1_label" aria-describedby="allocatePercent_r1_error" aria-required="false"/>
																						<span class="fms_form_control_percentage"></span>
																						<div class="fms_form_error" id="allocatePercent_r2_error"></div>
																						<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																				</g:else>
																			</div>
		
												              			</div>
												            		</div>			
																	<div class="fms_form_button">	
																		<g:hiddenField name="seqBfciaryAllocId.${benefAllocationObject?.seqBfciaryAllocId}" value="${benefAllocationObject?.seqBfciaryAllocId}"/>																	
																		
																		<button 
																			id="BtnAddressDelete2" 
																			type="button" 
																			class="btn btn-primary BtnDeleteRow" 
																			title="Click to delete beneficiary details." 
																			data-target="#DeleteAlertModal"  
																			onclick="deleteAllocation(${benefAllocationObject?.seqBfciaryAllocId})" >
																		<i class="fa fa-trash"></i> Delete
																		</button>
																	</div>
																</fieldset>
															</div>
														</g:if>
													</g:if>
												</g:each>		
												<%--loop ends --%>
													
												<g:each in="${fmsbo?.beneficiaryAllcoation}" status="j" var="benefAllocationObject">
													<g:if test="${benefAllocationObject.planCode.equals(fmsbo.eligRecord?.planCode)}">
														<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')}">
																
															<div class="fms_widget">        
					      										<fieldset>
					              									<legend><h3>Beneficiary</h3></legend>				                               
																	<div class="fms_form_layout_2column">    
																		<div class="fms_form_column fms_very_long_labels">			                           			
		
																			<label for="bfciaryName" class="control-label fms_required"> 
																				<g:message code="bfciaryName.label" default="Name: " />																	
																			</label>
																			<div class="fms_form_input">
																				<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																					<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																						<g:textField class="form-control" title="The Beneficiary Name" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled" value="${benefObject.bfciaryName}" />
																						<div class="fms_form_error" id="bfciaryName_r2_error"></div>
																					</g:if>
																				</g:each>																
																			</div>	
																				
																			<label for="bfciaryType" class="control-label fms_required" > 
																				<g:message code="beneficiary.bfciaryType.label" default="Type: " />																		
																			</label>
																			<div class="fms_form_input">
																				<select class="form-control" name="bfciaryType.${i}.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled">
																					<option value="P" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')) ? 'selected':'' }>Primary</option>
																					<option value="C" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')) ? 'selected':'' }>Contingent</option>
																				</select>
																				<div class="fms_form_error" id="bfciaryType_r2_error"></div>
																			</div>			
		             													</div>
		             			
		             													<div class="fms_form_column fms_very_long_labels">	
		             			
		       																<label for="dateOfBirth" class="control-label"> 
		             															<g:message	code="beneficiary.dateOfBirth.label" default="Date of Birth: " />														
																			</label>
																			<div class="fms_form_input">
																				<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																					<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																						<g:textField class="form-control" title="The Beneficiary Date of Birth" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}.placeholder" disabled="disabled" size="10" value="${formatDate(date: benefObject.dateOfBirth, format: 'MM/dd/yyyy')}" />
																						<div class="fms_form_error" id="dateOfBirth_r2_error"></div>
																					</g:if>
																				</g:each>	
																			</div>					                           			
		
																			<label for="allocatePercent" class="control-label fms_required"> 
																				<g:message code="beneficiary.allocatePercent.label" default="Payout Percent: " />
																			</label>
																			<div class="fms_form_input fms_has_feedback_percentage">																		
																				<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
																					<g:textField  class="form-control fms_small_input fms_percentage_mask" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.primary" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																						onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																						onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"
																						aria-labelledby="allocatePercent_r1_label" aria-describedby="allocatePercent_r1_error" aria-required="false" placeholder="0.0"/>
																						<span class="fms_form_control_percentage"></span>
																					<div class="fms_form_error" id="allocatePercent_r2_error"></div>
																					<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																				</g:if>
																				<g:else>
																					<g:textField class="form-control fms_small_input fms_percentage_mask" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.contingent" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																						onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																						onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"
																						aria-labelledby="allocatePercent_r1_label" aria-describedby="allocatePercent_r1_error" aria-required="false" placeholder="0.0"/>
																						<span class="fms_form_control_percentage"></span>
																					<div class="fms_form_error" id="allocatePercent_r2_error"></div>
																					<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																				</g:else>
																			</div>
																			
																		</div>				                           			
		             	        									</div>	
		             	        									
		             	        									<div class="fms_form_button">
																		<g:hiddenField name="seqBfciaryAllocId.${benefAllocationObject?.seqBfciaryAllocId}" value="${benefAllocationObject?.seqBfciaryAllocId}"/>
		
																		<button 
																			id="BtnAddressDelete2" 
																			type="button" 
																			class="btn btn-primary BtnDeleteRow" 
																			title="Click to delete beneficiary details." 
																			data-target="#DeleteAlertModal"  
																			onclick="deleteAllocation(${benefAllocationObject?.seqBfciaryAllocId})" >
																		<i class="fa fa-trash"></i> Delete
																		</button>
																	</div>
																</fieldset>
															</div>
														</g:if>
													</g:if>
												</g:each>
												<%-- II widget end--%>
												
												<%-- Empty form Start --%>
												<div class="fms_widget">        
		     										<fieldset>
										                <legend><h3>Beneficiary</h3></legend>	
										                <div class="fms_form_layout_2column">    
		                									<div class="fms_form_column fms_very_long_labels">	
		                			
		                										<label for="bfciaryName" class="control-label fms_required"> 
		                 											<g:message code="bfciaryName.label" default="Name: " />																	
																</label>
																<div class="fms_form_input">
																	<g:if test="${benificiaries}">
																		<g:select title="The Beneficiary Name" name="bfciaryNameForSave.${i}" class="form-control"
																			from="${benificiaries}" noSelection="${['null':'-- Beneficiary Name --']}"
																			optionKey="${{it.seqBfciaryId + ',' + formatDate(date: it.dateOfBirth, format: 'MM/dd/yyyy')}}"
																			optionValue="bfciaryName" onChange="updateSeq(this,${i.toString()});checkPercentforSave(${i});">																
																		</g:select>
																		<div class="fms_form_error" id="bfciaryName_r2_error"></div>
																	</g:if>
																	<g:else>
																		<g:textField class="form-control" name="Beneficiary_Name" title="The Beneficiary Name" disabled="disabled" />
																	</g:else>
																</div>	
		              		
		              											<label for="bfciaryTypeForSave" class="control-label fms_required" > 
																	<g:message code="beneficiary.bfciaryType.label" default="Type: "/>																		
																</label>
																<div class="fms_form_input">
																	<select class="form-control" name="bfciaryTypeForSave.${i}" id="bfciaryTypeForSave.${i}" onChange="checkPercentforSave(${i});" title="Beneficiary Type">
																		<option value="P">Primary</option>
																		<option value="C">Contingent</option>
																	</select>
																	<div class="fms_form_error" id="bfciaryTypeForSave_r2_error"></div>
																</div>			
		           	 										</div>
		  
		  													<div class="fms_form_column fms_very_long_labels">	
		  														<label for="dateOfBirthForSave" class="control-label"> 
		   															<g:message code="beneficiary.dateOfBirthForSave.label" default="Date of Birth: " />																	
																</label>
																<div class="fms_form_input">
																	<g:textField class="form-control" title="The Beneficiary Date of Birth" name="dateOfBirthForSave${i}" size="10" readonly="readonly" value="${formatDate(date: null, format: 'MM/dd/yyyy')}" />	
																    <div class="fms_form_error" id="dateOfBirthForSave_r2_error"></div>
																</div>	
		              		
																<label for="allocatePercentForSave" class="control-label fms_required" > 
																	<g:message code="beneficiary.allocatePercentForSave.label" default="Payout Percent: " />																		
																</label>
																<div class="fms_form_input fms_has_feedback_percentage">
																	<g:textField class="amtNumeric"  class="form-control fms_small_input fms_percentage_mask"
																		title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." 
																		name="allocatePercentForSave.${i}" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" 
																		max="100" min="0"maxlength="5" size="5"  value="${benefAllocationObject?.allocatePercent}"
																		aria-labelledby="allocatePercent_r1_label" aria-describedby="allocatePercent_r1_error" aria-required="false"/>
																		<span class="fms_form_control_percentage"></span>
																	<div class="fms_form_error" id="allocatePercentForSave_r2_error"></div>
																</div>	
		                             						</div>
		                         						</div>
		                         						<g:if test="${benificiaries}">
		                         							<div class="fms_form_button">	
																<g:checkURIAuthorization uri="/beneficiaryAllocation/addBeneficiaryAllocation">
																	<button name="addDetails" class="btn btn-primary btnAddAddress" title="Click to add Detail." onclick="addAllocation(${i}); updateAllocation(${i});" ><i class="fa fa-plus"></i> Add</button>
																</g:checkURIAuthorization>
															</div>
														</g:if>
														<g:else></g:else>
													</fieldset>	
		           								</div>
		           								<%-- Empty form End --%>
		         							</td>
										</tr>				          
									</tbody>
								</table>
							</div>
						</g:if>
					</g:each>
				</div>
			</div>
		</div>
	</div>
 
	 
	<div id="addGroupPlaceHolder"></div>
	
	<!-- START - Delete Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4>Are you sure you want to delete this record?</h4>            
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal" >Yes, Delete</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Delete Notice Modal -->

</html>