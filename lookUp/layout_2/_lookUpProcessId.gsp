<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"
	type="text/css">

<style type='text/css' media='screen'>
.search {
	-moz-box-shadow: inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow: inset -1px 1px 7px 0px #ffffff;
	box-shadow: inset -1px 1px 7px 0px #ffffff;
	background-color: #ededed;
	-moz-border-radius: 15px;
	-webkit-border-radius: 15px;
	border-radius: 10px;
	border: 1px solid #999999;
	display: inline-block;
	color: #404040;
	font-family: arial;
	font-size: 16px;
	font-weight: normal;
	padding: 5px 24px;
	text-decoration: none;
	text-shadow: 1px 0px 13px #ffffff;
}

.search:hover {
	background-color: #dfdfdf;
}

.search:active {
	position: relative;
	top: 1px;
}
</style>

<script>
		var total = ${cdoCollectionSize};
		var htmlElementName= "${htmlElementIdName}";
		var cdoClassName = "${cdoClassName}";
		var cdoClassAttributeName = "${cdoClassAttributeName}";
		var updateFields = "${updateFields}" ;
		var updateFieldsCdoName = "${updateFieldsCdoName}";
		var assocFieldCdoName = "${assocFieldCdoName}";
		var assocFieldValue = "${assocFieldValue}";
		var assocFields = "${assocFields}";
					
		function fnClose() {
			var radios = document.forms["lookUpMainForm"].myLookUpValue			
			var lookUpId
			if (radios.length >1) {
				for (var i = 0, length = radios.length; i < length; i++) {
					if (radios[i].checked) {
						lookUpId = radios[i].value;
					}
				}
			} else {
				lookUpId = radios.value;
			}
			var lookUpId = document.getElementById(lookUpId).value;
			//alert(updateFieldsCdoName)
			top.document.getElementById(htmlElementName).value= lookUpId;
			if (updateFieldsCdoName) {
				if (updateFieldsCdoName.indexOf("|") != -1) {
					var cdoNameArray = updateFieldsCdoName.split("|")
					var updateFieldsArray = updateFields.split("|")					
					for (var i =0;i<cdoNameArray.length;i++) {			
						var fieldToUpdate = document.getElementById(cdoNameArray[i]).value
							top.document.getElementById(updateFieldsArray[i]).value = fieldToUpdate
					}
				} else {
					var fieldToUpdate = document.getElementById(updateFieldsCdoName).value
					//alert (updateFields && updateFields.indexOf("|") != -1)
					if (updateFields && updateFields.indexOf("|") == -1) {
						top.document.getElementById(updateFields).value = fieldToUpdate
					}
					
				}
			}
			top.document.getElementById(htmlElementName).focus();
			top.document.getElementById("closeIframes").click();			
		}
		
		function checkResult() {
			//alert ("entering checkResult")
			var sessionValid = ${session?.user?.getId() ? true : false}
			//if (sessionValid) {
				if (total == 1) {
					var radio = document.forms["lookUpMainForm"].myLookUpValue
					lookUpId  = radio.value;
					lookUpId = document.getElementById(lookUpId).value;
					top.document.getElementById(htmlElementName).value= lookUpId;
					if (updateFieldsCdoName) {
						if (updateFieldsCdoName.indexOf("|") != -1) {
							var cdoNameArray = updateFieldsCdoName.split("|")
							var updateFieldsArray = updateFields.split("|")					
							for (var i =0;i<cdoNameArray.length;i++) {			
								var fieldToUpdate = document.getElementById(cdoNameArray[i]).value
									top.document.getElementById(updateFieldsArray[i]).value = fieldToUpdate
							}
						} else {
							var fieldToUpdate = document.getElementById(updateFieldsCdoName).value
							//alert (updateFields && updateFields.indexOf("|") != -1)
							if (updateFields && updateFields.indexOf("|") == -1) {
								top.document.getElementById(updateFields).value = fieldToUpdate
							}
							
						}
					}
					//alert ("requesting focus")
					top.document.getElementById(htmlElementName).focus();
					top.document.getElementById("closeIframes").click();					
				}
		}
		
		function fnReloadLookup() {
			var srchProcessId = document.forms["searchLookUpForm"].idModifyingProcessId.value
			if (srchProcessId) {
				top.document.getElementById(htmlElementName).value= srchProcessId;				
				//top.document.getElementById("genericLookUpButton").click();
				parent.lookupProcessId(htmlElementName,cdoClassName,cdoClassAttributeName, assocFields , assocFieldCdoName, updateFields, updateFieldsCdoName);
			}
		}
	
	</script>
