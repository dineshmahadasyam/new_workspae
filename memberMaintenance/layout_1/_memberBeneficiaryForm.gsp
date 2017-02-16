<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.Beneficiary" %>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.States" %>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?true:false}" />
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script type="text/javascript">

	function clearSearchCriteria() {
			var elements = document.getElementsByTagName("input");
			var firstText = true;
			for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    elements[ii].value = "";
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
				 }
			  }
			  if (elements[ii].type == "radio") {
				    elements[ii].checked = false;
			  }
			}
			var elements = document.getElementsByTagName("select");
			for (var ii=0; ii < elements.length; ii++) {
			    elements[ii].selectedIndex = 0;
			}
		}
	
	$(window).load(function() {
		
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

		$(".bSSN").mask("?999-99-9999");
		$(".bZipCode").mask("99999?-9999");	
		$(".bTaxID").mask("?99-9999999");
		
	});

	var addRowClicked = false
	var previousDivObj

	function showBeneficiary(selectedObj) 
	{		
			var hiddenObj = document.getElementById("editMemberDBID")		
			if (!addRowClicked) {
				var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
				var beneficiaryDivObj = document.getElementById(selectedValue)
				var addBeneficiaryDivObj = document.getElementById("addBeneficiaryDiv")
				hiddenObj.value=selectedValue			
				if (beneficiaryDivObj  != null) {
					if (previousDivObj != null) {
						previousDivObj.style.display="none"
					}
					beneficiaryDivObj.style.display = "block"
					//addBeneficiaryDivObj.style.display = "block"
					previousDivObj = beneficiaryDivObj
				} 
			} 
	}
	

	function addBeneficiary() 
	{
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		
		if (selectObj.selectedIndex == 01)
		{
			var memberDBID = selectObj.options[selectObj.selectedIndex].value
			var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
			var appName = "${appContext.metadata['app.name']}";
	
			window.location.assign("/"+appName+"/memberMaintenance/addMemberBeneficiary?subscriberId="
					+ subscriberId + "&editType=BENEFICIARY&memberDBID="+memberDBID+"&personNumber="+personNumber);
		}
		else
		{
			//alert("You may add beneficiaries for subscribers only.");
			 document.getElementById('BtnInfoAlertADD').click();
		}
	}

	function showSSNMessage() {
		//alert ("Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.");
		 document.getElementById('BtnInfoAlertId').click();
	}
	
	function deleteButton(seqId)
	{
	    document.getElementById('benefSeqId').value = seqId
	    document.getElementById('benefSubsId').value = "${subscriberMember.subscriberID}";

	    var memberBenefAllocList = '${memberBenefAllocList}';
	    var memberBenefAllocListArray =[];
		
		//split and trim the array items
	    $.each(memberBenefAllocList.split(","), function(){
	    	memberBenefAllocListArray.push($.trim(this));
	    });

	    if(memberBenefAllocListArray.indexOf(seqId.toString()) > -1)
		{
	    	//alert("To delete this beneficiary, You must first go to the Beneficiary Allocation screen and remove the beneficiary.");
	    	 document.getElementById('InfoDeleteModelId').click();
	    	return false;
	    }
	    else
		{
	    	document.getElementById('BtnInfoAlertId5').click();
			//Note: This past is moved to new delete alert.
	    	//if (confirm("Are you sure you want to delete this Beneficiary?") == true) 
			// {
		    //	return true;
		    // } 
		   // else 
			//{
		    	//return false;
		   // }	    	
		}
	}
	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/list");
	}
