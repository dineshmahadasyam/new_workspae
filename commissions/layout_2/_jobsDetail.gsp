<%@ page import="com.perotsystems.diamond.bom.AgencyJobRequest"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_2">
	<g:set var="entityName" value="${message(code: 'AgencyJobRequest.label', default: 'AgencyJobRequest')}" />	
	<g:set var="appContext" bean="grailsApplication"/>
	
	<script>
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/commissions/searchJobs")
	}
	var grpInnerWindow
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if (grpInnerWindow) {
			grpInnerWindow.close()
		}
	}

	function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds,
			assocFieldCdoName, updateFields, updateFieldsCdoName) {
		var htmlElementValue
		var assocHTMLElementsValue = ""
		htmlElementValue = document.getElementById(idName).value
		//alert (assocFieldIds)
		if (assocFieldIds) {
			if (assocFieldIds.indexOf('|') == -1) {
				if (document.getElementById(assocFieldIds)
						&& document.getElementById(assocFieldIds).value != "undefined") {
					assocHTMLElementsValue = document
							.getElementById(assocFieldIds).value
				}
			} else {
				var nameArray = assocFieldIds.split("|")
				for ( var i = 0; i < nameArray.length; i++) {
					if (document.getElementById(nameArray[i])
							&& document.getElementById(nameArray[i]).value != "undefined") {
						//		alert (document.getElementById(nameArray[i]).value)
						assocHTMLElementsValue += document
								.getElementById(nameArray[i]).value
								+ "|"
					}
				}
			}
		}
		//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
		var appName = "${appContext.metadata['app.name']}";
		var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName="
				+ idName
				+ "&htmlElementValue="
				+ htmlElementValue
				+ "&cdoClassName="
				+ cdoClassName
				+ "&cdoClassAttributeName="
				+ cdoClassAttributeName
				+ (assocFieldIds ? "&assocFields=" + assocFieldIds : "")
				+ (assocFieldCdoName ? "&assocFieldCdoName="
						+ assocFieldCdoName : "")
				+ (assocHTMLElementsValue ? "&assocFieldValue="
						+ assocHTMLElementsValue : "")
				+ (updateFieldsCdoName ? "&updateFieldsCdoName="
						+ updateFieldsCdoName : "")
				+ (updateFields ? "&updateFields=" + updateFields : "")
				+ "&offset=0"
		if (!innerWindowClosed) {
			grpInnerWindow.setUrl(urlValue)
		} else {
			innerWindowClosed = false;
			grpInnerWindow = $.window({
				showModal : true,
				title : "Lookup",
				bookmarkable : false,
				minimizable : false,
				maximizable : false,
				width : 900,
				height : 350,
				scrollable : false,
				url : urlValue,
				onClose : function(wnd) { // a callback function while user click close button
					innerWindowClosed = true;
				}
			});
		}
	}
</script>
	
	<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
	
