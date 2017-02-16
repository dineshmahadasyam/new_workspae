<%@ page import="com.perotsystems.diamond.bom.AgencyJobRequest"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="searchJobs"/>
<g:set var="entityName"
	value="${message(code: 'AgencyJobRequest.label', default: 'AgencyJobRequest')}" />
<g:set var="appContext" bean="grailsApplication" />
<script>
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/commissions/searchJobs")
	}
</script>
<script type="text/javascript">

		$(document).ready(function() {
			
			$('.groupIdAlert').hide();  
			$('.groupIdAlert').click(function(e){ 
		    	$('#SearchAlertModal').modal('show');
		    });
		 	$('#SearchAlertModal').modal({
		    	backdrop: 'static',
		       show: false
		   	});
		
		 	$('.groupIdAlertInfo').hide();  
			$('.groupIdAlertInfo').click(function(e){ 
		    	$('#SearchAlertModalInfo').modal('show');
		    });
		 	$('#SearchAlertModalInfo').modal({
		    	backdrop: 'static',
		       show: false
		   	});
		
		 	
		});


		function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {
			var groupId = document.getElementById(idName).value
			 if(groupId == null || groupId == "") {
				//alert ("Please enter Group Id");
				document.getElementById('GroupIdAlertInfo').click();						
				return false;
			}

			var isValidGroupId= "";
			 var descr = jQuery.ajax({
					url : '<g:createLinkTo dir="/agency/ajaxValidateGroupId"/>',
					async: false,				
					type : "POST",
					data : {groupId:groupId},
					success : function(result) {
						isValidGroupId = result
					}
				});
			
			if(isValidGroupId == null || isValidGroupId != "true"){
				//alert ("Please enter a valid Group Id");
				document.getElementById('GroupIdAlert').click();						
				return false;
			}
			
			var htmlElementValue 
			var assocHTMLElementsValue
			if(idName.indexOf('|') == -1){			
				htmlElementValue = document.getElementById(idName).value
				assocHTMLElementsValue = htmlElementValue
			} else {
				var nameArray = idName.split("|")
				for (var i =0;i<nameArray.length;i++) {
					if(i == 0) {
						htmlElementValue = document.getElementById(nameArray[i]).value					
					}
					assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
				}
			}
			//alert("htmlElementValue = "+htmlElementValue )
			var appName = "${appContext.metadata['app.name']}";
				$('#LookupModal').modal('show');
				var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
								+ "&htmlElementValue=" + htmlElementValue 
								+ "&cdoClassName="+ cdoClassName 
								+ "&cdoClassAttributeName="+ cdoClassAttributeName 
								+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
								+ "&setToIdName=" + setToIdName
								+ "&setToIdName1=" + setToIdName1
								+ "&offset=0"
				document.getElementById('LookupSrc').setAttribute('src', urlValue);
			
		}
	