</script>
<head>
	<script>
	function editBeneficiary(beneficiary){
		//var address = document.getElementById(address);
		//alert(address);
		$(document.getElementById('beneficiary.'+beneficiary+'.toggleFields')).css('display','table-cell');
		$(document.getElementById('beneficiary.'+beneficiary+'.toggleSaveButton')).css('display','table-cell');
		$(document.getElementById('beneficiary.'+beneficiary+'.toggleResetButton')).css('display','table-cell');
		$(document.getElementById('beneficiary.'+beneficiary+'.toggleEditButton')).css('display','none');
	}
	</script>

	<script type="text/javascript">
	
		$(document).ready(function() {
		
			$('.BtnDeleteRow').hide();  
			$('.btnInfoAlert').hide();  
			$('.btnInfoAlert').click(function(e){ 
	        	$('#InfoAlert').modal('show');
	        });
	     	$('#InfoAlert').modal({
	        	backdrop: 'static',
	           show: false
	       	});


			$('.btnInfoAlertADD').hide();  
			$('.btnInfoAlertADD').click(function(e){ 
	        	$('#InfoAlertADD').modal('show');
	        });
	     	$('#InfoAlertADD').modal({
	        	backdrop: 'static',
	           show: false
	       	});

	     	$('.InfoDeleteRow').hide();  
			$('.InfoDeleteRow').click(function(e){ 
	        	$('#InfoDeleteModel').modal('show');
	        });
	     	$('#InfoDeleteModel').modal({
	        	backdrop: 'static',
	           show: false
	       	});
	     	
	     	$('.BtnDeleteRow');
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
		               myFm.action = "/"+appName+"/memberMaintenance/delete";     	
		               myFm.submit();
		           
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

<input type="hidden" name="editType" value="BENEFICIARY" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />	

<div id="fms_content_body">
	<div class="right-corner" align="right">MEBNM</div>
	   	
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
            <select id="memberIdSelectList" class="form-control" name="memberIdlist" onChange="showBeneficiary(this)">
            	<option value="dummy">-- Select a Member --</option>
				<g:each in="${memberMasterMap.keySet() }" status="idCount" var="memberDBID">
            	<% SimpleMember member = memberMasterMap.get(memberDBID) %>
            	  <option value="${memberDBID}"
						<g:if test="${"01".equals(member.personNumber)}">
							selected="${true}"
						</g:if>
						<g:else>
							readonly="${true}" 
						</g:else> >
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
				<input type="hidden" id="${subscriberMember.subscriberID}:${memberDBID }" 
				name="${subscriberMember.subscriberID}:${memberDBID }" value="${member.personNumber}"/>
			</g:each>
		</div>
	
		<g:checkURIAuthorization uri="/memberMaintenance/addMemberBeneficiary">
			<h2>Beneficiaries  <button name="addBeneficiaryButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new Beneficiary." 
			onClick="addBeneficiary()"><i class="fa fa-plus"></i> New Beneficiary</button></h2>
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

        <br>
        
        <div class="fms_required_legend fms_required">= required</div>        
        
        <div id="dummy" style="display:none">&nbsp;</div>
        <g:hiddenField name="benefSeqId" id="benefSeqId" value="" />
		<g:hiddenField name="benefSubsId" id="benefSubsId" value ="" />

		<g:each in="${memberBeneficiaryMap.keySet()}" status="idCount" var="memberDBID">
	    	<div id="${memberDBID}" style="display: none">
       
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
						
            			<!--  <div class="row fms-col_selector_row">
			                <div id="DataTableFound" class="col-xs-6 fms-results-found"></div>
			                <div class="col-xs-6 fms-column-selector">
                 
               					<div class="columnSelectorWrapper">
			                    <input id="colSelect1" name="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
				                    <label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
				                    <div id="columnSelector" class="columnSelector"><label><input type="checkbox" id="chkbox" name="chkbox" data-column="auto">Auto display columns: </label>
				                      this div is where the column selector is added 
					                    <label><input type="checkbox" data-column="0" class="checked">Effective Date </label>
					                    <label><input type="checkbox" data-column="1" class="checked">Term Date</label>
					                    <label><input type="checkbox" data-column="2" class="checked">Address Type</label>
					                    <label><input type="checkbox" data-column="3" class="checked">Address Line 1</label>
					                    <label><input type="checkbox" data-column="4" class="checked">City</label>
					                    <label><input type="checkbox" data-column="5" class="checked">State</label> 
				               		</div> 
               					</div>
            				</div>
						</div>	
						-->
            			<div class="fms_table_wrapper">
							<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
               					<thead>
                 						<tr role="row" class="tablesorter-headerRow">
			                     	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Name</th>
					             	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Beneficiary Category</th>
					             	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Date of Birth</th>
					             	<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Actions</th>
            						</tr>
               					</thead>
               						
               					<tfoot></tfoot>
    
								<tbody aria-live="polite" aria-relevant="all"> 
    
    								<g:each in="${memberBeneficiaryMap.get(memberDBID)}" status="i" var="beneficiary">
										<input type="hidden" name="seq_Bfciary_id_${i}" value="${beneficiary.seqBfciaryId}">
										<input type="hidden" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.iterationCount" value="${beneficiary.seqBfciaryId}">
										
										<tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
											<td>${beneficiary.bfciaryName}</td>
											<td class="clickme">
												<g:if test="${"P".equals(beneficiary?.bfciaryCategory)}">Person</g:if>
												<g:if test="${"T".equals(beneficiary?.bfciaryCategory)}">Trust</g:if>
												<g:if test="${"E".equals(beneficiary?.bfciaryCategory)}">Estate</g:if>
												<g:if test="${"O".equals(beneficiary?.bfciaryCategory)}">Organization</g:if>
											</td>

											<td><g:formatDate format="MM/dd/yyyy" date="${beneficiary.dateOfBirth}" /></td>
											
											<td>		
												<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        						<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
												
												<button id="BtnAddressDelete2" type="button" class="btn fms_btn_icon btn-sm"  title="Click to delete Beneficiary." data-target="#DeleteAlertModal" onclick="deleteButton(${beneficiary?.seqBfciaryId})"><i class="fa fa-trash"></i></button>
												<button id="InfoDeleteModelId" type="button" class="btn fms_btn_icon btn-sm InfoDeleteRow" title="Click to delete beneficiary form." data-target="#InfoDeleteModel" onclick="deleteButton(${beneficiary?.seqBfciaryId})"><i class="fa fa-trash"></i></button>
												<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset beneficiary form." data-target="#InfoAlert"></button>
												<button id="BtnInfoAlertADD" type="button" class="btn fms_btn_icon btn-sm btnInfoAlertADD" title="Click to reset beneficiary form." data-target="#InfoAlertADD"></button>
												<button id="BtnInfoAlertId5" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow" data-target="#InfoAlertModal"></button>
											</td>
      										</tr>
      
								        <tr id="Row2Child" class="tablesorter-childRow" role="row">
									        <td colspan="4" id="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.toggleFields" class="" style="display:none;">
												
												<g:if test="${"P".equals(beneficiary?.bfciaryCategory)}">
												
													<div class="fms_widget">        
												        <fieldset>
												        	<legend><h3>General Information</h3></legend>
												           	<div class="fms_form_layout_2column">                  
												           		<div class="fms_form_column fms_very_long_labels">
															    
																	<label for="bfciaryCategory" class="control-label fms_required" id="bfciaryCategory_label">
																	   <g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category :" />
																	</label>
																	<div class="fms_form_input"> 
																		<g:secureSystemCodeToken
															   				systemCodeType="BFCIARY_CAT" languageId="0"
																			htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
																			blankValue="Beneficiary Category"
																			tableName="BENEFICIARY" attributeName="bfciaryCategory"
																			defaultValue="${beneficiary?.bfciaryCategory}" 
																			value="${beneficiary?.bfciaryCategory}"
																			title="The Beneficiary Category" 
																			disable="true"
																			cssClass="form-control"
																		    aria-labelledby="bfciaryCategory_label" 
															                aria-describedby="bfciaryCategory_error" 
															                aria-required="true">
																		</g:secureSystemCodeToken>
																		<div class="fms_form_error" id="bfciaryCategory_error"></div>
																	</div>
																   	<label for="relationshipCode" class="control-label fms_required" id="relationshipCode_label"> 
																		<g:message code="beneficiary.relationshipCode.label" default="Relationship Code:" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureSystemCodeToken
																			systemCodeType="BFCIARY_REL" languageId="0"
																			tableName="BENEFICIARY" attributeName="relationshipCode" 
																			htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.relationshipCode"
																			blankValue="Relationship Code" 
																			defaultValue="${beneficiary?.relationshipCode}" 
																			cssClass="form-control"
																		    aria-labelledby="relationshipCode_label" 
															                aria-describedby="relationshipCode_error" 
															                aria-required="true">
																		</g:secureSystemCodeToken>
														            	<div class="fms_form_error" id="relationshipCode_error"></div>
																    </div>
																	<label for="firstName" class="control-label fms_required" id="firstName_label"> 
																		<g:message code="beneficiary.firstName.label" default="First Name:" />
																	</label>
														            <div class="fms_form_input">
															            <g:secureTextField  
															            		type="text" class="form-control"
																		        name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
																		        tableName="BENEFICIARY" attributeName="firstName"
																				maxlength="60" 
																				value="${beneficiary.firstName}"
																				title="The First Name of the Person" >
																		</g:secureTextField>
														            	<div class="fms_form_error" id="firstName_error"></div>
																    </div>
																    
																    <label for="lastName" class="control-label fms_required" id="lastName_label" > 
																		<g:message code="beneficiary.lastName.label" default="Last Name:" />
																		
																	</label>
														            <div class="fms_form_input">
														            	<g:secureTextField 
														            			type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"												
																				tableName="BENEFICIARY" attributeName="lastName"
																				maxlength="60"
																				value="${beneficiary.lastName }"
																				title="The Last Name of the Person" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="lastName_error"></div>
																    </div>
																	 <label for="socialSecNo" class="control-label fms_required" id="socialSecNo_label"> 
																		<g:message code="beneficiary.socialSecNo.label" default="SSN:" /> 
																		 
																	</label>
																	<div class="fms_form_input fms_has_feedback">
																		<g:secureTextField
																				type="text" class="form-control fms_ssn_mask"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.socialSecNo"
																				tableName="BENEFICIARY" attributeName="socialSecNo"
																				maxlength="11"
																				value="${beneficiary?.socialSecNo}"
																				title="The Social Security Number (SSN) of the Person" >
																				<button type="button" class="btn fms_btn_icon btn-sm fms_form_control_feedback" onclick="showSSNMessage();">
																					<i class="fa fa-question"></i>
																				</button>
																		</g:secureTextField>
																		
																	    <div class="fms_form_error" id="socialSecNo_error"></div>
																	 </div>
																			
																	<label for="beneficiaryGender" class="control-label fms_required" id="beneficiaryGender_label"> 
																		<g:message code="beneficiary.gender.label" default="Gender:" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureDiamondDataWindowDetail
																				cssClass="form-control"
																				columnName="gender" dwName="dw_edied_de" languageId="0"
																				htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.gender"
																				defaultValue="${beneficiary?.gender}" blankValue="Gender" 
																				title="The Gender of the Person"
																				tableName="BENEFICIARY" attributeName="gender" value="${beneficiary?.gender}">
																		</g:secureDiamondDataWindowDetail>
																		<div class="fms_form_error" id="beneficiaryGender_error"></div>
																	</div>
																	
																</div>
																
																<div class="fms_form_column fms_very_long_labels">
																	<label for="bfciaryName" class="control-label" id="bfciaryName_label">
																		<g:message code="beneficiary.bfciaryName.label" default="Name:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName" maxlength="180"
																				tableName="BENEFICIARY" attributeName="lastName"
																				readonly="readonly" onkeydown="event.preventDefault()"
																				value="${beneficiary.bfciaryName }" tabindex="-1"
																				title="Beneficiary Name as entered in Firstname, Middle Initial, Lastname, Suffix" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="bfciaryName_error"></div>
																		<br><br>
																	</div>
																	
																	<label for="middleInitial" class="control-label" id="middleInitial_label"> 
																		<g:message code="beneficiary.middleInitial.label" default="Middle Initial:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField 
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.middleInitial"
																				tableName="BENEFICIARY" attributeName="middleInitial"
																				maxlength="35" 
																				value="${beneficiary.middleInitial }"
																				title="The Middle Initial of the Person" >
																		</g:secureTextField>
																	<div class="fms_form_error" id="middleInitial_error"></div>
																	</div>
																	<label for="suffix" class="control-label" id="suffix_label">
																		<g:message code="beneficiary.suffix.label" default="Suffix:" />
																	</label>
																	
																	<div class="fms_form_input">
																		<g:secureCdoSelectBox 
																				cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
																				tableName="BENEFICIARY" attributeName="suffix"
																				cdoAttributeWhereValue="F"
																				cdoAttributeWhere="titleType"
																				cdoAttributeSelect="contactTitle"
																				cdoAttributeSelectDesc="description"
																				languageId="0"
																				htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.suffix"
																				defaultValue="${beneficiary?.suffix}"
																				value="${beneficiary?.suffix}"
																				blankValue="Suffix" 
																				className="form-control" 
																				aria-labelledby="suffix_label" 
																				aria-describedby="suffix_error" 
																				type="text" 
																				aria-required="false">
																			</g:secureCdoSelectBox>
																			<div class="fms_form_error" id="suffix_error"></div>
																	</div>
																	
																	<label for="dateOfBirth" class="control-label fms_required" id="dateOfBirth_label"> 
																		<g:message code="beneficiary.dateOfBirth.label" default="Date of Birth:" /> 
																	</label>
																	<div class="fms_form_input">																
																		<g:securejqDatePickerUIUX
																			tableName="BENEFICIARY" attributeName="dateOfBirth"
																			dateElementId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.dateOfBirth" 
																			dateElementName="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.dateOfBirth" mandatory="mandatory"
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange: '${((beneficiary?.dateOfBirth != null ? beneficiary?.dateOfBirth.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)}:+0',maxDate:0, numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.dateOfBirth)}" 
																			title="The Date of Birth of the Person"
																			ariaAttributes="aria-labelledby='dateOfBirth_label' aria-describedby='dateOfBirth_error' aria-required='false'" 
													                     	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						 													showIconDefault="${isShowCalendarIcon}"/>                                  
													                    <div class="fms_form_error" id="dateOfBirth_error"></div>
																	</div>
																</div>
															</fieldset>
														</div>
														
														<div class="fms_widget">        
												            <fieldset>
												        	    <legend><h3>Person Address</h3></legend>
												            	<div class="fms_form_layout_2column">                  
												           		 	<div class="fms_form_column fms_very_long_labels">
           
																		<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
																			<g:message code="beneficiary.addressLine1.label" default="Address 1:" />
																		</label>
																		<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
																				tableName="BENEFICIARY" attributeName="addressLine1"
																				maxlength="60" 
																				value="${beneficiary.addressLine1 }"
																				title="The Address of the Person" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine1_error"></div>
																		</div>
																		
																		<label for="city" class="control-label fms_required" id="city_label"> 
																			<g:message code="beneficiary.city.label" default="City:" /> 
																			 
																		</label>
																		<div class="fms_form_input">
																				<g:secureTextField 
																					type="text" class="form-control"
																					name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
																					tableName="BENEFICIARY" attributeName="city"
																					maxlength="30" 
																					value="${beneficiary.city}" title="The City of the Person" >
																				</g:secureTextField>
																				<div class="fms_form_error" id="city_error"></div>
																		</div>
																		
																		<label for="zipCode" class="control-label fms_required" id="zipCode_label"> 
																			<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																			 
																		</label>
																		<div class="fms_form_input">
																				<g:secureTextField
																					type="text" class="form-control bZipCode"
																					name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
																				    tableName="BENEFICIARY" attributeName="zipCode" 
																					maxlength="10" 
																					value="${beneficiary?.zipCode}"
																					title="The Zip Code of the Person" >
																					</g:secureTextField>	
																					<div class="fms_form_error" id="zipCode_error"></div>
																			</div>
																		</div>
																		<div class="fms_form_column fms_very_long_labels">
																		
																		<label for="addressLine2" class="control-label" id="addressLine2_label"> 
																			<g:message code="beneficiary.addressLine2.label" default="Address 2:" />
																		</label>
																		<div class="fms_form_input">
																				<g:secureTextField
																					type="text" class="form-control"
																					name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
																					tableName="BENEFICIARY" attributeName="addressLine2"
																					maxlength="60"
																					value="${beneficiary.addressLine2 }"
																					title="The Address of the Person" >
																				</g:secureTextField>
																				<div class="fms_form_error" id="addressLine2_error"></div>
																		</div>
																		<label for="benState" class="control-label fms_required" id="benState_label"> 
																			<g:message code="beneficiary.benState.label" default="State:" /> 
																		</label>
																		<div class="fms_form_input">
																				<g:secureComboBox
																					class="form-control" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
																					tableName="BENEFICIARY" attributeName="state" 
																					optionValue="stateName" id="state.name" from="${states}"
																					noSelection="['':'-- Select a State --']"
																					value="${beneficiary?.state}">
																				</g:secureComboBox>
																				<div class="fms_form_error" id="benState_error"></div>
																		</div>
																		
																		<label for="country" class="control-label fms_required" id="country_label"> 
																			<g:message code="beneficiary.country.label" default="Country:" />
																		</label>
																		<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"  
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
																				readonly="readonly" 
																				tableName="BENEFICIARY" attributeName="country"
																				value="${beneficiary?.country}"
																				title="The Country of the Person" maxlength="30" value="USA" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="country_error"></div>
																		</div>
																	</div>
																</div>
															</fieldset>
														</div>
													</div>
												</g:if>
      
												<g:if test="${"T".equals(beneficiary?.bfciaryCategory)}">
												
													<div class="fms_widget">        
														<fieldset>
											        	    <legend><h3>General Information</h3></legend>
											            	<div class="fms_form_layout_2column">                  
											           		 	<div class="fms_form_column fms_very_long_labels">
          
																	<label for="bfciaryCategory" class="control-label fms_required" id="bfciaryCategory_label"> 
																		<g:message	code="beneficiary.bfciaryCategory.label" default="Beneficiary Category :" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureSystemCodeToken
																			systemCodeType="BFCIARY_CAT" languageId="0"
																			htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
																			blankValue="Beneficiary Category"
																			tableName="BENEFICIARY" attributeName="bfciaryCategory"
																			defaultValue="${beneficiary?.bfciaryCategory}"
																			value="${beneficiary?.bfciaryCategory}"
																			title="The Beneficiary Category" 
																			disable="true" 
																			cssClass="form-control"
																			aria-labelledby="bfciaryCategory_label" 
																			aria-describedby="bfciaryCategory_error" 
																			aria-required="true">
																		</g:secureSystemCodeToken>
																		<div class="fms_form_error" id="bfciaryCategory_error"></div>
																	</div>
																	 
																	<label for="firstName" class="control-label fms_required" id="firstName_label"> 
																		<g:message code="beneficiary.firstName.label" default="Trustee First Name:" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField
																			type="text" class="form-control"
																			name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
																			tableName="BENEFICIARY" attributeName="firstName"
																			maxlength="60" 
																			value="${beneficiary.firstName}"
																			title="The First Name of the Trustee" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="firstName_error"></div>
																	</div>
																	 
																	<label for="trustDate" class="control-label fms_required" id="trustDate_label"> 
																		 <g:message	code="beneficiary.trustDate.label" default="Trust Date:" />
																	</label>
																					
																	<div class="fms_form_input">																
																		<g:securejqDatePickerUIUX
																			tableName="BENEFICIARY" attributeName="trustDate" 
																			datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${((beneficiary?.trustDate != null ? beneficiary?.trustDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((beneficiary?.trustDate != null ? beneficiary?.trustDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
																			dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.trustDate)}" 
																			dateElementId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.trustDate"
																			dateElementName="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.trustDate" mandatory="mandatory"
																			title="The Trust Date of the Trustee"
																			ariaAttributes="aria-labelledby='trustDate_label' aria-describedby='trustDate_error' aria-required='false'" 
													                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						 													showIconDefault="${isShowCalendarIcon}"/>                                  
													                	<div class="fms_form_error" id="trustDate_error"></div>
																	</div>
																</div>
																
																<div class="fms_form_column fms_very_long_labels">
																
																	<label for="bfciaryName" class="control-label fms_required" id="bfciaryName_label"> 
																		 <g:message code="beneficiary.bfciaryName.label" default="Trust Name:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField
																			type="text" class="form-control"
																			name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
																			value="${beneficiary.bfciaryName }" maxlength="180"
																			tableName="BENEFICIARY" attributeName="bfciaryName"
																			value="${beneficiary?.bfciaryName}"
																			title="The Name of the Trust" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="bfciaryName_error"></div>
																	</div> 

																	<label for="lastName" class="control-label fms_required" id="lastName_label"> 
																		 <g:message	code="beneficiary.lastName.label" default="Trustee Last Name:" /> 
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField
																			type="text" class="form-control"
																			name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
																			tableName="BENEFICIARY" attributeName="lastName"
																			maxlength="60"
																			value="${beneficiary.lastName }"
																			title="The Last Name of the Trustee" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="lastName_error"></div>
																	</div>
																	 
																	<label for="taxId" class="control-label fms_required" id="taxId_label"> 
																		 <g:message	code="beneficiary.taxId.label" default="Tax ID:" /> 
																	</label>
																	 
																	<div class="fms_form_input">
																		<g:secureTextField 
																			 type="text" class="form-control bTaxID"
																			 name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId" 
																			 tableName="BENEFICIARY" attributeName="taxId"	
																			 maxlength="10"
																			 value="${beneficiary.taxId}" 
																			 title="The Tax ID of the Trustee" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="taxId_error"></div>
																	</div>
										   						</div>
										   					</div>
									 					</fieldset>
													</div>
												
													<div class="fms_widget">        
										             	<fieldset>
										             		<legend><h3>Trustee Address</h3></legend>
									             			<div class="fms_form_layout_2column">                  
										             			<div class="fms_form_column fms_very_long_labels">
										             			
																	<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
																		<g:message code="beneficiary.addressLine1.label" default="Address 1:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
																				tableName="BENEFICIARY" attributeName="addressLine1"
																				maxlength="60" 
																				value="${beneficiary.addressLine1 }"
																				title="The Address of the Trustee" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine1_error"></div>
																	</div>
																	
																	<label for="city" class="control-label fms_required" id="city_label"> 
																		<g:message code="beneficiary.city.label" default="City:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField 
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
																				tableName="BENEFICIARY" attributeName="city"
																				maxlength="30" 
																				value="${beneficiary.city}" title="The City of the Trustee" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="city_error"></div>
																	</div>
																	
																	<label for="zipCode" class="control-label fms_required" id="zipCode_label"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																		 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control bZipCode"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
																			    tableName="BENEFICIARY" attributeName="zipCode" 
																				maxlength="10" 
																				value="${beneficiary?.zipCode}"
																				title="The Zip Code of the Trustee" >
																				</g:secureTextField>	
																				<div class="fms_form_error" id="zipCode_error"></div>
																		</div>
																	</div>
																	<div class="fms_form_column fms_very_long_labels">
																	
																	<label for="addressLine2" class="control-label" id="addressLine2_label"> 
																		<g:message code="beneficiary.addressLine2.label" default="Address 2:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
																				tableName="BENEFICIARY" attributeName="addressLine2"
																				maxlength="60" 
																				value="${beneficiary.addressLine2 }"
																				title="The Address of the Trustee" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine2_error"></div>
																	</div>
																	<label for="benState" class="control-label fms_required" id="benState_label"> 
																		<g:message code="beneficiary.benState.label" default="State:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureComboBox
																				class="form-control" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
																				tableName="BENEFICIARY" attributeName="state" 
																				optionValue="stateName" id="state.name" from="${states}"
																				noSelection="['':'-- Select a State --']"
																				value="${beneficiary?.state}">
																			</g:secureComboBox>
																			<div class="fms_form_error" id="benState_error"></div>
																	</div>
																	<label for="country" class="control-label fms_required" id="country_label"> 
																		<g:message code="beneficiary.country.label" default="Country:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"  
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
																				readonly="readonly" 
																				tableName="BENEFICIARY" attributeName="country"
																				value="${beneficiary?.country}"
																				title="The Country of the Trustee" maxlength="30" value="USA" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="country_error"></div>
																	</div>
												  				</div>
															</div>
														</fieldset>
										  			</div>
												</g:if>
												   
												<g:if test="${"E".equals(beneficiary?.bfciaryCategory)}">
												
													<div class="fms_widget">        
														<fieldset>
											        	    <legend><h3>General Information</h3></legend>
											            	<div class="fms_form_layout_2column">                  
											           		 	<div class="fms_form_column fms_very_long_labels">
											           		 	   
																   <label for="bfciaryCategory" class="control-label fms_required" id="bfciaryCategory_label"> 
																	   <g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category :" /> 
																   </label>
																   <div class="fms_form_input">
																			<g:secureSystemCodeToken
																				systemCodeType="BFCIARY_CAT" languageId="0"
																				htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
																				blankValue="Beneficiary Category"
																				tableName="BENEFICIARY" attributeName="bfciaryCategory"
																				defaultValue="${beneficiary?.bfciaryCategory}" 
																				value="${beneficiary?.bfciaryCategory}"
																				title="The Beneficiary Category" 
																				disable="true" 
																				cssClass="form-control"
																				aria-labelledby="bfciaryCategory_label" 
																				aria-describedby="bfciaryCategory_error" 
																				aria-required="true">
																			</g:secureSystemCodeToken>
																			<div class="fms_form_error" id="bfciaryCategory_error"></div>
																		</div>
																    <label for="firstName" class="control-label fms_required" id="firstName_label"> 
																		<g:message code="beneficiary.firstName.label" default="Executor First Name:" />
																	</label>
																    <div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
																				tableName="BENEFICIARY" attributeName="firstName"
																				maxlength="60" 
																				value="${beneficiary.firstName}"
																				title="The First Name of the Executor" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="firstName_error"></div>
																	</div>
																</div>
																
																<div class="fms_form_column fms_very_long_labels">
																	<label for="bfciaryName" class="control-label fms_required" id="bfciaryName_label"> 
																		<g:message code="beneficiary.bfciaryName.label" default="Estate Name:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
																				value="${beneficiary.bfciaryName }" maxlength="180"
																				tableName="BENEFICIARY" attributeName="bfciaryName"
																				value="${beneficiary?.bfciaryName}"
																				title="The Name of the Estate" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="bfciaryName_error"></div>
																	</div>
																	<label for="lastName" class="control-label fms_required" id="lastName_label"> 
																		<g:message code="beneficiary.lastName.label" default="Executor Last Name:" /> 
																		 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
																				tableName="BENEFICIARY" attributeName="lastName"
																				maxlength="60" 
																				value="${beneficiary.lastName }"
																				title="The Last Name of the Executor" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="lastName_error"></div>
																	 </div>
																</div>
															</div>
														</fieldset>
													</div>
											
													<div class="fms_widget">        
										             	<fieldset>
										             		<legend><h3>Executor Address</h3></legend>
										             		<div class="fms_form_layout_2column">                  
										             			<div class="fms_form_column fms_very_long_labels">
													 
																	<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
																		<g:message code="beneficiary.addressLine1.label" default="Address 1:" />
																	</label>
																	<div class="fms_form_input">
																		<g:secureTextField
																			type="text" class="form-control"
																			name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
																			tableName="BENEFICIARY" attributeName="addressLine1"
																			maxlength="60" 
																			value="${beneficiary.addressLine1 }"
																			title="The Address of the Trustee" >
																		</g:secureTextField>
																		<div class="fms_form_error" id="addressLine1_error"></div>
																	</div>
																	
																	<label for="city" class="control-label fms_required" id="city_label"> 
																		<g:message code="beneficiary.city.label" default="City:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField 
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
																				tableName="BENEFICIARY" attributeName="city"
																				maxlength="30" 
																				value="${beneficiary.city}" title="The City of the Trustee" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="city_error"></div>
																	</div>
																	
																	<label for="zipCode" class="control-label fms_required" id="zipCode_label"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control bZipCode"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
																			    tableName="BENEFICIARY" attributeName="zipCode" 
																				maxlength="10" 
																				value="${beneficiary?.zipCode}"
																				title="The Zip Code of the Trustee" >
																				</g:secureTextField>	
																				<div class="fms_form_error" id="zipCode_error"></div>
																		</div>
																	</div>
																	<div class="fms_form_column fms_very_long_labels">
																	
																	<label for="addressLine2" class="control-label" id="addressLine2_label"> 
																		<g:message code="beneficiary.addressLine2.label" default="Address 2:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
																				tableName="BENEFICIARY" attributeName="addressLine2"
																				maxlength="60" 
																				value="${beneficiary.addressLine2 }"
																				title="The Address of the Trustee" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine2_error"></div>
																	</div>
																	<label for="benState" class="control-label fms_required" id="benState_label"> 
																		<g:message code="beneficiary.benState.label" default="State:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureComboBox
																				class="form-control" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
																				tableName="BENEFICIARY" attributeName="state" 
																				optionValue="stateName" id="state.name" from="${states}"
																				noSelection="['':'-- Select a State --']"
																				value="${beneficiary?.state}">
																			</g:secureComboBox>
																			<div class="fms_form_error" id="benState_error"></div>
																	</div>
																	
																	<label for="country" class="control-label fms_required" id="country_label"> 
																		<g:message code="beneficiary.country.label" default="Country:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"  
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
																				readonly="readonly" 
																				tableName="BENEFICIARY" attributeName="country"
																				value="${beneficiary?.country}"
																				title="The Country of the Trustee" maxlength="30" value="USA" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="country_error"></div>
																	  </div>
																</div>
															</div>
														</fieldset>	
													</div>
												</g:if>
												   
												<g:if test="${"O".equals(beneficiary?.bfciaryCategory)}">
													
													<div class="fms_widget">        
														<fieldset>
											        	    <legend><h3>General Information</h3></legend>
											            	<div class="fms_form_layout_2column">                  
											           		 	<div class="fms_form_column fms_very_long_labels">
											           		 	
																	<label for="bfciaryCategory" class="control-label fms_required" id="bfciaryCategory_label"> 
																		<g:message code="beneficiary.bfciaryCategory.label"	default="Beneficiary Category :" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureSystemCodeToken
																				systemCodeType="BFCIARY_CAT" languageId="0"
																				htmlElelmentId="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory"
																				blankValue="Beneficiary Category"
																				tableName="BENEFICIARY" attributeName="bfciaryCategory"
																				defaultValue="${beneficiary?.bfciaryCategory}" 
																				value="${beneficiary?.bfciaryCategory}"
																				title="The Beneficiary Category" 
																				disable="true" 
																			    cssClass="form-control"
																				aria-labelledby="bfciaryCategory_label" 
																				aria-describedby="bfciaryCategory_error" 
																				aria-required="true">
																			</g:secureSystemCodeToken>
																			<div class="fms_form_error" id="bfciaryCategory_error"></div>
																		</div>
																	
																	<label for="firstName" class="control-label fms_required" id="firstName_label"> 
																		<g:message code="beneficiary.firstName.label" default="Contact First Name:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName"
																				tableName="BENEFICIARY" attributeName="firstName"
																				maxlength="60" 
																				value="${beneficiary.firstName}"
																				title="The First Name of the Organization Contact Person" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="firstName_error"></div>
																	</div>
																	<label for="taxId" class="control-label fms_required" id="taxId_label"> 
																		<g:message code="beneficiary.taxId.label" default="Tax ID:" />
																	</label>
																	
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control bTaxID"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId"
																				tableName="BENEFICIARY" attributeName="taxId"
																				maxlength="10" 
																				value="${beneficiary.taxId}"
																				title="The Tax ID of the Organization" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="taxId_error"></div>
																	</div>
																</div>
																
																<div class="fms_form_column fms_very_long_labels" >
													
																	<label for="bfciaryName" class="control-label fms_required" id="bfciaryName_label"> 
																		<g:message code="beneficiary.bfciaryName.label"	default="Organization Name:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName"
																				value="${beneficiary.bfciaryName }" maxlength="180"
																				tableName="BENEFICIARY" attributeName="bfciaryName"
																				title="The Name of the Organization" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="bfciaryName_error"></div>
																		</div>
																	<label for="lastName" class="control-label fms_required" id="lastName_label">
																		<g:message code="beneficiary.lastName.label" default="Contact Last Name:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName"
																				value="${beneficiary.lastName }" maxlength="60" 
																				tableName="BENEFICIARY" attributeName="lastName"
																				title="The Last Name of the Organization Contact Person" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="lastName_error"></div>
																	</div>
																</div>
															</div>
														</fieldset>
													</div>
															
													<div class="fms_widget">        
														<fieldset>
														<legend><h3>Organization Address</h3></legend>
													    	<div class="fms_form_layout_2column">                  
													        	<div class="fms_form_column fms_very_long_labels">
																 
																	<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
																		<g:message code="beneficiary.addressLine1.label" default="Address 1:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1"
																				tableName="BENEFICIARY" attributeName="addressLine1"
																				maxlength="60" 
																				value="${beneficiary.addressLine1 }"
																				title="The Address of the Organization" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine1_error"></div>
																	</div>
																	
																	<label for="city" class="control-label fms_required" id="city_label"> 
																		<g:message code="beneficiary.city.label" default="City:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField 
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city"
																				tableName="BENEFICIARY" attributeName="city"
																				maxlength="30" 
																				value="${beneficiary.city}" title="The City of the Organization" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="city_error"></div>
																	</div>
																	
																	<label for="zipCode" class="control-label fms_required" id="zipCode_label"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control bZipCode"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode"
																			    tableName="BENEFICIARY" attributeName="zipCode" 
																				maxlength="10" 
																				value="${beneficiary?.zipCode}"
																				title="The Zip Code of the Organization" >
																				</g:secureTextField>	
																				<div class="fms_form_error" id="zipCode_error"></div>
																		</div>
																	</div>
																	<div class="fms_form_column fms_very_long_labels">
																	
																	<label for="addressLine2" class="control-label" id="addressLine2_label"> 
																		<g:message code="beneficiary.addressLine2.label" default="Address 2:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine2"
																				tableName="BENEFICIARY" attributeName="addressLine2"
																				maxlength="60" 
																				value="${beneficiary.addressLine2 }"
																				title="The Address of the Organization" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="addressLine2_error"></div>
																	</div>
																	<label for="benState" class="control-label fms_required" id="benState_label"> 
																		<g:message code="beneficiary.benState.label" default="State:" />
																	</label>
																	<div class="fms_form_input">
																			<g:secureComboBox
																				class="form-control" name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state"  optionKey="stateCode"
																				tableName="BENEFICIARY" attributeName="state" 
																				optionValue="stateName" id="state.name" from="${states}"
																				noSelection="['':'-- Select a State --']"
																				value="${beneficiary?.state}">
																			</g:secureComboBox>
																			<div class="fms_form_error" id="benState_error"></div>
																	</div>
																	
																	<label for="country" class="control-label fms_required" id="country_label"> 
																		<g:message code="beneficiary.country.label" default="Country:" /> 
																	</label>
																	<div class="fms_form_input">
																			<g:secureTextField
																				type="text" class="form-control"  
																				name="beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country"
																				readonly="readonly" 
																				tableName="BENEFICIARY" attributeName="country"
																				value="${beneficiary?.country}"
																				title="The Country of the Organization" maxlength="30" value="USA" >
																			</g:secureTextField>
																			<div class="fms_form_error" id="country_error"></div>
																	</div>
												
																</div>
															</div>
														</fieldset>
													</div>
												</g:if>
											</td>
										</tr>
									</g:each>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</g:each>
	</div>
</div>
	
	<div id="addGroupPlaceHolder"></div>											  

<div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>

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
				<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
			</div>
		</div>
	</div>
</div>
<!-- END - Delete Notice Modal -->

<div class="modal fade" id="InfoAlertADD" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>You may add beneficiaries for subscribers only.</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>

<!-- END - Delete Notice Modal -->

<div class="modal fade" id="InfoDeleteModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
  	<div class="modal-dialog">
       	<div class="modal-content fms_modal_info">
           	<div class="modal-body">
           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4>To delete this beneficiary, You must first go to the Beneficiary Allocation screen and remove the beneficiary.</h4>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          	</div>
      	</div>
  	</div>
</div>

<script>
	var memberSelectObject = document.getElementById('memberIdSelectList')
	showBeneficiary(memberSelectObject)
</script>
			