<script type="text/javascript">
	$(function(){
		if(${create}){
		    $("#groupId_radio, #batchId_radio, #agencyId_radio").change(function(){
		        $("#batchId, #seqAgencyId, #agencyId, #seqGroupId, #groupId, #planCode").val("").attr("readonly",true);
		        $("#batchLookup, #agentLookup, #groupLookup, #planLookup").attr("onClick","");
		        if($("#batchId_radio").is(":checked")){
		            $("#batchId").removeAttr("readonly");
		            $("#batchId").focus();
		            document.getElementById("groupId").style.backgroundColor = "#CCC";
		            document.getElementById("planCode").style.backgroundColor = "#CCC";
		            document.getElementById("agencyId").style.backgroundColor = "#CCC";
		            document.getElementById("batchId").style.backgroundColor = "#FFFFFF";
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
		            document.getElementById("batchId").style.backgroundColor = "#CCC";
		            document.getElementById("agencyId").style.backgroundColor = "#CCC";   
		            document.getElementById("groupId").style.backgroundColor = "#FFFFFF";
		            document.getElementById("planCode").style.backgroundColor = "#FFFFFF";
		            $("#batchLookup").attr("onClick","");
		            $("#agentLookup").attr("onClick","");
		            $("#groupLookup").attr("onClick","lookup('groupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId',null, null, 'seqGroupId', 'seqGroupId' )");
		            $("#planLookup").attr("onClick","lookup('planCode', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','planRiderCode', 'seqGroupId','seqGroupId')");		            		            
		        }
		        else if($("#agencyId_radio").is(":checked")){
		            $("#agencyId").removeAttr("readonly");
		            $("#seqAgencyId").removeAttr("readonly");
		            $("#agencyId").focus();   
		            document.getElementById("batchId").style.backgroundColor = "#CCC";
		            document.getElementById("groupId").style.backgroundColor = "#CCC";
		            document.getElementById("planCode").style.backgroundColor = "#CCC";
		            document.getElementById("agencyId").style.backgroundColor = "#FFFFFF";		        
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
    document.getElementById("agencyId").style.backgroundColor = "#FFFFFF";	
    document.getElementById("groupId").style.backgroundColor = "#FFFFFF";
    document.getElementById("planCode").style.backgroundColor = "#FFFFFF";
    document.getElementById("batchId").style.backgroundColor = "#FFFFFF";
}
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
			<a style="color: #48802C">Commission-Incentive Job Detail</a>
		</h1>		
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
		
		<g:hasErrors bean="${job}">
			<ul class="errors" role="alert">
				<g:eachError bean="${job}" var="error">
					<li
						<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
							error="${error}" /></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
	</div>
	
	<g:form>	
	<table>
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'jobId', 'error')} required" style="display: inline">
					<label for="jobId"> 
						<g:message code="AgencyJobRequest.jobId.label" default="Job ID :" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField readOnly="true" style="background-color:#CCC" name="jobId" maxlength="50" required="Job ID is Required"
						autofocus="autofocus" value="${job?.jobId}" />
				</div>
			</td>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'jobType', 'error')} required" style="display: inline">
					<label for="jobType">
						<g:message code="AgencyJob.jobType.label" default="Job Type :" />						
					</label>
					<select name="jobType" id="jobType"  style="width: 150px;"   ${create? '' :'disabled=true' }>
						<option value="C" ${"C".equals(job.jobType)? 'selected' :'' }>Commissions</option>
						<option value="I" ${"I".equals(job.jobType)? 'selected' :'' }>Incentives</option>
					</select>											
				</div>
			</td>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'CommMonth', 'error')} required" style="display: inline">
					<label for="CommMonth"> 
						<g:message code="AgencyJobRequest.CommMonth.label" default="Comm/Incen. Month :" />
						<span class="required-indicator">*</span>
					</label>
					<g:datePicker  disabled="${!create?"true":"false"}" name="CommMonth" precision="month" default="none" value="${job?.CommMonth}" noSelection="['':'']"  disabled="${!create?"true":"false"}"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'batchId', 'error')} required" style="display: inline">					
					<label for="batchId">
						<g:if test="${create}">
							<input type="radio" name="typeSelectorRadio" id="batchId_radio" />
						</g:if>
						<g:message code="AgencyJobRequest.batchId.label" default="Batch :" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField  disabled="${!create?"true":"false"}" readonly="readonly" name="batchId" id="batchId" maxlength="50" value="${job?.batchId}" />
					<g:if test="${create}">
						<img width="25" height="25" id="batchLookup" name="batchLookup"
							style="float: none; vertical-align: bottom"
							class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
							onclick="">
					</g:if>
				</div>
			</td>
			
			<td></td>
			
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'glPostMonth', 'error')} required" style="display: inline">
					<label for="glPostMonth">
						<g:message code="AgencyJobRequest.glPostMonth.label" default="G/L Post Month :" />
					</label>
					<g:datePicker disabled="${!create?"true":"false"}" name="glPostMonth" precision="month" default="none" value="${job?.glPostMonth}" noSelection="['':'']"/>
				</div>
			</td>			
		</tr>	
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'seqAgencyId', 'error')} required" style="display: inline">					
					<label for="seqAgencyId">
						<g:if test="${create}">
							<input type="radio" name="typeSelectorRadio" id="agencyId_radio" />
						</g:if>
						<g:message code="AgencyJob.seqAgencyId.label" default="Agency/Agent :" />
						<span class="required-indicator">*</span>
					</label>					
					<g:textField disabled="${!create?"true":"false"}" readonly="readonly" name="agencyId" id="agencyId" maxlength="50" value="${agencyId}" />
					<input type="hidden" name="seqAgencyId" id="seqAgencyId" maxlength="50" value="${job?.seqAgencyId}" />
					<g:if test="${create}">
						<img width="25" height="25" id="agentLookup" name="agentLookup"
							style="float: none; vertical-align: bottom"
							class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
							onclick="">
					</g:if>
				</div>
			</td>
			
			<td></td>
			
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'runOption', 'error')} required" style="display: inline">
					<label for="runOption">
						<g:message code="AgencyJobRequest.runOption.label" default="Run Option :" />
					</label>
					<select name="runOption" id="runOption" style="width: 150px;"  ${create? '' :'disabled=true' }>
						<option value="I">Immediate</option>
						<option value="D">Deferred</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'groupId', 'error')} required" style="display: inline">					
					<label for="groupId">
						<g:if test="${create}">
							<input type="radio" name="typeSelectorRadio" id="groupId_radio" />
						</g:if>
						<g:message code="AgencyJobRequest.groupId.label" default="Group :" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="groupId" id="groupId" readonly="readonly" maxlength="50" value="${job?.groupId}" disabled="${!create?"true":"false"}"/>
					<input type="hidden" name="seqGroupId" id="seqGroupId" value="" />
					<g:if test="${create}">
						<img width="25" height="25" style="float: none; vertical-align: bottom" id="groupLookup" name="groupLookup"
								class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
								onclick="">
					</g:if>
				</div>
			</td>		
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'planCode', 'error')} required" style="display: inline">
					<label for="planCode">
						<g:message code="AgencyJobRequest.planCode.label" default="Plan :" />
					</label>
					<g:textField name="planCode" maxlength="50" value="${job?.planCode}" disabled="${!create?"true":"false"}"/>
					<g:if test="${create}">
						<img width="25" height="25" id="planLookup" name="planLookup"
							style="float: none; vertical-align: bottom"
							class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
							onclick="">
					</g:if>
				</div>
			</td>			
			<td></td>
		</tr>	
		<BR><BR>
		<tr>
			<td>
				<div class="fieldcontain ${hasErrors(bean: job, field: 'statementMessage', 'error')} required" style="display: inline">
					<label for="batch">
						<g:message code="AgencyJobRequest.statementMessage.label" default="Statement Message :" />
					</label>
					<g:textArea name="statementMessage" maxlength="50" value="${job?.statementMessage}" disabled="${!create?"true":"false"}"/>
				</div>
			</td>	
		</tr>		
	</table>

		<fieldset class="buttons">
				<g:if test="${create}">
					<g:actionSubmit class="create" action="createJob" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</g:if>
				<div style="align:right;display:inline" >
				<g:if test="${create}">
					<input type="Reset" class="reset" value="Reset" onClick="resetFieldAppearance();document.forms['jobsDetail'].reset();"/>
				</g:if>
					<input type="button" class="close" value="Close" onClick="closeForm()"/>
				</div>			
		</fieldset>

	</g:form>
	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>
</body>

</html>