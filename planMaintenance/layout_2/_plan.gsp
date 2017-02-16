<%@ page import=" com.perotsystems.diamond.dao.cdo.PlanMaster"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_2">
	<g:set var="entityName"
		value="${message(code: 'planMaster.label', default: 'PlanMaster')}" />
		
	<g:set var="appContext" bean="grailsApplication"/>
	
	<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/planMaintenance/search"/>')			
		}
	</script>
	
	<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script><%--
	
	<script type="text/javascript">
	$(function() {		
		$("#editForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
			rules : {
					 'plan.0.productType' : {
						required : true
					},
					'plan.0.hixProductCode' : {
						required : true
					}
			},

			messages : {
				'plan.0.productType' : {
					required : "Please select a product Type"
				},
				'plan.0.hixProductCode' : {
					required : "Please enter HIX Product Code"
				}
			} 
			 
		})
	});
	}); 
	</script>
	
--%>
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
			<a style="color: #48802C">${editType} Plan</a>
		</h1>
		<div class="right-corner" align="center">PLANC</div>			
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
		
		<g:hasErrors bean="${plan}">
			<ul class="errors" role="alert">
				<g:eachError bean="${plan}" var="error">
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
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'planCode', 'error')} required" 
					style="display: inline">
					<label for="planCode"> <g:message
							code="planMaster.planCode.label" default="Plan Code :" />
						<span class="required-indicator">*</span>
					</label>
					<g:textField readOnly="true" style="background-color:#CCC" name="planCode" maxlength="50" required="Plan Code is Required"
						autofocus="autofocus" value="${plan?.planCode}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'plan.productType', 'error')} required" 
					style="display: inline">
					<label for="productType"> <g:message
							code="planMaster.productType.label" default="Product Type :" />
						<span class="required-indicator">*</span>
					</label>
				<g:if test="${editType.equals("Edit")}">
				<g:hiddenField name="productType" value="${plan?.productType}" />
				<g:getSystemCodes
					systemCodeType="PRODUCT_TYPE" 
					systemCodeActive = "Y"
					htmlElelmentId="productType"
					blankValue="productType"
					disable="true"
					defaultValue="${plan?.productType}" 
					width="150px"
					title = "Select the type of coverage for the plan from list"/>
				</g:if>
				<g:elseif test="${editType.equals("Create")}">
				<g:getSystemCodes
					systemCodeType="PRODUCT_TYPE" 
					systemCodeActive = "Y"
					htmlElelmentId="productType"
					blankValue="productType"
					defaultValue="${plan?.productType}" 
					width="150px"
					title = "Select the type of coverage for the plan from list"/>
				</g:elseif>
					
				</div>
		</td>	
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'shortDescription', 'error')} required"
					style="display: inline;">
					<label for="shortDescription"> <g:message
							code="planMaster.shortDescription.label" default="Short Description :" /> 
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="shortDescription" maxlength="20" required="Short Description is Required"
						value="${plan?.shortDescription}"/>
				</div>
			</td>
			<td>
				<g:if test="${HIXProductcodeMandatory}">			
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'hixProductCode', 'error')} required"
					style="display: inline;">
					<label for="hixProductCode"> <g:message
							code="planMaster.hixProductCode.label" default="HIX Product Code :" /> 
						<span class="required-indicator">*</span>
					</label>
					<g:textField name="hixProductCode" maxlength="15" required="HIX Product Code is Required"
						value="${plan?.hixProductCode}"/>
				</div>
				</g:if>
				<g:else>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'hixProductCode', 'error')} required"
					style="display: inline;">
					<label for="hixProductCode"> <g:message
							code="planMaster.hixProductCode.label" default="HIX Product Code :" />
					</label>
					<g:textField name="hixProductCode" maxlength="15"
						value="${plan?.hixProductCode}"/>
				</div>
				</g:else>
			</td>
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'description', 'error')}"
					style="display: inline">
					<label for="description"> <g:message
							code="plan.description.label" default="Long Description :" /> <span
						class="required-indicator">*</span>
					</label>
					<g:textArea name="description" maxlength="240" value="${plan?.description}" required="Long Description is Required" />
				</div>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td colspan="2">User Defined Information
				<hr></hr>
			</td>
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined1', 'error')}"
					style="display: inline">
					<label for="userDefined1"> <g:message
							code="planMaster.userDefined1.label" default="User Defined 1 :" />
					</label>
					<g:textField name="userDefined1" maxlength="30"
						value="${plan?.userDefined1}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDate1', 'error')}"
					style="display: inline">
					<label for="userDate1"> <g:message
							code="planMaster.userDate1.label" default="User Date 1 :" />
					</label>
					
					<g:datePicker name="userDate1" precision="day" noSelection="['':'']" value="${plan?.userDate1}" default="none"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined2', 'error')}"
					style="display: inline">
					<label for="userDefined2"> <g:message
							code="planMaster.userDefined2.label" default="User Defined 2 :" />
					</label>
					<g:textField name="userDefined2" maxlength="30"
						value="${plan?.userDefined2}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDate2', 'error')}"
					style="display: inline">
					<label for="userDate2"> <g:message
							code="planMaster.userDate2.label" default="User Date 2 :" />
					</label>
					
					<g:datePicker name="userDate2" precision="day" noSelection="['':'']" value="${plan?.userDate2}" default="none"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined3', 'error')}"
					style="display: inline">
					<label for="userDefined3"> <g:message
							code="planMaster.userDefined3.label" default="User Defined 3 :" />
					</label>
					<g:textField name="userDefined3" maxlength="30"
						value="${plan?.userDefined3}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDate3', 'error')}"
					style="display: inline">
					<label for="userDate3"> <g:message
							code="planMaster.userDate3.label" default="User Date 3 :" />
					</label>
					<g:datePicker name="userDate3" precision="day" noSelection="['':'']" value="${plan.userDate3}" default="none"/>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined4', 'error')}"
					style="display: inline">
					<label for="userDefined4"> <g:message
							code="planMaster.userDefined4.label" default="User Defined 4 :" />
					</label>
					<g:textField name="userDefined4" maxlength="30"
						value="${plan?.userDefined4}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined4', 'error')}"
					style="display: inline">
					<label for="userDefined4"> <g:message
							code="planMaster.userDefined4.label" default="User Date 4 :" />
					</label>
					<g:datePicker name="userDate4" precision="day" noSelection="['':'']" value="${plan.userDate4}" default="none"/>
				</div>
			</td>
		</tr>	
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined5', 'error')}"
					style="display: inline">
					<label for="userDefined5"> <g:message
							code="planMaster.userDefined5.label" default="User Defined 5 :" />
					</label>
					<g:textField name="userDefined5" maxlength="30"
						value="${plan?.userDefined5}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined5', 'error')}"
					style="display: inline">
					<label for="userDefined5"> <g:message
							code="planMaster.userDefined5.label" default="User Date 5 :" />
					</label>
					<g:datePicker name="userDate5" precision="day" noSelection="['':'']" value="${plan.userDate5}" default="none"/>
				</div>
			</td>
		</tr>	
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined6', 'error')}"
					style="display: inline">
					<label for="userDefined6"> <g:message
							code="planMaster.userDefined6.label" default="User Defined 6 :" />
					</label>
					<g:textField name="userDefined6" maxlength="30"
						value="${plan?.userDefined6}" />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean: plan, field: 'userDefined6', 'error')}"
					style="display: inline">
					<label for="userDefined6"> <g:message
							code="planMaster.userDefined6.label" default="User Date 6 :" />
					</label>
					<g:datePicker name="userDate6" precision="day" noSelection="['':'']" value="${plan.userDate6}" default="none"/>
				</div>
			</td>
		</tr>					
	</table>
	
	<g:if test="${editType.equals("Edit")}">
		<fieldset class="buttons">
			<div style="align:left;display:inline">
			<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
			<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			</div>
			<div style="align:right;display:inline" >
			<input type="Reset" class="reset" value="Reset" />
			<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</div>
		</fieldset>
	</g:if>
	<g:elseif test="${editType.equals("Create")}">
		<fieldset class="buttons">
			<g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
			<div style="align:right;display:inline" >
				<input type="Reset" class="reset" value="Reset" onClick="document.forms['plan'].reset()"/>
				<input type="button" class="close" value="Close" onClick="closeForm()"/>
			</div>
		</fieldset>
	</g:elseif>
	</g:form>
</body>
</html>