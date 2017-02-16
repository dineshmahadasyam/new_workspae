<%@ page import="com.perotsystems.diamond.bom.AgencyBatchJob"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<!-- Main menu select -->
	<meta name="navSelector" content="maint"/>
	<!-- Child menu select -->
	<meta name="navChildSelector" content="searchJobs"/>
	<g:set var="entityName"
		value="${message(code: 'Batch.label', default: 'Batch')}" />
		
	<g:set var="appContext" bean="grailsApplication"/>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
	
	<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/commissions/batchSearch"/>')			
		}
		
		$(function($){
		
		   $("#batchId").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});
			
		})
		
		function show() {
		document.getElementById('BtnInfoAlertId').click();
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
		});
	</script>	

</head>

<div id="fms_content">

		<!-- START - FMS Content Header -->
		<div id="fms_content_header">
			<div class="fms_content_header_note">
				<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / ${editType} Batch
        	</div>
			
			<div class="fms_content_title">
          		<h1>${editType} Batch</h1>
          		
        	</div> 
      	</div>
      	<!-- END - FMS Content Header -->
      	<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
		    	<li><g:link class="list" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
				<li><g:link class="active" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
				<li><a class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
      	<!-- START - FMS Content Body -->
      	<div id="fms_content_body">
      	<div id="AddNewDataSection" class="fms_form_border" style="display: block;">
			<div class="fms_widget_border fms_widget_bgnd-color">
				<div class="fms_widget"> 
	           	<p>           		
	           	<%-- Error messages start--%>
	           	<div id="edit-planMaster" class="content scaffold-edit" role="main">
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
			<g:hasErrors bean="${batch}">
				<ul class="errors" role="alert">
					<g:eachError bean="${batch}" var="error">
						<li
							<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
								error="${error}" /></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
				</p>
			</div>
		<%-- Error messages end--%>
		<g:form>	
		<input type="hidden" name="seqBatchId" value="${batch.seqBatchId}">
		<input type="hidden" name="editType" value="${editType}">
	
          <fieldset>
				<legend><h3>${editType} Batch</h3></legend>
					<div class="fms_form_layout_2column">                  
					<div class="fms_form_column fms_long_labels">
		                  	
                  	<label class="control-label" for="planCode" id="planCode_label">
                  		<g:message code="Batch.batchId.label" default="Batch Id:" /> 
                  	</label>
                	<div class="fms_form_input">
                        <g:textField 
                        name="batchId" 
                        maxlength="50" 
						autofocus="autofocus" 
						value="${batch?.batchId}" 
						Class="form-control"
						aria-labelledby="planCode_label" 
						aria-describedby="planCode_error" 
						aria-required="false"/>
                        <div class="fms_form_error" id="planCode_error"></div>
                	</div>
					
					<label class="control-label" for="billingScheduleType" id="billingScheduleType_label">
					<g:message code="Batch.scheduleType.label" default="Batch Schedule:" />		
					 </label>
                	<div class="fms_form_input">
                        <g:getDiamondDataWindowDetail 
                        columnName="billing_frequency"
						dwName="dw_grupb_de" languageId="0"
						htmlElelmentId="scheduleType"
						defaultValue="${batch?.scheduleType}"
						blankValue="Schedule Type" 
						cssClass="form-control"
						aria-labelledby="billingScheduleType_label" 
						aria-describedby="billingScheduleType_error" 
						aria-required="false"/>
                        <div class="fms_form_error" id="billingScheduleType_error"></div>
                	</div>
                 </div>
                    
	             <div class="fms_form_column fms_long_labels">	
	                     
					<label class="control-label" for="excludeAutoSchedule" id="excludeAutoSchedule_label">
					<g:message code="Batch.excludeAutoSchedule.label" default="Exclude Auto Schedule:" />	 
					</label>
                 	<div class="fms_form_input">
                       		<select name="excludeAutoSchedule" Class="form-control"
                       		aria-labelledby="excludeAutoSchedule_label" 
							aria-describedby="excludeAutoSchedule_error" 
							aria-required="false">
								<option value="N"
									${batch && 'N'.equals(batch?.excludeAutoSchedule) ? 'selected':'' }>No</option>
								<option value="Y"
									${batch && 'Y'.equals(batch?.excludeAutoSchedule) ? 'selected':'' }>Yes</option>
							</select>
                    	<div class="fms_form_error" id="excludeAutoSchedule_error"></div>
                 	</div>			
			
					<label class="control-label" for="excludeAutoSchedule" id="excludeAutoSchedule_label">
					<g:message code="Batch.excludeAutoSchedule.label" default="Batch Type:" />	
					</label>
                 	<div class="fms_form_input">
                      	<select name="batchType" id="batchType" Class="form-control"
                      	aria-labelledby="excludeAutoSchedule_label" 
							aria-describedby="excludeAutoSchedule_error" 
							aria-required="false">
							<option value="C"
								${"C".equals(batch?.batchType)? 'selected' :'' }>C- Commissions</option>
							<option value="I"
								${"I".equals(batch?.batchType)? 'selected' :'' }>I- Incentives</option>
						</select>
                   		<div class="fms_form_error" id="excludeAutoSchedule_error"></div>
      				</div>
				</div>
		</div>
	</fieldset>
		<br></br>
		
		<!-- ADD groups -->
		<g:if test="${editType.equals("Create")}">
			<input type="button" class="btn btn-primary"  value="Add Group(s)" onclick="show()" >
		</g:if>
		<g:else>
			<g:link type="button" class="btn btn-primary" value="Add Group" action="addGroups" params="${[editType:editType, seqBatchId:batch?.seqBatchId]}">Add Group(s)</g:link>
		</g:else>
		<!-- End Add Groups -->
		
		<br></br>
	<!-- END - Search Form -->
	
	<!-- Table for added groups -->
	<g:if test="${groups.size() > 0}">
	<div id="list-planMaster" class="content scaffold-list" role="main">
	<div id="SearchResults" class="fms_widget">
       			
	<div class="fms_widget">
	<!-- Column Selector starts here -->
	<div class="row fms-col_selector_row">
		<div id="SearchResultsFound" class="col-xs-6 fms-results-found">Associated Groups - ${groups.size()}</div>
	</div>
	<br></br>
	<!-- Column Selector ends here -->
	<div class="fms_table_wrapper">
         <table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
            	<thead>
              		<tr role="row" class="tablesorter-headerRow">
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" data-columnselector="disable" aria-disabled="true">Group Id</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" data-columnselector="disable" aria-disabled="true">Name</th>
						<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Actions</th>
																																
					</tr>
				</thead>
						
						<g:each in="${groups}" status="i" var="result">
							<input type="hidden" value="${fieldValue(bean: result, field: "seqGroupId")}" name="seqGroupId.${i}">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td> ${fieldValue(bean: result, field: "groupId")}</td>
								<td> ${fieldValue(bean: result, field: "groupName1")}</td>
								<td>
									<g:link action="deleteGroupFromBatch" class="btn fms_btn_icon btn-sm BtnDeleteRow"  title="Click to delete groups." params="${[seqGroupId:result?.seqGroupId, seqBatchId:batch.seqBatchId]}"><i class="fa fa-trash"></i></g:link>
								</td>	
							</tr>
						</g:each>
				</table>
