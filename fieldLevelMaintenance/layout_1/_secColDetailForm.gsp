<%@ page import="com.dell.diamond.fms.sfldl.FieldLevelSecurityTableEnum"%>
<%@ page import="com.dell.diamond.fms.sfldl.enums.FieldLevelSecurityAccessEnum"%>

<g:set var="appContext" bean="grailsApplication" />
<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="userMaintenance"/>
		
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>

<script type="text/javascript">
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
	var previousDivObj
	function releaseMemberSelection() {
		var result = confirm("Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ", "Yes - Change Member ", "No - Stay on this page")
		if (result) {			
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display="none"		
			var formObj = document.getElementById('editForm')
			formObj.reset()
			var addButtonDiv = document.getElementById("addSecColDetailButtonDiv")
			var placeHolderDiv = document.getElementById("addSecColDetailPlaceHolder")
			var releaseDataDiv = document.getElementById("releaseSelect")
			var saveButtonObj = document.getElementById("saveButton")
			placeHolderDiv.innerHTML  = "&nbsp;"
			placeHolderDiv.style.display = "block"
			addButtonDiv.style.display = "block"
			releaseDataDiv.style.display = "none"
			saveButtonObj.disabled = false
		} 
	}
	
	function addSecColDetail(sfldlId) {
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/fieldLevelMaintenance/addSecColDetail?sfldlId="
				+ sfldlId + "&editType=DETAIL");
	}
	function saveNewSecColDetail() {
		${remoteFunction(
			     action:'a', 
				 controller : 'fieldLevelMaintenance',
			     update:'columnNameDivObj', 
			     params: '{clazzName: selectedValue, sfldlId: sfldlId}'
			     )}
	}

	function populateColumnName(selectedValue, sfldlId, updateObjSuffix) {
		var updateObj = "columnNameDivObj."+updateObjSuffix
		var updateObjValue = document.getElementById("secColDetail."+updateObjSuffix+".columnName").value
		var appName = "${appContext.metadata['app.name']}";		
		if(selectedValue) {
			jQuery.ajax(
					{
						type:'POST',
						data:{clazzName: selectedValue, sfldlId: sfldlId, selected: updateObjValue, idName: "secColDetail."+updateObjSuffix+".columnName" }, 
						url:"/"+appName+"/fieldLevelMaintenance/ajaxRefreshColumnNames",
						success:function(data){
							document.getElementById(updateObj).innerHTML = data
						}					
					});
		}
	 }
	
	function checkLoggedIn(accessURI) {
		var appName = "${appContext.metadata['app.name']}";
		var loggedInUser;
		var loginRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxGetLoggedInUserName",
			type : "POST",
			success : function(result) {
				if (result == "null") {
					window.location.assign('/"+appName+"/login')
				}
			}
		});
		var authorizeRequest = jQuery.ajax({
			url : "/"+appName+"/login/ajaxAuthorizeUser?uri="+accessURI,
			type : "POST",
			success : function(result) {
				if (result == "false") {
					alert ("You do not have permission to update this content");
					return false;
				}
			}
		});		
	}

	function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/fieldLevelMaintenance/search");
	}
	
	function deleteSubmitted(sfldlId, tableName, columnName) {

		document.getElementById ("sfldlIdToDelete").value = sfldlId
		document.getElementById ("tableNameToDelete").value = tableName
		document.getElementById ("columnNameToDelete").value = columnName
		
        var appName = "${appContext.metadata['app.name']}";
        var myFm = document.getElementById("editForm") ; 			
        myFm.action = "/"+appName+"/fieldLevelMaintenance/deleteSecColDetail";     	
        myFm.submit();
		
}
</script>

