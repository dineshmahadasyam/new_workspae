<%@ page import="com.perotsystems.diamond.bom.AgencyBatchJob"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_2">
	<g:set var="entityName"
		value="${message(code: 'Batch.label', default: 'Batch')}" />
		
	<g:set var="appContext" bean="grailsApplication"/>
	
	<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/commissions/batchSearch"/>')			
		}
	</script>
	
	
	<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script>
	$(function($){
		
		   $("#batchId").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});
			
		})
	</script>

	<style>
		div.right-corner {
		    position: absolute;
		    top: 0px;
		    right: 0;
		    margin-right: 40px;
		    font:normal normal 21pt / 1 Tahoma;
		    color: #48802C;
		}
	</style>
</head>
<body>
	<div id="edit-planMaster" class="content scaffold-edit" role="main">
		<h1>
			<a style="color: #48802C">${editType} Batch</a>
		</h1>
		<div class="right-corner" align="center"></div>			
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
	</div>
	
	<g:form>	
	<input type="hidden" name="seqBatchId" value="${batch.seqBatchId}">
	<input type="hidden" name="editType" value="${editType}">
	<table>
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: batch, field: 'batchId', 'error')} required" style="display: inline">
					<label for="planCode"> 
						<g:message code="Batch.batchId.label" default="Batch Id:" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="batchId" maxlength="50" 
						autofocus="autofocus" value="${batch?.batchId}" />
				</div>
			</td>
			<td>
				<div class="fieldcontain ${hasErrors(bean: batch, field: 'scheduleType', 'error')} required" style="display: inline">
					<label for="billingScheduleType"> 
						<g:message code="Batch.scheduleType.label" default="Batch Schedule:" />						
					</label>
					<g:getDiamondDataWindowDetail columnName="billing_frequency"
						dwName="dw_grupb_de" languageId="0"
						htmlElelmentId="scheduleType"
						defaultValue="${batch?.scheduleType}"
						blankValue="Schedule Type" width="150px"/>					
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: batch, field: 'excludeAutoSchedule', 'error')} required" 
					style="display: inline">
					<label for="planCode"> 
						<g:message code="Batch.excludeAutoSchedule.label" default="Exclude Auto Schedule:" />						
					</label>				
						<select name="excludeAutoSchedule">
							<option value="N"
								${batch && 'N'.equals(batch?.excludeAutoSchedule) ? 'selected':'' }>No</option>
							<option value="Y"
								${batch && 'Y'.equals(batch?.excludeAutoSchedule) ? 'selected':'' }>Yes</option>
						</select>
				</div>
			</td>	
			<td>
				<div class="fieldcontain ${hasErrors(bean: batch, field: 'excludeAutoSchedule', 'error')} required" style="display: inline">
				<label for="planCode"> 
					<g:message code="Batch.excludeAutoSchedule.label" default="Batch Type:" />						
				</label>
				<select name="batchType" id="batchType" style="width:150px;">
					<option value="C"
						${"C".equals(batch?.batchType)? 'selected' :'' }>Commissions</option>
					<option value="I"
						${"I".equals(batch?.batchType)? 'selected' :'' }>Incentives</option>
				</select>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<g:if test="${editType.equals("Create")}">
					<input type="button" class="load"  value="Add Group(s)" onclick="alert('Please Create the Batch before adding a group')" >
				</g:if>
				<g:else>
					<g:link type="button" class="load" value="Add Group" action="addGroups" params="${[editType:editType, seqBatchId:batch?.seqBatchId]}">Add Group(s)</g:link>
				</g:else>
				
			</td>
		</tr>					
	</table>
	<g:if test="${groups.size() > 0}">
	<div id="list-planMaster" class="content scaffold-list" role="main"  style="width:100%; overflow-x: scroll;">
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Associated Groups - ${groups.size()}<br> <br>
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<thead>
											<tr>
												<th>Group Id</th>
												<th>Name</th>
												<th>Actions</th>																								
											</tr>
										</thead>
										<tbody>
											<g:each in="${groups}" status="i" var="result">
											<input type="hidden" value="${fieldValue(bean: result, field: "seqGroupId")}" name="seqGroupId.${i}">
												<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
													<td style="height: 20px; overflow: hidden;">
														${fieldValue(bean: result, field: "groupId")}
													</td>
													<td style="height: 20px; overflow: hidden;">														
															${fieldValue(bean: result, field: "groupName1")}
													</td>
													<td>
														<g:link class="load" action="deleteGroupFromBatch" params="${[seqGroupId:result?.seqGroupId, seqBatchId:batch.seqBatchId]}">Remove Group</g:link>
													</td>																															
												</tr>
											</g:each>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</g:if>
	<g:else><table><tr><td>No Associated groups found</td></tr></table></g:else>
	<g:if test="${editType.equals("Edit")}">
		<fieldset class="buttons">
			<div style="align:left;display:inline">
			<g:actionSubmit class="save" action="updateBatch" value="${message(code: 'default.button.update.label', default: 'Update')}" />
			</div>
			<div style="align:right;display:inline" >
			<input type="Reset" class="reset" value="Reset" />
			<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</div>
		</fieldset>
	</g:if>
	<g:elseif test="${editType.equals("Create")}">
		<fieldset class="buttons">
			<g:actionSubmit class="create" action="saveBatch" value="${message(code: 'default.button.create.label', default: 'Create')}" />
			<div style="align:right;display:inline" >
				<input type="Reset" class="reset" value="Reset" onClick="document.forms['plan'].reset()"/>
				<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</div>
		</fieldset>
	</g:elseif>
	</g:form>
</body>
</html>