<!-- END Table for added groups -->
		</div>
	</div>
</div>
</div>
</g:if>
<g:else><table><tr><td>No Associated groups found</td></tr></table></g:else>
<div class="fms_form_button">
			<g:if test="${editType.equals("Edit")}">
				<g:actionSubmit class="btn btn-primary" action="updateBatch" value="${message(code: 'default.button.save.label', default: 'Save')}" />
				<input type="Reset" class="btn btn-default" value="Reset" />
				<input type="button" class="btn btn-default" value="Close" onClick="closeForm()"/>
			</g:if>
			<g:elseif test="${editType.equals("Create")}">
				<g:actionSubmit class="btn btn-primary" action="saveBatch" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<input type="Reset" class="btn btn-default" value="Reset" onClick="document.forms['plan'].reset()"/>
				<input type="button" class="btn btn-default" value="Cancel" onClick="closeForm()"/>
			</g:elseif>
			<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset beneficiary form." data-target="#InfoAlert"></button>
		</div>    
	</g:form>
</div>
</div>
</div>
</div>
</div>
	<!-- Infomatory modal -->
		<div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
		  	<div class="modal-dialog">
		       	<div class="modal-content fms_modal_error-sm">
		           	<div class="modal-body">
		           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		           		<h5>Please Create the Batch before adding a group.</h5>
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
		          	</div>
		      	</div>
		  	</div>
	</div>
	<!-- END Infomatory modal -->
</html>