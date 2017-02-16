<%@ page import="com.dell.diamond.fms.FMSBeneficiaryObject" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.Beneficiary"%>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="entityName" value="${message(code: 'beneficiaryAllocation.label', default: 'Beneficiary Allocation')}" />

<title><g:message code="default.edit.label" args="[entityName]" /></title>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">

<style type="text/css">
	.fieldcontain LABEL, .fieldcontain .property-label {
		color: #666666;
		text-align: left;
		width: 40%;
		font-size: 0.8em;
		font-weight: bold
	}
	.fieldcontain span {
	color: #0066CC;
	}
	#editFields label{
		width:140px;
		text-align:right;    	
	}
	#editFields input{
		width:140px;
		text-align:left;
	}
	#editFields datePicker{
		width:200px;
		text-align:left;
	}
	#editFields checkBox{
		width:10px;
		text-align:left;
 	}
 	.fieldcontain span {
	color: #0066CC;
	}
 	
	.hideme Label{
		text-align:left;
		padding-bottom:5px;
	}
	.addButton {
		-moz-box-shadow:inset -1px 1px 7px 0px #ffffff;
		-webkit-box-shadow:inset -1px 1px 7px 0px #ffffff;
		box-shadow:inset -1px 1px 7px 0px #ffffff;
		background-color:#ededed;
		-moz-border-radius:15px;
		-webkit-border-radius:15px;
		border-radius:10px;
		border:1px solid #999999;
		display:inline-block;
		color:#404040;
		font-family:arial;
		font-size:16px;
		font-weight:normal;
		padding:5px 24px;
		text-decoration:none;
		text-shadow:1px 0px 13px #ffffff;
	}.addButton:hover {
		background-color:#dfdfdf;
	}.addButton:active {
		position:relative;
		top:1px;
	}
</style>
	


<script type="text/javascript">
//<![CDATA[ 
$(window).load(function() {
	$('.hideme').find('div').hide();
	$('.clickme').click(function() {
		$(this).parent().next('.hideme').find('div').slideToggle(500);
		return false;
	});

	needToConfirm = false; 

	var primaryCheck = true;
 	var contingentCheck = true;
 	var numberOfPlans = document.getElementById("numberOfPlans").value;
 	
 	for (j = 0; j < numberOfPlans; j++) {
		var formIdForPrimaryPercent = j+".allocatePercent.primary";
	 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
	 	var formIdForContingentPercent = j+".allocatePercent.contingent";
	 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
	 	var formPercentSave = "allocatePercentForSave."+j;
	 	
	 	if(primaryElements && primaryElements.length > 0){	
	 		var primaryTotal = 0;
		 	var number = primaryTotal;
		 	for (i = 0; i < primaryElements.length; i++) { 
			    	number += parseFloat(primaryElements[i].value);
		 	}
		 	primaryTotal = Math.round( number * 10 ) / 10;
		 	if(primaryTotal < 99.9 || primaryTotal > 100){
		 		needToConfirm = true;
			}
		}
		
	 	if(contingentElements && contingentElements.length > 0){
	 		var contingentTotal = 0;
	 		var number = contingentTotal;
		 	for (i = 0; i < contingentElements.length; i++) { 
					number += parseFloat(contingentElements[i].value);
		 	}
		 	contingentTotal = Math.round( number * 10 ) / 10;
		 	if(contingentTotal < 99.9 || contingentTotal > 100){
		 		needToConfirm = true;
			}
	 	}
 	}
	
	$("form").submit(function() {
		needToConfirm = false;
		window.onbeforeunload = null;
	});

	function askConfirm() {
		if(needToConfirm){
	    	return "Beneficiary Allocation Percentages MUST add up to 100% for both the Primary and Contingent Beneficiaries!";
		}
	}
	
	window.onbeforeunload = askConfirm;
});//]]>
</script>

