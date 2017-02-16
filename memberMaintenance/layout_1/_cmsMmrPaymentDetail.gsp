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
		   $(".maskZip").mask("99999?-9999");
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

				// If all rows are deleted show message
		        if ($('#DataTable td').length <= 0) {
		            $('#BtnSave').attr('disabled', 'disabled');
		            $('#BtnUndo').attr('disabled', 'disabled');
		          $('#DataTable').append('<tr id="EmptyTable"><td colspan="13">There are no records to display</td></tr>');
		        }

		        // Click on save button in add form
		        // Hide form show table 
		        // Remove empty table row (if one)
		        // Add clone rows and updates tablesorter
		        $("#BtnAddNewSave").click(function(){ 
		          $('#DataTable #EmptyTable').remove(); 
		          $("#DataTableSection").show(); 
		          $("#BtnAddNewSection").hide();
		          updateCloneIDs();
		          storeSampleRow.clone().appendTo( "#DataTable tbody" );
		          storeSampleRowChild.clone().appendTo( "#DataTable tbody" );
		          $('#DataTable').trigger('update');             
		        });
		        

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
		         $('#BtnSaveModal').click(function(e){
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
		<div class="right-corner" align="right">MMRPD</div>
		
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
	          	<h2>CMS MMR Payment Detail <%-- <button name="addAddressButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new address." onClick="addAddress()"><i class="fa fa-plus"></i> New Address</button>--%></h2>
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
		   	<g:each in="${memberPmtDtlMap.keySet() }" status="idCount" var="memberDBID">
				<div id="${memberDBID}" style="display: none">  
					<div id="SearchResults" class="fms_widget">
		            	
		            	<!-- START - FMS Widget -->
						<div class="fms_widget">
						
							<div class="row bottom-margin-sm">
				                  <div class="col-xs-6">
				                    <button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
				                  </div>
				                  <div class="col-xs-6 text-right">
				                   <%--<button id="BtnSave" class="btn btn-primary btn-sm BtnSave" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
				                    <button id="BtnUndo" class="btn btn-default btn-sm BtnUndo" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button> --%> 
				                  </div>
				       		</div>
				       		
							<!-- START - FMS Table Wrapper -->
				           	<div class="fms_table_wrapper">
								<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
			                  		<thead>
			                    		<tr role="row" class="tablesorter-headerRow">
					                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Payment Date</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">MMR Run Date</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">CMS Plan Code</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Start Date</th>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">End Date</th>														                      			
			                      			<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
			                    		</tr>
			                  		</thead>
			                  		<tfoot></tfoot>
		      
									<tbody aria-live="polite" aria-relevant="all">                                        
			 							<g:each in="${ memberPmtDtlMap.get(memberDBID)}" status="i" var="mmrMaster">																
											<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
												<td><g:formatDate format="yyyy-MM-dd" date="${mmrMaster.paymentDate}" /></td>
												<td><g:formatDate format="yyyy-MM-dd" date="${mmrMaster.mmrRunDate}" /></td>
												<td></td>
												<td><g:formatDate format="yyyy-MM-dd" date="${mmrMaster.paymentStartDate}" /></td>
												<td><g:formatDate format="yyyy-MM-dd" date="${mmrMaster.paymentEndDate}" /></td>
												
												<td>				
													<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        							<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
												</td>
											</tr>
							
											<tr id="Row2Child" class="tablesorter-childRow" role="row">
												<td colspan="11" id="address.toggleFields" class="" style="display:none;">
		
													<div class="fms_widget">        
		          <fieldset class="no_border">
		             <%--  <h3>Batch Information</h3>
		              <br>
		              <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label fms_required" for="batchId_v0" id="batchId_label_v0">Batch ID:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="batchId" aria-labelledby="batchId_label_v0"  aria-describedby="batchId_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.batchId}" maxlength="30" readOnly="true" style="background-color:#CCC" name="batchId">
		                        <div class="fms_form_error" id="batchId_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="transactionId_v0" id="transactionId_v0_label">Transaction ID:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="transactionId" id="transactionId" aria-labelledby="transactionId_v0_label" aria-describedby="transactionId_v0_error" aria-required="false"
		                        	value="${mmrMaster?.transactionId}" maxlength="30">
		                        <div class="fms_form_error" id="transactionId_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                </div>
		              <br>--%>
		              <h3>Member Information</h3>
		              <br>
		              <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="medicareNo_v0" id="medicareNo_label_v0">Medicare/HIC No:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" readonly="readonly" type="text" class="form-control " id="medicareNo" aria-labelledby="medicareNo_label_v0"  aria-describedby="medicareNo_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.hicNo}" maxlength="30" name="medicareNo">
		                        <div class="fms_form_error" id="medicareNo_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="eghpFlag_v0" id="eghpFlag_v0_label">EGHP Flag:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="eghpFlag" id="eghpFlag" aria-labelledby="eghpFlag_v0_label" aria-describedby="eghpFlag_v0_error" aria-required="false"
		                        	value="${mmrMaster?.eghpFlag}" maxlength="30">
		                        <div class="fms_form_error" id="eghpFlag_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="lastName_v0" id="lastName_label_v0">Last Name:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="lastName" aria-labelledby="LanguageCode_label_v0"  aria-describedby="lastName_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.lastName}" maxlength="30" name="lastName">
		                        <div class="fms_form_error" id="lastName_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partA_v0" id="partA_v0_label">Part A Entitlement:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partA" id="partA" aria-labelledby="partA_v0_label" aria-describedby="partA_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partA}" maxlength="30">
		                        <div class="fms_form_error" id="partA_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="firstName_v0" id="firstName_label_v0">First Initial:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="firstName" aria-labelledby="LanguageCode_label_v0"  aria-describedby="firstName_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.firstName}" maxlength="30" name="firstName">
		                        <div class="fms_form_error" id="firstName_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partB_v0" id="partB_v0_label">Part B Entitlement:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partB" id="partB" aria-labelledby="partB_v0_label" aria-describedby="partB_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partB}" maxlength="30">
		                        <div class="fms_form_error" id="partB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="gender_v0" id="gender_label_v0">Gender:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="gender" aria-labelledby="LanguageCode_label_v0"  aria-describedby="gender_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.gender}" maxlength="30" name="gender">
		                        <div class="fms_form_error" id="gender_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="pbpCode_v0" id="pbpCode_v0_label">Plan Benefit Pkg ID:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="pbpCode" id="pbpCode" aria-labelledby="pbpCode_v0_label" aria-describedby="pbpCode_v0_error" aria-required="false"
		                        	value="${mmrMaster?.pbpCode}" maxlength="30">
		                        <div class="fms_form_error" id="pbpCode_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="dob_v0" id="dob_label_v0">Date of Birth:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="dob" aria-labelledby="LanguageCode_label_v0"  aria-describedby="dob_error_v0" aria-required="false" 
		                        	value="<g:formatDate format="MM/dd/yyyy" date="${mmrMaster?.dob}" />" name="dob">
		                        <div class="fms_form_error" id="dob_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="pbpSegmentId_v0" id="pbpSegmentId_v0_label">PBP Segment ID:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="pbpSegmentId" id="pbpSegmentId" aria-labelledby="pbpSegmentId_v0_label" aria-describedby="pbpSegmentId_v0_error" aria-required="false"
		                        	value="${mmrMaster?.pbpSegmentId}" maxlength="30">
		                        <div class="fms_form_error" id="pbpSegmentId_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="ageGroup_v0" id="ageGroup_label_v0">Age Group:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="ageGroup" aria-labelledby="LanguageCode_label_v0"  aria-describedby="ageGroup_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.ageGroup}" maxlength="30" name="ageGroup">
		                        <div class="fms_form_error" id="ageGroup_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="enrollmentSource_v0" id="enrollmentSource_v0_label">Enrollment Source:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="enrollmentSource" id="enrollmentSource" aria-labelledby="enrollmentSource_v0_label" aria-describedby="enrollmentSource_v0_error" aria-required="false"
		                        	value="${mmrMaster?.enrollmentSource}" maxlength="30">
		                        <div class="fms_form_error" id="enrollmentSource_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="stateAndCountyCode_v0" id="stateAndCountyCode_label_v0">State & County Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="stateAndCountyCode" aria-labelledby="LanguageCode_label_v0"  aria-describedby="stateAndCountyCode_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.stateAndCountyCode}" maxlength="30" name="stateAndCountyCode">
		                        <div class="fms_form_error" id="stateAndCountyCode_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="raceCode_v0" id="raceCode_v0_label">Race Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="raceCode" id="raceCode" aria-labelledby="raceCode_v0_label" aria-describedby="raceCode_v0_error" aria-required="false"
		                        	value="${mmrMaster?.raceCode}" maxlength="30">
		                        <div class="fms_form_error" id="raceCode_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="outOfAreaInd_v0" id="outOfAreaInd_label_v0">Out of Area:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="outOfAreaInd" aria-labelledby="outOfAreaInd_label_v0"  aria-describedby="outOfAreaInd_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.outOfAreaInd}" maxlength="30" name="outOfAreaInd">
		                        <div class="fms_form_error" id="outOfAreaInd_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                </div>
		              <br>
		              <h3>Health Status Indicators</h3>
		              <br>
		              <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="currMedicaidStatus_v0" id="currMedicaidStatus_label_v0">Current Medicaid Status:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="currMedicaidStatus" aria-labelledby="LanguageCode_label_v0"  aria-describedby="currMedicaidStatus_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.currMedicaidStatus}" maxlength="30" name="currMedicaidStatus">
		                        <div class="fms_form_error" id="currMedicaidStatus_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="medicaidDualStatus_v0" id="medicaidDualStatus_v0_label">Medicaid Dual Status Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="medicaidDualStatus" id="medicaidDualStatus" aria-labelledby="medicaidDualStatus_v0_label" aria-describedby="medicaidDualStatus_v0_error" aria-required="false"
		                        	value="${mmrMaster?.medicaidDualStatus}" maxlength="30">
		                        <div class="fms_form_error" id="medicaidDualStatus_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="medicaid_v0" id="medicaid_label_v0">New Medicare Ben Medicaid Status:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="medicaid" aria-labelledby="medicaid_label_v0"  aria-describedby="medicaid_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.medicaid}" maxlength="30" name="medicaid">
		                        <div class="fms_form_error" id="medicaid_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="institutional_v0" id="institutional_v0_label">Institutional:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="institutional" id="institutional" aria-labelledby="institutional_v0_label" aria-describedby="institutional_v0_error" aria-required="false"
		                        	value="${mmrMaster?.institutional}" maxlength="30">
		                        <div class="fms_form_error" id="institutional_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="hospice_v0" id="hospice_label_v0">Hospice:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="hospice" aria-labelledby="LanguageCode_label_v0"  aria-describedby="hospice_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.hospice}" maxlength="30" name="hospice">
		                        <div class="fms_form_error" id="hospice_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="lti_v0" id="lti_v0_label">LTI Flag:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="lti" id="lti" aria-labelledby="lti_v0_label" aria-describedby="lti_v0_error" aria-required="false"
		                        	value="${mmrMaster?.lti}" maxlength="30">
		                        <div class="fms_form_error" id="lti_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="esrd_v0" id="esrd_label_v0">ESRD:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="esrd" aria-labelledby="LanguageCode_label_v0"  aria-describedby="esrd_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.esrd}" maxlength="30" name="esrd">
		                        <div class="fms_form_error" id="esrd_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="esrdMsp_v0" id="esrdMsp_v0_label">ESRD MSP Flag:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="esrdMsp" id="esrdMsp" aria-labelledby="esrdMsp_v0_label" aria-describedby="esrdMsp_v0_error" aria-required="false"
		                        	value="${mmrMaster?.esrdMsp}" maxlength="30">
		                        <div class="fms_form_error" id="esrdMsp_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="workingAged_v0" id="workingAged_label_v0">Working Aged/Disabled MSP:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="workingAged" aria-labelledby="LanguageCode_label_v0"  aria-describedby="workingAged_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.workingAged}" maxlength="30" name="workingAged">
		                        <div class="fms_form_error" id="workingAged_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="nhc_v0" id="nhc_v0_label">NHC:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="nhc" id="nhc" aria-labelledby="nhc_v0_label" aria-describedby="nhc_v0_error" aria-required="false"
		                        	value="${mmrMaster?.nhc}" maxlength="30">
		                        <div class="fms_form_error" id="nhc_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>		                
		                </div>
		                <br>
		                <h3>Risk Adjuster Indicators</h3>
		                <br>
		                 <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="riskAdjustorFactorA_v0" id="riskAdjustorFactorA_label_v0">Risk Adjuster Factor A:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="riskAdjustorFactorA" aria-labelledby="LanguageCode_label_v0"  aria-describedby="riskAdjustorFactorA_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.riskAdjustorFactorA}" maxlength="30" name="riskAdjustorFactorA">
		                        <div class="fms_form_error" id="riskAdjustorFactorA_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="prevDisabledRatio_v0" id="prevDisabledRatio_v0_label">Previously Disable Ratio (PRDIB):</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="prevDisabledRatio" id="prevDisabledRatio" aria-labelledby="prevDisabledRatio_v0_label" aria-describedby="prevDisabledRatio_v0_error" aria-required="false"
		                        	value="${mmrMaster?.prevDisabledRatio}" maxlength="30">
		                        <div class="fms_form_error" id="prevDisabledRatio_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="riskAdjustorFactorB_v0" id="riskAdjustorFactorB_label_v0">Risk Adjuster Factor B:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="riskAdjustorFactorB" aria-labelledby="riskAdjustorFactorB_label_v0"  aria-describedby="riskAdjustorFactorB_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.riskAdjustorFactorB}" maxlength="30" name="riskAdjustorFactorB">
		                        <div class="fms_form_error" id="riskAdjustorFactorB_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="frailtyIndicator_v0" id="frailtyIndicator_v0_label">Frailty Indicator:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="frailtyIndicator" id="frailtyIndicator" aria-labelledby="frailtyIndicator_v0_label" aria-describedby="frailtyIndicator_v0_error" aria-required="false"
		                        	value="${mmrMaster?.frailtyIndicator}" maxlength="30">
		                        <div class="fms_form_error" id="frailtyIndicator_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="riskAdjAgeGroup_v0" id="riskAdjAgeGroup_label_v0">Risk Adjuster Age Group:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="riskAdjAgeGroup" aria-labelledby="riskAdjAgeGroup_label_v0"  aria-describedby="riskAdjAgeGroup_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.riskAdjAgeGroup}" maxlength="30" name="riskAdjAgeGroup">
		                        <div class="fms_form_error" id="riskAdjAgeGroup_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="orec_v0" id="orec_v0_label">Original Reason Entitlement (OREC):</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="orec" id="orec" aria-labelledby="orec_v0_label" aria-describedby="orec_v0_error" aria-required="false"
		                        	value="${mmrMaster?.orec}" maxlength="30">
		                        <div class="fms_form_error" id="orec_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="raFactorTypeCode_v0" id="raFactorTypeCode_label_v0">RA Factor Type Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="raFactorTypeCode" aria-labelledby="raFactorTypeCode_label_v0"  aria-describedby="raFactorTypeCode_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.raFactorTypeCode}" maxlength="30" name="raFactorTypeCode">
		                        <div class="fms_form_error" id="raFactorTypeCode_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="lagIndicator_v0" id="lagIndicator_v0_label">Lag Indicator:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="lagIndicator" id="lagIndicator" aria-labelledby="lagIndicator_v0_label" aria-describedby="lagIndicator_v0_error" aria-required="false"
		                        	value="${mmrMaster?.lagIndicator}" maxlength="30">
		                        <div class="fms_form_error" id="Description_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="medicaidIndicator_v0" id="medicaidIndicator_label_v0">Medicaid Indicator:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="medicaidIndicator" aria-labelledby="medicaidIndicator_label_v0"  aria-describedby="medicaidIndicator_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.medicaidIndicator}" maxlength="30" name="medicaidIndicator">
		                        <div class="fms_form_error" id="medicaidIndicator_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partcFrailtyScoreFactor_v0" id="partcFrailtyScoreFactor_v0_label">Part C Frailty Score Factor:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partcFrailtyScoreFactor" id="partcFrailtyScoreFactor" aria-labelledby="partcFrailtyScoreFactor_v0_label" aria-describedby="partcFrailtyScoreFactor_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partcFrailtyScoreFactor}" maxlength="30">
		                        <div class="fms_form_error" id="partcFrailtyScoreFactor_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="pipDcg_v0" id="pipDcg_label_v0">PIP-DCG</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="pipDcg" aria-labelledby="pipDcg_label_v0"  aria-describedby="pipDcg_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.pipDcg}" maxlength="30" name="pipDcg">
		                        <div class="fms_form_error" id="pipDcg_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="defaultFactor_v0" id="defaultFactor_v0_label">Default Risk Factor Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="defaultFactor" id="defaultFactor" aria-labelledby="defaultFactor_v0_label" aria-describedby="defaultFactor_v0_error" aria-required="false"
		                        	value="${mmrMaster?.defaultFactor}" maxlength="30">
		                        <div class="fms_form_error" id="defaultFactor_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <br>
			                <h3>Payment Rate Information</h3>
			                <br>
			                 <div class="fms_form_layout_2column">                  
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="mmrRunDate_v0" id="mmrRunDate_label_v0">Run Date of File:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="mmrRunDate" aria-labelledby="mmrRunDate_label_v0"  aria-describedby="mmrRunDate_error_v0" aria-required="false" 
			                        	value="<g:formatDate format="MM/dd/yyyy" date="${mmrMaster?.mmrRunDate}" />" maxlength="30" name="mmrRunDate">
			                        <div class="fms_form_error" id="mmrRunDate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="demographicPaymentAdjRateA_v0" id="demographicPaymentAdjRateA_v0_label">Demographic Payment/Adjust Rate A:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="demographicPaymentAdjRateA" id="demographicPaymentAdjRateA" aria-labelledby="demographicPaymentAdjRateA_v0_label" aria-describedby="demographicPaymentAdjRateA_v0_error" aria-required="false"
			                        	value="${mmrMaster?.demographicPaymentAdjRateA}" maxlength="30">
			                        <div class="fms_form_error" id="demographicPaymentAdjRateA_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="paymentDate_v0" id="paymentDate_label_v0">Payment Date:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="paymentDate" aria-labelledby="paymentDate_label_v0"  aria-describedby="paymentDate_error_v0" aria-required="false" 
			                        	value="<g:formatDate format="MM/dd/yyyy" date="${mmrMaster?.paymentDate}" />" maxlength="30" name="paymentDate">
			                        <div class="fms_form_error" id="paymentDate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="demographicPaymentAdjRateB_v0" id="demographicPaymentAdjRateB_v0_label">Demographic Payment/Adjust Rate B:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="demographicPaymentAdjRateB" id="demographicPaymentAdjRateB" aria-labelledby="demographicPaymentAdjRateB_v0_label" aria-describedby="demographicPaymentAdjRateB_v0_error" aria-required="false"
			                        	value="${mmrMaster?.demographicPaymentAdjRateB}" maxlength="30">
			                        <div class="fms_form_error" id="demographicPaymentAdjRateB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="paymentStartDate_v0" id="paymentStartDate_label_v0">Paymt/Adjust Start Date:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="paymentStartDate" aria-labelledby="paymentStartDate_label_v0"  aria-describedby="paymentStartDate_error_v0" aria-required="false" 
			                        	value="<g:formatDate format="MM/dd/yyyy" date="${mmrMaster?.paymentStartDate}" />" maxlength="30" name="paymentStartDate">
			                        <div class="fms_form_error" id="paymentStartDate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="blendedPaymentAdjRateA_v0" id="blendedPaymentAdjRateA_v0_label">RA Payment/Adjust Amount A:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="blendedPaymentAdjRateA" id="blendedPaymentAdjRateA" aria-labelledby="blendedPaymentAdjRateA_v0_label" aria-describedby="blendedPaymentAdjRateA_v0_error" aria-required="false"
			                        	value="${mmrMaster?.blendedPaymentAdjRateA}" maxlength="30">
			                        <div class="fms_form_error" id="Description_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="paymentEndDate_v0" id="paymentEndDate_label_v0">Paymt/Adjust End Date:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="paymentEndDate" aria-labelledby="paymentEndDate_label_v0"  aria-describedby="paymentEndDate_error_v0" aria-required="false" 
			                        	value="<g:formatDate format="MM/dd/yyyy" date="${mmrMaster?.paymentEndDate}" />" maxlength="30" name="paymentEndDate">
			                        <div class="fms_form_error" id="paymentEndDate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="blendedPaymentAdjRateB_v0" id="blendedPaymentAdjRateB_v0_label">RA Payment/Adjust Amount B:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="blendedPaymentAdjRateB" id="blendedPaymentAdjRateB" aria-labelledby="blendedPaymentAdjRateB_v0_label" aria-describedby="blendedPaymentAdjRateB_v0_error" aria-required="false"
			                        	value="${mmrMaster?.blendedPaymentAdjRateB}" maxlength="30">
			                        <div class="fms_form_error" id="blendedPaymentAdjRateB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="noPaymentAdjPartA_v0" id="noPaymentAdjPartAlabel_v0"># Paymt/Adjust Months Part A:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="noPaymentAdjPartA" aria-labelledby="noPaymentAdjPartA_label_v0"  aria-describedby="noPaymentAdjPartA_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.noPaymentAdjPartA}" maxlength="30" name="noPaymentAdjPartA">
			                        <div class="fms_form_error" id="noPaymentAdjPartA_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="mspFactor_v0" id="mspFactor_v0_label">MSP Factor:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="mspFactor" id="mspFactor" aria-labelledby="mspFactor_v0_label" aria-describedby="mspFactor_v0_error" aria-required="false"
			                        	value="${mmrMaster?.mspFactor}" maxlength="30">
			                        <div class="fms_form_error" id="Description_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="noPaymentAdjPartB_v0" id="noPaymentAdjPartB_label_v0"># Paymt/Adjust Months Part B:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="noPaymentAdjPartB" aria-labelledby="noPaymentAdjPartB_label_v0"  aria-describedby="noPaymentAdjPartB_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.noPaymentAdjPartB}" maxlength="30" name="noPaymentAdjPartB">
			                        <div class="fms_form_error" id="noPaymentAdjPartB_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="mspReductionAdjAmtPartA_v0" id="mspReductionAdjAmtPartA_v0_label">MSP Red/Red Adjust Amt – Part A:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="mspReductionAdjAmtPartA" id="mspReductionAdjAmtPartA" aria-labelledby="mspReductionAdjAmtPartA_v0_label" aria-describedby="mspReductionAdjAmtPartA_v0_error" aria-required="false"
			                        	value="${mmrMaster?.mspReductionAdjAmtPartA}" maxlength="30">
			                        <div class="fms_form_error" id="mspReductionAdjAmtPartA_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="adjReasonCode_v0" id="adjReasonCode_label_v0">Adjustment Reason Code:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="adjReasonCode" aria-labelledby="adjReasonCode_label_v0"  aria-describedby="adjReasonCode_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.adjReasonCode}" maxlength="30" name="adjReasonCode">
			                        <div class="fms_form_error" id="adjReasonCode_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="mspReductionAdjAmtPartB_v0" id="mspReductionAdjAmtPartB_v0_label">MSP Red/Red Adjust Amt – Part B:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="mspReductionAdjAmtPartB" id="mspReductionAdjAmtPartB" aria-labelledby="mspReductionAdjAmtPartB_v0_label" aria-describedby="mspReductionAdjAmtPartB_v0_error" aria-required="false"
			                        	value="${mmrMaster?.mspReductionAdjAmtPartB}" maxlength="30">
			                        <div class="fms_form_error" id="mspReductionAdjAmtPartB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="cleanupId_v0" id="batchId_label_v0">Cleanup ID:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="cleanupId" aria-labelledby="cleanupId_label_v0"  aria-describedby="cleanupId_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.cleanupId}" maxlength="30" name="cleanupId">
			                        <div class="fms_form_error" id="cleanupId_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                </div>
			                <br>
			                <h3>Part C Premium Information</h3>
			                <br>
			                 <div class="fms_form_layout_2column">                  
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="totalPartAMaPayment_v0" id="totalPartAMaPayment_label_v0">Total Part A Payment:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="totalPartAMaPayment" aria-labelledby="totalPartAMaPayment_label_v0"  aria-describedby="totalPartAMaPayment_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.totalPartAMaPayment}" maxlength="30" name="totalPartAMaPayment">
			                        <div class="fms_form_error" id="totalPartAMaPayment_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="rebatePartACostShare_v0" id="rebatePartACostShare_v0_label">Reb-Part A Cost Share Red:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="rebatePartACostShare" id="rebatePartACostShare" aria-labelledby="rebatePartACostShare_v0_label" aria-describedby="rebatePartACostShare_v0_error" aria-required="false"
			                        	value="${mmrMaster?.rebatePartACostShare}" maxlength="30">
			                        <div class="fms_form_error" id="rebatePartACostShare_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="totalPartBMaPayment_v0" id="totalPartBMaPayment_label_v0">Total Part B Payment:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="totalPartBMaPayment" aria-labelledby="LanguageCode_label_v0"  aria-describedby="totalPartBMaPayment_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.totalPartBMaPayment}" maxlength="30" name="totalPartBMaPayment">
			                        <div class="fms_form_error" id="totalPartBMaPayment_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="rebatePartBCostShare_v0" id="rebatePartBCostShare_v0_label">Reb-Part B Cost Share Red:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="rebatePartBCostShare" id="rebatePartBCostShare" aria-labelledby="rebatePartBCostShare_v0_label" aria-describedby="rebatePartBCostShare_v0_error" aria-required="false"
			                        	value="${mmrMaster?.rebatePartBCostShare}" maxlength="30">
			                        <div class="fms_form_error" id="rebatePartBCostShare_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="totalMaPayment_v0" id="totalMaPayment_label_v0">Total Part C Payment:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="totalMaPayment" aria-labelledby="totalMaPayment_label_v0"  aria-describedby="totalMaPayment_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.totalMaPayment}" maxlength="30" name="totalMaPayment">
			                        <div class="fms_form_error" id="totalMaPayment_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="rebateOtherPartA_v0" id="rebateOtherPartA_v0_label">Reb-Other Part A Mand Suppl Ben:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="rebateOtherPartA" id="rebateOtherPartA" aria-labelledby="rebateOtherPartA_v0_label" aria-describedby="rebateOtherPartA_v0_error" aria-required="false"
			                        	value="${mmrMaster?.rebateOtherPartA}" maxlength="30">
			                        <div class="fms_form_error" id="rebateOtherPartA_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="partCBasicPremPartA_v0" id="partCBasicPremPartA_label_v0">Basic Premium-Part A Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="partCBasicPremPartA" aria-labelledby="LanguageCode_label_v0"  aria-describedby="partCBasicPremPartA_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.partCBasicPremPartA}" maxlength="30" name="partCBasicPremPartA">
			                        <div class="fms_form_error" id="partCBasicPremPartA_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="rebateOtherPartB_v0" id="rebateOtherPartB_v0_label">Reb-Other Part B Mand Suppl Ben:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="rebateOtherPartB" id="rebateOtherPartB" aria-labelledby="rebateOtherPartB_v0_label" aria-describedby="rebateOtherPartB_v0_error" aria-required="false"
			                        	value="${mmrMaster?.rebateOtherPartB}" maxlength="30">
			                        <div class="fms_form_error" id="rebateOtherPartB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="partCBasicPremPartB_v0" id="partCBasicPremPartB_label_v0">Basic Premium-Part B Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="partCBasicPremPartB" aria-labelledby="partCBasicPremPartB_label_v0"  aria-describedby="partCBasicPremPartB_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.partCBasicPremPartB}" maxlength="30" name="partCBasicPremPartB">
			                        <div class="fms_form_error" id="partCBasicPremPartB_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="partBRebatePartA_v0" id="partBRebatePartA_v0_label">Reb-Part B Prem Red-Part A Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="partBRebatePartA" id="partBRebatePartA" aria-labelledby="partBRebatePartA_v0_label" aria-describedby="partBRebatePartA_v0_error" aria-required="false"
			                        	value="${mmrMaster?.partBRebatePartA}" maxlength="30">
			                        <div class="fms_form_error" id="partBRebatePartA_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="partAMntlyPymtRate_v0" id="partAMntlyPymtRate_label_v0">Part A-RA Monthly Rate:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="partAMntlyPymtRate" aria-labelledby="LanguageCode_label_v0"  aria-describedby="partAMntlyPymtRate_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.partAMntlyPymtRate}" maxlength="30" name="partAMntlyPymtRate">
			                        <div class="fms_form_error" id="partAMntlyPymtRate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="partBRebatePartB_v0" id="partBRebatePartB_v0_label">Reb-Part B Prem Red-Part B Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="partBRebatePartB" id="partBRebatePartB" aria-labelledby="partBRebatePartB_v0_label" aria-describedby="partBRebatePartB_v0_error" aria-required="false"
			                        	value="${mmrMaster?.partBRebatePartB}" maxlength="30">
			                        <div class="fms_form_error" id="partBRebatePartB_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="partBMntlyPymtRate_v0" id="partBMntlyPymtRate_label_v0">Part B-RA Monthly Rate:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="partBMntlyPymtRate" aria-labelledby="LanguageCode_label_v0"  aria-describedby="partBMntlyPymtRate_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.partBMntlyPymtRate}" maxlength="30" name="partBMntlyPymtRate">
			                        <div class="fms_form_error" id="partBMntlyPymtRate_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="partARebatePartD_v0" id="partARebatePartD_v0_label">Reb-Part D Suppl Ben-Part A Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="partARebatePartD" id="partARebatePartD" aria-labelledby="partARebatePartD_v0_label" aria-describedby="partARebatePartD_v0_error" aria-required="false"
			                        	value="${mmrMaster?.partARebatePartD}" maxlength="30">
			                        <div class="fms_form_error" id="partARebatePartD_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                      </div>
			                     <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="msaPartADepRecov_v0" id="msaPartADepRecov_label_v0">MSA Part A Dep/Rec Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="msaPartADepRecov" aria-labelledby="msaPartADepRecov_label_v0"  aria-describedby="msaPartADepRecov_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.msaPartADepRecov}" maxlength="30" name="msaPartADepRecov">
			                        <div class="fms_form_error" id="msaPartADepRecov_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="partBRebatePartD_v0" id="partBRebatePartD_v0_label">Reb-Part D Suppl Ben-Part B Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="partBRebatePartD" id="partBRebatePartD" aria-labelledby="partBRebatePartD_v0_label" aria-describedby="partBRebatePartD_v0_error" aria-required="false"
			                        	value="${mmrMaster?.partBRebatePartD}" maxlength="30">
			                        <div class="fms_form_error" id="partBRebatePartD_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    </div>
			                     <div class="fms_form_column fms_long_labels">
			                      <label class="control-label" for="msaPartBDepRecov_v0" id="msaPartBDepRecov_label_v0">MSA Part B Dep/Rec Amt:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control " id="msaPartBDepRecov" aria-labelledby="msaPartBDepRecov_label_v0"  aria-describedby="msaPartBDepRecov_error_v0" aria-required="false" 
			                        	value="${mmrMaster?.msaPartBDepRecov}" maxlength="30" name="msaPartBDepRecov">
			                        <div class="fms_form_error" id="msaPartBDepRecov_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                    </div>
			                    <div class="fms_form_column">
			                      <label class="control-label" for="msaDepRecovMonths_v0" id="msaDepRecovMonths_v0_label">MSA Dep/Rec Months:</label>
			                      <div class="fms_form_input">
			                        <input readonly="readonly" type="text" class="form-control" name="msaDepRecovMonths" id="msaDepRecovMonths" aria-labelledby="msaDepRecovMonths_v0_label" aria-describedby="msaDepRecovMonths_v0_error" aria-required="false"
			                        	value="${mmrMaster?.msaDepRecovMonths}" maxlength="30">
			                        <div class="fms_form_error" id="msaDepRecovMonths_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
			                      </div>
			                 	</div>
			                  </div>
			           <br>
		              <h3>Part D Risk Adjuster Indicators</h3>
		              <br>
		              <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDRaFactor_v0" id="partDRaFactor_label_v0">Part D RA Factor:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDRaFactor" aria-labelledby="partDRaFactor_label_v0"  aria-describedby="partDRaFactor_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDRaFactor}" maxlength="30" name="partDRaFactor">
		                        <div class="fms_form_error" id="partDRaFactor_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partDLowIncomeInd_v0" id="partDLowIncomeInd_v0_label">Part D Low-Income Ind:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partDLowIncomeInd" id="partDLowIncomeInd" aria-labelledby="partDLowIncomeInd_v0_label" aria-describedby="partDLowIncomeInd_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partDLowIncomeInd}" maxlength="30">
		                        <div class="fms_form_error" id="partDLowIncomeInd_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDRaFactorType_v0" id="partDRaFactorType_label_v0">Part D RA Factor Type:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDRaFactorType" aria-labelledby="partDRaFactorType_label_v0"  aria-describedby="partDRaFactorType_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDRaFactorType}" maxlength="30" name="partDRaFactorType">
		                        <div class="fms_form_error" id="partDRaFactorType_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partDLowIncomeFactor_v0" id="partDLowIncomeFactor_v0_label">Part D Low-Income Mult:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partDLowIncomeFactor" id="partDLowIncomeFactor" aria-labelledby="partDLowIncomeFactor_v0_label" aria-describedby="partDLowIncomeFactor_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partDLowIncomeFactor}" maxlength="30">
		                        <div class="fms_form_error" id="partDLowIncomeFactor_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="raFactorTypeCode_v0" id="raFactorTypeCode_label_v0">Default Part D Risk Factor Code:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="raFactorTypeCode" aria-labelledby="raFactorTypeCode_label_v0"  aria-describedby="raFactorTypeCode_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.raFactorTypeCode}" maxlength="30" name="raFactorTypeCode">
		                        <div class="fms_form_error" id="raFactorTypeCode_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="lti_v0" id="lti_v0_label">Part D Long Term Institutional Ind:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="lti" id="lti" aria-labelledby="lti_v0_label" aria-describedby="lti_v0_error" aria-required="false"
		                        	value="${mmrMaster?.lti}" maxlength="30">
		                        <div class="fms_form_error" id="lti_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDLongTermInstFactor_v0" id="partDLongTermInstFactor_label_v0">Part D Long Term Institutional Mult:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDLongTermInstFactor" aria-labelledby="partDLongTermInstFactor_label_v0"  aria-describedby="partDLongTermInstFactor_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDLongTermInstFactor}" maxlength="30" name="partDLongTermInstFactor">
		                        <div class="fms_form_error" id="partDLongTermInstFactor_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>		                    
		                </div>
		                 <br>
		              <h3>Part D Payment Rate Information</h3>
		              <br>
		              <div class="fms_form_layout_2column">                  
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="totalPartDPayment_v0" id="totalPartDPayment_label_v0">Total Part D Payment:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="totalPartDPayment" aria-labelledby="totalPartDPayment_label_v0"  aria-describedby="totalPartDPayment_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.totalPartDPayment}" maxlength="30" name="totalPartDPayment">
		                        <div class="fms_form_error" id="totalPartDPayment_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="lisPremSubsidy_v0" id="lisPremSubsidy_v0_label">LIS Premium Subsidy:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="lisPremSubsidy" id="lisPremSubsidy" aria-labelledby="lisPremSubsidy_v0_label" aria-describedby="lisPremSubsidy_v0_error" aria-required="false"
		                        	value="${mmrMaster?.lisPremSubsidy}" maxlength="30">
		                        <div class="fms_form_error" id="lisPremSubsidy_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDBasicPremiumAmt_v0" id="partDBasicPremiumAmt_label_v0">Part D Basic Premium Amt:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDBasicPremiumAmt" aria-labelledby="partDBasicPremiumAmt_label_v0"  aria-describedby="partDBasicPremiumAmt_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDBasicPremiumAmt}" maxlength="30" name="partDBasicPremiumAmt">
		                        <div class="fms_form_error" id="partDBasicPremiumAmt_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="deMinimis_v0" id="deMinimis_v0_label">De Minimis:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="deMinimis" id="deMinimis" aria-labelledby="deMinimis_v0_label" aria-describedby="deMinimis_v0_error" aria-required="false"
		                        	value="${mmrMaster?.deMinimis}" maxlength="30">
		                        <div class="fms_form_error" id="deMinimis_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="numberOfPaymentsAdjPartD_v0" id="numberOfPaymentsAdjPartD_label_v0"># Paymt/Adjust Months Part D:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="numberOfPaymentsAdjPartD" aria-labelledby="numberOfPaymentsAdjPartD_label_v0"  aria-describedby="numberOfPaymentsAdjPartD_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.numberOfPaymentsAdjPartD}" maxlength="30" name="numberOfPaymentsAdjPartD">
		                        <div class="fms_form_error" id="numberOfPaymentsAdjPartD_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="benDualPartdEnrollStatus_v0" id="benDualPartdEnrollStatus_v0_label">Benef Dual Part D Enroll Status Flag:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="benDualPartdEnrollStatus" id="benDualPartdEnrollStatus" aria-labelledby="benDualPartdEnrollStatus_v0_label" aria-describedby="benDualPartdEnrollStatus_v0_error" aria-required="false"
		                        	value="${mmrMaster?.benDualPartdEnrollStatus}" maxlength="30">
		                        <div class="fms_form_error" id="benDualPartdEnrollStatus_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDDirectSubsidyAmt_v0" id="partDDirectSubsidyAmt_label_v0">Direct Subsidy Mo Rate Amt:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDDirectSubsidyAmt" aria-labelledby="partDDirectSubsidyAmt_label_v0"  aria-describedby="partDDirectSubsidyAmt_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDDirectSubsidyAmt}" maxlength="30" name="partDDirectSubsidyAmt">
		                        <div class="fms_form_error" id="partDDirectSubsidyAmt_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="rebatePartDPremReduct_v0" id="rebatePartDPremReduct_v0_label">Reb-Part D Basic Premium Reduction:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="rebatePartDPremReduct" id="rebatePartDPremReduct" aria-labelledby="rebatePartDPremReduct_v0_label" aria-describedby="rebatePartDPremReduct_v0_error" aria-required="false"
		                        	value="${mmrMaster?.rebatePartDPremReduct}" maxlength="30">
		                        <div class="fms_form_error" id="rebatePartDPremReduct_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDDirectSubsidyAmt_v0" id="partDDirectSubsidyAmt_label_v0">Direct Subsidy Mo Paymt Amt:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDDirectSubsidyAmt" aria-labelledby="partDDirectSubsidyAmt_label_v0"  aria-describedby="partDDirectSubsidyAmt_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDDirectSubsidyAmt}" maxlength="30" name="partDDirectSubsidyAmt">
		                        <div class="fms_form_error" id="partDDirectSubsidyAmt_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="pacePremiumAddOn_v0" id="pacePremiumAddOn_v0_label">PACE Premium Add-On:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="pacePremiumAddOn" id="pacePremiumAddOn" aria-labelledby="pacePremiumAddOn_v0_label" aria-describedby="pacePremiumAddOn_v0_error" aria-required="false"
		                        	value="${mmrMaster?.pacePremiumAddOn}" maxlength="30">
		                        <div class="fms_form_error" id="pacePremiumAddOn_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDReinsuranceAmt_v0" id="partDReinsuranceAmt_label_v0">Reinsurance Subsidy Amount:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDReinsuranceAmt" aria-labelledby="partDReinsuranceAmt_label_v0"  aria-describedby="partDReinsuranceAmt_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDReinsuranceAmt}" maxlength="30" name="partDReinsuranceAmt">
		                        <div class="fms_form_error" id="partDReinsuranceAmt_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="paceCostsharingAddOn_v0" id="paceCostsharingAddOn_v0_label">PACE Cost Sharing Add-On:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="paceCostsharingAddOn" id="paceCostsharingAddOn" aria-labelledby="paceCostsharingAddOn_v0_label" aria-describedby="paceCostsharingAddOn_v0_error" aria-required="false"
		                        	value="${mmrMaster?.paceCostsharingAddOn}" maxlength="30">
		                        <div class="fms_form_error" id="Description_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column fms_long_labels">
		                      <label class="control-label" for="partDLowIncomeSubsidy_v0" id="partDLowIncomeSubsidy_label_v0">Low Income Subs Cost Share Amt:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control " id="partDLowIncomeSubsidy" aria-labelledby="partDLowIncomeSubsidy_label_v0"  aria-describedby="partDLowIncomeSubsidy_error_v0" aria-required="false" 
		                        	value="${mmrMaster?.partDLowIncomeSubsidy}" maxlength="30" name="partDLowIncomeSubsidy">
		                        <div class="fms_form_error" id="partDLowIncomeSubsidy_error_v0">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>
		                    <div class="fms_form_column">
		                      <label class="control-label" for="partDCovGapDiscntAmt_v0" id="partDCovGapDiscntAmt_v0_label">Coverage Gap Discount Amount:</label>
		                      <div class="fms_form_input">
		                        <input readonly="readonly" type="text" class="form-control" name="partDCovGapDiscntAmt" id="partDCovGapDiscntAmt" aria-labelledby="partDCovGapDiscntAmt_v0_label" aria-describedby="partDCovGapDiscntAmt_v0_error" aria-required="false"
		                        	value="${mmrMaster?.partDCovGapDiscntAmt}" maxlength="30">
		                        <div class="fms_form_error" id="partDCovGapDiscntAmt_v0_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
		                      </div>
		                    </div>		                    
		                </div>
		                </div>
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
	
	<!-- START - Reset Notice Modal -->
      <div class="modal fade" id="WarningAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
        <div class="modal-dialog">
          <div class="modal-content fms_modal_warning">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4>Are you sure you want to reset this form?</h4>
              <p>You'll lose any changes you made by doing so.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary BtnUndoModal" data-dismiss="modal">Yes, Reset</button>
            </div>
          </div>
        </div>
      </div>
    <!-- END - Reset Notice Modal -->

	
	<!-- START - Save Notice Modal -->
      <div class="modal fade" id="SaveAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
        <div class="modal-dialog">
          <div class="modal-content fms_modal_success">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4>Do you want to save all changes?</h4>              
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <button id="BtnSaveModal" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Save</button>
            </div>
          </div>
        </div>
      </div>
    <!-- END - Save Notice Modal -->

	
	
	<script>
		var memberSelectObject = document.getElementById('memberIdSelectList')
		showAddress(memberSelectObject)
	</script> 
</div>