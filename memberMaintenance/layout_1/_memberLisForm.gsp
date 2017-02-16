<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberLisInfo"%>
              
<g:set var="appContext" bean="grailsApplication"/>

<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?true:false}" />

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'fms-main.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>  
<script type="text/javascript">
$(function(){
    $(".numeric").numeric({});
});

$(function(){
	$(".alphanum").alphanum();
});

$(function(){
    $(".amtNumeric").numeric({});
    $(".qhpMask").mask("99999aa999999999");		
});

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
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newMemberLisInfo')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addLisInfoDiv')
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
			var divObj = document.getElementById('addLisInfoDiv')
			divObj.style.display = "block"
			var formObj = document.getElementById('editForm')
			formObj.reset()
		} 
	}
	function showLisInfo(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")		
		if (!addRowClicked) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var lisInfoDivObj = document.getElementById(selectedValue)
			var addLisInfoDivObj = document.getElementById("addLisInfoDiv")
			hiddenObj.value=selectedValue			
			if (lisInfoDivObj  != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display="none"
				}
				lisInfoDivObj.style.display = "block"
				addLisInfoDivObj.style.display = "block"
				previousDivObj = lisInfoDivObj
			} 
		} 
	}

	function addLisInfo() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var selectObj = document.getElementById("memberIdSelectList")
		var memberDBID = selectObj.options[selectObj.selectedIndex].value
		var personNumber = document.getElementById(subscriberId+":"+memberDBID).value
		
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/memberMaintenance/addLisInfo?subscriberId="
				+ subscriberId + "&editType=DETAIL&memberDBID="+memberDBID+"&personNumber="+personNumber);
	}
		function gotoSearch() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/list");
	}
	
</script>
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