<style type="text/css">
	#report changed {color:blue;}
    #report { border-collapse:collapse;}
    #report div {background:#C7DDEE}
    #report h4 { margin:0px; padding:0px;}
    #report img { float:right;}
    #report ul { margin:10px 0 10px 40px; padding:0px;}
    #report td { none repeat-x scroll center left; color:#000; padding:2px 15px; }
    #report tr.hideme { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
    #report td.clickme td { background:#fffff repeat-x scroll center left; cursor:pointer; }
    #report div.arrow { background:transparent url(arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
    #report div.up { background-position:0px 0px;}
        
	.showme Label{
		width:240px;
		text-align:left;
		padding-bottom:5px;
		padding-top:10px;
	}
	.showme Input{
		width:200px;
		text-align:left;
	}
	#editFields span{
		color:#0066CC;
	}
</style>

<script>
	function checkPercentages(form, primary, contingent){
		//alert("form: "+form+" Primary: "+primary.value+" contingent: "+contingent.value+ " Return:"+form+".allocatePercent" );
	 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
	 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
	 	var formIdForContingentPercent = form+".allocatePercent.contingent";
	 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
	 	
	 	if(primaryElements && primaryElements.length > 0){
		 	var primaryTotal = 100 / (primaryElements.length);
		 	var number = primaryTotal;
		 	primaryTotal = Math.round( number * 10 ) / 10;
		 	for (i = 0; i < primaryElements.length; i++) { 
			    if(primary.value == "Y"){
			    	//document.getElementsByName(formIdForPrimaryPercent)[i].setAttribute('readOnly', true);
			    	primaryElements[i].value = primaryTotal;
			    	primaryElements[i].click();
				}
		 	}
		 	checkPercentforSave(form);
		}
		
	 	if(contingentElements && contingentElements.length > 0){
		 	var contingentTotal = 100 / (contingentElements.length);
		 	var number = contingentTotal;
		 	contingentTotal = Math.round( number * 10 ) / 10;
		 	for (i = 0; i < contingentElements.length; i++) { 
				if(contingent.value == "Y"){
					contingentElements[i].value = contingentTotal;
					contingentElements[i].click();
				}
		 	}
		 	checkPercentforSave(form);
	 	}
	}
</script>

<script>
	function clickFieldsToUpdateValues(form){
		//alert("form: "+form+" Primary: "+primary.value+" contingent: "+contingent.value+ " Return:"+form+".allocatePercent" );
	 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
	 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
	 	var formIdForContingentPercent = form+".allocatePercent.contingent";
	 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
	 	 
	 	if(primaryElements && primaryElements.length > 0){
		 	for (i = 0; i < primaryElements.length; i++) { 
			    primaryElements[i].click();
		 	}
		}
		
	 	if(contingentElements && contingentElements.length > 0){
		 	for (i = 0; i < contingentElements.length; i++) { 
				contingentElements[i].click();
		 	}
	 	}
	}
</script>

<script>
	function updateSeq(selectedObject, indexToUpdate){	
		var split = selectedObject.value.split(",");
		var v1 = split[0];
		var v2 = split[1];
		
		var seqIdLocation = "seqBeneficiaryIdForSave.".concat(indexToUpdate);
	    document.getElementById(seqIdLocation).value = v1;

	    var dateLocation = "dateOfBirthForSave".concat(indexToUpdate);
	    document.getElementById(dateLocation).value = v2;
	}
</script>

<script type="text/javascript">
	function deleteAllocation(seqId){
	    document.getElementById('deleteThisAllocation').value = seqId;
	    return true;
	}
</script>

<script type="text/javascript">
	function checkAllocationPercentagesOnClose(seqId){
	    document.getElementById('deleteThisAllocation').value = seqId;
	    return true;
	}
</script>

