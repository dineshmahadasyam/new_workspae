<%@ page import=" com.perotsystems.diamond.dao.cdo.SecColMaster"%>
<%@ page import=" com.dell.diamond.domain.command.SecColMasterCommand"%>
<script>
	function booleanCheckBoxValue(chkObj) {
		if (chkObj.value="on") {
			chkObj.value= 'Y'
		} else {
			chkObj.value= 'N'
		}
	}
</script>
	<style>
		div.right-corner {
		    position: absolute;
		    top: 9px;
		    right: 0;
		    margin-right: 40px;
		    font:normal normal 21pt / 1 Tahoma;
		    color: #48802C;
		}
	</style>
<g:if test="${!params.editType }">
<input type="hidden" name="editType" value="MASTER">
</g:if>

<g:if test="${updatable }">
</g:if>
<g:else>
	<table>
		<tr>
			<td>
				<h1 style="color: #48802C; padding:0px; margin:0px; border-spacing:0px;">Edit Field Level Security Master</h1>
				<div class="right-corner" align="center">SFLDL</div>	
			</td>
		</tr>
	</table>
</g:else>
<table class="topics">
	<tr>
		<td>
			<table class="topics">
				<tr>
					<td style="width: 30%">
						<div
							class="fieldcontain ${hasErrors(bean: secColMasterInstance, field: 'sfldlId', 'error')} required">
							<label for="sfldlId"> <g:message
									code="secColMaster.sfldlId.label"
									default="Field Level Security Id:"/>
									<span class="required-indicator">*</span>
							</label>
							<g:if test="${!editType.equals("create") }">
								${secColMasterInstance?.sfldlId}
							</g:if>
							<g:else>
								<g:textField name="sfldlId" maxlength="15" style="background-color:#CCC"
									value="${secColMasterInstance?.sfldlId}" />
							</g:else>
						</div>
					</td>
					<td style="width: 25%">
						<div
							class="fieldcontain ${hasErrors(bean: secColMasterInstance, field: 'description', 'error')} required">
							<label for="description"> <g:message
									code="secColMaster.description.label" 
									default="Description:" />
									<span class="required-indicator">*</span>
							</label>
							<g:textField name="description" maxlength="60" size="40" required=""
								value="${secColMasterInstance?.description}" 
								title="The Description for the FLS id"/>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
</table>