<input type="hidden" name="editType" value="MEMMC_LIS_INFO" />
<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
<div id="fms_content_body">
	<div class="right-corner" align="right">MEMMCLIS</div>
	       
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

            	<select id="memberIdSelectList"  class="form-control" name="memberIdlist" onChange="showLisInfo(this)" >
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
			 <h2>MEMMC LIS Info  <button name="addLisInfoButton" type="button" class="btn btn-primary btn-sm" title="Click to add a new lis info." onClick="addLisInfo()"><i class="fa fa-plus"></i> New LIS Info</button></h2>
		<table>
			<tr>
				<td>
					<div id="addLisInfoDiv" style="display:block"></div>
				</td>
				<td>
					<div id="releaseSelect" style="display: none">
						<input type="button" name="enableMemberSelection" value="Enable Member Selection" onClick="releaseMemberSelection()">
					</div>
				</td>
			</tr>
		</table>
		<div class="fms_required_legend fms_required">= required</div>   	
		<div id="dummy" style="display: none"></div>
        <g:each in="${lisInfoMap.keySet()}" status="idCount" var="memberDBID">
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
       						<div class="fms_table_wrapper">
          						<table id="DataTable" class=" tablesorter tablesorter-fms tablesorteree7b702bcolumnselector" role="grid" aria-describedby="DataTable_pager_info">
		                  <thead>
		                    <tr role="row" class="tablesorter-headerRow">
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">LIS Start Date </th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">LIS End Date</th>
		                      <th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">LIS Subsidy Level</th>		
		                     
		                      <th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="6" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</th>
		                    </tr>
		                  </thead>
					      <tbody aria-live="polite" aria-relevant="all"> 
					         
					      	<g:each in="${lisInfoMap.get(memberDBID)}" status="i" var="lisInfo" >									      
								<input type="hidden" name="seq_lis_id_${i}" value="${lisInfo.seqLisInfo}">
								<input type="hidden" name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.iterationCount" value="${lisInfo.seqLisInfo}">		
																									
					            <tr id="Row2" role="row" class="tablesorter-hasChildRow" style="">
					         
		                       		<td><g:formatDate format="yyyy-MM-dd" date="${lisInfo.lisStartDate}" /></td>
		                        	<td><g:formatDate format="yyyy-MM-dd" date="${lisInfo.lisEndDate}" /></td>
		                        	<td>${lisInfo.lisSubsidyLevel}</td>                     
				                   	<td>				
													<button class="btn fms_btn_icon btn-sm BtnEditRow" type="button" title="Click to edit or view this row."><span class="glyphicon glyphicon-pencil"></span></button>
                        							<button class="btn fms_btn_icon btn-sm BtnCollapseRow hidden" type="button" title="Click to collapse this row."><span class="glyphicon glyphicon-collapse-up"></span></button>
									</td>
					            </tr>
					            
					            <tr id="Row2Child" class="tablesorter-childRow" role="row">
					            	<td colspan="4" id="LisInfo.${memberDBID }.${lisInfo.seqLisInfo}.toggleFields" class="" style="display:none;">
					                	<div class="fms_widget">        
					                    	<fieldset>
					                            <legend><h3>Information</h3></legend>
					                           		<div class="fms_form_layout_2column">                  
					                           			<div class="fms_form_column fms_long_labels">									
					
								                            <label class="control-label fms_required" for="lisStartDate" id="lisStartDate_label">
								                            <g:message code="lisInfo.lisStartDate.label" default="LIS Start Date :" /></label>                              
								                            <div class="fms_form_input">
								                            
								                             <g:securejqDatePickerUIUX
                                                					tableName="MEMBER_LIS_INFO" attributeName="lisStartDate" title="Low Income Subsidy Start Date"
                                                					datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisStartDate != null ? lisInfo?.lisStartDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1"
                                                					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: lisInfo?.lisStartDate)}"  
                                                					dateElementId="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisStartDate"
                                                					dateElementName="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisStartDate" 
                                                					ariaAttributes="aria-labelledby='lisStartDates_label' aria-describedby='lisStartDates_error' aria-required='false'" 
                                                					classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                                					showIconDefault="${isShowCalendarIcon}"/>                                            
                                                					<div class="fms_form_error" id="lisStartDates_error"></div>
                               								 </div>
					                              			<!-- Lis subsidy -->
								                            <label class="control-label" for="lisInfo.lisSubsidyLevel" id="lisInfo.lisSubsidyLevel_label">
								                            <g:message	code="lisInfo.lisSubsidyLevel.label" default="LIS Subsidy Level :" />	
																
															</label>
								                            <div class="fms_form_input">
								                            	<g:secureTextField maxlength="6"
																		name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisSubsidyLevel" 
																		tableName="MEMBER_LIS_INFO" 
																		attributeName="lisSubsidyLevel" Class="form-control amtNumeric"
																		value="${formatNumber(number: lisInfo?.lisSubsidyLevel, format: '###,##0.00')}" 										
																		title="Calculated value as per TRR business">
																</g:secureTextField>
								                            	 <div class="fms_form_error" id="lisSubsidyLevel_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								                            </div>
					                         
					                         		
					                         			   <!--Lis source code  -->
							                               <label class="control-label fms_required" id="lisSourceCode_label" for="lisSourceCode">
							                              		<g:message code="lisInfo.lisSourceCode.label" default="LIS Source Code :" />	
															</label>
							                               <div class="fms_form_input">
							                               		<g:secureComboBox
																		name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisSourceCode" 
																		tableName="MEMBER_LIS_INFO" 
																		attributeName="lisSourceCode" Class="form-control"
																		blankValue="SELECT"
																		value="${lisInfo.lisSourceCode}"
																		from="${['A': 'Approved SSA Applicant', 'D': 'Deemed eligible by CMS', 'B': 'BAE']}" 
																		optionValue="value" optionKey="key"
																		title="Low Income Subsidy Source Code">
																</g:secureComboBox>
							                                    <div class="fms_form_error" id="lisSourceCode_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
							                                </div>
					       							 		
					       							 		
					       							 		<!-- part D -->
								       						<label class="control-label" for="lisInfo.partdLisEnrSubsidy" id="lisInfo.partdLisEnrSubsidy_label">
								       						<g:message code="lisInfo.partdLisEnrSubsidy.label"	default="Part D Enr Subsidy :" />
															</label>
								                            <div class="fms_form_input">
								                            	<g:secureTextField maxlength="24"
																		name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.partdLisEnrSubsidy" 
																		tableName="MEMBER_LIS_INFO" 
																		attributeName="partdLisEnrSubsidy" Class="form-control amtNumeric"
																		value="${formatNumber(number: lisInfo?.partdLisEnrSubsidy, format: '###,##0.00')}" 		
																		class="amtNumeric"
																		title="Part D late enrollment penalty subsidy amount"></g:secureTextField>
					                                    <div class="fms_form_error" id="partdLisEnrSubsidy_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
								                            </div>
					       							</div>
					       							<!-- END OF RIGHT SIDE -->	
					       														       						
						                            <div class="fms_form_column fms_long_labels">
						                            	<label class="control-label fms_required" for="lisEndDate" id="lisEndDate_label">
						                            	<g:message	code="lisInfo.lisEndDate.label" default="LIS End Date :" />
													</label>                              
						                            	<div class="fms_form_input">
						                            	 <g:securejqDatePickerUIUX
                                                					tableName="MEMBER_LIS_INFO" attributeName="lisEndDate" title="Low Income Subsidy End Date"
                                                					datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (lisInfo?.lisEndDate != null ? lisInfo?.lisEndDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100' , maxDate:'+100y', numberOfMonths: 1"
                                                					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: lisInfo?.lisEndDate)}"  
                                                					dateElementId="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisEndDate"
                                                					dateElementName="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisEndDate" 
                                                					ariaAttributes="aria-labelledby='lisEndDate_label' aria-describedby='lisEndDate_error' aria-required='false'" 
                                                					classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                                					showIconDefault="${isShowCalendarIcon}"/>                                            
                                                			<div class="fms_form_error" id="lisEndDate_error"></div>
						                            </div> 
					
					
												<!-- LIS COPAY CATEGORY -->
												 	<label class="control-label fms_required" id="lisCopayCategory_label" for="lisCopayCategory">
												 		<g:message	code="lisInfo.lisCopayCategory.label" default="LIS Copay Category:" />
													</label>
					                                <div class="fms_form_input">
					                                	<g:secureComboBox	name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.lisCopayCategory" 
																tableName="MEMBER_LIS_INFO" attributeName="lisCopayCategory" Class="form-control"
																value="${lisInfo.lisCopayCategory}"
																title="Low Income Subsidy Category"
																from="${['0': 'None, not low-income', '1': 'High', '2': 'Low','3': '$0 Full duals that are institutionalized', '4': '15%', '5': 'Unknown']}" 
																optionValue="value" optionKey="key"></g:secureComboBox>
					                                	    <div class="fms_form_error" id="lisCopayCategory_error"></div>
					                           		</div>
													 
					       							 <!-- Enrollee -->
					       							<label class="control-label fms_required" id="enrolleeTypeFlag_label" for="enrolleeTypeFlag">
					       							<g:message code="lisInfo.enrolleeTypeFlag.label" default="Enrollee Type Flag:" />
													</label>
					                                <div class="fms_form_input">
					                                	<g:secureComboBox
																name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.enrolleeTypeFlag" 
																tableName="MEMBER_LIS_INFO" 
																attributeName="enrolleeTypeFlag" Class="form-control"
																value="${lisInfo.enrolleeTypeFlag}"
																from="${['C': 'Current PBP Enrollee', 'P': 'Prospective PBP Enrollee', 'Y': 'Previous PBP Enrollee']}" 
																optionValue="value" optionKey="key"
																title="Low Income Subsidy Type Flag">
														</g:secureComboBox>
					                                    <div class="fms_form_error" id="enrolleeTypeFlag_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
					                                </div>
					       							 
					       							<label class="control-label" for="lisInfo.partdLisSubsidy" id="lisInfo.partdLisSubsidy_label">
					       							<g:message
															code="lisInfo.partdLisSubsidy.label"
															default="Part D LIS Subsidy:" />
													</label>
					                              	<div class="fms_form_input">
					                                 	<g:secureTextField maxlength="24"
															name="lisInfo.${memberDBID }.${lisInfo.seqLisInfo}.partdLisSubsidy" 
															tableName="MEMBER_LIS_INFO" 
															attributeName="partdLisSubsidy" Class="form-control amtNumeric"
															value="${formatNumber(number: lisInfo?.partdLisSubsidy, format: '###,##0.00')}" 
															class="form-control amtNumeric"
															title="Low Income Part D premium subsidy amount"></g:secureTextField>
					                                 	 <div class="fms_form_error" id="partdLisSubsidy_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
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
<script>
		var memberSelectObject = document.getElementById('memberIdSelectList')
		showLisInfo(memberSelectObject)
	</script>	
</div>
</html>
	
	   
	