<script>
	function checkPercentforSave(form){
	 	var formIdForPrimaryPercent = form+".allocatePercent.primary";
	 	var primaryElements = document.getElementsByName(formIdForPrimaryPercent);
	 	var formIdForContingentPercent = form+".allocatePercent.contingent";
	 	var contingentElements = document.getElementsByName(formIdForContingentPercent);
	 	var formPercentSave = "allocatePercentForSave."+form;
	 	var formTypeSave = "bfciaryTypeForSave."+form;
	 	var typeValue = document.getElementById(formTypeSave).value
	
	 	if(!primaryElements || primaryElements.length == 0){	
		 	if(typeValue == "P"){
		 		document.getElementById(formPercentSave).value = 100;
			}
		}
	 	else if(primaryElements && primaryElements.length > 0){	
		 	if(typeValue == "P"){
		 		var primaryTotal = 0;
			 	var number = primaryTotal;
			 	for (i = 0; i < primaryElements.length; i++) { 
				    	number += parseFloat(primaryElements[i].value);
			 	}
			 	primaryTotal = 100 - number;
			 	primaryTotal = Math.round( primaryTotal * 10 ) / 10;
			 	if(!isNaN(primaryTotal)){
			 		document.getElementById(formPercentSave).value = primaryTotal;
			 	}
		 	}
		}
		
	 	if(!contingentElements || contingentElements.length == 0){
	 		if(typeValue == "C"){
		 		document.getElementById(formPercentSave).value = 100;
			}
	 	}
	 	
	 	else if(contingentElements && contingentElements.length > 0){
		 	if(typeValue == "C"){
		 		var contingentTotal = 0;
		 		var number = contingentTotal;
			 	for (i = 0; i < contingentElements.length; i++) { 
						number += parseFloat(contingentElements[i].value);
			 	}
			 	contingentTotal = 100 - number;
			 	contingentTotal = Math.round( contingentTotal * 10 ) / 10;
			 	if(!isNaN(contingentTotal)){
					document.getElementById(formPercentSave).value = contingentTotal;
			 	}
		 	}
	 	}
	}
</script>

<script type="text/javascript">
	function addAllocation(index){
	    document.getElementById('addThisAllocationIndex').value = index;
	    return true;
	}
</script>

<script type="text/javascript">
	function updateAllocation(indexValue){
	    document.getElementById("indexForUpdate").value = indexValue;
	}
</script>

<script type="text/javascript">
	function updatePercentValue(formId, seqId, inputValue){ 
		var formDocumentId = "allocationRecord."+formId+"."+seqId+".allocatePercent";
		document.getElementById(formDocumentId).value = inputValue.value;
	}
</script>

<script>
	function updateBirthDate(indexToUpdate){
		var seqIdLocation = "seqBeneficiaryIdForSave.".concat(indexToUpdate);
		document.getElementById(seqIdLocation).value = seqId.value;
		
	    var dobLocation = "dobTrigger.".concat(indexToUpdate);
	    document.getElementById(dobLocation).value = seqId.value;
	}
</script>

<g:javascript>
	var userflag=false;
		$(function(){
		  $("form")	   
		    .dirty_form({changedClass: "forever_changes"})
		    .dirty(function(event, data){
		      var label = $(event.target).parents("li").find("label");
		      userflag=true;	     
		    })
		});	
</g:javascript>

<script>
$(function(){
    $(".amtNumeric").numeric({});
})
</script>

