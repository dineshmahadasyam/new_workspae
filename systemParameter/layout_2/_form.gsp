

<div class="fieldcontain ${hasErrors(bean: systemParameterInstance, field: 'parameterId', 'error')} required">
	<label for="parameterId">
		<g:message code="systemParameter.parameterId.label" default="Parameter Id :" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="parameterId" maxlength="12" required="" readonly="true" style="background:#CCC;" value="${systemParameterInstance?.parameterId}"/>
</div>
<br>
<div class="fieldcontain ${hasErrors(bean: systemParameterInstance, field: 'parameter1', 'error')} ">
	<label for="parameter1">
		<g:message code="systemParameter.parameter1.label" default="Parameter1 :" />
		
	</label>
	<g:textArea  style="height:50px; width:800px" name="parameter1" cols="240" rows="2" maxlength="700" value="${systemParameterInstance?.parameter1}"/>
</div>
<br>
<div class="fieldcontain ${hasErrors(bean: systemParameterInstance, field: 'parameter2', 'error')} ">
	<label for="parameter2">
		<g:message code="systemParameter.parameter2.label" default="Parameter2 :" />
		
	</label>
	<g:textArea  style="height:50px; width:800px" name="parameter2" cols="240" rows="2" maxlength="700" value="${systemParameterInstance?.parameter2}"/>
</div>
<br>
<div class="fieldcontain ${hasErrors(bean: systemParameterInstance, field: 'parameter3', 'error')} ">
	<label for="parameter3">
		<g:message code="systemParameter.parameter3.label" default="Parameter3 :" />
		
	</label>
	<g:textArea  style="height:50px; width:800px" name="parameter3" cols="240" rows="2" maxlength="700" value="${systemParameterInstance?.parameter3}"/>
</div>
<br>
<div class="fieldcontain ${hasErrors(bean: systemParameterInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="systemParameter.description.label" default="Description :" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea  style="height:50px; width:800px" style="height:50px; width:800px" name="description" cols="240" rows="2" maxlength="1500" required="" value="${systemParameterInstance?.description}"/>
</div>