</script>
<script type="text/javascript">
	$(function(){
		if(${create}){
			$('#planCode').attr('disabled', 'disabled');
			$('#Btn_batchId').attr('disabled', 'disabled');
			$('#Btn_agencyId').attr('disabled', 'disabled');
			$('#Btn_groupId').attr('disabled', 'disabled');
			$('#Btn_planCode').attr('disabled', 'disabled');
		    $("#groupId_radio, #batchId_radio, #agencyId_radio").change(function(){
		        $("#batchId, #seqAgencyId, #agencyId, #seqGroupId, #groupId, #planCode").val("").attr("readonly",true);
		        $("#batchLookup, #agentLookup, #groupLookup, #planLookup").attr("onClick","");
		        if($("#batchId_radio").is(":checked")){
		            $("#batchId").removeAttr("readonly");
		            $("#batchId").focus();
		            $('#Btn_batchId').removeAttr('disabled', 'disabled');
		            $('#Btn_groupId').attr('disabled', 'disabled'); 
		            $('#Btn_planCode').attr('disabled', 'disabled');
		            $('#Btn_agencyId').attr('disabled', 'disabled');
		            document.getElementById("groupId");
		            document.getElementById("planCode");
		            document.getElementById("agencyId");
		            document.getElementById("batchId");
		            $("#groupLookup").attr("onClick","");
		            $("#planLookup").attr("onClick","");
		            $("#agentLookup").attr("onClick","");
		            $("#batchLookup").attr("onClick","lookup('batchId', 'com.perotsystems.diamond.bom.AgencyBatchJob','batchId', null, null)");
		        }
		        else if($("#groupId_radio").is(":checked")){
		            $("#groupId").removeAttr("readonly");
		            $("#seqGroupId").removeAttr("readonly");
		            $("#planCode").removeAttr("readonly");
		            $("#groupId").focus();
		            $('#planCode').removeAttr('disabled', 'disabled');
		            $('#Btn_groupId').removeAttr('disabled', 'disabled');
		            $('#Btn_planCode').removeAttr('disabled', 'disabled');
		            $('#Btn_agencyId').attr('disabled', 'disabled');
		            $('#Btn_batchId').attr('disabled', 'disabled');   
		            document.getElementById("batchId");
		            document.getElementById("agencyId");   
		            document.getElementById("groupId");
		            document.getElementById("planCode");
		            $("#batchLookup").attr("onClick","");
		            $("#agentLookup").attr("onClick","");
		            $("#groupLookup").attr("onClick","lookup('groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'seqGroupId', 'seqGroupId' )");
		            $("#planLookup").attr("onClick","lookup('planCode', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'seqGroupId','seqGroupId')");		            		            
		        }
		        else if($("#agencyId_radio").is(":checked")){
		            $("#agencyId").removeAttr("readonly");
		            $("#seqAgencyId").removeAttr("readonly");
		            $("#agencyId").focus();
		            $('#Btn_agencyId').removeAttr('disabled', 'disabled');   
		            $('#Btn_batchId').attr('disabled', 'disabled');  
		            $('#Btn_groupId').attr('disabled', 'disabled'); 
		            $('#Btn_planCode').attr('disabled', 'disabled'); 
		            document.getElementById("batchId");
		            document.getElementById("groupId");
		            document.getElementById("planCode");
		            document.getElementById("agencyId");		        
		            $("#batchLookup").attr("onClick","");
		            $("#groupLookup").attr("onClick","");
		            $("#planLookup").attr("onClick","");
		            $("#agentLookup").attr("onClick","lookup('agencyId', 'com.perotsystems.diamond.dao.cdo.Agency','agencyId', null, null, 'seqAgencyId', 'seqAgencyId')");		            
		        }
		    });
		}
	});
</script>
<script>
function resetFieldAppearance(){
	$("#batchId, #seqAgencyId, #agencyId, #seqGroupId, #groupId, #planCode").val("").attr("readonly",true);
    $("#batchLookup, #agentLookup, #groupLookup, #planLookup").attr("onClick","");
    document.getElementById("agencyId");	
    document.getElementById("groupId");
    document.getElementById("planCode");
    document.getElementById("batchId");
    $('#Btn_batchId').attr('disabled', 'disabled');
    $('#Btn_agencyId').attr('disabled', 'disabled');
    $('#Btn_groupId').attr('disabled', 'disabled');
    $('#Btn_planCode').attr('disabled', 'disabled');
}
</script>

