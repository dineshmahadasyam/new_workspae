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
			$(document).ready(function(){

				jQuery.validator.addMethod("desc", function(value, element) {
					value = value.replace(/\s+/g, "");
					return this.optional(element) || value.length > 4
				}, "description should be of size between 5 to 1,500.");

				jQuery.validator.setDefaults({
					ignore: ":hidden",
					debug: true			 
				});
				
			$(function() {		
					$("#editForm").validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
			                      form.submit(); 
			                  return false; // prevent normal form posting
				        },
				      //jQuery validate selects the first invalid element or the last focused invalid element
				        //The code below will set focus to first element that fails
				        invalidHandler: function(form, validator) {
				            var errors = validator.numberOfInvalids();
				            if (errors) {      
					            //Hide any previous message from the server when the client validation is occuring
				            	$(".message").hide();              
				                validator.errorList[0].element.focus();
				            }
				        },
				        
						errorLabelContainer: "#errorDisplay", 
						 wrapper: "li",		
						rules : {
								 'description' : {
									required : true,
									desc : true
								}
						},
						messages : {
							'description' : {
								required : "Description is a mandatory field.",
									desc : "description should be of size between 5 to 1,500."	
							}
						} 
						 
					})
				});
			
				}); 


			
	 	</script>
<br>

<!-- START - FMS Content Body -->
	<div id="fms_content_body">
		<g:form action="save" id="editForm" name="editForm">
			<div class="fms_required_legend fms_required">= required</div>           
  			<div id="AddNewDataSection" class="fms_form_border" style="display: block;">
       			<div class="fms_form_body">
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
					
					<g:hasErrors bean="${systemParameterInstance}">
						<ul class="errors" role="alert">
							<g:eachError bean="${systemParameterInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
							</g:eachError>
						</ul>
					</g:hasErrors>
					<div class="fms_widget">
						<fieldset class="no_border">
							<g:if test="${editType.equals("edit")}">
	          					<legend><h3><g:message code="default.edit.label" args="[entityName]" /></h3></legend>
	          				</g:if>
			        		<g:else>
								<legend><h3><g:message code="default.create.label" args="[entityName]" /></h3></legend>
							</g:else>
							<div class="fms_form_layout_1column">                  
								<div class="fms_form_column">
									<label class="control-label fms_required" for="parameterId" id="parameterId_label">
										<g:message code="systemParameter.parameterId.label" default="Parameter Id :" />
									</label>
									<div class="fms_form_input">
										<g:textField name="parameterId" 
										 maxlength="12" 
										 required="" 
										 readonly="true"
										 value="${systemParameterInstance?.parameterId}"
										 class="form-control"
										 aria-labelledby="parameterId_label"  
										 aria-describedby="parameterId_error" 
										 aria-required="false" />
										 <div class="fms_form_error" id="parameterId_error"></div>
			    				    </div>
									<label class="control-label" for="parameter1" id="parameter1_label">
										<g:message code="systemParameter.parameter1.label" default="Parameter1 :" />
									</label>
									<div class="fms_form_input">
										<g:textArea  name="parameter1" 
										 cols="240" 
										 rows="2" 
										 maxlength="700" 
										 value="${systemParameterInstance?.parameter1}"
										 class="form-control"
										 aria-labelledby="parameter1_label"  
										 aria-describedby="parameter1_error" 
										 aria-required="false" />
										 <div class="fms_form_error" id="parameter1_error"></div>
			    				    </div>	
						    		<label class="control-label" for="parameter2" id="parameter2_label">
										<g:message code="systemParameter.parameter2.label" default="Parameter2 :" />
									</label>
									<div class="fms_form_input">
										<g:textArea  name="parameter2" 
										 cols="240" 
										 rows="2" 
										 maxlength="700" 
										 value="${systemParameterInstance?.parameter2}"
										 class="form-control"
										 aria-labelledby="parameter2_label"  
										 aria-describedby="parameter2_error" 
										 aria-required="false" />
										<div class="fms_form_error" id="parameter2_error"></div>
			    					</div>	
						    		<label class="control-label" for="parameter3" id="parameter3_label">
										<g:message code="systemParameter.parameter3.label" default="Parameter3 :" />
									</label>
									<div class="fms_form_input">
										<g:textArea  name="parameter3" 
										 cols="240" 
										 rows="2" 
										 maxlength="700" 
										 value="${systemParameterInstance?.parameter3}"
										 class="form-control"
										 aria-labelledby="parameter3_label"  
										 aria-describedby="parameter3_error" 
										 aria-required="false" />
										<div class="fms_form_error" id="parameter3_error"></div>
			    					</div>
						    		<label class="control-label fms_required" for="description" id="description_label">
										<g:message code="systemParameter.description.label" default="Description :" />
									</label>
									<div class="fms_form_input">
										<g:textArea 
											id="description"
											name="description" 
											 cols="240" 
											 rows="2" 
											 maxlength="1500" 
											 value="${systemParameterInstance?.description}"
											 class="form-control"
											 aria-labelledby="description_label"  
											 aria-describedby="description_error" 
											 aria-required="false" />
											 <div class="fms_form_error" id="description_error"></div>
				    				</div>	
						  		</div>
							</div>
						</fieldset>
					</div>
					<g:if test="${editType.equals("edit")}">
						<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
							<input type="Reset" class="btn btn-default" value="Reset" />
							<input type="button" class="btn btn-default" value="Close" onClick="closeForm()"/>
		    			</div> 
		    		</g:if>
		    		<g:else>
		 				<div class="fms_form_button">
						  <g:submitButton name="create" action="save" class="btn btn-primary create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					      <input type="Reset" class="btn btn-default" value="Reset" />
					      <input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
	    	      		</div>  
					</g:else>  
	    		</div>
	    	</div>
		</g:form>
	</div>  
<!-- END - FMS Content Body -->  