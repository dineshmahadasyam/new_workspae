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
			//alert(lookUpId)
			top.document.getElementById(htmlElementName).value= lookUpId;
			top.document.getElementById("closeIframes").click();
		}
		
		function checkResult() {
		}
		
		function fnReloadLookup() {
			var srchBatchId1 = document.forms["searchLookUpForm"].srchBatchId.value
			if (srchBatchId1) {
				top.document.getElementById(htmlElementName).value= srchBatchId1;				
				//top.document.getElementById("genericLookUpButton").click();
				parent.lookup(htmlElementName,cdoClassName,cdoClassAttributeName,srchBatchId1)
			}
		}
	
	</script>
	<style>
		p.error {
		    color:red;
		    margin:30px;
			font-size:80%;
		}
	</style>
</head>
<body onLoad="checkResult()">

	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${flash.message1}">
		<p class="error">${flash.message1}</p>
	</g:if>
	<g:else>
		<br>
	</g:else>
	<g:if test="${("MEMBER_ELIG_HISTORY".equals(request.getParameter("auditedTableName"))) && ("U".equals(request.getParameter("databaseAction")))}">
	<div style="width: 98%">
	<table>
	<tbody>
	<tr>
		<td>
			<span id="subscriberId-label" class="property-label">
			<g:message code="memberEligHistory.subscriberId.label" default="Subscriber Id: " />
			<g:fieldValue bean="${memberEligHistory}" field="subscriberId" /></span>
		</td>
		<td>
			<span id="personNumber-label" class="property-label">
			<g:message code="memberEligHistory.personNumber.label" default="Person Number: " />
			<g:fieldValue bean="${memberEligHistory}" field="personNumber" /></span>
		</td>
		<td>
			<span id="effectiveDate-label" class="property-label">
			<g:message code="memberEligHistory.effectiveDate.label" default="Effective Date: " />
			<g:formatDate format="dd-MMM-yy" date="${memberEligHistory.effectiveDate}"/></span>
		</td>
		<td>
			<span id="termDate-label" class="property-label">
			<g:message code="memberEligHistory.termDate.label" default="Term Date: " />
			<g:formatDate format="dd-MMM-yy" date="${memberEligHistory.termDate}"/></span>
		</td>				
	</tr>
	</tbody>
	</table>
	</div>
	</g:if>
	<br>
	<form name="lookUpMainForm" >
		<div style="width: 100%; height: 144px; overflow-y: scroll;">
			<table border="1">
				<thead>
					<tr>
						<g:each in="${fields}" status="i" var="field">
						<%
							String[] fieldLabelTokens = org.apache.commons.lang.StringUtils.splitByCharacterTypeCamelCase(org.apache.commons.lang.StringUtils.capitalize(field.name));
							String fieldLabel = "";
							fieldLabelTokens.each() { labelTok -> fieldLabel += labelTok + " " };
							fieldLabel = fieldLabel.trim();
						%>
							<g:sortableColumn property="${field.name}"
								titleKey="${field.name}.label" title="${fieldLabel}" params="${[cdoClassName:request.getParameter('cdoClassName'), order:request.getParameter('order'), offset:request.getParameter('offset'), cdoClassAttributeName:request.getParameter('cdoClassAttributeName'), htmlElementValue:request.getParameter('htmlElementValue'), htmlElementIdName:request.getParameter('htmlElementIdName'), assocHTMLElementsValue:request.getParameter('assocHTMLElementsValue')]}" />
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
<input type="hidden" name="cdoCollection" value="${request.getParameter('cdoCollection') ? request.getParameter('cdoCollection') : 'cdoCollection' }">
<input type="hidden" name="fields" value="${request.getParameter('fields') ? request.getParameter('fields') : 'fields' }">
<input type="hidden" name="cdoClassName" value="${request.getParameter('cdoClassName') ? request.getParameter('cdoClassName') : 'cdoClassName' }">
<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'windId' }">
<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'desc' }">
<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
		<div class="pagination">
			<g:paginate total="${cdoCollectionSize}" params="${[cdoCollection:request.getParameter('cdoCollection'), fields:request.getParameter('fields'), cdoClassName:request.getParameter('cdoClassName'), order:request.getParameter('order'), offset:request.getParameter('offset'), cdoClassAttributeName:request.getParameter('cdoClassAttributeName'), htmlElementValue:request.getParameter('htmlElementValue'), idName:request.getParameter('idName'), assocHTMLElementsValue:request.getParameter('assocHTMLElementsValue')]}"/>
		</div>
	</form>
</body>
</html>