</head>
<div id="fms_content">
	<div id="fms_content_header">
		<div class="fms_content_header_note">
			<a href="${createLink(uri: '/commissions/searchJobs')}">Commissions Maintenance</a> / Job
       	</div>
		<div class="fms_content_title">
			<h2>Commission-Incentive Job Detail</h2>
		</div>
	</div>
	<div id="fms_content_body">
		<g:form>
			<%-- Error messages start--%>
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>
							${error}
						</li>
					</g:each>
				</ul>
			</g:if>
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<%-- Error messages end--%>


				<g:hasErrors bean="${job}">
					<ul class="errors" role="alert">
						<g:eachError bean="${job}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>

				<div id="AddNewDataSection" class="fms_form_border"
					style="display: block;">
					<div class="fms_widget_border fms_widget_bgnd-color">
						<div class="fms_widget">
							<fieldset class="no_border">
								<legend>
									<g:if test="${create}">
									<h2>Create Job Detail</h2>
									</g:if>
									<g:else>
										<h2>Edit Job Detail</h2>
									</g:else>
								</legend>

								<div class="fms_form_layout_2column">
									<div class="fms_form_column fms_long_labels">

											<label class="control-label fms_required" for="jobId_v1"
												id="jobId"> <g:message
													code="AgencyJobRequest.jobId.label" default="Job ID :" />
											</label>
											<div class="fms_form_input">
												<g:textField class="form-control" readOnly="true"
													name="jobId" maxlength="50" required="Job ID is Required"
													autofocus="autofocus" value="${job?.jobId}" />
												<div class="fms_form_error" id="CompanyCode_v1_error"></div>
											</div>
										
											<label class="control-label fms_required" for="batchId" id="batchId_l1"> 
												<g:if test="${create}">
													<input type="radio" name="typeSelectorRadio" id="batchId_radio" />
												</g:if> 
												<g:message code="AgencyJobRequest.batchId.label" default="Batch :" />
											</label>
											<div class="fms_form_input fms_has_feedback">
												<g:textField  Class="form-control" disabled="${!create?"true":"false"}" readonly="readonly" name="batchId" id="batchId" maxlength="50" value="${job?.batchId}" />
											<g:if test="${create}">
												<fmsui:cdoLookup 
												lookupElementId="batchId"
                                                lookupElementName="batchId" 
                                                lookupElementValue="${job?.batchId}"
                                                lookupCDOClassName="com.perotsystems.diamond.bom.AgencyBatchJob"
                                                lookupCDOClassAttribute="batchId"/>
											</g:if>
												<div class="fms_form_error" id="batchId_v1_error"></div>
											</div>
									
											<label class="control-label fms_required" for="seqAgencyId"
												id="seqAgencyId_l2">
											 <g:if test="${create}">
												<input type="radio" name="typeSelectorRadio" id="agencyId_radio" />
											</g:if> 
											<g:message code="AgencyJob.seqAgencyId.label" default="Agency/Agent :" />
											</label>
											
											<div class="fms_form_input fms_has_feedback">
												<input type="hidden" name="seqAgencyId" id="seqAgencyId" maxlength="50" value="${job?.seqAgencyId}" />
												<g:textField disabled="${!create?"true":"false"}" Class="form-control" readonly="readonly" name="agencyId" id="agencyId" maxlength="50" value="${agencyId}" />
											<g:if test="${create}">
												<fmsui:cdoLookup 
												lookupElementId="agencyId"
                                                lookupElementName="agencyId" 
                                                lookupElementValue="${agencyId}"
                                                lookupCDOClassName="com.perotsystems.diamond.dao.cdo.Agency"
                                                lookupCDOClassAttribute="agencyId"
                                                htmlElementsToUpdate="seqAgencyId"
											    htmlElementsToUpdateCDOProperty="seqAgencyId"/>
											</g:if>
												<div class="fms_form_error" id="seqAgencyId_error"></div>
											</div>

											<label class="control-label fms_required" for="groupId" id="groupId_v1"> 
												<g:if test="${create}">
													<input type="radio" name="typeSelectorRadio" id="groupId_radio" />
												</g:if> 
												<g:message code="AgencyJobRequest.groupId.label" default="Group :" />
											</label>
											<div class="fms_form_input fms_has_feedback">
									
											<g:textField Class="form-control" name="groupId" id="groupId"
												readonly="readonly" maxlength="50" value="${job?.groupId}"
												disabled="${!create?"true":"false"}" />
											<input type="hidden" name="seqGroupId" id="seqGroupId"  maxlength="50" value="${job?.groupId}" />
												<g:if test="${create}">
												<fmsui:cdoLookup 
												lookupElementId="groupId"
                                                lookupElementName="groupId" 
                                                lookupElementValue="${job?.groupId}"
                                                lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
                                                lookupCDOClassAttribute="groupId"
                                                htmlElementsToAddToQuery="seqGroupId"
                                                htmlElementsToAddToQueryCDOProperty="seqGroupId"/>
											</g:if>
											<div class="fms_form_error" id="groupId_error"></div>
										</div>

											<label class="control-label" for="batch_v1" id="batch">
												<g:message code="AgencyJobRequest.statementMessage.label"
													default="Statement Message :" />
											</label>
											<div class="fms_form_input">
												<g:textArea class="form-control" name="statementMessage"
													maxlength="50" value="${job?.statementMessage}"
													disabled="${!create?"true":"false"}" />
												<div class="fms_form_error" id="batch_error"></div>
											</div>
									</div>

									<div class="fms_form_column fms_long_labels">

											<label class="control-label" for="jobType_v1" id="jobType">
												<g:message code="AgencyJob.jobType.label"
													default="Job Type :" />
											</label>
											<div class="fms_form_input">
												<select class="form-control" name="jobType" id="jobType"
													${create? '' :'disabled=true' }>
													<option value="C"
														${"C".equals(job.jobType)? 'selected' :'' }>C- Commissions</option>
													<option value="I"
														${"I".equals(job.jobType)? 'selected' :'' }>I- Incentives</option>
												</select>
												<div class="fms_form_error" id="CompanyCode_v1_error"></div>
											</div>

											<label class="control-label fms_required" id="CommMonth_label"
												for="CommMonth">  <g:message
													code="AgencyJobRequest.CommMonth.label"
													default="Comm/Incen. Month :" />
											</label>
											<div class="fms_form_input">
											
											<fmsui:jqDatePickerNoDayUIUX 
												datePickerOptions="changeMonth:true, changeYear:true,showButtonPanel:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/yyyy',date: job?.CommMonth)}"
		                                  		dateElementId="CommMonth" 
		                                  		disabled="${!create?"true":"false"}"
		                                  		dateElementName="CommMonth" 
		                                        ariaAttributes="aria-labelledby='CommMonth_label' aria-describedby='CommMonth_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${create?"true":"false"}"/>
												<div class="fms_form_error" id="CommMonth_v1_error"></div>
											</div>

											<label class="control-label" id="glPostMonth_v1"
											for="glPostMonth"> <g:message
												code="AgencyJobRequest.glPostMonth.label"
												default="G/L Post Month :" />
											</label>
											<div class="fms_form_input">
											<fmsui:jqDatePickerNoDayUIUX 
												datePickerOptions="changeMonth:true, changeYear:true, showButtonPanel:true, yearRange:'-100:+100', numberOfMonths: 1"
		                                  		dateElementValue="${formatDate(format:'MM/yyyy',date: job?.glPostMonth)}"
		                                  		dateElementId="glPostMonth" 
		                                  		disabled="${!create?"true":"false"}"
		                                  		dateElementName="glPostMonth" 
		                                        ariaAttributes="aria-labelledby='glPostMonth_label' aria-describedby='glPostMonth_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${create?"true":"false"}"/> 
											
											<div class="fms_form_error" id="glPostMonth_error"></div>
										</div>

											<label class="control-label fms_required" for="planCode"
												id="planCode_v1"> <g:message
													code="AgencyJobRequest.planCode.label" default="Plan :" />
											</label>
											<div class="fms_form_input fms_has_feedback">	
											<input type="hidden" id="dummyabc" name="dummyabc" value="" />										
											<g:textField class="form-control" name="planCode"
												maxlength="50" value="${job?.planCode}"
												disabled="${!create?"true":"false"}" />
											<g:if test="${create}">
												<button type="button" id="Btn_planCode"
													class="btn fms_btn_icon btn-sm fms_form_control_feedback"
													title="Click to do full search."
													onclick="lookupplanId('groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', 'planCode','dummyabc')">
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
											</g:if>
												<div class="fms_form_error" id="planCode_error"></div>
											</div>
											
											<label class="control-label" for="runOption_v1" id="runOption">
												<g:message code="AgencyJobRequest.runOption.label"
													default="Run Option :" />
											</label>
											<div class="fms_form_input">
												<select class="form-control" name="runOption" id="runOption"
													${create? '' :'disabled=true' }>
													<option value="I">Immediate</option>
													<option value="D">Deferred</option>
												</select>
												<div class="fms_form_error" id="runOption_error"></div>
											</div>
									</div>
								</div>
						</div>

						<div class="fms_form_button">
							<g:if test="${create}">
								<g:actionSubmit class="btn btn-primary" action="createJob"
									value="${message(code: 'default.button.create.label', default: 'Create')}" />
							</g:if>
							<g:if test="${create}">
								<input type="Reset" class="btn btn-default" value="Reset"
									onClick="resetFieldAppearance();document.forms['jobsDetail'].reset();" />
							</g:if>
							<g:if test="${create}">
							<input type="button" class="btn btn-default" value="Cancel"
								onClick="closeForm()" />
							</g:if>
							<g:else>
								<input type="button" class="btn btn-primary" value="Close"
								onClick="closeForm()" />
							</g:else>
								
						</div>
					</div>
				</div>
				</fieldset>
			</div>
		</g:form>
	</div>
</body>
<!-- START - Search Group ID Modal -->
<div class="modal fade" id="SearchAlertModalInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->	

<!-- START - Search Valid Group ID Modal -->
<div class="modal fade" id="SearchAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter a valid Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->		
</html>