</head>
Beneficiary Allocation for Member Id LAYOUT 2 (${subscriberMember.subscriberID})
<br></br>
<a href="#edit-tradingPartnerDetail" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div id="edit-tradingPartnerDetail" class="content scaffold-edit" role="main">

	<g:if test="${fieldErrors}">
		<ul class="errors" role="alert">
			<g:each in="${fieldErrors}" var="error">
				<li>
					${error}
				</li>
			</g:each>
		</ul>
	</g:if>
	<div id="errorDisplay" style="display: none;" class="errors" style="float:left; margin: -5px 10px 0px 0px; ">
	</div>
	<g:hiddenField name="indexForUpdate" value=""/>
	<g:hiddenField name="memberDbId" value="${subscriberMember?.memberDBID}"/>
	<g:hiddenField name="deleteThisAllocation" value=""/>
	<g:hiddenField name="addThisAllocationIndex" value=""/>
	<g:hiddenField name="subscriberId" value="${subscriberMember?.subscriberID}"/>
	<g:hiddenField name="numberOfPlans" value="${FmsBeneficiaryObjects.size()}"/>
	<g:each in="${FmsBeneficiaryObjects}" status="i" var="fmsbo">
		<g:if test="${fmsbo?.plan?.planCode}">
			<table border="1" id="report" style="font-size:14px; text-align:left;">
				<tr class="head">
					<th>
						Select
					</th>
					<th>
						Plan Code
					</th>
					<th>
						Product Category
					</th>
					<th>
						Short Description
					</th>
					<th>
						Effective Date
					</th>
					<th>
						Term Date
					</th>
				</tr>
					<tr  class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td class="clickme">
							<input type="radio" name="eligbeneficiaryradio">
						</td>
						<td class="clickme">
							${fmsbo.plan?.planCode}
						</td>
						<td class="clickme">
							${fmsbo.plan?.productType}
						</td>
						<td class="clickme">
							${fmsbo.plan?.shortDescription}
						</td>
						<td class="clickme">
							<g:formatDate format="yyyy-MM-dd" date="${fmsbo.eligRecord?.effectiveDate}" />
						</td>
						<td class="clickme">
							<g:formatDate format="yyyy-MM-dd" date="${fmsbo.eligRecord?.termDate}" />	
						</td>
					</tr>	
					<tr class="hideme">
						<td colspan="13">
							<div class="divContent">
								<g:hiddenField name="createPlanType.${i}" value="${fmsbo.plan?.productType}"/>
								<g:hiddenField name="createPlanCode.${i}" value="${fmsbo.plan?.planCode}"/>
								<g:hiddenField name="seqBeneficiaryIdForSave.${i}" value=""/>									
								<table>
										<tr>
											<td class="tdFormElement" style="white-space: nowrap">
													<div>
														<label> 
															<g:message code="eligHistory.voidEligFlag.label" default="Allocate percentage evenly to all Primary Beneficiaries? :" />
														</label>
														<select name="allocatePrimaryBenif${i}" onChange="checkPercentages(${i}, allocatePrimaryBenif${i}, allocateContingentBenif${i})">
															<option value="N">No</option>
															<option value="Y">Yes</option>														
														</select>
													</div>
											</td>
										</tr>
										<tr>
											<td class="tdFormElement" style="white-space: nowrap">
													<div>
														<label> 
															<g:message code="eligHistory.voidEligFlag.label" default="Allocate percentage evenly to all Contingent Beneficiaries? :" />
														</label>
														<select name="allocateContingentBenif${i}" onChange="checkPercentages(${i}, allocatePrimaryBenif${i}, allocateContingentBenif${i})">
										 					<option value="N">No</option>
															<option value="Y">Yes</option>
														</select>
													</div>											 
											</td>
										</tr>											
										<g:each in="${fmsbo?.beneficiaryAllcoation}" status="j" var="benefAllocationObject">													
											<g:if test="${benefAllocationObject.planCode.equals(fmsbo.eligRecord?.planCode)}">
												<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
												<tr>
													<td>
														<table>
															<tr>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryName', 'error')} ">
																		<label for="bfciaryName"> <g:message
																				code="bfciaryName.label" default="Name: " />
																				<span class="required-indicator">*</span>
																		</label>
																		<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																			<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																				<g:textField title="The Beneficiary Name" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled" value="${benefObject.bfciaryName}" />
																			</g:if>
																		</g:each>
																	</div>
																</td>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryType', 'error')} ">
																		<label for="bfciaryType"> <g:message
																				code="beneficiary.bfciaryType.label" default="Type: " />
																			<span class="required-indicator">*</span>
																		</label>
																		<select name="bfciaryType.${i}.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled">
																			<option value="P" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')) ? 'selected':'' }>Primary</option>
																			<option value="C" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')) ? 'selected':'' }>Contingent</option>
																		</select>
																	</div>
																</td>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'dateOfBirth', 'error')} ">
																		<label for="dateOfBirth"> <g:message
																				code="beneficiary.dateOfBirth.label" default="Date of Birth: " />
														
																		</label>
																		<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																			<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																				<g:textField title="The Beneficiary Date of Birth" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}.placeholder" disabled="disabled" size="10" value="${formatDate(date: benefObject.dateOfBirth, format: 'MM/dd/yyyy')}" />
																			</g:if>
																		</g:each>			
																	</div>
																</td>
																<td>
																	<div class="fieldcontain ${hasErrors(bean: detail, field: 'allocatePercent', 'error')} ">
																		<label for="allocatePercent"> <g:message
																				code="beneficiary.allocatePercent.label" default="Payout Percent: " />
																				<span class="required-indicator">*</span>
																		</label>
																		<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
																			<g:textField class="amtNumeric" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.primary" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																				onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																				onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"/>
																			<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																			
																		</g:if>
																		<g:else>
																			<g:textField class="amtNumeric" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.contingent" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																				onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																				onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"/>
																			<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																		</g:else>
																	</div>
																</td>
																<td>														
																	<g:hiddenField name="seqBfciaryAllocId.${benefAllocationObject?.seqBfciaryAllocId}" value="${benefAllocationObject?.seqBfciaryAllocId}"/>
																	<g:actionSubmit class="addButton" action="deleteBeneficiaryAllocation" value="Delete"
																			onclick="deleteAllocation(${benefAllocationObject?.seqBfciaryAllocId}); return confirm('${message(code: 'This Beneficiary Allocation will be deleted. Are you sure?', default: 'This Beneficiary Allocation will be deleted. Are you sure?')}');" />
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</g:if>
										</g:if>
									</g:each>
										<g:each in="${fmsbo?.beneficiaryAllcoation}" status="j" var="benefAllocationObject">
											<g:if test="${benefAllocationObject.planCode.equals(fmsbo.eligRecord?.planCode)}">
												<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')}">
												<tr>
													<td>
														<table>
															<tr>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryName', 'error')} ">
																		<label for="bfciaryName"> <g:message
																				code="bfciaryName.label" default="Name: " />
																				<span class="required-indicator">*</span>
																		</label>
																		<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																			<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																				<g:textField title="The Beneficiary Name" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled" value="${benefObject.bfciaryName}" />
																			</g:if>
																		</g:each>
																	</div>
																</td>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryType', 'error')} ">
																		<label for="bfciaryType"> <g:message
																				code="beneficiary.bfciaryType.label" default="Type: " />
																			<span class="required-indicator">*</span>
																		</label>
																		<select name="bfciaryType.${i}.${benefAllocationObject?.seqBfciaryAllocId}" disabled="disabled">
																			<option value="P" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')) ? 'selected':'' }>Primary</option>
																			<option value="C" ${(benefAllocationObject && benefAllocationObject?.bfciaryType.equals('C')) ? 'selected':'' }>Contingent</option>
																		</select>
																	</div>
																</td>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'dateOfBirth', 'error')} ">
																		<label for="dateOfBirth"> <g:message
																				code="beneficiary.dateOfBirth.label" default="Date of Birth: " />
														
																		</label>
																		<g:each in="${fmsbo?.beneficiaries}" status="k" var="benefObject">
																			<g:if test="${benefObject.seqBfciaryId.equals(benefAllocationObject.seqBfciaryId) }">
																				<g:textField title="The Beneficiary Date of Birth" name="benefObjectdateOfBirth.${benefAllocationObject?.seqBfciaryAllocId}.placeholder" disabled="disabled" size="10" value="${formatDate(date: benefObject.dateOfBirth, format: 'MM/dd/yyyy')}" />
																			</g:if>
																		</g:each>			
																	</div>
																</td>
																<td>
																	<div
																		class="fieldcontain ${hasErrors(bean: detail, field: 'allocatePercent', 'error')} ">
																		<label for="allocatePercent"> <g:message
																				code="beneficiary.allocatePercent.label" default="Payout Percent: " />
																				<span class="required-indicator">*</span>
																		</label>
																		<g:if test="${benefAllocationObject && benefAllocationObject?.bfciaryType.equals('P')}">
																			<g:textField  class="amtNumeric" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.primary" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																				onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																				onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"/>
																			<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																			
																		</g:if>
																		<g:else>
																			<g:textField class="amtNumeric" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="${i}.allocatePercent.contingent" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" maxlength="5" min="0" minlength="1" size="5" value="${benefAllocationObject?.allocatePercent}" 
																				onKeyUp="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this); checkPercentforSave(${i});"
																				onclick="updatePercentValue(${i},${benefAllocationObject?.seqBfciaryAllocId}, this);"/>
																			<g:hiddenField name="allocationRecord.${i}.${benefAllocationObject?.seqBfciaryAllocId}.allocatePercent" value="${benefAllocationObject?.allocatePercent}"/>
																		</g:else>
																	</div>
																</td>
																<td>															
																	<g:hiddenField name="seqBfciaryAllocId.${benefAllocationObject?.seqBfciaryAllocId}" value="${benefAllocationObject?.seqBfciaryAllocId}"/>
																	<g:actionSubmit class="addButton" action="deleteBeneficiaryAllocation" value="Delete"
																			onclick="deleteAllocation(${benefAllocationObject?.seqBfciaryAllocId}); return confirm('${message(code: 'This Beneficiary Allocation will be deleted. Are you sure?', default: 'This Beneficiary Allocation will be deleted. Are you sure?')}');" />																				
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</g:if>
										</g:if>
									</g:each>
								<tr>
									<td>
										<table>
											<tr>
												<td>
													<div
														class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryName', 'error')} ">
														<label for="bfciaryNameForSave"> <g:message
																code="bfciaryName.label" default="Name: " />
																<span class="required-indicator">*</span>
														</label>
														<g:if test="${benificiaries}">
															<g:select title="The Beneficiary Name" name="bfciaryNameForSave.${i}"
														          from="${benificiaries}"
														          noSelection="${['null':'-- Beneficiary Name --']}"
														          optionKey="${{it.seqBfciaryId + ',' + formatDate(date: it.dateOfBirth, format: 'MM/dd/yyyy')}}"
														          optionValue="bfciaryName" 
														          onChange="updateSeq(this,${i.toString()});checkPercentforSave(${i});"/>
													    </g:if>
													</div>
												</td>
												<td>
													<div
														class="fieldcontain ${hasErrors(bean: detail, field: 'bfciaryType', 'error')} ">
														<label for="bfciaryType"> <g:message
																code="beneficiary.bfciaryType.label" default="Type: " />
															<span class="required-indicator">*</span>
														</label>
														<select name="bfciaryTypeForSave.${i}" id="bfciaryTypeForSave.${i}" onChange="checkPercentforSave(${i});">
															<option value="P" >Primary</option>
															<option value="C" >Contingent</option>
														</select>
													</div>
												</td>
												<td>
													<div class="fieldcontain ${hasErrors(bean: detail, field: 'dateOfBirthForSave', 'error')} ">
														<label for="dateOfBirthForSave"> <g:message
																code="beneficiary.dateOfBirthForSave.label" default="Date of Birth: " />
														</label>
														<g:textField title="The Beneficiary Date of Birth" name="dateOfBirthForSave${i}" size="10" readonly="readonly" value="${formatDate(date: null, format: 'MM/dd/yyyy')}" />	
													</div>	
												</td>
												<td>
													<div
														class="fieldcontain ${hasErrors(bean: detail, field: 'allocatePercentForSave', 'error')} ">
														<label for="allocatePercentForSave"> <g:message
																code="beneficiary.allocatePercentForSave.label" default="Payout Percent: " />
																<span class="required-indicator">*</span>
														</label>
														<g:textField class="amtNumeric" title="The percentage amount to be allocated. Example: Enter 50 to allocate 50 percent." name="allocatePercentForSave.${i}" pattern="^[0-9]+\\s*\$|^[0-9]+\\.?[0-9]+\\s*\$" max="100" min="0"maxlength="5" size="5"  value="${benefAllocationObject?.allocatePercent}" />
													</div>
												</td>
												<td>
													<g:checkURIAuthorization uri="/beneficiaryAllocation/addBeneficiaryAllocation">
															<g:actionSubmit class="addButton" action="createBeneficiaryAllocation" value="Add" onclick="addAllocation(${i}); updateAllocation(${i});"/>					
													</g:checkURIAuthorization>				
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<fieldset class="buttons">
											<g:actionSubmit class="save" action="updateBeneficiaryAllocation" onclick="updateAllocation(${i}); clickFieldsToUpdateValues(${i});" value="${message(code: 'default.button.update.label', default: 'Update')}" />
											<input class="reset" type="reset" onclick="clickFieldsToUpdateValues(${i});">
											<%--NOTE: Had to put this here because otherwise IE would not detect that there is a submit button here --%>
											<script type="text/javascript">
												$("form").submit(function() {
													needToConfirm = false;
													window.onbeforeunload = null;
												});
											</script>
										</fieldset>											
									</td>
								</tr>
								</table>		
							</div>
						</td>
					</tr>
			</table>
		</g:if>
	</g:each>			
</div>			