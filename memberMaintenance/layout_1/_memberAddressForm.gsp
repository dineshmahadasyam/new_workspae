<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.Address"%>
<%@ page import="com.perotsystems.diamond.bom.MemberAddress"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?true:false}" />

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

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
		$( "#EffectiveDate, #TermDate, #EffectiveDate_r2, #TermDate2, #EffectiveDate_n1" ).datepicker({
            numberOfMonths: 1,
            showOn: "button",
            buttonText: "<i class='fa fa-calendar'></i>",
          });
	});//]]>

	$(function($){
		   $(".SSNAddress").mask("?999-99-9999");
		   $(".maskZip").mask("?99999-9999");
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

	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/list");
	}
	
	</script>
	<head>
		<script>
		function editAddress(address){
			//var address = document.getElementById(address);
			//alert(address);
			$(document.getElementById('address.'+address+'.toggleFields')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleSaveButton')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleResetButton')).css('display','table-cell');
			$(document.getElementById('address.'+address+'.toggleEditButton')).css('display','none');
		}
		</script>
		
		
		<script type="text/javascript">
		
			$(document).ready(function() {

				$('.BtnCollapseRow').hide().removeClass('hidden');	

		      // Edit icon on table row
		         $('.tablesorter').delegate('.BtnEditRow, .BtnCollapseRow', 'click' ,function(e){
		          // e.preventDefault();  
		           var parentTR = $(this).closest('tr');
		           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
		           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
		         });

		     // Save button 
		        $('.BtnSave').click(function(e){
		          //e.preventDefault();            
		          $('#SaveAlertModal').modal('show');
		        });
		        
		        // Save Modal
		        $('.BtnSaveModal').click(function(e){
		         // e.preventDefault();            
		          //this.form.submit(); // JQuery validations will not trigger
		          $('#editForm').submit();//resetForm();
		        });
		
		      // Undo button
		        $('.BtnUndo').click(function(e){
		          //e.preventDefault();            
		          $('#WarningAlertModal').modal('show');
		        });
		
		        $('.BtnUndoModal').click(function(e){
		          //e.preventDefault(); 
		          this.form.reset();
		          resetForm();           
		        });
		        		      
		        function resetForm(){
		            $('.BtnCollapseRow').hide();
		            $('.BtnEditRow').show();
		            $('.tablesorter-childRow td').hide();
		            //$('#BtnSave').attr('disabled','disabled');
		            //$('#BtnUndo').attr('disabled','disabled');
		            //$('.UnsavedChanges').hide();          
		          }
		        
		     // On form change enable the save and reset buttons
		       /* $('form :input').on('change input', function(e) {
		          $('#BtnSave').removeAttr('disabled');
		          $('#BtnUndo').removeAttr('disabled');
		        });	*/
		        
		      //$('#DataTable').removeClass( "hidden" );
		});
		</script>
	</head>
	
	<input type="hidden" name="editType" value="ADDRESS" />
	<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />	
	
	<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<div class="right-corner" align="right">MEMBA</div>
		
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
		
		<!-- START - Data Table Section -->	
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
          	<g:checkURIAuthorization uri="/memberMaintenance/addMemberAddress">
	          	<h2>Addresses  <button name="addAddressButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new address." onClick="addAddress()"><i class="fa fa-plus"></i> New Address</button></h2>
			</g:checkURIAuthorization>
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
			<div id="dummy" style="display: none">&nbsp;</div>
		   	<g:each in="${memberAddressMap.keySet() }" status="idCount" var="memberDBID">
				<div id="${memberDBID}" style="display: none">  
					<div id="SearchResults" class="fms_widget">
		            	
		            	<!-- START - FMS Widget -->
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
							<!-- START - FMS Table Wrapper -->
				           	<div class="fms_table_wrapper">
								<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
			                  		<thead>
			                    		<tr role="row" class="tablesorter-headerRow">
					                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Effective Date</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Term Date</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Address Type</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Last Name</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Address Line 1</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">City</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">County</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">State</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Zip Code</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Country</th>
														                      			
			                      			<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
			                    		</tr>
			                  		</thead>
			                  		<tfoot></tfoot>
		      
									<tbody aria-live="polite" aria-relevant="all">                                        
			 							<g:each in="${ memberAddressMap.get(memberDBID)}" status="i" var="address">
											<input type="hidden" name="seq_address_id_${i}" value="${address.seqMembAddress}">
											<input type="hidden" name="address.${memberDBID }.${address.seqMembAddress}.iterationCount" value="${address.seqMembAddress}">
																
											<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
												<td><g:formatDate format="yyyy-MM-dd" date="${address.effectiveDate}" /></td>
												<td><g:formatDate format="yyyy-MM-dd" date="${address.termDate}" /></td>
												<td>${address.addressType}</td>
												<td>${address?.lastName}</td>
												<td>${address.address1}</td>
												<td>${address.city}</td>
												<td>${address?.county}</td>
												<td>${address.state}</td>
												<td><g:if test="${address?.zip?.length() > 5}" >${address?.zip.with {length()? getAt(0..4):''}}-${address?.zip.with {length()? getAt(5..length()-1):''}}</g:if>
													<g:elseif test="${address?.zip?.length() == 5}">${address?.zip.with {length()? getAt(0..4):''}}</g:elseif>
													<g:else></g:else>
												</td>                     
												<td>${address?.country}</td>
												<td>				
													<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        							<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
												</td>
											</tr>
							
											<tr id="Row2Child" class="tablesorter-childRow" role="row">
												<td colspan="11" id="address.${memberDBID }.${address.seqMembAddress}.toggleFields" class="" style="display:none;">
		
													<!-- START - WIDGET: General Information -->
													<div class="fms_widget">        
														<fieldset>
															<legend><h3>General Information</h3></legend>
															<div class="fms_form_layout_2column">                  
																<div class="fms_form_column fms_very_long_labels">
		
																	<label id="AddressType_r2_label" for="addressType" class="control-label fms_required" >
																		<g:message code="address.addressType.label" default="Address Type:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureSystemCodeToken
																			tableName="MEMBER_ADDRESS" attributeName="addressType"
																			systemCodeType="ADDRESSTYPE" languageId="0"
																			htmlElelmentId="address.${memberDBID}.${address.seqMembAddress}.addressType"
																			blankValue="Address Type" 
																			defaultValue="${address?.addressType}" 
																			value="${address?.addressType}"
																			cssClass="form-control"
																			title="Type of Address"
																			aria-labelledby="AddressType_r2_label" 
																			aria-describedby="AddressType_r2_error" 
																			aria-required="true" >
																			</g:secureSystemCodeToken>
																		<div class="fms_form_error" id="AddressType_r2_error"></div>
																	</div>
										  
																	<label class="control-label" id="ContractPref_r2_label" for="contactPref"> 
																		<g:message code="subscriberMember.contactPref.label" default="Contact Pref:" />
																	</label>
								
																	<div class="fms_form_input">
																		<g:secureDiamondDataWindowDetail columnName="contact_pref" dwName="dw_memba_de" languageId="0" 
																			htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.contactPref"
																			defaultValue="${address?.contactPref}" blankValue="Contact Pref"
																			name="address.${memberDBID }.${address.seqMembAddress}.contactPref" 
																			tableName="MEMBER_ADDRESS" attributeName="contactPref" value="${address?.contactPref}"
																			cssClass="form-control"
																			title="Preference of the Contact"
																			aria-labelledby="ContractPref_r2_label" 
																			aria-describedby="ContractPref_r2_error" 
																			aria-required="false"/>
																		<div class="fms_form_error" id="ContractPref_r2_error"></div>
																	</div>
		
																	<label class="control-label" id="BillingAddress_r2_label" for="billingAddress"> 
																		<g:message 	code="subscriberMember.billingAddress.label" default="Billing Address:" />
																	</label>
																  
																	<div class="fms_form_input">		
																		<g:secureComboBox
																			class="form-control fms_width_auto"
																			name="address.${memberDBID }.${address.seqMembAddress}.billingAddress" 
																			tableName="MEMBER_ADDRESS" attributeName="billingAddress" value="${address.billingAddress}"
																			from="${['Y': 'Yes', 'N': 'No']}" optionValue="value" optionKey="key"
																			title="If this is the Billing Address choose Y else choose N"
																			aria-labelledby="BillingAddress_r2_label" 
																			aria-describedby="BillingAddress_r2_error" 
																			aria-required="false">
																		</g:secureComboBox>
																		<div class="fms_form_error" id="BillingAddress_r2_error"></div>
																	</div>
																</div>
										
																<div class="fms_form_column fms_very_long_labels">
											
																	<label for="effectiveDate"class="control-label fms_required" id="EffectiveDate_r2_label" > 
																		<g:message code="subscriberMember.effectiveDate.label" default="Effective Date:" />
																	</label>
									
																	<div class="fms_form_input">
																		<g:securejqDatePickerUIUX
																			tableName="MEMBER_ADDRESS" attributeName="effectiveDate" title="Effective Date of the Address"
																			dateElementId="address.${memberDBID }.${address.seqMembAddress}.effectiveDate" 
																			dateElementName="address.${memberDBID }.${address.seqMembAddress}.effectiveDate" 
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.effectiveDate != null ? address?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.effectiveDate != null ? address?.effectiveDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.effectiveDate)}" 
																			ariaAttributes="aria-labelledby='EffectiveDate_r2_label' aria-describedby='EffectiveDate_r2_error' aria-required='false'" 
													                     	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						 													showIconDefault="${isShowCalendarIcon}"/> 
																		<div class="fms_form_error" id="EffectiveDate_r2_error"></div>
																	</div>
																	
																	<label for="termDate" class="control-label" id="TermDate_r2_label"> 
																		<g:message code="subscriberMember.termDate.label" default="Term Date:" />
																	</label>
																	<div class="fms_form_input">													
																		<g:securejqDatePickerUIUX 
																			tableName="MEMBER_ADDRESS" attributeName="termDate" title="Termination Date of the Address"
																			dateElementId="address.${memberDBID }.${address.seqMembAddress}.termDate" 
																			dateElementName="address.${memberDBID }.${address.seqMembAddress}.termDate" 
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.termDate != null ? address?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.termDate != null ? address?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.termDate)}"
																			ariaAttributes="aria-labelledby='TermDate_r2_label' aria-describedby='TermDate_r2_error' aria-required='false'" 
																			classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																			showIconDefault="${isShowCalendarIcon}" />
																		<div class="fms_form_error" id="TermDate_r2_error"></div>
																	</div>
																	
																	<label for="termReason" class="control-label" id="TermReason_r2_label" > 
																		<g:message code="subscriberMember.termReason.label" default="Term Reason:" />
																	</label>
																				
																	<div class="fms_form_input fms_has_feedback">
																	
																		<g:secureTextField maxlength="5" class="form-control"
																			name="address.${memberDBID }.${address.seqMembAddress}.termReason" 
																			tableName="MEMBER_ADDRESS" attributeName="termReason" 
																			value="${address?.termReason}"
																			title="The Reason the Address is terminated"></g:secureTextField>
																		
																		<fmsui:cdoLookup lookupElementId="address.${memberDBID }.${address.seqMembAddress}.termReason"
                                                                           lookupElementName="address.${memberDBID }.${address.seqMembAddress}.termReason" 
                                                                           lookupElementValue="${address?.termReason}"
                                                                           lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
                                                                           lookupCDOClassAttribute="reasonCode"/>																	   
																	   <div class="fms_form_error" id="TermReason_r2_error"></div>
																	</div>
																</div>
															</div>
														</fieldset>
													</div>
													<!-- END - WIDGET: General Information -->
													
													<!-- START - WIDGET: Address -->
													<div class="fms_widget">        
														<fieldset>
															<legend><h3>Address</h3></legend>
															<div class="fms_form_layout_2column">                  
																<div class="fms_form_column fms_very_long_labels">
																	
																	<%--<input type="checkbox" name="ckb" id="ckb" value="" checked="checked" /> Use member name for address.</label> --%>
								
																	<label for="lastName" class="control-label fms_required" id="LastName_r2_label" > 
																		<g:message code="subscriberMember.lastName.label" default="Last Name:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField maxlength="60"
																			name="address.${memberDBID }.${address.seqMembAddress}.lastName" 
																			tableName="MEMBER_ADDRESS" attributeName="lastName"
																			value="${address?.lastName}" 
																			type="text" class="form-control fms-alphanumeric" 
																			id="LastName_r2" 
																			title="Last Name of the Contact for the Address"
																			aria-labelledby="LastName_r2_label" aria-describedby="LastName_r2_error" 
																			aria-required="true">
																		</g:secureTextField>
																		<div class="fms_form_error" id="LastName_r2_error"></div>
																	</div>  
															
																	<label for="firstName"class="control-label" id="FirstName_r2_label"> 
																		<g:message code="subscriberMember.firstName.label" default="First Name:" />
																	</label>
																	<div class="fms_form_input">                                     	
																		<g:secureTextField type="text" 
																			class="form-control FirstName fms-alphanumeric" 
																			id="FirstName_r2" 
																			aria-labelledby="FirstName_r2_label"  
																			aria-describedby="FirstName_r2_error" aria-required="false"
																			maxlength="60" name="address.${memberDBID }.${address.seqMembAddress}.firstName" 
																			tableName="MEMBER_ADDRESS" attributeName="firstName"
																			value="${address?.firstName}"
																			title="First Name of the Contact for the Address">
																		</g:secureTextField>
																		<div class="fms_form_error" id="FirstName_r2_error"></div>
																	</div> 
									   								
									   								<label class="control-label" id="middleName_label" for="middleName"> 
																		<g:message code="subscriberMember.middleName.label" default="Middle:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.middleName" 
																			tableName="MEMBER_ADDRESS" attributeName="middleName"
																			maxlength="25"
																			value="${address?.middleName}" 
																			type="text" 
																			class="form-control" 
																			id="Address22" 
																			title="Middle Initial or Middle Name of the Contact for the Address"
																			aria-labelledby="Address22_label" 
																			aria-describedby="Address22_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="middleName_error"></div>
																	</div> 
																	
																	<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
																		<g:message code="subscriberMember.address1.label" default="Address 1:" />
																	</label>				
																	<div class="fms_form_input">
																		<g:secureTextField
																			name="address.${memberDBID }.${address.seqMembAddress}.address1"
																			tableName="MEMBER_ADDRESS" attributeName="addressLine1"
																			maxlength="60"
																			value="${address?.address1}" 
																			type="text" 
																			class="form-control" 
																			id="address1" 
																			title="Line 1 Address"
																			aria-labelledby="addressLine1_label" 
																			aria-describedby="address1_error" />
																		<div class="fms_form_error" id="addressLine1_error"></div>
																	</div> 
																	
																	<label class="control-label" id="addressLine2_label" for="address2"> 
																		<g:message code="subscriberMember.address2.label" default="Address 2:" />		
																	</label>		
																	<div class="fms_form_input">
																		<g:secureTextField 
																			 name="address.${memberDBID }.${address.seqMembAddress}.address2" 
																			 tableName="MEMBER_ADDRESS" attributeName="addressLine2" 
																			 value="${address?.address2}" 
																			 maxlength="60"
																			 type="text" 
																			 class="form-control" 
																			 id="addressLine2" 
																			 title="Line 2 Address"
																			 aria-labelledby="addressLine2_label" 
																			 aria-describedby="addressLine2_error" 
																			 aria-required="false" />
																		<div class="fms_form_error" id="addressLine2_error"></div>
																	</div> 
																	
																	<label class="control-label" id="addressLine3_label" for="addressLine3"> 
																		<g:message code="subscriberMember.addressLine3.label" default="Address 3:" />
																	</label> 
																										 
																	<div class="fms_form_input">
																		<g:secureTextField 
																		name="address.${memberDBID }.${address.seqMembAddress}.addressLine3" 
																		tableName="MEMBER_ADDRESS" attributeName="addressLine3" 
																		maxlength="60"
																		value="${address?.addressLine3}" 
																		type="text" 
																		class="form-control" 
																		id="addressLine3" 
																		title="Line 3 Address"
																		aria-labelledby="addressLine3_label" 
																		aria-describedby="addressLine3_error" 
																		aria-required="false" />
																		<div class="fms_form_error" id="addressLine3_error"></div>
																	</div> 
																	
																	<label class="control-label" id="Address4_label" for="addressLine4"> 
																		<g:message code="subscriberMember.addressLine4.label" default="Address 4:" />
																	</label>				
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.addressLine4" 
																			tableName="MEMBER_ADDRESS" attributeName="addressLine4" 
																			maxlength="60"
																			value="${address?.addressLine3}" 
																			type="text" 
																			class="form-control" 
																			id="Address4" 
																			title="Line 4 Address"
																			aria-labelledby="Address4_label" 
																			aria-describedby="Address4_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="Address4_error"></div>
																	</div> 
																																				
																	<label for="addressLine5" class="control-label" id="Address5_label">
																		<g:message code="subscriberMember.addressLine5.label" default="Address 5:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																		name="address.${memberDBID }.${address.seqMembAddress}.addressLine5"
																		tableName="MEMBER_ADDRESS" attributeName="addressLine5" 
																		maxlength="60"
																		value="${address?.addressLine5}" 
																		type="text" 
																		class="form-control" 
																		id="Address22" 
																		title="Line 5 Address"
																		aria-labelledby="Address5_label" 
																		aria-describedby="Address5_error" 
																		aria-required="false" />
																		<div class="fms_form_error" id="Address5_error"></div>
																	</div> 
																	
																	<label class="control-label" id="Address6_label" for="addressLine6"> 
																		<g:message code="subscriberMember.addressLine6.label" default="Address 6:" />
																	</label>					  
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.addressLine6"
																			tableName="MEMBER_ADDRESS" attributeName="addressLine6" 
																			maxlength="60" 
																			value="${address?.addressLine6}" 
																			type="text" 
																			class="form-control" 
																			id="Address6" 
																			title="Line 6 Address"
																			aria-labelledby="Address6_label" 
																			aria-describedby="Address6_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="Address6_error"></div>
																	</div> 
																</div>
																
																<div class="fms_form_column fms_very_long_labels">
																	
																	<label class="control-label fms_required" id="City_r2_label" for="city"> 
																		<g:message code="subscriberMember.city.label" default="City:" />
																	</label>				
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.city"
																			tableName="MEMBER_ADDRESS" attributeName="city" 
																			maxlength="30"
																			value="${address?.city}" 
																			type="text" 
																			class="form-control" 
																			id="City"
																			title="City of the Address" 
																			aria-labelledby="City_label" 
																			aria-describedby="City_error" 
																			aria-required="true" />
																		 <div class="fms_form_error" id="City_error"></div>
																	</div>
																	
																	<label class="control-label fms_required" id="State_r2_label" for="groupState"> 
																		<g:message code="subscriberMember.groupState.label" default="State:" />
																	</label>	  
																	<div class="fms_form_input">
																		<g:secureComboBox
																			class="form-control"
																			aria-labelledby="State_r2_label" aria-describedby="State_r2_error" aria-required="true"
																			name="address.${memberDBID }.${address.seqMembAddress}.state" 
																			optionKey="stateCode"
																			tableName="MEMBER_ADDRESS" attributeName="state" 
																			optionValue="stateName" id="state.name" from="${states}"
																			noSelection="['':'-- Select a State --']"
																			value="${address?.state}"
																			title="State of the Address">
																		</g:secureComboBox>
																		<div class="fms_form_error" id="State_r2_error"></div>
																	</div>
																	
																	<label class="control-label" id="County_r2_label" for="county"> 
																		<g:message code="subscriberMember.county.label" default="County:" />
																	</label>     
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.county"
																			tableName="MEMBER_ADDRESS" attributeName="county" 
																			maxlength="30"
																			value="${address?.county}" 
																			type="text" 
																			class="form-control" 
																			id="County"
																			title="County of the Address" 
																			aria-labelledby="County_label" 
																			aria-describedby="County_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="County_r2_error"></div>
																	</div>  
																	
																	<label class="control-label" id="Country_r2_label" for="country"> 
																		<g:message code="subscriberMember.country.label" default="Country:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			class="form-control"
																			aria-labelledby="Country_r2_label" 
																			aria-describedby="Country_r2_error" aria-required="false"
																			maxlength="30"
																			name="address.${memberDBID }.${address.seqMembAddress}.country" 
																			tableName="MEMBER_ADDRESS" attributeName="country" 
																			value="${address?.country}"
																			title="Country of the Address"></g:secureTextField>
																		<div class="fms_form_error" id="Country_r2_error"></div>
																	</div> 
																	
																	<label class="control-label fms_required" id="ZIP_r2_label" for="zipCode"> 
																		<g:message code="subscriberMember.zipCode.label" default="Zip Code:" />
																	</label>						
																	<div class="fms_form_input">
																		<g:secureTextField maxlength="10"
																			name="address.${memberDBID }.${address.seqMembAddress}.zip" 
																			tableName="MEMBER_ADDRESS" attributeName="zipCode"
																			value="${address?.zip}" 
																			type="text" 
																			placeholder="00000-0000"
																			class="form-control maskZip" 
																			id="ZIP_r2" 
																			title="Zip Code of the Address"
																			aria-labelledby="ZIP_r2_label" 
																			aria-describedby="ZIP_r2_error" aria-required="true" />
																		<div class="fms_form_error" id="ZIP_r2_error"></div>
																	</div>  
																	
																	<label class="control-label" id="email_label" for="email"> 
																		<g:message code="subscriberMember.email.label" default="Email Id:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.email" 
																			tableName="MEMBER_ADDRESS" attributeName="email" 
																			value="${address?.email}" maxlength="80"
																			type="text" 
																			class="form-control"
																			title="Email Address of the Contact" 
																			aria-labelledby="email_label" 
																			aria-describedby="email_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="email_error"></div>
																	</div> 
																	
																	<label class="control-label" id="countrySubdivisionCode_label" for="countrySubdivisionCode"> 
																		<g:message code="subscriberMember.countrySubdivisionCode.label" default="Country Sub Division Code:" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField type="text" class="form-control" aria-labelledby="countrySubdivisionCode_label" aria-describedby="countrySubdivisionCode_error" aria-required="false"
																			maxlength="3" name="address.${memberDBID }.${address.seqMembAddress}.countrySubdivisionCode" 
																			tableName="MEMBER_ADDRESS" attributeName="countrySubdivisionCode" 
																			value="${address?.countrySubdivisionCode}"
																			title="Country Sub Division Code of the Address">
																		</g:secureTextField>
																		<div class="fms_form_error" id="countrySubdivisionCode_error"></div>
																	</div> 
																</div>
															</div>
														</fieldset>
													</div>
													<!-- END - WIDGET: Address -->
													
													<!-- START - WIDGET: Phone -->		
													<div class="fms_widget">        
														<fieldset>
															<legend><h3>Phone</h3></legend>
															<div class="fms_form_layout_2column">                  
																<div class="fms_form_column fms_very_long_labels">
											
																	<label class="control-label" id="HomePhone_r2_label" for="homePhone"> 
																		<g:message code="subscriberMember.homePhone.label" default="Home Phone:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			id="HomePhone_r2" maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.homePhone" 
																			tableName="MEMBER_ADDRESS" attributeName="homePhoneNumber" 
																			value="${address?.homePhone}"
																			placeholder="(000) 000-0000"
																			class="form-control fms_phone_mask" 
																			title="Home Phone Number for the Address"
																			aria-labelledby="HomePhone_r2_label" aria-describedby="HomePhone_r2_error" 
																			aria-required="false"/>							
																						
																		<div class="fms_form_error" id="HomePhone_r2_error"></div>
																	</div> 
											
																	<label class="control-label" id="BusinessPhone_r2_label" for="businessPhone"> 
																		<g:message code="subscriberMember.businessPhone.label" default="Business Phone:" /> 
																	</label>
																	<div class="fms_form_input">
																	 <g:secureTextField maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.businessPhone" 
																			tableName="MEMBER_ADDRESS" attributeName="busPhoneNumber"
																			value="${address?.businessPhone}"
																			placeholder="(000) 000-0000"
																			class="form-control fms_phone_mask" 
																			id="BusinessPhone_r2" 
																			title="Business Phone Number for the Address"
																			aria-labelledby="BusinessPhone_r2_label" 
																			aria-describedby="BusinessPhone_r2_error" aria-required="false"/>
																		<div class="fms_form_error" id="BusinessPhone_r2_error"></div>
																	</div>
																	
																	<label class="control-label" id="AlternatePhone_r2_label" for="alternatePhone"> 
																		<g:message code="subscriberMember.alternatePhone.label" default="Alternate Phone:" />  
																	</label>
																	<div class="fms_form_input">
																	 <g:secureTextField maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.alternatePhone" 
																			tableName="MEMBER_ADDRESS" attributeName="alternatePhone"  
																			value="${address?.alternatePhone}"
																			placeholder="(000) 000-0000"
																			class="form-control fms_phone_mask" 
																			id="AlternatePhone_r2" 
																			title="Alternate Phone Number for the Address"
																			aria-labelledby="AlternatePhone_r2_label" 
																			aria-describedby="AlternatePhone_r2_error" aria-required="false"/>
																	 <div class="fms_form_error" id="AlternatePhone_r2_error"></div>
																	</div> 
																	
																	<label class="control-label" id="telephoneNumber_label" for="telephoneNumber"> 
																		<g:message code="subscriberMember.telephoneNumber.label" default="Telephone:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.telephoneNumber"
																			tableName="MEMBER_ADDRESS" attributeName="telephoneNumber" 
																			value="${address?.telephoneNumber}" 
																			placeholder="(000) 000-0000"
																			maxlength="40"
																			class="form-control fms_phone_mask" 
																			title="Telephone Number for the Address"
																			aria-labelledby="telephoneNumber_label" 
																			aria-describedby="telephoneNumber_error" aria-required="false" />
																		<div class="fms_form_error" id="telephoneNumber_error"></div>
																	</div> 
															 	</div>  
																<div class="fms_form_column fms_very_long_labels">
																	<label class="control-label" id="MobilePhone_r2_label" for="mobilePhone"> 
																		<g:message code="subscriberMember.mobilePhone.label" default="Mobile Phone:" />
																	</label>	
																	<div class="fms_form_input">
																		<g:secureTextField maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.mobilePhone" 
																			tableName="MEMBER_ADDRESS" attributeName="mobilePhone" 
																			value="${address?.mobilePhone}"
																			placeholder="(000) 000-0000"
																			class="form-control fms_phone_mask" 
																			id="MobilePhone_r2" 
																			title="Mobile Phone Number for the Address"
																			aria-labelledby="MobilePhone_r2_label" 
																			aria-describedby="MobilePhone_r2_error" 
																			aria-required="false"  />
																		<div class="fms_form_error" id="MobilePhone_r2_error"></div>
																	</div>
																	 
																	<label class="control-label" id="beeperNumber_label" for="beeperNumber"> 
																		<g:message code="subscriberMember.beeperNumber.label" default="Beeper Number:" />
																	</label> 
																	<div class="fms_form_input">
																		<g:secureTextField 
																			tableName="MEMBER_ADDRESS" attributeName="beeperNumber" 
																			name="address.${memberDBID }.${address.seqMembAddress}.beeperNumber" 
																			value="${address?.beeperNumber}" 
																			placeholder="(000) 000-0000"
																			maxlength="40"
																			class="form-control fms_phone_mask" 
																			title="Beeper Number for the Address"
																			aria-labelledby="beeperNumber_label" 
																			aria-describedby="beeperNumber_error" 
																			aria-required="false"/>
																		<div class="fms_form_error" id="beeperNumber_error"></div>
																	</div> 
																	
																	<label class="control-label" id="FaxNumber_r2_label"for="faxNumber"> 
																		<g:message code="subscriberMember.faxNumber.label"default="Fax Number:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.faxNumber" 
																			tableName="MEMBER_ADDRESS" attributeName="fax" 
																			value="${address?.faxNumber}" 
																			placeholder="(000) 000-0000"
																			class="form-control fms_phone_mask" 
																			id="FaxNumber_r2"
																			title="Fax Numer for the Address" 
																			aria-labelledby="FaxNumber_r2_label" 
																			aria-describedby="FaxNumber_r2_error" 
																			aria-required="false"/>
																		<div class="fms_form_error" id="FaxNumber_r2_error"></div>
																	</div>
																	
																	<label class="control-label" id="Extension_r2_label" for="telephoneNumberEx"> 
																		<g:message code="subscriberMember.telephoneNumberEx.label" default="Tel Ext:" />
																	</label>				
																	<div class="fms_form_input">
																		<g:secureTextField maxlength="40"
																			name="address.${memberDBID }.${address.seqMembAddress}.telephoneNumberEx" 
																			tableName="MEMBER_ADDRESS" attributeName="telephoneExtension" 
																			value="${address?.telephoneNumberEx}"
																			class="form-control fms_ext_mask" 
																			id="Extension_r2" placeholder="00000000"
																			title="Telephone Ext for the Telephone Number"
																			aria-labelledby="Extension_r2_label" 
																			aria-describedby="Extension_r2_error" 
																			aria-required="false"/>
																		<div class="fms_form_error" id="Extension_r2_error"></div>
																	</div>  
													
																</div>
															</div>
														</fieldset>
													</div>
													<!-- END - WIDGET: Phone -->	
													
													<!-- START - WIDGET: Other Information -->	
													<div class="fms_widget">        
														<fieldset>
															<legend><h3>Other Information</h3></legend>
															<div class="fms_form_layout_2column">                  
																<div class="fms_form_column fms_very_long_labels">
																	
																	<label class="control-label" id="prefixName_label" for="prefixName"> 
																		<g:message code="subscriberMember.prefixName.label" default="Prefix:" />
																	</label>
																	<div class="fms_form_input">
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
																			className="form-control" 
																			aria-labelledby="prefixName_label" 
																			aria-describedby="prefixName_error" 
																			type="text" 
																			aria-required="false" 
																			title="Prefix of the Contact"/>
																		<div class="fms_form_error" id="prefixName_error"></div>
																	</div>
			
																	<label class="control-label" id="suffixName_label" for="suffixName"> 
																		<g:message code="subscriberMember.suffixName.label" default="Suffix:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureCdoSelectBox
																			cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
																			tableName="MEMBER_ADDRESS" attributeName="suffixName"
																			cdoAttributeWhereValue="F"
																			cdoAttributeWhere="titleType"
																			cdoAttributeSelect="contactTitle"
																			cdoAttributeSelectDesc="description" languageId="0"
																			htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.suffixName"
																			defaultValue="${address?.suffixName}"
																			value="${address?.suffixName}" blankValue="Suffix"
																			className="form-control" type="text"
																			aria-labelledby="suffixName_label"
																			aria-describedby="suffixName_error"
																			aria-required="false" 
																			title="Suffix of the Contact"/>
																		<div class="fms_form_error" id="suffixName_error"></div>
																	</div>
								
																	<label class="control-label" id="socialSecNo_label" for="socialSecurityNumber"> 
																		<g:message code="subscriberMember.socialSecurityNumber.label" default="SSN:" />
																	</label>						
																	<div class="fms_form_input">
																		<input 
																			type="text" 
																			class="form-control fms_ssn_mask" 
																			aria-labelledby="SSN_label" 
																			aria-describedby="SSN_error" 
																			aria-required="false" 
																			placeholder="000-00-0000" 
																			name="socialSecurityNumber" 
																			id="idSocialSecurityNumber" 
																			maxlength="11" 
																			value="${params.socialSecurityNumber}"
																			title="Social Security Number of the Contact"/>
																		<div class="fms_form_error" id="SSN_error"></div>
																	</div>
																	
																	<label class="control-label" id="employerIdNumber_label" for="employeridNumber"> 
																		<g:message code="subscriberMember.employeridNumber.label" default="Emp ID Number:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.employeridNumber" 
																			tableName="MEMBER_ADDRESS" attributeName="employerIdNumber" 
																			value="${address?.employeridNumber}" 
																			type="text" maxlength="80"
																			class="form-control" 
																			aria-labelledby="employerIdNumber_label" 
																			aria-describedby="employerIdNumber_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="employerIdNumber_error"></div>
																	</div> 
																	
																	<label class="control-label" id="nationalIndivIdNumber_label" for="nationalIndividNumber"> 
																		<g:message code="subscriberMember.nationalIndividNumber.label" default="Nat. Ind. ID Number:" />
																	</label>				
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.nationalIndividNumber" 
																			tableName="MEMBER_ADDRESS" attributeName="nationalIndivIdNumber" 
																			value="${address?.nationalIndividNumber}" 
																			type="text" class="form-control" maxlength="80"
																			aria-labelledby="nationalIndivIdNumber_label" 
																			aria-describedby="nationalIndivIdNumber_error" aria-required="false" />
																		<div class="fms_form_error" id="nationalIndivIdNumber_error"></div>
																		
																	</div> 
																		
																	<label class="control-label" id="beneficiaryRelCode_label" for="beneficiaryRelationShip"> 
																		<g:message code="subscriberMember.beneficiaryRelationShip.label" default="Ben Rel Code:" />			
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.beneficiaryRelationShip" 
																			tableName="MEMBER_ADDRESS" attributeName="beneficiaryRelCode" 
																			value="${address?.beneficiaryRelationShip}" 
																			type="text" class="form-control" maxlength="1"
																			aria-labelledby="beneficiaryRelCode_label" 
																			aria-describedby="beneficiaryRelCode_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="beneficiaryRelCode_error"></div>
																	</div> 
																</div>  
																
																<div class="fms_form_column fms_very_long_labels">
																	<label class="control-label" id="beneficiaryGender_label" for="beneficiaryGender"> 
																		<g:message code="subscriberMember.beneficiaryGender.label" default="Ben Gender:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureDiamondDataWindowDetail 
																			cssClass="form-control" 
																			columnName="gender" 
																			dwName="dw_edied_de" 
																			languageId="0"
																			htmlElelmentId="address.${memberDBID }.${address.seqMembAddress}.beneficiaryGender"
																			defaultValue="${address?.beneficiaryGender}" 
																			blankValue="Benificiary Gender"
																			name="address.${memberDBID }.${address.seqMembAddress}.beneficiaryGender" 
																			tableName="MEMBER_ADDRESS" 
																			attributeName="beneficiaryGender" 
																			value="${address?.beneficiaryGender}" />
																		
																		<div class="fms_form_error" id="SelectMember_error"></div>
																	</div>
																	
																	<label class="control-label" id="beneficiaryDob_label" for="beneficiaryDOB"> 
																		<g:message code="subscriberMember.beneficiaryDOB.label" default="Ben DOB:" />
																	</label>
																	<div class="fms_form_input">													
																		<g:securejqDatePickerUIUX 
																			tableName="MEMBER_ADDRESS" attributeName="beneficiaryDob"
																			dateElementId="address.${memberDBID }.${address.seqMembAddress}.beneficiaryDOB" 
																			dateElementName="address.${memberDBID }.${address.seqMembAddress}.beneficiaryDOB" 
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.beneficiaryDOB != null ? address?.beneficiaryDOB.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:+0', numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.beneficiaryDOB)}"
																			ariaAttributes="aria-labelledby='beneficiaryDob_label' aria-describedby='beneficiaryDob_error' aria-required='false'" 
																			classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																			showIconDefault="${isShowCalendarIcon}" />
																		<div class="fms_form_error" id="beneficiaryDob_error"></div>
																	</div>
																	
																	<label class="control-label" id="memAddrUserDefined1_label" for="userDefined1"> 
																		<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_1_t" defaultText="User Defined 1:"/>
																	</label>			
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.userDefined1" 
																			tableName="MEMBER_ADDRESS" attributeName="memAddrUserDefined1"
																			value="${address?.userDefined1}" 
																			type="text" 
																			class="form-control"  
																			aria-labelledby="memAddrUserDefined1_label" 
																			aria-describedby="memAddrUserDefined1_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="memAddrUserDefined1_error"></div>
																	</div> 
																	
																	<label class="control-label" id="memAddrUserDefined2_label" for="userDefined2"> 
																		<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_2_t" defaultText="User Defined 2:"/>
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																			name="address.${memberDBID }.${address.seqMembAddress}.userDefined2" 
																			tableName="MEMBER_ADDRESS" attributeName="memAddrUserDefined2"
																			value="${address?.userDefined2}" 
																			type="text"
																			class="form-control" maxlength="30"
																			aria-labelledby="memAddrUserDefined2_label" 
																			aria-describedby="memAddrUserDefined2_error" 
																			aria-required="false" />
																		<div class="fms_form_error" id="memAddrUserDefined2_error"></div>
																	</div> 
																	
																				
																	<label class="control-label" id="memAddrUserDate1_label" for="userDate1"> 
																		<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_1_t" defaultText="User Date 1:"/>
																	</label>
																	<div class="fms_form_input">													
																		<g:securejqDatePickerUIUX 
																			tableName="MEMBER_ADDRESS" attributeName="memAddrUserDate1" 
																			dateElementId="address.${memberDBID }.${address.seqMembAddress}.userDate1" 
																			dateElementName="address.${memberDBID }.${address.seqMembAddress}.userDate1"
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate1 != null ? address?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate1 != null ? address?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1" 
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate1)}"
																			ariaAttributes="aria-labelledby='memAddrUserDate1_label' aria-describedby='memAddrUserDate1_error' aria-required='false'" 
																			classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																			showIconDefault="${isShowCalendarIcon}" />
																		<div class="fms_form_error" id="memAddrUserDate1_error"></div>
																	</div>
																	
																	<label class="control-label" id="userDate2_label" for="userDate2"> 
																		<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_2_t" defaultText="User Date 2:"/>
																	</label>
																	<div class="fms_form_input">													
																		<g:securejqDatePickerUIUX 
																			tableName="MEMBER_ADDRESS" attributeName="memAddrUserDate2"
																			dateElementId="address.${memberDBID }.${address.seqMembAddress}.userDate2" 
																			dateElementName="address.${memberDBID }.${address.seqMembAddress}.userDate2" 
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((address?.userDate2 != null ? address?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:${((address?.userDate2 != null ? address?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate2)}"
																			ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
																			classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
																			showIconDefault="${isShowCalendarIcon}" />
																		<div class="fms_form_error" id="userDate2_error"></div>
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
		<!-- START - Data Table Section -->	
	</div>
    <!-- END - FMS Content Body -->   
     
	<div id="addGroupPlaceHolder"></div>
	<script>
		var memberSelectObject = document.getElementById('memberIdSelectList')
		showAddress(memberSelectObject)
	</script> 
</div>