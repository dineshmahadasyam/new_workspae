<%@ page import="com.dell.diamond.fms.sfldl.FieldLevelSecurityTableEnum"%>
<%@ page import="com.dell.diamond.fms.sfldl.enums.FieldLevelSecurityAccessEnum"%>

<g:set var="appContext" bean="grailsApplication" />

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

	});//]]>
</script>

<script>
function deleteSubmitted(sfldlId, tableName, columnName) {
	var checkConfirm = confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');
	if(checkConfirm) {
		document.getElementById ("sfldlIdToDelete").value = sfldlId
		document.getElementById ("tableNameToDelete").value = tableName
		document.getElementById ("columnNameToDelete").value = columnName
		//alert (document.getElementById ("sfldlIdToDelete").value + " "+document.getElementById ("tableNameToDelete").value +" "+ document.getElementById ("columnNameToDelete").value)
	} else {
		return false;
	}
}

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
		//alert  ("updateObj = " +updateObj)
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
							//alert (data)
							//$("#"+updateObj).append(data)
							//alert(document.getElementById(updateObj))
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
<table>
	<tr>
		<td>
			<h1 style="color: #48802C; padding:0px; margin:0px; border-spacing:0px;">Edit Field Level Security</h1>
			<div class="right-corner" align="center">SFLDL</div>	
		</td>
	</tr>
</table>

<table>
	<tr>
		<td>
			<div id="addSecColDetailButtonDiv">
				<g:checkURIAuthorization
					uri="/fieldLevelMaintenance/addSecColDetail">
					<input type="button" name="addSecColDetailBtn" class="load"
						value="Add Detail" onClick="addSecColDetail('${sfldlId}')">
				</g:checkURIAuthorization>
			</div>
		</td>
		<td>
			<div id="releaseSelect" style="display: none">
				<input type="button" name="enableMemberSelection"
					value="Enable Selection" onClick="releaseMemberSelection()">
			</div>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td>
			Field Level Security Detail records for Id: ${sfldlId}
		</td>
	</tr>
</table>

<div id="dummy" style="display: none">&nbsp;</div>
<g:if test="${!params.editType }">
<input type="hidden" editType="DETAIL">
</g:if>			
<input type="hidden" name="sfldlIdToDelete" id="sfldlIdToDelete" value="">
<input type="hidden" name="tableNameToDelete" id="tableNameToDelete" value="">
<input type="hidden" name="columnNameToDelete" id="columnNameToDelete" value="">
<div id="">
	<table border="1" id="report">
		<tr class="head">
			<th>Select</th>
			<th>Functional Area</th>
			<th>Table Name</th>
			<th>Column Name</th>
			<th>Security</th>
		</tr>
		
				<div id="addSecColDetailPlaceHolder" style="display: none"></div>
		
		<g:each in="${ secColDetailList}" status="i" var="secColDetail" >
			<input type="hidden" name="secColDetail.${i}.sfldlId" value="${ secColDetail.sfldlId}">
			<g:if test="${ i==0 }"></g:if>
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td class="clickme"><input type="radio" name="columnName"
					value="${secColDetail?.columnName}"></td>
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
			</tr>
			<tr class="hideme" id="rowToClone2">
				<td colspan="5">
					<div class="divContent" >
						<table class="report1" style="table-layout: fixed;">
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.functionalArea', 'error')} ">
										<label for="functionalArea"> <g:message
												code="secColDetail.functionalArea.label"
												default="Functional Area:" /> <span
											class="required-indicator">*</span>
										</label>
									</div>
								</td>
								<td class="tdFormElement" style="white-space: nowrap"
									colspan="2">
										<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.SystemCodes" disable= "disabled" 
											cdoAttributeWhere="systemCodeType" cdoAttributeWhereValue="FLS_FUNC_AREA"
											cdoAttributeSelect="systemCode"  cdoAttributeSelectDesc="systemCode"
											htmlElelmentId="secColDetail.${i}.functionalArea"
											languageId="0"
											blankValue="Functional Area"
											defaultValue="${secColDetail?.functionalArea}" width="200px"
											title="The functional area"/>
										<input type="hidden" name="secColDetail.${i}.functionalArea" value="${secColDetail?.functionalArea}">
										</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.tableName', 'error')} ">
										<label for="tableName"> <g:message
												code="secColDetail.tableName.label" default="Table Name :" />
										<span class="required-indicator">*</span>

										</label>
									</div>
								</td>
								<td class="tdFormElement" style="white-space: nowrap"
									colspan="2">
									<%String selectedValue = com.perotsystems.diamond.tools.build.cdo.Util.dbNameToJavaName (secColDetail?.tableName, true)+ com.dell.diamond.service.auth.SecurityService.SEC_COL_CLASS_NAME_SUFFIX %>
									<g:if test="${!FieldLevelSecurityTableEnum.values()?.contains(selectedValue)  }">
										<select name="secColDetail.${i}.tableName" style="width: 200px" disabled= "disabled" 
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
								</td>								
								<td class="tdnoWrap" style="white-space: nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.columnName', 'error')} ">
										<label for="columnNameName"> <g:message
												code="secColDetail.columnName.label" default="Column Name :" />
												<span class="required-indicator">*</span>
										</label>
									</div>
								</td>
								<td class="tdFormElement" style="white-space: nowrap"
									colspan="2">
									<div id="columnNameDivObj.${i }">&nbsp;
									<g:secColDetailColumn style="width: 200px" disabled= "disabled" clazzName="${selectedValue }" selectedValue="${secColDetail?.columnName }" idName="secColDetail.${i}.columnName"
									title="The column that will have the restriction"/>
									<input type="hidden" name="secColDetail.${i}.columnName" value="${secColDetail?.columnName }">
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div
										class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.securityInd', 'error')} ">
										<label for="securityInd"> <g:message
												code="subscriberMember.securityInd.label"
												default="Security Indicator :" />

										</label>
									</div>
								</td>
								<td class="tdFormElement" style="white-space: nowrap"
									colspan="2">
									<g:select style="width: 200px"
										name="secColDetail.${i}.securityInd"
										from="${FieldLevelSecurityAccessEnum.values() }"
										optionKey="accessType" optionValue="description" value="${secColDetail?.securityInd}" noSelection="['':'-- Select a Security Indicator --']"
										title="Enter the security restriction"/></td>
							</tr>
							<tr>
								<td>								
									<g:actionSubmit class="delete" action="deleteSecColDetail"  class="load"
									value="${message(code: 'default.button.delete.label', default: 'Delete')}" 
									formnovalidate="" onClick="return deleteSubmitted('${secColDetail.sfldlId }', '${secColDetail.tableName }', '${secColDetail.columnName }')"/>
								</td>
							</tr>
						</table>						
					</div>
				</td>
			</tr>
		</g:each>
	</table>
</div>