<script type="text/javascript">

	$(document).ready(function() {
	
		$('.BtnDeleteRow').click(function(e){
             $('#DeleteAlertModal').modal('show');
         });

	      $('#DeleteAlertModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });
		  
		$('.BtnCollapseRow').hide().removeClass('hidden');	
      // Edit icon on table row
         $('.tablesorter').delegate('.BtnEditRow, .BtnCollapseRow', 'click' ,function(e){
           var parentTR = $(this).closest('tr');
           $(parentTR).find('.BtnEditRow, .BtnCollapseRow').toggle();
           $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
         });

      // Save button 
         $('.BtnSave').click(function(e){
           $('#SaveAlertModal').modal('show');
         });
         
         // Save Modal
         $('#BtnSaveModal').click(function(e){
        	var appName = "${appContext.metadata['app.name']}";
            var myFm = document.getElementById("editForm") ; 			
            myFm.action = "/"+appName+"/fieldLevelMaintenance/update";     	
            myFm.submit();
         });

         // Undo button
         $('.BtnUndo').click(function(e){
           $('#WarningAlertModal').modal('show');
         });

         $('.BtnUndoModal').click(function(e){
           this.form.reset();
           resetForm();           
         });
         		      
         function resetForm(){
             $('.BtnCollapseRow').hide();
             $('.BtnEditRow').show();
             $('.tablesorter-childRow td').hide();
           }
	});
</script>

	<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<div class="right-corner" align="right">SFLDL</div>
		<h2>Edit Field Level Security Detail

       	<g:checkURIAuthorization uri="/fieldLevelMaintenance/addSecColDetail">
       		<button name="addSecColDetailBtn" type="button" class="btn btn-primary btn-sm" title="Click to add a new detail" onClick="addSecColDetail('${sfldlId}')"><i class="fa fa-plus"></i> Add New Detail</button>
		</g:checkURIAuthorization> </h2>

		<%-- Error messages start--%>
		<div id="flash_messages" class="flash_messages">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${secColMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${secColMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:if test="${errors}">
			<ul class="errors" role="alert">
				<g:each in="${errors}" var="error">
				<li> ${ error}</li>
				</g:each>
			</ul>
			</g:if>
			<g:if test="${messages}">
			<ul class="message" role="alert">
				<g:each in="${messages}" var="message">
				 ${ message}
				</g:each>
			</ul>
			</g:if>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>${error}</li>
					</g:each>
				</ul>
			</g:if>
		  <ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		</div>
		<%-- Error messages end--%>
		
		<div class="fms_required_legend fms_required">= required</div> 
		
		<div id="dummy" style="display: none"></div>
		
		<input type="hidden" name= "editType" value="DETAIL">
		<input type="hidden" name= "sfldlId" value="${params.sfldlId }">
		<input type="hidden" name="sfldlIdToDelete" id="sfldlIdToDelete" value="">
		<input type="hidden" name="tableNameToDelete" id="tableNameToDelete" value="">
		<input type="hidden" name="columnNameToDelete" id="columnNameToDelete" value="">
		
		<!-- START - Data Table Section -->	
	   	<div id="DataTableSection">
			<div id="SearchResults" class="fms_widget">
	            	
            	<!-- START - FMS Widget -->
				<div class="fms_widget">

					<div class="row bottom-margin-sm">
		                  <div class="col-xs-6">
		                    <button class="btn btn-sm btn-primary" type="button" onclick='gotoSearch()' title="Click to perform a new search.">New Search</button>
		                  </div>
		                  <div class="col-xs-6 text-right">
		                    <button id="BtnSave" class="btn btn-primary btn-sm BtnSave" type="button" title="Click to save all changes."><span class="fa fa-floppy-o"></span> Save All Changes</button>
		                    <button id="BtnUndo" class="btn btn-default btn-sm BtnUndo" type="button" title="Click to clear all changes."><span class="glyphicon glyphicon-repeat"></span> Undo All Changes</button>
		                  </div>
		       		</div>
		       		
					<!-- START - FMS Table Wrapper -->
		           	<div class="fms_table_wrapper">	
						<table id="DataTable" class="tablesorter tablesorter-fms tablesorterdf6319efcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
	                  		<thead>
	                    		<tr role="row" class="tablesorter-headerRow">
			                      	<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" aria-disabled="true">Funtional Area</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Table Name</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Column Name</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Security</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Action</th>
	                    		</tr>
	                  		</thead>
	                  		
	                  		<tfoot></tfoot>
	                  		
							<tbody aria-live="polite" aria-relevant="all"> 				

		
								<g:each in="${ secColDetailList}" status="i" var="secColDetail" >
									<input type="hidden" name="secColDetail.${i}.sfldlId" value="${ secColDetail.sfldlId}">
									<g:if test="${ i==0 }"></g:if>
									
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										<td class="clickme">
											${secColDetail?.functionalArea }
										</td>
										<td class="clickme">
											${secColDetail?.tableName }
										</td>
										<td class="clickme">
											${secColDetail?.columnName }
										</td>
										<td class="clickme">
											${FieldLevelSecurityAccessEnum.byaccessType(secColDetail?.securityInd)?.description()}
										</td>
										<td>
											<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        					<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
										</td>
									</tr>
									
									<tr id="Row2Child" class="tablesorter-childRow" role="row">
										<td colspan="5" id="address.${i}.toggleFields" class="" style="display:none;">
									
											<!-- START - WIDGET: General Information -->
											<div class="fms_widget">        
												<fieldset>
													<legend><h3>General Information</h3></legend>
													<div class="fms_form_layout_2column">                  
														<div class="fms_form_column fms_very_long_labels">
														
															<label id="functionalArea_label" class="control-label fms_required" for="functionalArea"> 
																<g:message code="secColDetail.functionalArea.label" default="Functional Area:" />
															</label>
															<div class="fms_form_input">
																<g:getCdoSelectBox 
																	className="form-control"
																	cdoClassName="com.perotsystems.diamond.dao.cdo.SystemCodes" disable= "disabled" 
																	cdoAttributeWhere="systemCodeType" cdoAttributeWhereValue="FLS_FUNC_AREA"
																	cdoAttributeSelect="systemCode"  cdoAttributeSelectDesc="systemCode"
																	htmlElelmentId="secColDetail.${i}.functionalArea"
																	languageId="0"
																	blankValue="Functional Area"
																	defaultValue="${secColDetail?.functionalArea}"
																	title="The functional area"/>
																<div class="fms_form_error" id="functionalArea_error"></div>	
															</div>
															
															<label id="securityInd_label" class="control-label" for="securityInd"> 
																<g:message code="subscriberMember.securityInd.label" default="Security Indicator :" />
															</label>
															<div class="fms_form_input">
																<g:select 
																	class="form-control"
																	name="secColDetail.${i}.securityInd"
																	from="${FieldLevelSecurityAccessEnum.values() }"
																	optionKey="accessType" optionValue="description" value="${secColDetail?.securityInd}" noSelection="['':'-- Select a Security Indicator --']"
																	title="Enter the security restriction"/>
																<div class="fms_form_error" id="functionalArea_error"></div>	
															</div>
														</div>
														
														<div class="fms_form_column fms_very_long_labels">
															<label id="tableName_label" class="control-label fms_required" for="tableName"> 
																<g:message code="secColDetail.tableName.label" default="Table Name :" />
															</label>
															<div class="fms_form_input">
																<%String selectedValue = com.perotsystems.diamond.tools.build.cdo.Util.dbNameToJavaName (secColDetail?.tableName, true)+ com.dell.diamond.service.auth.SecurityService.SEC_COL_CLASS_NAME_SUFFIX %>
																<g:if test="${!FieldLevelSecurityTableEnum.values()?.contains(selectedValue)  }">
																	<select class="form-control"
																		name="secColDetail.${i}.tableName" disabled= "disabled" 
																		onChange="populateColumnName(this.value, '${params.sfldlId }', '${i}')"
																		title="The table that will have the restriction">
																		<option value="">-- Select a Table name--</option>
																		<g:each in="${FieldLevelSecurityTableEnum.values() }" var="tableName">
																			<option ${tableName.tableMappingName?.equals(selectedValue)? 'selected':'' } value="${tableName.tableName }">${tableName.tableName}</option>
																		</g:each>
																	</select>
																	<input type="hidden" name="secColDetail.${i}.tableName" value="${secColDetail?.tableName}">
																</g:if>
																<g:else>
																	${secColDetail?.tableName}
																</g:else>
																<div class="fms_form_error" id="tableName_error"></div>	
															</div>
															
															<label id="columnNameName_label" class="control-label" for="columnNameName"> 
																<g:message code="secColDetail.columnName.label" default="Column Name :" />
															</label>
															<div class="fms_form_input">
																<div id="columnNameDivObj.${i }">
																	<g:textField 
																		class="form-control" 
																		readOnly="readOnly"
																		name="secColDetail.${i}.columnName" 
																		value="${secColDetail?.columnName }" />
																</div>
																<div class="fms_form_error" id="columnNameName_error"></div>	
															</div>
														</div>
													</div>
												</fieldset>
											</div>
											<div class="fms_form_button">

												<button id="BtnAddressDelete2" type="button" class="btn btn-primary BtnDeleteRow btn-sm" 
													title="Click to delete record." 
													data-target="#DeleteAlertModal">
													<i class="fa fa-trash"></i> Delete
												</button>
												<input type="reset" class="btn btn-primary btn-sm" value="Reset" />
											</div>
										</td>
									</tr>	
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
													<button onClick="return deleteSubmitted('${secColDetail.sfldlId }', '${secColDetail.tableName }', '${secColDetail.columnName }')" id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
												</div>
											</div>
										</div>
									</div>
									<!-- END - Delete Notice Modal -->
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>		
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
              <%--<g:actionSubmit class="btn btn-primary" action="update" id="saveButton" value="Yes, Save" />--%>
              <button id="BtnSaveModal" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Save</button>
            </div>
          </div>
        </div>
      </div>
    <!-- END - Save Notice Modal -->
    	
</div>