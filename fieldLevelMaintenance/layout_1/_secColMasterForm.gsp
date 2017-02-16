<%@ page import=" com.perotsystems.diamond.dao.cdo.SecColMaster"%>
<%@ page import=" com.dell.diamond.domain.command.SecColMasterCommand"%>

<g:set var="appContext" bean="grailsApplication"/>
<script>
	function booleanCheckBoxValue(chkObj) {
		if (chkObj.value="on") {
			chkObj.value= 'Y'
		} else {
			chkObj.value= 'N'
		}
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
		          var sfldlId = "${params.sfldlId}";
			      $("#BtnDeleteRowYes").click(function(e){	  		         
			               var appName = "${appContext.metadata['app.name']}";
			               var myFm = document.getElementById("editForm") ; 			
			               myFm.action = "/"+appName+"/fieldLevelMaintenance/delete?sfldlId="+sfldlId;     	
			               myFm.submit();
			           
			  		});
			});
		
	</script>
		
<g:if test="${!params.editType }">
	<input type="hidden" name="editType" value="MASTER">
</g:if>

<div id="fms_content_body">
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
			
	<div class="right-corner" align="right">SFLDL</div>	
		<div class="fms_required_legend fms_required">= required</div>
	    <div id="AddNewDataSection" class="fms_form_border" style="display: block;">
	        <div class="fms_form_body fms_widget_border fms_widget_bgnd-color"> 
			<!-- START - WIDGET: General Information -->
			<div class="fms_widget">
				<fieldset class="no_border">
					<legend><h3>General Information</h3></legend>
					<div class="fms_form_layout_2column">
						<div class="fms_form_column fms_extra_long_labels">
							<label class="control-label fms_required" id="sfldlId_label" for="sfldlId">
							 <g:message code="secColMaster.sfldlId.label" default="Field Level Security Id:" />
							</label>
							<div class="fms_form_input">
								<g:if test="${!editType.equals("create") }">
									<p aria-labelledby="groupId_label" class="form-control-static">${secColMasterInstance?.sfldlId}</p>
								</g:if>
								<g:else>
									<g:textField name="sfldlId" maxlength="15" readonly="readonly" class="form-control" value="${secColMasterInstance?.sfldlId}" />
								</g:else>
								<div class="fms_form_error" id="sfldlId_error"></div>
							</div>
		
							<label class="control-label fms_required" id="description_label" for="description">
							 <g:message code="secColMaster.description.label" default="Description:" />
							</label>
							<div class="fms_form_input required">
								<g:textField name="description" maxlength="60" class="form-control"
								    value="${secColMasterInstance?.description}"
									title="The Description for the FLS id" />
								<div class="fms_form_error" id="description_error"></div>
							</div>
						</div>
			    	</div>
				</fieldset>
			</div>
			<!-- END - WIDGET: General Information -->
			<div class="fms_form_button">
				<g:if test="${!editType.equals("create") }">
					<g:actionSubmit class="btn btn-primary" action="update" id="saveButton" value="Save" />
					<button id="BtnAddressDelete2" type="button" class="btn BtnDeleteRow btn-default" title="Click to delete record." data-target="#DeleteAlertModal">Delete</button>
				</g:if>			
			    <g:else>
					<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</g:else>						
				<input type="reset" class="btn btn-default" value="Reset" />
				<input class="btn btn-default" onclick="closeForm()" type="button" value="Cancel">
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