</head>
<body onLoad="checkResult();document.getElementById('idSrchBatchId').focus()" >
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:else>
		<br>
	</g:else>
	<form name="searchLookUpForm" onSubmit="fnReloadLookup();return false;">
		&nbsp;&nbsp;Process ID: &nbsp;&nbsp;<input type="text" id="idModifyingProcessId"
			name="modifyingProcessId" value="${htmlElementValue}"> &nbsp;&nbsp;<input
			class="search" type="button" name="Search" value="Search"
			onclick="fnReloadLookup()">
	</form>
	<br>
	<form name="lookUpMainForm">
		<div style="width: 100%; height: 144px; overflow-y: scroll;">
			<table border="1">
				<thead>
					<tr>
						<th>Select</th>
						<g:each in="${fields}" status="i" var="field">
						<%
							String[] fieldLabelTokens = org.apache.commons.lang.StringUtils.splitByCharacterTypeCamelCase(org.apache.commons.lang.StringUtils.capitalize(field.name));
							String fieldLabel = "";
							fieldLabelTokens.each() { labelTok -> fieldLabel += labelTok + " " };
							fieldLabel = fieldLabel.trim();
						%>
							<g:sortableColumn property="${ field.name}"
								titleKey="${field.name}.label" title="${fieldLabel}"
								params="[cdoClassName:params.cdoClassName, cdoClassAttributeName:params.cdoClassAttributeName, htmlElementIdName:params.htmlElementIdName, htmlElementValue:params.htmlElementValue, offset:params.offset, action:params.action, controller:params.controller, sort:params.sort, order:params.order]" />
						</g:each>
					</tr>
				</thead>
				<tbody>
					<g:each in="${cdoCollection}" status="j" var="cdoObject">
						<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
						<%String searchKeyMethodName = cdoClassAttributeName							
									searchKeyMethodName = "get"+new String(searchKeyMethodName.charAt(0)).toUpperCase().concat(searchKeyMethodName.substring(1, searchKeyMethodName.length()))	
									java.lang.reflect.Method searchKeyGetMeth = cdoObject.getClass().getMethod(searchKeyMethodName)
							 %>
							<td nowrap="nowrap"><input type="radio" name="myLookUpValue" value="${searchKeyGetMeth.invoke(cdoObject) }"/>&nbsp;&nbsp;${ searchKeyGetMeth.invoke(cdoObject) }
							<input type="hidden" id="${ searchKeyGetMeth.invoke(cdoObject) }" value="${ searchKeyGetMeth.invoke(cdoObject) }"/></td>
							
							<%  if (updateFieldsCdoName) {
								if (updateFieldsCdoName.indexOf("|") != -1) {
									java.util.ArrayList cdoFieldNamesList = updateFieldsCdoName.tokenize('|')
									
									cdoFieldNamesList.each { cdoAttributeName ->
										String searchKeyMethodName1 = cdoAttributeName							
										searchKeyMethodName1 = "get"+new String(searchKeyMethodName1.charAt(0)).toUpperCase().concat(searchKeyMethodName1.substring(1, searchKeyMethodName1.length()))	
										java.lang.reflect.Method searchKeyGetMeth1 = cdoObject.getClass().getMethod(searchKeyMethodName1)
									%>
									<input type="hidden" id="${ cdoAttributeName }" value="${ searchKeyGetMeth1.invoke(cdoObject) }"/>
								<%
									}
								} else {
								String searchKeyMethodName1 = updateFieldsCdoName
								searchKeyMethodName1 = "get"+new String(searchKeyMethodName1.charAt(0)).toUpperCase().concat(searchKeyMethodName1.substring(1, searchKeyMethodName1.length()))
								java.lang.reflect.Method searchKeyGetMeth1 = cdoObject.getClass().getMethod(searchKeyMethodName1)
							%>
							<input type="hidden" id="${ updateFieldsCdoName }" value="${ searchKeyGetMeth1.invoke(cdoObject) }"/>
						<%
								}
							}
								 %>														
							<g:each in="${fields}" status="q" var="cdoField">
								<%String getMethodName = cdoField.getName()							
									getMethodName = "get"+new String(getMethodName.charAt(0)).toUpperCase().concat(getMethodName.substring(1, getMethodName.length()))	
									java.lang.reflect.Method getMeth = cdoObject.getClass().getMethod(getMethodName)
							 %>
								<td>
								<g:if test="${java.util.GregorianCalendar.class.equals(cdoField.getType())}">								
									<g:formatDate  format="yyyy-MM-dd"  date="${getMeth.invoke(cdoObject) }" />
								</g:if>
								<g:else>
									${getMeth.invoke(cdoObject) }
								</g:else>
								</td>
							</g:each>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="pagination">
			<g:paginate total="${cdoCollectionSize}" params="[cdoClassName:params.cdoClassName,cdoClassAttributeName:params.cdoClassAttributeName,htmlElementIdName:params.htmlElementIdName, htmlElementValue:params.htmlElementValue]" />
		</div>
		<br>
		<div align="right">
			<input class="search" type="button" value="Select"
				onclick="fnClose()">
		</div>
		<br>
	</form>
</body>
</html>
